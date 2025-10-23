ArrayList<PVector> grid = new ArrayList<>();

void setup(){
  size(600,600);
  strokeWeight(0.4);
  background(255);
  int i = 0, j = 0;
  while(j < 50){
    grid.add(new PVector(i,j));
    i += 5;
    if(i == 50){
      i = 0;
      j += 5;
    }
  }
}
void draw(){
  for(PVector p1 : grid){
    boolean b = false;
    for(PVector p2 : grid){
      stroke(random(0,50));
      if(sin(p1.x + sq(p2.y)) + sq(cos(p2.y)-sin(p1.y)) > 2) stroke(255); b = true;
      if(b && int(random(0,2))==1) stroke(255);
      if(degrees(angle(p1,p2)) == 45) line(p1.x,p1.y,p2.x,p2.y);
    }
  }
  
  for(PVector point: grid){
    point.x += 40;
    point.x += int(random(-5,5));
    point.y += int(random(-3,3));
  }
  if(grid.get(0).x >= width){
    for(PVector point: grid){
      point.x -= width;
      point.y += 40;
    }
  }
}
float angle(PVector p1, PVector p2){
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
