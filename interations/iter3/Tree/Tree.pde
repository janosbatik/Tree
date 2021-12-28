/* 
 stair like tree to show the moving center of mass
*/

int count = 0;
int yflip = -1;

Branch b1;
Branch b2;

Branch base;

void setup() {
  size(850, 500);
  frameRate(1);
  background(0);
  stroke(255);


  base = new Branch(new PVector(20, height), new PVector(0, height/6));
  b1 = new Branch(base, base.end.copy(), new PVector(-base.dir.y, base.dir.x));
  base.branches.add(b1);
  b2 = b1;
}
void draw() {
  background(0);

  println("Pass "+ count++);
  base.Render();

  b1 = new Branch(b2, b2.end.copy(), new PVector(-b2.dir.y, yflip*b2.dir.x));
  b2.branches.add(b1);
  b2 = b1; 
  yflip = yflip * -1;
}



PVector RandomHeight(int y)
{
  return new PVector(random(-0.03*y, 0.05*y), random(0.4*y, 0.6*y));
}
