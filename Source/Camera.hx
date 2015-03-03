package ;

import openfl.geom.Matrix3D;
import openfl.geom.Vector3D;

class Camera
{
  public var pos:Vector3D;
  public var matrix:Matrix3D;

  public function new(pos:Vector3D, f:Float)
  {
    this.pos = pos;

    this.matrix = new Matrix3D([f, 0, 0, 0,
                                0, f, 0, 0,
                                0, 0, 1, 0,
                                0, 0, 0, 1]);
  }

  public function project(vec:Vector3D):Vector3D
  {
    var out:Vector3D = matrix.transformVector(vec);

    return out;
  }
}
