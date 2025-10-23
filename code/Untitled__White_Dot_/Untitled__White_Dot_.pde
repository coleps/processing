float  x = 0;
float y = 0;
float xinc = 1;
int frame = 0;

void setup(){
  size(500,500);
  background(50);
}
void draw(){
  rectMode(CORNER);
  fill(0);
  //int i = int(random(0,20));
  //if(i == 0) fill(255);
  //stroke(255);
  //rect(x,y,50,50);
  if(x > 500 || x < 0){
    y += 50;
    xinc *= -1;
  }
  if(y >= 500) y = 0;
  x += xinc;
  fill(100,2);
  rect(-10,-10,510,510);
  //fill(0);
  if(frameCount%2==0) stroke(20);
  stroke(0,0);
  fill(random(100,200),random(100,200),random(100,200),40);
  circle(random(0,500),random(0,500),random(0,50));
  
  stroke(0,0);
  fill(50);
  circle(random(0,500),random(0,500),random(0,50));
  
  stroke(0);
  stroke(255,50);
  fill(0,0);
  if(frameCount % 20 == 0){
    quad(random(0,500),random(0,500),random(0,500),random(0,500),
    random(0,500),random(0,500),random(0,500),random(0,500));
  }
  
  
  fill(150 + 105*sin(frameCount/15.0),100);
  stroke(255);
  circle(width/2,height/2,200);
  
  fill(200,0,0,10);
  fill(200,0,0,30);
  stroke(255,0);
  if(frameCount - frame > 100) return;
  quad(random(100,400),random(100,400),random(100,400),random(100,400),
  random(100,400),random(100,400),random(100,400),random(100,400));
  
  frame = frameCount;
}
class Mote{
  
}
