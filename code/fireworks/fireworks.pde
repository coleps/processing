ArrayList<Body> bodies = new ArrayList<>();
int num = 15;
int dist = 20;
float size = 7;
float incr = 8;
float it = 0;

void setup(){
  size(500,500);
  background(255);
  //frameRate(10);
  colorMode(HSB,360);
}
void draw(){
  //background(0,10);
  fill(0,0,0,40);
  rect(-1,-1,501,501);
  
  if(mousePressed){
    float mx = mouseX;
    float my = mouseY;
    for(int i = 0; i < num; i++){
        float angle = 0 + i*((2*PI)/num);
        float x = mx + dist*cos(angle) + random(-5,5);
        float y = my + dist*sin(angle) + random(-5,5);
        
        bodies.add(new Body(x,y,angle));
    }
  }
  ArrayList<Body> dead = new ArrayList<>();
  for(Body body : bodies){
    fill(body.hue[0],body.hue[1],360);
    stroke(0,0,100);
    circle(body.x,body.y,size);
    body.x = body.x + incr*cos(body.angle) + 2*sin(it*2);
    body.y = body.y + incr*sin(body.angle) + body.age * 0.5;
    body.age++;
    if(body.age > 60) dead.add(body);
  }
  for(Body body : dead){
    bodies.remove(body);
  }
  it+=0.1;
}

class Body{
  float x, y, angle;
  int age;
  int[] hue;
  Body(float x, float y, float angle){
    this.x = x;
    this.y = y;
    this.angle = angle;
    age = 0;
    hue = new int[]{int(random(0,360)),int(random(0,360))};
  }
  void setY(float y){
    this.y = y;
  }
}
