package;


import openfl.display.Sprite;
import openfl.events.Event;


class Main extends Sprite 
{	
	
  public function new () 
  {	
    super();
    init();		
  }
	
  function init():Void
  {


    this.addEventListener(Event.ENTER_FRAME, update);
  }

  function update():Void
  {
    
  }	
}
