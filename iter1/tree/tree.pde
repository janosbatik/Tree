Branch tree;


void setup() {
  size(640, 360);
  frameRate(1);
  background(0);
  stroke(255);
   tree = new Branch(640, 360);
}

void draw() {

  
  tree.Render();
   tree.Grow();

}
