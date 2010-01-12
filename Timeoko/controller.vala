
namespace Timeoko {
  
  class Controller {
    ViewEggTimer view_egg_timer;
    ModelEggTimer model_egg_timer;
    PlaySound sound_controller;
    
    /* Constructor */
    public Controller() {
      // Initialize model
      model_egg_timer = new ModelEggTimer();
      // Initialize view
      view_egg_timer = new ViewEggTimer(this, model_egg_timer);
      model_egg_timer.set_view(view_egg_timer);
      
      sound_controller = new PlaySound();
    }
    
    public void run_program() {
      view_egg_timer.show_window();
      Elm.run();
    }
    
    //--- Callbacks ---
    public void callback_start_pause_egg() {
      if( model_egg_timer.is_timer_running() ) {
        callback_reset_egg(false);
      } else {
        int seconds_to_count;
        int hrs, min, sec;
        sound_controller.stop_ring();
        view_egg_timer.set_timer.time_get(out hrs,out min,out sec);
        seconds_to_count = hrs*60*60 + min*60 + sec;
        
        model_egg_timer.start_countdown( seconds_to_count );
        view_egg_timer.update_view();
      }
    }
    public void callback_reset_egg(bool reset_time = true) {
      if( reset_time )
        view_egg_timer.set_timer.time_set( 0,0,0 );
      model_egg_timer.reset();
      sound_controller.stop_ring();
      view_egg_timer.update_view();
    }
    public void egg_is_done() {
      sound_controller.ring();
    }
    
    public void callback_close_window() {
      model_egg_timer.shutdown();
      Elm.exit();
    }
  }
  
}