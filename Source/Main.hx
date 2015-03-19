package;

import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Vector3D;
import openfl.Assets;
import openfl.Vector;

class Main extends Sprite 
{
  var screen:Sprite;

  var inited:Bool;
	
  var cube:Model;
  var hypercube:Model4D;
  var cam:Camera;
  var rot:RotQuat;
  var rotSpeed:Float = 0.01;
  var rotAxis:Vector3D = new Vector3D(1,0,0);
  var cubesLoaded:Bool;

  var leftRot:RotQuat;
  var rightRot:RotQuat;

  var leftRotSpeed:Float = 0.006;
  var leftRotAxis:Vector3D = new Vector3D(1,0,1);
  var rightRotSpeed:Float = 0.006;
  var rightRotAxis:Vector3D = new Vector3D(0,1,1);
	
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

//    Assets.loadText("assets/cube.txt", function (_loadedText):Void{
//         cube = new Model(_loadedText);
//         cube.scale(100);});

    Assets.loadText("assets/hypercube.txt", function(_loadedText):Void{
         hypercube = new Model4D(_loadedText);
         hypercube.scale(100);});
 
    
    cam = new Camera(new Vector3D(stage.stageWidth/2,stage.stageHeight/2,500),500);
   
    rot = new RotQuat(rotSpeed, rotAxis);

    leftRot = new RotQuat(leftRotSpeed, leftRotAxis);
    rightRot = new RotQuat(rightRotSpeed, rightRotAxis);

    this.addEventListener(Event.ENTER_FRAME, update);
  }

  function update(e:Event):Void
  {
    screen.graphics.clear();

//    cube.rotate(rot);
//    cube.draw(this.screen, cam);

    hypercube.rotate(leftRot.rot, rightRot.rot);
    hypercube.draw(this.screen, cam);
  }	
}
