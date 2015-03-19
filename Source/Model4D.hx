package ;

import openfl.Vector;
import openfl.display.Sprite;
import openfl.geom.Vector3D;

class Model4D
{
  var adjacency:Vector<Pair<Quaternion>>;

  public function new(data:String)
  {
    adjacency = new Vector<Pair<Quaternion>>();
    this.read(data);
  }


  // Needs lot of input checking
  public function read(data:String):Void
  {
    var lines:Vector<String> = data.split("\n");

    var line:String;

    for(line in lines)
    {
      if(line == "") continue;
 
      var points:Vector<String> = line.split(";");
      
      var string_coords:Vector<String> = points[0].split(",");

      var coords:Vector<Float> = new Vector<Float>();

      var s:String;

      for(s in string_coords)
      {
        coords.push(Std.parseFloat(s));
      }
      var one:Quaternion = new Quaternion(coords[0], coords[1],
                                          coords[2], coords[3]);

      string_coords = points[1].split(",");
      coords = new Vector<Float>();

      for(s in string_coords)
      {
        coords.push(Std.parseFloat(s));
      }
      var two:Quaternion = new Quaternion(coords[0], coords[1],
                                          coords[2], coords[3]);

      adjacency.push(new Pair<Quaternion>(one, two));
    }
  }

  public function draw(screen:Sprite, cam:Camera)
  {
    screen.graphics.lineStyle(1.0, 0x0000ff, 1.0);


    var points:Pair<Quaternion>;

    for(points in adjacency)
    {
      var one:Quaternion = points.one;
      var two:Quaternion = points.two;
      var p:Vector3D;
      var q:Vector3D;

      var rad:Float = one.norm();
      p = new Vector3D(one.a/(rad - one.d), one.b/(rad - one.d), 
                       one.c/(rad - one.d));

      rad = two.norm();
      q = new Vector3D(two.a/(rad - two.d), two.b/(rad - two.d),
                       two.c/(rad - two.d));

      p.scaleBy(100);
      q.scaleBy(100);

      p = cam.pos.subtract(p);
      q = cam.pos.subtract(q);

      p = cam.project(p);
      q = cam.project(q);


//      if(p.x > 1920 || p.x < 0) continue;
//      if(q.x > 1920 || q.x < 0) continue;
//      if(p.y > 1080 || p.y < 0) continue;
//      if(q.y > 1080 || q.y < 0) continue;

      screen.graphics.moveTo(p.x/p.z, p.y/p.z);
      screen.graphics.lineTo(q.x/q.z, q.y/q.z);
    }
  }

  public function scale(s:Float)
  {
    var points:Pair<Quaternion>;

    for(points in adjacency)
    {
      points.one.scale(s);
      points.two.scale(s);
    }
  }

  public function rotate(left:Quaternion, right:Quaternion)
  {
    left.normalize();
    right.normalize();

    var points:Pair<Quaternion>;

    for(points in adjacency)
    {
      points.one = left.left_product(points.one.left_product(right));
      points.two = left.left_product(points.two.left_product(right));
    }
  }
  
}
