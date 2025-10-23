ArrayList<ArrayList<Integer[]>> list = new ArrayList<>();

void setup(){
  size(500,500);
  background(255);
}

void draw(){
  if(mousePressed){
    int x = mouseX;
    int y = mouseY;
    ArrayList<Integer[]> dots = new ArrayList<>();
    dots.add(new Integer[]{x,y,5});
    list.add(dots);
  }
  for(ArrayList<Integer[]> dots : list){
    int x = dots.get(0)[0];
    int y = dots.get(0)[1];
    if(dots.size() < 50){
     
      for(Integer[] dot : dots){
        int size = dot[2];
        size += 10;
        dot[2] = size;
      }
      dots.add(0, new Integer[]{x,y,5});
    }
  }
  for(ArrayList<Integer[]> dots : list){
    for(Integer[] dot : dots){
      fill(255,30);
      circle(dot[0],dot[1],dot[2]);
    }
  }
  if(list.size()>5){
    list.remove(0);
  }
}
