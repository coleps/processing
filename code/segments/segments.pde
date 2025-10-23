Segment seg;
void setup(){
  size(480,640);
  background(255);
  seg = new Segment(200,height);
}
void draw(){
  stroke(seg.fill-200,70);
  fill(seg.fill);
  ellipse(seg.pos.x,seg.pos.y,seg.w,seg.h);
  seg.move();
}

class Segment{
  PVector pos;
  float w = 40;
  float h = 20;
  float angle = radians(90);
  boolean increasing = true;
  float fill;
  float maxW = 60;
  float minW = 30;
  Segment(float x, float y){
    pos = new PVector(x,y);
    clr();
  }
  void move(){
    //pos.y -= 3;
    pos.x += 3*cos(angle);
    pos.y -= 3*sin(angle);
    if(increasing) w += 2;
    else w -= 2;
    w += random(-2,2);
    if(int(random(0,10))==0) increasing = !increasing;
    if(w < minW) increasing = true;
    if(w > maxW) increasing = false;
    clr();
    
    angle += random(-0.05,0.05);
  }
  void clr(){
    fill = (w/maxW)*255;
    
  }
}
