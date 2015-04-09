package ;

import openfl.Vector;
import openfl.display.Sprite;
import openfl.geom.Vector3D;

class Grid4D
{
  var points:Vector<Vector<Vector<Vector<Quaternion>>>>;

  var world_coords:Vector<Quaternion>;

  var length:Float;

  public function new(maxX:Int, maxY:Int, maxZ:Int, maxW:Int, length:Float)
  {
    this.length = length;

    points = new Vector<Vector<Vector<Vector<Quaternion>>>>();
    world_coords = new Vector<Quaternion>();

    var x:Int, y:Int, z:Int, w:Int;

    for(x in 0...maxX)
    {
      var xtemp:Vector<Vector<Vector<Quaternion>>> = new Vector<Vector<Vector<Quaternion>>>();
      for(y in 0...maxY)
      {
        var ytemp:Vector<Vector<Quaternion>> = new Vector<Vector<Quaternion>>();
        for(z in 0...maxZ)
        {
          var ztemp:Vector<Quaternion> = new Vector<Quaternion>();
          for(w in 0...maxW)
          {
            ztemp.push(new Quaternion((2*x - maxX)/2.0 * length, 
                                      (2*y - maxY)/2.0 * length,
                                      (2*z - maxZ)/2.0 * length,
                                      (2*w - maxW)/2.0 * length));
          }
          ytemp.push(ztemp);
        }
        xtemp.push(ytemp);
      } 
      points.push(xtemp);
    }
    precompute();
  }

  public function precompute()
  {
    world_coords = new Vector<Quaternion>();

    var xtemp:Vector<Vector<Vector<Quaternion>>>;
    for(xtemp in points)
    {
      var ytemp:Vector<Vector<Quaternion>>;
      for(ytemp in xtemp)
      {
        var ztemp:Vector<Quaternion>;
        for(ztemp in ytemp)
        {
          var point:Quaternion;
          for(point in ztemp)
          {
            world_coords.push(point);
          }
        }
      }
    }
  } 

  public function draw(screen:Sprite, cam:Camera)
  {
    screen.graphics.lineStyle(1.0, 0x0000ff, 1.0);

    var point:Quaternion;
    
    for(point in world_coords)
    {
      var rad:Float = point.norm();
      var p:Vector3D = new Vector3D(point.a/(rad - point.d), point.b/(rad - point.d), 
                                    point.c/(rad - point.d));

      p.scaleBy(length);

      p = cam.pos.subtract(p);
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
          var w:Int;
          for(w in 0...(points[x][y][z].length))
          {
            var point = points[x][y][z][w];

            var p:Vector3D = point.stereoProj();
            p.scaleBy(length);
            p = cam.pos.subtract(p);
            p = cam.project(p);

            var q:Vector3D;
            if(x+1 < points.length)
            {
              q = points[x+1][y][z][w].stereoProj();
              q.scaleBy(length);
              q = cam.pos.subtract(q);
              q = cam.project(q);

              screen.graphics.moveTo(p.x/p.z, p.y/p.z);
              screen.graphics.lineTo(q.x/q.z, q.y/q.z);
            }
            if(y+1 < points[x].length)
            {
              q = points[x][y+1][z][w].stereoProj();
              q.scaleBy(length);
              q = cam.pos.subtract(q);
              q = cam.project(q);

              screen.graphics.moveTo(p.x/p.z, p.y/p.z);
              screen.graphics.lineTo(q.x/q.z, q.y/q.z);
            }
            if(z+1 < points[x][y].length)
            {
              q = points[x][y][z+1][w].stereoProj();
              q.scaleBy(length);
              q = cam.pos.subtract(q);
              q = cam.project(q);

              screen.graphics.moveTo(p.x/p.z, p.y/p.z);
              screen.graphics.lineTo(q.x/q.z, q.y/q.z);
            }
            if(w+1 < points[x][y][z].length)
            {
              q = points[x][y][z][w+1].stereoProj();
              q.scaleBy(length);
              q = cam.pos.subtract(q);
              q = cam.project(q);

              screen.graphics.moveTo(p.x/p.z, p.y/p.z);
              screen.graphics.lineTo(q.x/q.z, q.y/q.z);
            }
          }
        }
      }
    }
  }

  
}
