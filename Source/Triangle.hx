package ;

import openfl.display.Sprite;
import openfl.geom.Vector3D;
import openfl.geom.Matrix3D;

class Triangle
{
  public var one:Vector3D;
  public var two:Vector3D;
  public var three:Vector3D;

  public var color:Int = 0x0000ff;
  public var line_width:Float = 1.0;
  public var alpha:Float = 1.0;

  public function new(one:Vector3D, two:Vector3D, three:Vector3D)
  {
    this.one = one;
    this.two = two;
    this.three = three;
  }

  public function scale(s:Float):Void
  {
    one.scaleBy(s);
    two.scaleBy(s);
    three.scaleBy(s);
  }

  public function translate(dx:Float, dy:Float, dz:Float)
  {
    one.x += dx;
    two.x += dx;
    three.x += dx;
    
    one.y += dy;
    two.y += dy;
    three.y += dy;
    
    one.z += dz;
    two.z += dz;
    three.z += dz;
  }

  public function changeOrigin(vec:Vector3D):Triangle
  {
    return new Triangle(vec.subtract(one), vec.subtract(two),
                                         vec.subtract(three));
  }

  public function rotate(rot:RotQuat)
  {
    rot.rotate(this.one);
    rot.rotate(this.two);
    rot.rotate(this.three);
  } 

  public function draw(screen:Sprite, cam:Camera)
  {
    screen.graphics.lineStyle(line_width, color, alpha);
    
    var t:Triangle = this.changeOrigin(cam.pos);

    t.one = cam.project(t.one);
    t.two = cam.project(t.two);
    t.three = cam.project(t.three);

    screen.graphics.moveTo(t.one.x/t.one.z, t.one.y/t.one.z);
    screen.graphics.lineTo(t.two.x/t.two.z, t.two.y/t.two.z);
    screen.graphics.lineTo(t.three.x/t.three.z, t.three.y/t.three.z);
    screen.graphics.lineTo(t.one.x/t.one.z, t.one.y/t.one.z);
  } 
}
