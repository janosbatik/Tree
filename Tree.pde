Branch tree;
boolean fin = false;

void setup() {
  size(850, 500);
  frameRate(3);
  background(0);
  stroke(255);
   
  tree = new Branch(-height/2);
}

void draw() {
  background(0);

  if (!fin) {
   translate(width/2, height/5*4);
    tree.Render();
    fin = !tree.Grow();
  }
}



PVector RandomHeight(int y)
{
  return new PVector(random(-0.03*y, 0.05*y), random(0.4*y, 0.6*y));
}
