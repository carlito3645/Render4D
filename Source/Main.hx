package;

import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Vector3D;
import openfl.Assets;


class Main extends Sprite 
{
  var screen:Sprite;

  var inited:Bool;
	
  var cube:Model;
  var cam:Camera;
  var rot:RotQuat;
  var rotSpeed:Float = 0.01;
  var rotAxis:Vector3D = new Vector3D(1,1,1);
	
  public function new () 
  {	
    super();
    init();		
  }
	
  function init():Void
  {
    if(inited) return;
    inited = true;

    trace("Begin Init: ");

    screen = new Sprite();
    addChild(screen);

    var fps:FPS = new FPS(10, 10, 0x0000ff);
    addChild(fps);

    trace("Begin Asset Loading: ");
    Assets.loadText("assets/cube.txt", function (_loadedText):Void{
         cube = new Model(_loadedText);
         trace("End Asset Loading");});

 
    cube.scale(100);
    
    cam = new Camera(new Vector3D(stage.stageWidth/2,stage.stageHeight/2,500),500);
   
    rot = new RotQuat(rotSpeed, rotAxis);

    this.addEventListener(Event.ENTER_FRAME, update);
  }

  function update(e:Event):Void
  {
    screen.graphics.clear();
    cube.rotate(rot);
    cube.draw(this.screen, cam);
  }	
}
