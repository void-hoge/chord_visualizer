static String[] newArgs;

public static void main(String args[]) {
  if (!(args.length == 1 || args.length == 2)) {
    throw new IllegalArgumentException("too much/few commandline option");
  }
  // println(args.length);
  newArgs = new String[4];
  newArgs[0] = "--bgcolor=#FFFFFF";
  newArgs[1] = "chord_visualizer";
  newArgs[2] = args[0];
  if (args.length == 2) {
    newArgs[3] = args[1];
  }
  PApplet.main(newArgs);
}

Circle cl;

void setup() {
  size(1280, 720);
  noLoop();
  int display_option = 0;
  // display_option |= cl.isDisplayChord;
  display_option |= cl.isDisplayFlare;
  display_option |= cl.isDisplayParabola;
  display_option |= cl.isDisplayPoint;
  display_option |= cl.isDisplayCircle;
  cl = new Circle(0,0,200, 5, display_option);

  String[] lines = loadStrings(newArgs[2]);
  ArrayList<Integer> connectlist = new ArrayList<Integer>();

  // parse N
  String[] data = lines[0].split(", |,| ");
  int n = 0;
  try {
    n = Integer.parseInt(data[0]);
    println("N = "+n);
  }catch(NumberFormatException e){
    println("Error: cannot parse \"" + data[0] + "\" as N (must be a integer)");
  }finally{}
  // println(n);

  // parse list of parabola's coeff
  println("Parabola's coeffs");
  data = lines[1].split(", |,| ");
  for (int i = 0; i < data.length; i++) {
    try {
      float tmp = Float.parseFloat(data[i]);
      cl.add_parabola(tmp);
      print(tmp+" ");
    }catch(NumberFormatException e){
      println("Error: cannot parse \"" + data[0] + "\" as parabola's coeff(must be a float)");
    }finally{}
  }
  println();

  // parse list of connections
  for (int i = 2; i < lines.length; i++) {
    data = lines[i].split(", |,| ");
    for (int j = 0; j < data.length; j++) {
      try {
        connectlist.add(Integer.parseInt(data[j]));
      }catch (NumberFormatException e){
         println("Error: cannot parse \""+data[j]+"\" as connection of a pair(must be a integer)");
      }finally{}
    }
  }

  // setting to Circle class obj
  println("Connection pairs");
  for (int i = 0; i < connectlist.size()/2; i++) {
    cl.add_chord(connectlist.get(i*2)-1, connectlist.get(i*2+1)-1);
    cl.add_flare(connectlist.get(i*2)-1, connectlist.get(i*2+1)-1);
    println("("+(connectlist.get(i*2)) + ", " + (connectlist.get(i*2+1))+")");
  }
}

void draw() {
  background(255);
  cl.display();
  save(newArgs[3]);
}
