/* TODO
 * Normal dist of origin 2/3 up parent branch
 * ADV: think about implementing center of mass type adjustments
 */

class Branch 
{
  // Growth
  float chanceOfNewBranch = 0.01;
  boolean hasSplit = false;
  boolean stillGrowing = true;
  float chanceOfSplit = 0.2;
  int minSplitAge = 400;
  int initLen = 2;


  // Base data
  Branch parent;
  ArrayList<Branch> branches = new ArrayList<Branch>(); 
  float angle;
  float len; 
  float locOnParent; // [0,1]

  // Accounting data
  int lvl;
  int branchNum;
  int maxLvl = 3;
  int age = 1;

  // Limiting variablies
  int maxBranches = 6;
  float minBranchAngle = -PI/2;
  float maxBranchAngle = PI/2;
  float childLenghtlowerBound = 0.3;
  float childLenghtupperBound = 0.65;

  // Settings
  color BRANCH_COL = color(0);
  boolean PRINT_INFO = false;

  // top of branch split
  Branch(Branch _parent, float _locOnParent) 
  {
    this(_parent);
    locOnParent = _locOnParent; // override
  }

  // first branch
  Branch(float _len) 
  {
    this(null);
    len = _len;
  }

  Branch(Branch _parent) 
  {
    parent = _parent;

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
      len = initLen; 
      BranchLength(_parent.len);
      lvl = _parent.lvl + 1;
      branchNum = _parent.branches.size();
    }
    if (PRINT_INFO)
      PrintBranchInfo(this);
  }


  float GrowthRate(int age)
  {
    return sqrt(1.0/(100.0*float(age)));
  }

  void Render()
  {
    DrawBranch();
    if (branches.size() > 0)
    {
      for (Branch branch : branches)
      {
        pushMatrix();
        branch.Render();
        popMatrix();
      }
    }
  }


  void Grow()
  {
        GrowBranch();
    if (branches.size() > 0)
    {
      for (Branch branch : branches)
      {
        branch.Grow();
      }
    }
  }

  void GrowBranch()
  {
    if (stillGrowing) {
      len += GrowthRate(age)*len;
      println(len, GrowthRate(age));
      if (age > minSplitAge && RandomSuccess(chanceOfSplit) && !hasSplit)
      {
        println("split");
        stillGrowing = false;
        hasSplit = true;
        for (int n = 0; n < ceil(random(3)); n++)
          branches.add(new Branch(this, 1));
      }
      if (RandomSuccess(chanceOfNewBranch))
      {
        branches.add(new Branch(this));
      }
    }
    age++;
  }

  boolean RandomSuccess(float chanceSuccess)
  {
    return random(1) < chanceSuccess;
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
    imageMode(CENTER);
    stroke(BRANCH_COL);
    translate(0, locOnParent*(parent == null ? 0 :  -parent.len));
    rotate(angle);
    line(0, 0, 0, -len);
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
