/* TODO
 * Normal dist of origin 2/3 up parent branch
 * ADV: think about implementing center of mass type adjustments
 */

class Branch 
{
  // Base data
  Branch parent;
  ArrayList<Branch> branches = new ArrayList<Branch>(); 
  float angle;
  float len; 
  float locOnParent; // [0,1]
  int numChildBranches;

  // Accounting data
  int lvl;
  int branchNum;
  int maxLvl = 6;

  // Limiting variablies
  int maxNewBranches = 10;
  int minNewBranches = 0;
  float minBranchAngle = -PI/4;
  float maxBranchAngle = PI/4;
  float childLenghtlowerBound = 0.3;
  float childLenghtupperBound = 0.8;

  // Settings
  color BRANCH_COL = color(255);
  boolean PRINT_INFO = false;

  // top of branch split
  Branch(Branch _parent, float _locOnParent) 
  {
    Setup(_parent);
    locOnParent = _locOnParent; // override
  }

  // first branch
  Branch(float _len) 
  {
    Setup(null);
    len = _len;
  }

  Branch(Branch _parent) 
  {
    Setup(_parent);
  }

  void Setup(Branch _parent) 
  {
    parent = _parent;
    numChildBranches = ceil(random(minNewBranches - 1, maxNewBranches));

    if (_parent == null) // if first branch
    {
      angle = 0;
      locOnParent = 0;
      lvl = 0;
      branchNum = 0;
    } else
    {
      angle = BranchAngle();
      locOnParent=LocationOnParent(); 
      len = BranchLength(_parent.len);
      lvl = _parent.lvl + 1;
      branchNum = _parent.branches.size();
    }
    if (PRINT_INFO)
      PrintBranchInfo(this);
  }


  void Render()
  {
    if (branches.size() > 0)
    {
      for (Branch branch : branches)
      {
        pushMatrix();
        DrawBranch();
        branch.Render();
        popMatrix();
      }
    } else 
    {
      DrawBranch();
    }
  }

  boolean Grow()
  {
    if (lvl >= maxLvl)
      return false;  
    if (branches.size() > 0)
    {
      for (Branch branch : branches)
        branch.Grow();
    } else 
    {
      Split();
      for (int i = 0; i < numChildBranches; i++)
      {
        branches.add(new Branch(this));
      }
    }
    return true;
  }

  void Split()
  {
    branches.add(new Branch(this, 1));
    branches.add(new Branch(this, 1));
  }


  float BranchLength(float parentLenght)
  {
    /*
    float mid = (childLenghtlowerBound + childLenghtupperBound)/2;
    float rand = randomGaussian()*0.2 + mid;
    return  min(max(rand, childLenghtlowerBound), childLenghtupperBound)*parentLenght;
    */
    return random(parentLenght * childLenghtlowerBound, parentLenght* childLenghtupperBound);
  }

  float BranchAngle()
  {
    return random(minBranchAngle, maxBranchAngle);
  }

  float LocationOnParent()
  {
    return max(0.1, min(1, randomGaussian()*0.2 + 0.6));
    //return random(1);
  }

  void DrawBranch()
  {
    stroke(BRANCH_COL);
    translate(0, locOnParent*(parent == null ? 0 :  parent.len));
    rotate(angle);
    line(0, 0, 0, len);
    
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
    println(branch);
    println("branch lvl: " + branch.lvl);
    println("num branches: " + branch.branches.size());
    println("len: "+len);
    println("angle: "+angle);
    println("locOnParent: "+locOnParent);
    println("----------");
  }
}
