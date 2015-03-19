package ;

import openfl.geom.Vector3D;
import openfl.Vector;
import openfl.display.Sprite;

class Model
{
  var triangles:Vector<Triangle>;

  public function new(data:String)
  {
    var strings:Vector<String> = data.split("\n");
    triangles = new Vector<Triangle>();
   
    var s:String;

    for(s in strings)
    {
      if(s == "") continue;
      var t:Triangle = new Triangle(null, null, null);
      
      t.read(s);
      triangles.push(t);
    }
  }

  public function scale(s:Float)
  {
    var t:Triangle;

    for(t in triangles)
    {
      t.scale(s);
    }
  }

  public function translate(dx:Float, dy:Float, dz:Float)
  {
    var t:Triangle;

    for(t in triangles)
    {
      t.translate(dx, dy, dz);
    }
  }

  public function rotate(rot:RotQuat)
  { 
    var t:Triangle;

    for(t in triangles)
    {
      t.rotate(rot);
    }
  }

  public function draw(screen:Sprite, cam:Camera)
  {
    var t:Triangle;

    for(t in triangles)
    {
      t.draw(screen, cam);
    }
  }
}
