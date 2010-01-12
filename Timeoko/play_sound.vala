
namespace Timeoko {

  class PlaySound {
    const string SOUND_FILE = "/usr/share/sounds/timeoko_ring.wav";
    private DBus.Connection conn;
    private dynamic DBus.Object fso_play;
    
    public PlaySound() {
      conn = DBus.Bus.get (DBus.BusType.SYSTEM);
      fso_play = conn.get_object ("org.freesmartphone.odeviced"
                                 ,"/org/freesmartphone/Device/Audio"
                                 ,"org.freesmartphone.Device.Audio");
    }
    
    public void ring() {
      try {
        fso_play.PlaySound(SOUND_FILE,0,0);
      } catch (GLib.Error e) {
        error("Couldn't play sound: %s".printf(SOUND_FILE));
      }
    }
    
    public void stop_ring() {
      try {
        fso_play.StopSound(SOUND_FILE);
      } catch (GLib.Error e) {
      }
    }
    
  }
}