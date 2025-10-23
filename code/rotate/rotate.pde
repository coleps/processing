float it = 0;
Rect r;
void setup(){
  size(500,500);
  background(255);
  r = new Rect();
  //frameRate(30);
}
void draw(){
  fill(255,100);
  translate(500/2, 500/2);
  rotate(it);
  rectMode(CENTER);
  rect(0,0,r.w,r.h);
  
  translate(-250,-250);
  rotate(-it);
  translate(-100,-100);
  
  rectMode(CORNER);
  fill(255,20);
  //rect(-1,-1,501,501);
  for(int i = 0; i < 100; i++){
    stroke(255);
    fill(random(0,255),random(0,255),random(0,255),60);
    float x = random(-50,500);
    float y = random(-50,500);
    float w = random(50,60);
    float h = random(20,30);
    rect(x,y,w,h);
    
    fill(255,20);
    rect(x,y,w,h);
  }
  
  it+=0.01;
}
class Rect{
  float x = 250;
  float y = 250;
  float w = 300;
  float h = 300;
}
