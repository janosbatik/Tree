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
  
  float childLenghtlowerBound = 0.15;
  float childLenghtupperBound = 0.6;

  CenterOfMass branchCenterMass;
  CenterOfMass lvlCenterMass;
  int massFactor; 

  int lvl;
  int branchNum;
  int maxLvl = 5;
  int maxNewBranches = 10;
  int minNewBranches = 0;
  float maxBranchAngle = PI/4;
  
  boolean DRAW_BRANCH_CENTER_OF_MASS = false;
  
  boolean DRAW_LVL_CENTER_OF_MASS = true;
  
  
  color BRANCH_COL = color(255);

  Branch(Branch _parent) 
  {
    Setup(_parent, RandomPointOnLine(_parent.o, _parent.end), NewBranchDir(_parent.dir));
  }

  // top of branch split
  Branch(Branch _parent, PVector _o) 
  {
    Setup(_parent, _o, NewBranchDir(_parent.dir));
  }

  // first branch
  Branch(PVector _o, PVector _dir) 
  {
    Setup(null, _o, _dir);
  }

  Branch(Branch _parent, PVector _o, PVector _dir) 
  {
    Setup(_parent, _o, _dir);
  }
  
  void Setup(Branch _parent, PVector _o, PVector _dir) 
  {
    parent = _parent;
    o = _o;
    dir = _dir;
    end = PVector.sub(o, _dir);
   
    if (_parent == null) // if first branch
    {
      lvl = 0;
      branchNum = 0;
      massFactor = maxLvl;
    } else
    {
      lvl = _parent.lvl + 1;
      branchNum = _parent.branches.size();
      massFactor = max(_parent.massFactor - 1, 1);
      
    }
    branchCenterMass = new CenterOfMass(PVector.sub(o, PVector.mult(dir, 0.5)), dir.mag()*massFactor);
    lvlCenterMass = new CenterOfMass(branchCenterMass.center.copy(), branchCenterMass.mass, false);
    UpdateParentCenterMass(branchCenterMass);
    //PrintBranchInfo(_parent);
  }

  void UpdateParentCenterMass(CenterOfMass newMass)
  {
    Branch tmpParent = parent;
    for (int i = lvl  - 1; i >= 0; i--)
    {
      tmpParent.lvlCenterMass.AddNewMass(newMass);
      tmpParent = tmpParent.parent;
    }
  }


  void Render()
  {
    if (branches.size() > 0)
    {
      for (Branch branch : branches)
      {
        DrawBranch();
        branch.Render();
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
      for (int i = 0; i < ceil(random(minNewBranches - 1, maxNewBranches)); i++)
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
    float mag = dir.mag();

    return random(mag * childLenghtlowerBound, mag* childLenghtupperBound);
  }

  void DrawBranch()
  {
    //strokeWeight( maxLvl + 2 - lvl);
    stroke(BRANCH_COL);
    stroke(255);
    line(o.x, o.y, end.x, end.y);    

    if (DRAW_LVL_CENTER_OF_MASS && lvl < 1)
    {
      lvlCenterMass.Draw();
    }

    if (DRAW_BRANCH_CENTER_OF_MASS && lvl < maxLvl)
    {
      branchCenterMass.Draw();
    }
  }

  void PrintBranchID()
  {
    print("Branch ID: ");
    Branch branch = this;
    if (lvl == 0)
    {
      println("trunk");
      return;
    }
    for (int i = lvl; i > 0; i--)
    {
      print(branch.lvl+":"+branch.branchNum+" ");
      branch = branch.parent;
    }
    println("");
  }
  void PrintBranchInfo(Branch branch)
  {

    println("branch lvl: " + branch.lvl);
    println("num branches: " + branch.branches.size());
    println("o: ("+branch.o.x+ ","+branch.o.y+")");
    println("end: ("+branch.end.x+ ","+branch.end.y+")");
    println("dir: ("+branch.dir.x+ ","+branch.dir.y+")");
    println("----------");
  }
}
