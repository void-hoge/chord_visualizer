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
  ArrayList<Point> chord;
  ArrayList<Point> flare;
  Circle(int x, int y, int radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.chord = new ArrayList<Point>();
    this.flare = new ArrayList<Point>();
  }
  void add_chord(float a, float b) {
    this.chord.add(new Point(a,b));
  }
  void add_flare(float a, float b) {
    this.flare.add(new Point(a, b));
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
    this.display_flare2();
  }
  void display_flare1() {
    noFill();
    for (int i = 0; i < this.flare.size(); i++){
      Point p = this.flare.get(i);
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
  void display_flare2() {
    noFill();
    float taper = PI/8;
    for (int i = 0; i < this.flare.size(); i++) {
      Point p = this.flare.get(i);
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
      Point p = this.chord.get(i);
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
