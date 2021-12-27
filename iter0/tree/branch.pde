class Branch 
{
  Branch parent;
  ArrayList<Branch> branches = new ArrayList<Branch>(); 
  PVector o;
  PVector len;
  PVector end;
  int lvl;
  int maxLvl = 5;
  int maxNewBranches = 4;

  Branch(Branch _parent) 
  {
    parent = _parent;
    len = NewBranchLen(_parent.len);
    o = RandomPointOnLine(_parent.o, _parent.end);
    end = PVector.sub(o, len);
    lvl = _parent.lvl + 1;
    PrintBranchInfo(_parent);
    //println("New Branch created at: lvl: " + lvl + " starting at: " + o.x + " " + o.y);
  }

  // first branch
  Branch(int x, int y) 
  {
    parent = null;
    len = new PVector(0, 0.75*y); 
    o = new PVector(x/2, 0.9*y); 
    end = PVector.sub(o, len);
    lvl = 0;

    println("New Branch created at: lvl: " + lvl + " starting at: " + o.x + " " + o.y);
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
  
  void Grow()
  {
    if (lvl > maxLvl)
      return;  
    if (branches.size() > 0)
    {
      for (int i = 0; i < branches.size(); i++)
      {
        branches.get(i).Grow();
      }
    } else 
    {
      for (int i = 0; i < maxNewBranches; i++)
      {
        branches.add(new Branch(this));
      }
    }
  }

  PVector RandomPointOnLine(PVector a, PVector b)
  {
    //(1−u)p1+up2
    float u = random(1);
    return PVector.add(PVector.mult(a,1 - u), PVector.mult(b,u));
  }

  PVector NewBranchLen(PVector len)
  {
    float lowerBound = 0.2;
    float upperBound = 1;

    float mag = len.mag();

    float newMag = random(mag * lowerBound, mag* upperBound);
    
    PVector newLen = new PVector(random(-1,1), random(-1,1));
    newLen.normalize();
    newLen.mult(newMag);
    return newLen;
  }
  
  void DrawBranch()
  {
    strokeWeight( maxLvl + 2 - lvl);
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
