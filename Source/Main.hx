package;

import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Vector3D;

class Main extends Sprite 
{
  var screen:Sprite;

  var inited:Bool;
	
  var t:Triangle;
  var cam:Camera;
  var rot:RotQuat;
  var rotSpeed:Float = 0.01;
  var rotAxis:Vector3D = new Vector3D(0,0,1);
	
  public function new () 
  {	
    super();
    init();		
  }
	
  function init():Void
  {
    if(inited) return;
    inited = true;

    screen = new Sprite();
    addChild(screen);

    var fps:FPS = new FPS(10, 10, 0x0000ff);
    addChild(fps);

    t = new Triangle(new Vector3D(0,0,0), new Vector3D(1,0,0),
                     new Vector3D(0,0,1));

    t.scale(100);
    
    cam = new Camera(new Vector3D(stage.stageWidth/2,stage.stageHeight/2,500),500);
   
    rot = new RotQuat(rotSpeed, rotAxis);

    this.addEventListener(Event.ENTER_FRAME, update);
  }

  function update(e:Event):Void
  {
    screen.graphics.clear();
    t.rotate(rot);
    t.draw(this.screen, cam);
  }	
}
