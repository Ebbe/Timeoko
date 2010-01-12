
namespace Timeoko {
  
  class ModelEggTimer {
    DBus.Connection conn;
    dynamic DBus.Object fso_usaged;
    
    ViewEggTimer view;
    bool timer_running;
    bool countdown_done;
    bool requested_cpu;
    double start_time;
    double finish_time;
    int seconds_elapsed;
    Timer timer;
    CountingThread counting_thread;
    weak Thread thread;
    
    public ModelEggTimer() {
      conn = DBus.Bus.get (DBus.BusType.SYSTEM);
      fso_usaged = conn.get_object ("org.freesmartphone.ousaged"
                                    ,"/org/freesmartphone/Usage"
                                    ,"org.freesmartphone.Usage");

      timer_running = false;
      countdown_done = false;
      requested_cpu = false;
      finish_time = 0.0;
      timer = new Timer();
      counting_thread = new CountingThread(this);
      try {
        thread = Thread.create(counting_thread.run_thread, true);
      } catch (ThreadError e) {
      }
    }
    
    public void shutdown() {
      counting_thread.keep_running = false;
    }
    
    public void set_view(ViewEggTimer v) {
      view = v;
    }
    
    public bool is_timer_running() {
      return timer_running;
    }
    
    public string label_text() {
      if( countdown_done )
        return "Time is up!";
      if( timer_running )
        return "%s left".printf(seconds_as_human_readable());
      else
        return "Not started";
    }
    
    public void start_countdown(int seconds) {
      reset();
      timer_running = true;
      start_time = timer.elapsed();
      finish_time = ((int)start_time) + seconds + 1;
      if(!requested_cpu) {
        fso_usaged.RequestResource("CPU");
        requested_cpu = true;
      }
    }
    
    public void reset() {
      timer_running = false;
      countdown_done = false;
      seconds_elapsed = 0;
      if(requested_cpu) {
        fso_usaged.ReleaseResource("CPU");
        requested_cpu = false;
      }
    }
    
    /* This is run often */
    public void check_timer() {
      if( is_timer_running() ) {
        int old_seconds = seconds_elapsed;
        seconds_elapsed = (int) (timer.elapsed()-start_time);
        if( seconds_elapsed!=old_seconds ) {
          if( get_seconds_left() == 0 ) {
            // Time has run out!
            if( !countdown_done ) {
              reset();
              countdown_done = true;
              timer_running = false;
              view.egg_is_done();
            }
          } else {
            view.update_view();
          }
        }
      }
    }
    
    private int get_seconds_left() {
      int seconds = (int) (finish_time-timer.elapsed());
      if( seconds<0 )
        seconds = 0;
      return seconds;
    }
    
    private string seconds_as_human_readable() {
      int seconds_left = get_seconds_left();
      int min = seconds_left / 60;
      int hours = min / 60;
      int seconds = seconds_left % 60;
      return "%02i:%02i:%02i".printf(hours,min%60,seconds);
    }
  }
  
  private class CountingThread {
    ModelEggTimer callback_class;
    public bool keep_running;
    
    public CountingThread(ModelEggTimer _class) {
      callback_class = _class;
      keep_running = true;
    }
    
    public void* run_thread() {
      while (keep_running) {
        Thread.usleep((ulong)0.90*1000000);
        do_event();
      }
      return null;
    }
    
    private void do_event() {
      callback_class.check_timer();
    }
  }
  
}