class CenterOfMass
{
  float SIZE = 10;
  color DEFAULT_COL = color(255, 204, 0);
  boolean FILL = true;

  PVector center;
  float mass;
  color colour;

  CenterOfMass(PVector _center, float _mass)
  {
    SetUp(_center, _mass, DEFAULT_COL);
  }

  CenterOfMass(PVector _center, float _mass, color _col)
  {
    SetUp(_center, _mass, _col);
  }  

  CenterOfMass(PVector _center, float _mass, boolean randomCol)
  {
    if (randomCol)
      SetUp(_center, _mass, color(random(255),random(255),random(255)));
    else
      SetUp(_center, _mass, DEFAULT_COL);
  } 

  void SetUp(PVector _center, float _mass, color _colour)
  {
    center = _center;
    mass = _mass;
    colour = _colour;
  }

  void AddNewMass(CenterOfMass newMass)
  {
    float totalMass = mass + newMass.mass;
    center = PVector.div( PVector.add( PVector.mult(center, mass), PVector.mult(newMass.center, newMass.mass)), totalMass);
    ;
    mass = totalMass;
  }

  void Draw()
  {
    stroke(colour);

    if (FILL)
      fill(colour);
    else
      noFill();
    point(center.x, center.y);
    ellipse(center.x, center.y, SIZE, SIZE);
  }
}
