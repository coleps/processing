import processing.pdf.*;

float theta = 0.1;
PVector pos;
PVector cent;
float incr = 0.001;
float d = 0.2;

float max = 300;
void setup(){
  frameRate(200);
  beginRecord(PDF,"images/img.pdf");
  size(640,480);
  pos = new PVector(width/2,height/2);
  cent = new PVector(width/2,height/2);
}
void draw(){
  circle(pos.x,pos.y,2);
  rotate(pos,cent,theta);
  float angle = angle(pos,cent);
  pos.x+=d*cos(angle);
  pos.y+=d*sin(angle);
  
  //theta-=incr;
  //if(abs(theta)>0.1)incr*=-0.01;
  theta*=0.999;
  if(int(random(0,100))==0)theta*=-1;
  //d *= 0.9999999;
  if(PVector.dist(pos,cent) < 15) endRecord();
  if(PVector.dist(pos,cent)> max){
    max -= 10;
    stroke(random(255),random(255),random(255));
    pos = new PVector(width/2,height/2);
    theta = 0.1;
    d = 0.2;
  }
}

void rotate(PVector v, PVector pivot, float theta){
  v.x -= pivot.x;
  v.y -= pivot.y;
  
  v.rotate(theta);
  
  v.x += pivot.x;
  v.y += pivot.y;
}
float angle(PVector p1, PVector p2){
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
