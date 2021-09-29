class Point{
  float a;
  float b;
  Point(float a, float b) {
    this.a = a;
    this.b = b;
  }
  Point() {
    a = 0;
    b = 0;
  }
}

class Circle{
  int point_size = 5;
  int radius;
  int x;
  int y;
  ArrayList<Point> line;
  Circle(int x, int y, int radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    line = new ArrayList<Point>();
  }
  void add_line(float a, float b) {
    this.line.add(new Point(a,b));
  }
  void display() {
    ellipseMode(CENTER);
    translate(width/2, height/2);
    rotate(-PI/2);
    stroke(0);
    noFill();
    ellipse(x,y,radius*2, radius*2);
    this.display_chord();
    this.display_flare();
  }
  void display_flare() {
    stroke(2);
    noFill();
    for (int i = 0; i < this.line.size(); i++){
      Point p = this.line.get(i);
      float coef = abs(p.a - p.b)/PI+1;
      float anchor1 = p.a;
      float anchor2 = p.a+(p.b-p.a)/4;
      float anchor3 = p.a+(p.b-p.a)/2;
      float anchor4 = p.a+(p.b-p.a)*3/4;
      float anchor5 = p.b;

      Point a_c = new Point(cos(p.a)*radius, sin(p.a)*radius);
      Point b_c = new Point(cos(p.b)*radius, sin(p.b)*radius);

      Point anc1 = new Point(cos(anchor1)*radius*coef, sin(anchor1)*radius*coef);
      Point anc2 = new Point(cos(anchor2)*radius*coef, sin(anchor2)*radius*coef);
      Point anc4 = new Point(cos(anchor4)*radius*coef, sin(anchor4)*radius*coef);
      Point tmp = new Point((anc2.a+anc4.a)/2, (anc2.b+anc4.b)/2);
      Point anc3 = new Point(cos(anchor3)*radius*coef, sin(anchor3)*radius*coef);
      anc2 = new Point(anc2.a+(anc3.a-tmp.a), anc2.b+(anc3.b-tmp.b));
      anc4 = new Point(anc4.a+(anc3.a-tmp.a), anc4.b+(anc3.b-tmp.b));
      Point anc5 = new Point(cos(anchor5)*radius*coef, sin(anchor5)*radius*coef);

      stroke(0,0,255);
      noFill();
      beginShape();
        vertex(a_c.a, a_c.b);
        bezierVertex(anc1.a, anc1.b, anc2.a, anc2.b, anc3.a, anc3.b);
        bezierVertex(anc4.a, anc4.b, anc5.a, anc5.b, b_c.a, b_c.b);
      endShape();

      //noStroke();
      //fill(0,255,0);
      //ellipse(anc1.a, anc1.b, point_size, point_size);
      //fill(255,0,0);
      //ellipse(anc2.a, anc2.b, point_size, point_size);
      //fill(0,0,255);
      //ellipse(anc3.a, anc3.b, point_size, point_size);
      //fill(255, 0, 255);
      //ellipse(anc4.a, anc4.b, point_size, point_size);
      //fill(0, 255, 255);
      //ellipse(anc5.a, anc5.b, point_size, point_size);
    }
  }
  void display_chord() {
    for (int i = 0; i < this.line.size(); i++) {
      Point p = this.line.get(i);
      Point a_c = new Point(cos(p.a)*radius, sin(p.a)*radius);
      Point b_c = new Point(cos(p.b)*radius, sin(p.b)*radius);
      noStroke();
      fill(0,255,0);
      ellipse(a_c.a, a_c.b, point_size, point_size);
      fill(255,0,0);
      ellipse(b_c.a, b_c.b, point_size, point_size);
      stroke(0);
      line(a_c.a, a_c.b, b_c.a, b_c.b);
    }
  }
}
