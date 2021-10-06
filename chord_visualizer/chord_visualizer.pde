Circle cl;

void setup() {
  size(1280, 720);
  noLoop();
  cl = new Circle(0,0,200);
  cl.add_point(0);
  cl.add_point(1);
  cl.add_point(2);

  cl.add_chord(0,2);
  cl.add_chord(0,1);
  cl.add_flare(1,2);
  cl.add_flare(0,2);
}

void draw() {
  background(255);
  cl.display();
}
