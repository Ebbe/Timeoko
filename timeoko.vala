/*********************************************

 (NOT USED) ring.wav sound by Razzvio under the license "CC Sampling Plus 1.0"
 http://www.freesound.org/samplesViewSingle.php?id=79568

 timeoko_ring.wav sound by joedeshon (modified by Esben Damgaard)
 under the license "CC Sampling Plus 1.0"
 http://www.freesound.org/samplesViewSingle.php?id=78562
 
 Icon by Everaldo Coelho under the license "LGPL"
 http://commons.wikimedia.org/wiki/Crystal_Clear

*********************************************/


using Elm;


namespace Timeoko {
  
  public void main(string[] args) {
    Elm.init(args);
    
    Controller controller = new Controller();
    controller.run_program();
    
    Elm.shutdown();
  }
  
}