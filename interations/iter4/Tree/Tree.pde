PImage img;
PImage leg;
float w1;
float w2;
float t;
float ih = 20;
float iw = 60;
int count = 0;


void setup() {
  size(850, 500);
  frameRate(3);
  background(0);
  stroke(255);
  
  imageMode(CENTER);
  img = loadImage("img/leg.jpg");
  leg = loadImage("img/leg.png");
  
  w1 = width/5*2;
  w2 = width/5*4;
  t = width/2;
}

void draw() {

image(img, w1, t+ih*count--, iw+(2*count), ih );

image(leg, w2, t+ih*count);
}

/*
ArrayList<Branch> trees = new ArrayList<Branch>();
float numTrees = 5.0;
boolean fin = false;

void setup() {
  size(850, 500);
  frameRate(3);
  background(0);
  stroke(255);


  for (int i = 0; i < numTrees; i++)
  {

    PVector o = new PVector(850*((i+1)/(numTrees+1)), 500);
    trees.add(new Branch(o, RandomHeight(500)));
  }
}

void draw() {
  background(0);

  if (!fin) {
    for (Branch tree : trees) {
      tree.Render();
      fin = !tree.Grow();
    }
  }
}



PVector RandomHeight(int y)
{
  return new PVector(random(-0.03*y, 0.05*y), random(0.4*y, 0.6*y));
}

*/
