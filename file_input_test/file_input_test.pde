String filename = "../out.txt";

void setup() {
  String[] lines = loadStrings(filename);
  println("there are " + lines.length + " lines");
  ArrayList<Integer> hoge = new ArrayList<Integer>();
  for (int i = 0 ; i < lines.length; i++) {
    String[] data = lines[i].split(", |,");
    for (int j = 0; j < data.length; j++) {
      try {
        println(Integer.parseInt(data[j]));
        hoge.add(Integer.parseInt(data[j]));
      }catch(NumberFormatException e){
        println(data[j]);
      }finally{
      }
    }
  }
  println("---------");
  for (int i = 0; i < hoge.size(); i++) {
    println(hoge.get(i));
  }
}
