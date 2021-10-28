void setup() {
 	size(720, 720);
  //noLoop();
}

int x = 0;

void draw() {
  translate(width/2, height/2);
  background(255);
  display_parabola(5);
  display_tangent(5,-((float)mouseX-(width/2))/(width/2));
}

float linear(float a, float b, float x) {
  return a*x+b;
}

void display_tangent(float c, float x) {
  rotate(PI);
  float y = x*x*c;
  float ydash = 2*c*x;
  float a = ydash;
  float b = -y;
  line(0, linear(a, b, 0)*width/2, (float)1*width/2, linear(a, b, 1)*width/2);
  ellipseMode(CENTER);
  ellipse(0,0,5,5);
  rotate(-PI);
}

void display_parabola(float a) {
  rotate(PI);
  float x = 0, y = 0;
  float nx = 0, ny = 0;
  while (x < 1) {
    nx = x + 0.001;
    ny = nx*nx*a;
    line(x*width/2, y*width/2, nx*width/2, ny*width/2);
    line(-x*width/2, y*width/2, -x*width/2, ny*width/2);

    x = nx;
    y = ny;
  }
  rotate(PI);
}
