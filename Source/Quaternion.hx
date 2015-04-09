package ;

import openfl.geom.Vector3D;


class Quaternion
{
  public var a:Float;
  public var b:Float;
  public var c:Float;
  public var d:Float;

  public function new(a:Float, b:Float, c:Float, d:Float)
  {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
  }

  public function left_product(other:Quaternion):Quaternion
  {
    return new Quaternion(
      this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
      this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
      this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
      this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a);
  }

  public function right_product(other:Quaternion):Quaternion
  {
    return new Quaternion(
      other.a * this.a - other.b * this.b - other.c * this.c - other.d * this.d,
      other.a * this.b + other.b * this.a + other.c * this.d - other.d * this.c,
      other.a * this.c - other.b * this.d + other.c * this.a + other.d * this.b,
      other.a * this.d + other.b * this.c - other.c * this.b + other.d * this.a);
  }

  public function norm():Float
  {
    return Math.sqrt(a * a +  b * b + c * c + d * d);
  }

  public function normalize():Void
  {
    var n:Float = this.norm();

    this.a /= n;
    this.b /= n;
    this.c /= n;
    this.d /= n;
  }

  public function conjugate():Quaternion
  {
    return new Quaternion(a, -b, -c, -d);
  }

  public function reciprocal():Quaternion
  {
    var n:Float = this.norm();

    n = n*n;

    return new Quaternion(a/n, -b/n, -c/n, -d/n);
  }

  public function scale(s:Float):Void
  {
    a *= s;
    b *= s;
    c *= s;
    d *= s;
  }

  public function stereoProj():Vector3D
  {
    var rad:Float = this.norm();
    var p:Vector3D = new Vector3D(a/(rad-d), b/(rad-d), c/(rad-d));
 
    return p;
  }

  public function toString():String
  {
    var out:String = "";
    
    out += "(" + a + ", " + b + ", " + c + ", " + d + ")\n";
    
    return out;
  } 
}
