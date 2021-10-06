import processing.serial.*;

static String[] newArgs;
static int DEBUG = 0;

public static void main(String args[]) {
  if (args.length != 1) {
    throw new IllegalArgumentException("no commandline option");
  }
  println(args.length);
  // println(args[0]);
  newArgs = new String[3];
  println(args[0]);
  newArgs[0] = "--bgcolor=#FFFFFF";
  newArgs[1] = "commandline_input";
  newArgs[2] = args[0];
  PApplet.main(newArgs);
}

void setup() {
  println(newArgs[2]+"in setup");
  size(320, 240);
  background(0);
  text("DEBUG: " + DEBUG, 15, 20, 70, 70);
}
