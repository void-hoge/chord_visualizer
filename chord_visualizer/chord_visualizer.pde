static String[] newArgs;
static int DEBUG = 0;

public static void main(String args[]) {
  if (args.length != 1) {
    throw new IllegalArgumentException("too much/few commandline option");
  }
  println(args.length);
  newArgs = new String[3];
  newArgs[0] = "--bgcolor=#FFFFFF";
  newArgs[1] = "chord_visualizer";
  newArgs[2] = args[0];
  PApplet.main(newArgs);
}

Circle cl;

void setup() {
  size(1280, 720);
  noLoop();
  cl = new Circle(0,0,200);

  cl.add_parabola(16);
  cl.add_parabola(2);
  cl.add_parabola(0.25);
  cl.add_parabola(-0.25);
  cl.add_parabola(-3);
  String[] lines = loadStrings(newArgs[2]);
  ArrayList<Integer> hoge = new ArrayList<Integer>();
  for (int i = 0 ; i < lines.length; i++) {
    String[] data = lines[i].split(", |,");
    for (int j = 0; j < data.length; j++) {
      try {
        println(Integer.parseInt(data[j]));
        hoge.add(Integer.parseInt(data[j]));
      }catch(NumberFormatException e){
        println("cannot parse \"" +data[j]+"\"");
      }finally{
      }
    }
  }
  for (int i = 0; i < hoge.size()/2; i++) {
    cl.add_chord(hoge.get(i*2)-1, hoge.get(i*2+1)-1);
    cl.add_flare(hoge.get(i*2)-1, hoge.get(i*2+1)-1);
  }
}

void draw() {
  background(255);
  cl.display();
}
