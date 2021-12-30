Branch tree;
boolean fin = false;
PImage img;
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2;
boolean SAVE_OUTPUT = true;
SaveUtils utils;

void setup() {
  size(700, 700);
  frameRate(3);
  background(0);
  stroke(255);
  b1 = color(204, 255, 255); 
  b2 = color(255, 255, 153); 
  tree = new Branch(height/2);
  utils = new SaveUtils(tree.maxLvl+1);
}

void draw() {
  
  //setGradient(width/2, 0, width/2, height, b2, b1, Y_AXIS);

  if (!fin) {
  setGradient(0, 0, width, height, b1, b2, Y_AXIS);
    translate(width/2, height/8*7);

    tree.Render();
    fin = !tree.Grow();
    if (SAVE_OUTPUT)
      utils.SaveFrame();
  } 
}



void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  } else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
