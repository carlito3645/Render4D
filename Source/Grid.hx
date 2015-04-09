package ;

import openfl.Vector;
import openfl.display.Sprite;
import openfl.geom.Vector3D;
import openfl.geom.Matrix3D;

class Grid
{
  var points:Vector<Vector<Vector<Vector3D>>>;
  var world_coords:Vector<Vector3D>;

  public function new(maxX:Int, maxY:Int, maxZ:Int, length:Float)
  {
    points = new Vector<Vector<Vector<Vector3D>>>();

    world_coords = new Vector<Vector3D>(); 

    var x:Int, y:Int, z:Int;

    for(x in 0...maxX)
    {
      var xtemp:Vector<Vector<Vector3D>> = new Vector<Vector<Vector3D>>();
      for(y in 0...maxY)
      {
        var ytemp:Vector<Vector3D> = new Vector<Vector3D>();
        for(z in 0...maxZ)
        {
          ytemp.push(new Vector3D((2*x-maxX)/2.0 * length, (2*y-maxY)/2.0 * length, (2*z-maxZ)/2.0 * length));
        }
        xtemp.push(ytemp);
      }
      points.push(xtemp);
    }
    precompute();
  }

    public function precompute()
    {
      world_coords = new Vector<Vector3D>();

      var xtemp:Vector<Vector<Vector3D>>;
      for(xtemp in points)
      {
        var ytemp:Vector<Vector3D>;
        for(ytemp in xtemp)
        {
          var point:Vector3D;
          for(point in ytemp)
          {
            world_coords.push(point);
          }
        }
      }

      trace("Precompute Finished");
    }

  public function draw(screen:Sprite, cam:Camera)
  {
    screen.graphics.lineStyle(1.0, 0x0000ff, 1.0);
 
    var point:Vector3D;

    for(point in world_coords)
    {
      var p:Vector3D = cam.pos.subtract(point);
      p = cam.project(p);

      screen.graphics.drawRect(p.x/p.z - 2.5, p.y/p.z - 2.5, 5.0, 5.0);
    }

    var x:Int;
    for(x in 0...(points.length))
    {
      var y:Int;
      for(y in 0...(points[x].length))
      {
        var z:Int;
        for(z in 0...(points[x][y].length))
        {
          var p:Vector3D = cam.pos.subtract(points[x][y][z]);
          p = cam.project(p);

        var q:Vector3D;
        if(x+1 < points.length)
        {
          q = cam.pos.subtract(points[x+1][y][z]);
          q = cam.project(q);

          screen.graphics.moveTo(p.x/p.z, p.y/p.z);
          screen.graphics.lineTo(q.x/q.z, q.y/q.z);
       }
       if(y+1 < points[x].length)
       {
          q = cam.pos.subtract(points[x][y+1][z]);
          q = cam.project(q); 

          screen.graphics.moveTo(p.x/p.z, p.y/p.z);
          screen.graphics.lineTo(q.x/q.z, q.y/q.z);
       }
       if(z+1 < points[x][y].length)
       {
          q = cam.pos.subtract(points[x][y][z+1]);
          q = cam.project(q);

          screen.graphics.moveTo(p.x/p.z, p.y/p.z);
          screen.graphics.lineTo(q.x/q.z, q.y/q.z);
       } 
       }
      }
    }

  }

  public function rotate(rot:RotQuat)
  {
    var point:Vector3D;

    for(point in world_coords)
    {
      rot.rotate(point);
    }
  }


  public function transform(def:Matrix3D)
  {
    var point:Vector3D;
    
    for(point in world_coords)
    {
      var temp:Vector3D = def.transformVector(point);
      point.x = temp.x;
      point.y = temp.y;
      point.z = temp.z;
      point.w = temp.w;
    }
  }

  public function getPos(x:Int, y:Int, z:Int):Vector3D
  {
    var out:Vector3D = new Vector3D(-1,-1,-1);

    if(x < 0 || y < 0 || z < 0) return out;
    if(x > points.length) return out;
    if(y > points[x].length) return out;
    if(z > points[x][y].length) return out;

    out = points[x][y][z];

    return out;
  } 
}
