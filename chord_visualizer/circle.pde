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

class Pair{
  int a;
  int b;
  Pair(int a, int b) {
    this.a = a;
    this.b = b;
  }
  Pair() {
    a = -1;
    b = -1;
  }
}

class Circle{
  int point_size = 5;
  int radius;
  int x;
  int y;
  float small_section = 0.01;
  ArrayList<Point> point; // angle, coeff of function
  ArrayList<Pair> chord;
  ArrayList<Pair> flare;
  ArrayList<Float> parabola;
  Circle(int x, int y, int radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.chord = new ArrayList<Pair>();
    this.flare = new ArrayList<Pair>();
    this.parabola = new ArrayList<Float>();
    this.point = new ArrayList<Point>();
  }
  void add_chord(int a, int b) {
    this.chord.add(new Pair(a,b));
  }
  void add_flare(int a, int b) {
    this.flare.add(new Pair(a, b));
  }
  void add_parabola(float a) {
    this.parabola.add(a);
    
  }
  void add_point(float a) {
    this.point.add(new Point(a, 0));
  }
  void display() {
    ellipseMode(CENTER);
    translate(width/2, height/2);
    rotate(-PI/2);
    stroke(0);
    noFill();
    ellipse(x,y,radius*2, radius*2);
    this.display_chord();
    //this.display_flare1();
    this.display_flare();
    this.display_parabola();
  }
  void display_flare() {
    noFill();
    float taper = PI/8;
    for (int i = 0; i < this.flare.size(); i++) {
      Point p = new Point(this.point.get(this.flare.get(i).a).a, this.point.get(this.flare.get(i).b).a);
      Point a = new Point(cos(p.a)*radius, sin(p.a)*radius);
      Point b = new Point(cos(p.b)*radius, sin(p.b)*radius);
      float arcradius = radius*(abs(p.a-p.b)/PI+1);
      float half_arcradius = radius*(abs(p.a-p.b)/PI/2+1);
      if (taper*2 >= abs(p.a-p.b)) {
        float wp_ang = p.a+(p.b-p.a)/2;
        Point waypoint = new Point(cos(wp_ang)*arcradius, sin(wp_ang)*arcradius);
        Point anc1 = new Point(cos(p.a)*half_arcradius, sin(p.a)*half_arcradius);
        float anchor_dist = arcradius/cos(abs(p.a-p.b)/2);
        Point anc2 = new Point(cos(p.a)*anchor_dist, sin(p.a)*anchor_dist);
        anc2 = new Point((waypoint.a+anc2.a)/2, (waypoint.b+anc2.b)/2);
        Point anc3 = new Point(cos(p.b)*anchor_dist, sin(p.b)*anchor_dist);
        anc3 = new Point((waypoint.a+anc3.a)/2, (waypoint.b+anc3.b)/2);
        Point anc4 = new Point(cos(p.b)*half_arcradius, sin(p.b)*half_arcradius);
        bezier(a.a, a.b, anc1.a, anc1.b, anc2.a, anc2.b, waypoint.a, waypoint.b);
        bezier(b.a, b.b, anc4.a, anc4.b, anc3.a, anc3.b, waypoint.a, waypoint.b);
      } else {
        float wp1_ang;
        float wp2_ang;
        if (p.a < p.b) {
          wp1_ang = p.a+taper;
          wp2_ang = p.b-taper;
          arc(x, y, arcradius*2, arcradius*2, wp1_ang, wp2_ang);
        }else {
          wp1_ang = p.a-taper;
          wp2_ang = p.b+taper;
          arc(x, y, arcradius*2, arcradius*2, wp2_ang, wp1_ang);
        }
        Point waypoint1 = new Point(cos(wp1_ang)*arcradius, sin(wp1_ang)*arcradius);
        Point waypoint2 = new Point(cos(wp2_ang)*arcradius, sin(wp2_ang)*arcradius);
        Point anc1 = new Point(cos(p.a)*half_arcradius, sin(p.a)*half_arcradius);
        float anchor_dist = arcradius/cos(taper);
        Point anc2 = new Point(cos(p.a)*anchor_dist, sin(p.a)*anchor_dist);
        //anc2 = new Point((waypoint1.a+anc2.a)/2, (waypoint1.b+anc2.b)/2);
        Point anc3 = new Point(cos(p.b)*anchor_dist, sin(p.b)*anchor_dist);
        //anc3 = new Point((waypoint2.a+anc3.a)/2, (waypoint2.b+anc3.b)/2);
        Point anc4 = new Point(cos(p.b)*half_arcradius, sin(p.b)*half_arcradius);
        bezier(a.a, a.b, anc1.a, anc1.b, anc2.a, anc2.b, waypoint1.a, waypoint1.b);
        bezier(b.a, b.b, anc4.a, anc4.b, anc3.a, anc3.b, waypoint2.a, waypoint2.b);
        arc(x, y, arcradius*2, arcradius*2, wp1_ang, wp2_ang);
      }
    }
  }
  void display_chord() {
    for (int i = 0; i < this.chord.size(); i++) {
      Point p = new Point(this.point.get(this.chord.get(i).a).a, this.point.get(this.chord.get(i).b).a);
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
  void display_parabola() {
    stroke(0);
    rotate(-PI/2);
    for (int i = 0; i < this.parabola.size(); i++) {
      float x = 0;
      float y = 0;
      while (x*x+y*y <= 1.0) {
        float nx = x + small_section;
        float ny = nx*nx*parabola.get(i);
        if (nx*nx+ny*ny > 1.0) {
          nx = sqrt((-1+sqrt(1+4*parabola.get(i)*parabola.get(i)))/(2*parabola.get(i)*parabola.get(i)));
          ny = nx*nx*parabola.get(i);
          line(x*radius, y*radius, nx*radius, ny*radius);
          line(-x*radius, y*radius, -nx*radius, ny*radius);
          break;
        }
        line(x*radius, y*radius, nx*radius, ny*radius);
        line(-x*radius, y*radius, -nx*radius, ny*radius);
        x = nx;
        y = ny;
      }
    }
  }
}
