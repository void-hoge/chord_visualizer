Circle cl;

void setup() {
  size(1280, 720);
  noLoop();
  cl = new Circle(0,0,200);
  cl.add_parabola(PI*2);
  cl.add_flare(-0.39, -0.75);
  cl.add_parabola(PI/2);
  cl.add_flare(-1.38, 0.39);
  cl.add_parabola(PI/16);
  cl.add_flare(-1.76, 0.75);
  cl.add_parabola(-PI/16);
  cl.add_flare(-2.86+2*PI, 1.38);
  cl.add_parabola(-PI*4);
  cl.add_flare(2.86, 1.76);
}

void draw() {
  background(255);
  cl.display();
}
