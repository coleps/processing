ArrayList<PVector> points = new ArrayList<>();

void setup(){
  size(600,600);
  strokeWeight(0.4);
  int i = 0, j = 0;
  while(j < 50){
    points.add(new PVector(i,j));
    i += 10;
    if(i == 50){
      i = 0;
      j += 10;
    }
  }
}
void draw(){
  //background(255);
  for(PVector point: points){
    for(PVector other: points){
      //println((PVector.angleBetween(point,other)));
      if(abs(point.y - other.y) > 50) continue;
      stroke(random(0,80));
      line(point.x,point.y,other.x,other.y);
    }
  }
  for(PVector point: points){
    point.x += 40;
    point.x += random(-7,7);
    point.y += random(-7,7);
  }
  if(points.get(0).x > width){
    for(PVector point: points){
      point.x -= width;
      point.y += 50;
    }
  }
  
}
