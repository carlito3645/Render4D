package;

import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Vector3D;
import openfl.geom.Matrix3D;
import openfl.Assets;
import openfl.Vector;
import openfl.events.KeyboardEvent;

class Main extends Sprite 
{
  var screen:Sprite;
  var cam:Camera;

  var pos:Vector3D;
  var worldPos:Vector3D;

  var inited:Bool;
  var frameCount:Int;
	
//  var cube:Model;
//  var hypercube:Model4D;
  var rot:RotQuat;
  var rotSpeed:Float = 0.001;
  var rotAxis:Vector3D = new Vector3D(1,1,1);

  var shear:Matrix3D;
  var shearSpeed:Float = 0.005;

//  var cubesLoaded:Bool;
/*
  var leftRot:RotQuat;
  var rightRot:RotQuat;

  var leftRotSpeed:Float = 0.006;
  var leftRotAxis:Vector3D = new Vector3D(1,0,0);
  var rightRotSpeed:Float = 0.006;
  var rightRotAxis:Vector3D = new Vector3D(0,1,0);
*/

  var grid:Grid;
  var hypergrid:Grid4D;
	
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
/*
    Assets.loadText("assets/hypercube.txt", function(_loadedText):Void{
         hypercube = new Model4D(_loadedText);
         hypercube.scale(1);});
 */
    
    cam = new Camera(new Vector3D(stage.stageWidth/2,stage.stageHeight/2,500),500);
    shear = new Matrix3D([1.0, 0.1, 0.0, 0.0,
                          0.0, 1.0, 0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          0.0, 0.0, 0.0, 1.0]);


    rot = new RotQuat(rotSpeed, rotAxis);
/*
    leftRot = new RotQuat(leftRotSpeed, leftRotAxis);
    rightRot = new RotQuat(rightRotSpeed, rightRotAxis);
*/
    grid = new Grid(5, 6, 7, 50.0);
    hypergrid = new Grid4D(5, 3, 2, 4, 50.0);

    pos = new Vector3D(0, 0, 0);
    worldPos = grid.getPos(Std.int(pos.x), Std.int(pos.y), Std.int(pos.z));

    frameCount = 0;

    stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    this.addEventListener(Event.ENTER_FRAME, update);
  }

  function update(e:Event):Void
  {
/*
    shear = new Matrix3D([1.0, Math.sin(0.005 * frameCount) * shearSpeed, 0.0, 0.0,
                          0.0,                             1.0, 0.0, 0.0,
                          0.0,                             0.0, 1.0, 0.0,
                          0.0,                             0.0, 0.0, 1.0]);

    screen.graphics.clear();
    grid.transform(shear);

    shear = new Matrix3D([1.0, 0.0, Math.sin(0.005 * frameCount) * shearSpeed, 0.0,
                          0.0,                             1.0, 0.0, 0.0,
                          0.0,                             0.0, 1.0, 0.0,
                          0.0,                             0.0, 0.0, 1.0]);
    grid.transform(shear);

    grid.rotate(rot);
*/
//    cube.rotate(rot);
//    cube.draw(this.screen, cam);
/*
    hypercube.rotate(leftRot.rot,f rightRot.rot);
    hypercube.draw(this.screen, cam);
*/
/*
    grid.draw(this.screen, cam);

    worldPos = grid.getPos(Std.int(pos.x), Std.int(pos.y), Std.int(pos.z));

    var p:Vector3D = cam.pos.subtract(worldPos);
    p = cam.project(p);
    this.screen.graphics.lineStyle(1.0, 0xFA0000, 1.0);
    this.screen.graphics.drawCircle(p.x/p.z, p.y/p.z,10.0);
*/
    hypergrid.draw(this.screen, cam);
 
    frameCount++;
  }	

  function onKeyDown(e:KeyboardEvent):Void
  {
    var badvec = new Vector3D(-1, -1, -1);
    switch(e.keyCode)
    {
      case 87: // W
       if(!grid.getPos(Std.int(pos.x) + 1, Std.int(pos.y), Std.int(pos.z)).equals(badvec)) pos.x++; 
      case 65: // A
       if(!grid.getPos(Std.int(pos.x), Std.int(pos.y) - 1, Std.int(pos.z)).equals(badvec)) pos.y--; 
      case 83: // S
       if(!grid.getPos(Std.int(pos.x) - 1, Std.int(pos.y), Std.int(pos.z)).equals(badvec)) pos.x--; 
      case 68: // D
       if(!grid.getPos(Std.int(pos.x), Std.int(pos.y) + 1, Std.int(pos.z)).equals(badvec)) pos.y++; 
      case 81: // Q
       if(!grid.getPos(Std.int(pos.x), Std.int(pos.y), Std.int(pos.z) + 1).equals(badvec)) pos.z++; 
      case 69: // E
       if(!grid.getPos(Std.int(pos.x), Std.int(pos.y), Std.int(pos.z) - 1).equals(badvec)) pos.z--; 
      default: return;
    }
  }
}
