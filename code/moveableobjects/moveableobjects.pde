ArrayList<PVector> sinks = new ArrayList<>();
int selectedNum;
boolean selected = false;;

void setup(){
  size(600,600);
  for(int i = 0; i < 20; i++){
    sinks.add(new PVector(random(width),random(height)));
  }
}
void draw(){
  background(255);
  sinks.stream().forEach(s -> {circle(s.x,s.y,20);});
  
}
void mousePressed(){
  PVector mpos = new PVector(mouseX,mouseY);
  for(int i = 0; i < sinks.size(); i++){
    if(PVector.dist(mpos,sinks.get(i)) < 10) {selectedNum = i;selected = true;}
  }
}
void mouseReleased(){
  selected = false;
}
void mouseDragged(){
  if(selected){
    sinks.set(selectedNum,new PVector(mouseX,mouseY));
  }
}
