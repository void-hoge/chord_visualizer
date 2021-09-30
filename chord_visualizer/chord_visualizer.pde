Circle cl;

void setup() {
  size(1280, 720);
  cl = new Circle(0,0,150);
  cl.add_chord(0.0, 3.0);
  cl.add_chord(0.2, 2.8);
  cl.add_chord(0.4, 2.6);
  cl.add_chord(0.6, 2.4);
  cl.add_chord(0.8, 2.2);
  cl.add_chord(1.0, 1.2);
  cl.add_chord(1.4, 2.0);
  cl.add_flare(0.0, 3.0);
  cl.add_flare(0.2, 2.8);
  cl.add_flare(0.4, 2.6);
  cl.add_flare(0.6, 2.4);
  cl.add_flare(0.8, 2.2);
  cl.add_flare(1.0, 1.2);
  cl.add_flare(1.4, 2.0);
}

void draw() {
  background(255);
  cl.display();
}
