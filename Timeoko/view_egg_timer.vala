using Elm;

namespace Timeoko {
  
  class ViewEggTimer {
    Controller controller;
    ModelEggTimer model;
    Win win;
    Bg bg;
    Box bx;
    Box bx2;
    public Clock set_timer;
    Frame fr;
    public Label countdown_lbl;
    Box bottom_horizontal_box;
    Button start_pause_btn;
    Button reset_btn;
    
    /* Constructor */
    public ViewEggTimer(Controller con, ModelEggTimer m) {
      controller = con;
      model = m;
      generate_window();
    }
    
    public void show_window() {
      win.show();
    }
    
    public void update_view() {
      countdown_lbl.label_set(model.label_text());
      if(model.is_timer_running())
        start_pause_btn.label_set("    Stop!    ");
      else
        start_pause_btn.label_set("    Start!   ");
    }
    
    public void egg_is_done() {
      update_view();
      controller.egg_is_done();
    }
    
    private void generate_window() {
      win = new Win(null, "main", WinType.BASIC);
      win.title_set("Timeoko - Egg timer");
      
      bg = new Bg(win);
      bg.size_hint_weight_set(1.0, 1.0);
      bg.show();
      win.resize_object_add(bg);
    
      bx = new Box(win);
      bx.size_hint_weight_set(1.0, 1.0);
      win.resize_object_add(bx);
      bx.show();
      
      set_timer = new Clock(win);
      set_timer.scale_set( 0.75 );
      set_timer.time_set( 0,0,0 );
      set_timer.edit_set(true);
      set_timer.show_seconds_set(true);
      bx.pack_end(set_timer);
      set_timer.show();
      
      fr = new Frame(win);
      fr.size_hint_weight_set(0.0, 1.0);
      fr.size_hint_align_set(0.5, 0.5);
      fr.style_set("outdent_top");
      bx.pack_end(fr);
      fr.show();
      
      bx2 = new Box(win);
      bx2.size_hint_weight_set(1.0, 1.0);
      fr.content_set(bx2);
      bx2.show();
      
      countdown_lbl = new Label(win);
      countdown_lbl.scale_set( 3 );
      countdown_lbl.label_set(model.label_text());
      bx2.pack_end(countdown_lbl);
      countdown_lbl.show();
      
//      running_timer = new Clock(win);
//      running_timer.scale_set( 0.75 );
//      running_timer.time_set( 0,0,0 );
//      running_timer.edit_set(false);
//      running_timer.show_seconds_set(true);
//      bx2.pack_end(running_timer);
//      running_timer.show();
      
      bottom_horizontal_box = new Box(win);
      bottom_horizontal_box.horizontal_set(true);
      bottom_horizontal_box.homogenous_set(true);
      //bottom_horizontal_box.size_hint_weight_set(1.0, 1.0);
      bx.pack_end(bottom_horizontal_box);
      bottom_horizontal_box.show();
      
      start_pause_btn = new Button(win);
      start_pause_btn.scale_set( 2 );
      start_pause_btn.size_hint_weight_set(1.0, 1.0);
      start_pause_btn.size_hint_align_set(-1.0, -1.0);
      start_pause_btn.show();
      bottom_horizontal_box.pack_end(start_pause_btn);
      
      reset_btn = new Button(win);
      reset_btn.scale_set( 2 );
      reset_btn.label_set("    Reset!   ");
      reset_btn.size_hint_weight_set(1.0, 1.0);
      reset_btn.size_hint_align_set(-1.0, -1.0);
      reset_btn.show();
      bottom_horizontal_box.pack_end(reset_btn);
      
      update_view();
      set_callbacks();
    }
    
    private void set_callbacks() {
      win.smart_callback_add("delete-request", controller.callback_close_window );
      start_pause_btn.smart_callback_add("clicked", controller.callback_start_pause_egg );
      reset_btn.smart_callback_add("clicked", () => {controller.callback_reset_egg();} );
    }
  }
  
}