/* TODO
 * Normal dist of origin 2/3 up parent branch
 * ADV: think about implementing center of mass type adjustments
 */

class Branch 
{
  Branch parent;
  ArrayList<Branch> branches = new ArrayList<Branch>(); 
  PVector o;
  PVector dir;
  PVector end;
  int lvl;
  int maxLvl = 5;
  int maxNewBranches = 10;
  float maxBranchAngle = PI/4;

  Branch(Branch _parent) 
  {
    Setup(_parent, RandomPointOnLine(_parent.o, _parent.end));
  }

  // top of branch split
  Branch(Branch _parent, PVector _o) 
  {
    Setup(_parent, _o);
  }

  // first branch
  Branch(PVector _o, PVector _dir) 
  {
    parent = null;
    dir = _dir; //new PVector(0, 0.5*y); 
    o =  _o; //new PVector(x/2, 0.9*y); 
    end = PVector.sub(o, dir);
    lvl = 0;

    println("New Branch created at: lvl: " + lvl + " starting at: " + o.x + " " + o.y);
  }

  void Setup(Branch _parent, PVector _o) 
  {
    parent = _parent;
    o = _o;
    dir = NewBranchDir(_parent.dir);
    end = PVector.sub(o, dir);
    lvl = _parent.lvl + 1;
    //PrintBranchInfo(_parent);
  }

  void Render()
  {
    if (lvl > maxLvl)
      return;  
    if (branches.size() > 0)
    {
      for (int i = 0; i < branches.size(); i++)
      {
        branches.get(i).Render();
      }
    } else 
    {
      DrawBranch();
    }
  }

  boolean Grow()
  {
    if (lvl > maxLvl)
      return false;  
    if (branches.size() > 0)
    {
      for (int i = 0; i < branches.size(); i++)
      {
        branches.get(i).Grow();
      }
    } else 
    {
      Split();
      for (int i = 0; i < ceil(random(maxNewBranches)); i++)
      {
        branches.add(new Branch(this));
      }
    }
    return true;
  }

  void Split()
  {
    branches.add(new Branch(this, end.copy()));
    branches.add(new Branch(this, end.copy()));
  }

  PVector RandomPointOnLine(PVector a, PVector b)
  {
    //(1−u)p1+up2
    float u = random(1);
    return PVector.add(PVector.mult(a, 1 - u), PVector.mult(b, u));
  }

  PVector NewBranchDir(PVector dir)
  {
    PVector newDir = dir.copy().rotate(random(-1*maxBranchAngle, maxBranchAngle)); // create norm vec
    newDir.setMag(NewBranchMag(dir));
    return newDir;
  }


  float NewBranchMag(PVector dir)
  {
    float lowerBound = 0.1;
    float upperBound = 0.5;

    float mag = dir.mag();

    return random(mag * lowerBound, mag* upperBound);
  }

  /* int RandomDir()
   {
   return (floor(random(2)) * 2) - 1 ;
   }*/

  void DrawBranch()
  {
    //strokeWeight( maxLvl + 2 - lvl);
    line(o.x, o.y, end.x, end.y);
  }

  void PrintBranchInfo(Branch branch)
  {
    return;
    /*
    println("branch lvl: " + branch.lvl);
     println("num branches: " + branch.branches.size());
     println("o: ("+branch.o.x+ ","+branch.o.y+")");
     println("end: ("+branch.end.x+ ","+branch.end.y+")");
     println("len: ("+branch.len.x+ ","+branch.len.y+")");
     println("----------");
     */
  }
}
