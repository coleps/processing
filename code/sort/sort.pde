import java.util.Collections;

PImage img;


void setup(){
  size(600,600);
  img = loadImage("data/img2.jpg");
  img.resize(0,height);
  
  for(int i = 0; i < height; i++){
    color[] row = subset(img.pixels,img.width*i,img.width);
    ArrayList<C> rowA = cArr(row);
    Collections.sort(rowA);
    for(int x = img.width*i; x < img.width*(i+1); x++){
      img.pixels[x] = rowA.get(x%img.width).c;
    }
  }
  image(img,0,0);
}
ArrayList<C> cArr(color[] cols){
  ArrayList<C> a = new ArrayList<>();
  for(color c : cols){
    C entry = new C();
    entry.c = c;
    a.add(entry);
  }
  return a;
}
void sortA(color[] row){
  
}

class C implements Comparable<C>{
  color c;
  int compareTo(C o){
    if (brightness(c) > brightness(o.c)) return 1;
    if (brightness(c) < brightness(o.c)) return -1;
    return 0;
  }
}
