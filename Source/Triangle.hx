package ;

import openfl.geom.Vector3D;
import openfl.geom.Matrix3D;

class Triangle
{
  public var one:Vector3D;
  public var two:Vector3D;
  public var three:Vector3D;

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

  
}
