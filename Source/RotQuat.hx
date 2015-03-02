package ;

import openfl.geom.Vector3D;

class RotQuat
{
  var rot:Quaternion;
  var angle:Float;
  var axis:Vector3D;

  public function new(angle:Float, axis:Vector3D)
  {
    axis.normalize();

    this.angle = angle;
    this.axis = axis;

    rot = new Quaternion(Math.cos(angle/2), Math.sin(angle/2) * axis.x,
                         Math.sin(angle/2) * axis.y, Math.sin(angle/2) * axis.z);
  }

  public function rotate(vec:Vector3D):Void
  {
    var vector:Quaternion = new Quaternion(0, vec.x, vec.y, vec.z);

    var rotated:Quaternion = rot.left_product(vector).left_product(rot.reciprocal());

    vec.x = rotated.b;
    vec.y = rotated.c;
    vec.z = rotated.d;
  }
}
