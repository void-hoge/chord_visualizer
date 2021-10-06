Circle cl;

void setup() {
  size(1280, 720);
  noLoop();
  cl = new Circle(0,0,200);
  
  cl.add_parabola(2);
  cl.add_parabola(-3);
  cl.add_chord(0,3);
  cl.add_chord(1,2);
  cl.add_flare(0,1);
  cl.add_flare(2,3);

}

void draw() {
  //background(255);
  cl.display();
}
