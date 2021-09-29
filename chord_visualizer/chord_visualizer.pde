Circle cl;

void setup() {
	size(1280, 720);
  cl = new Circle(0,0,200);
  cl.add_line(0.0, 2.0);
  cl.add_line(2.5, 3.0);
  cl.add_line(4.5, 5.0);
  cl.add_line(3.5, 6.0);
}

void draw() {
  background(255);
  cl.display();
}
