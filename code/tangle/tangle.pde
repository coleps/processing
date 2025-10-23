import processing.pdf.*;
ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<Agent> agents = new ArrayList<>();

void setup(){
  beginRecord(PDF, "sinks.pdf");
  size(480,640);
  background(255);
  colorMode(HSB,100,100,100);
  
  int ni = 6;
  int nj = 6;
  float i = width/ni, j = height/nj;
  while(j < height * (2.0/3)){
    if(int(random(1,4))==1)sinks.add(new Sink(i,j));
    i += width/ni;
    if(i >= width){
      i = width/ni;
      j += height/nj;
    }
  }
  for(int x = 0; x < 50; x++){
    agents.add(new Agent());
  }
}
void draw(){
  for(Sink sink : sinks){
    stroke(0,0,50);
    fill(0,0,0,0);
    //circle(sink.pos.x,sink.pos.y,sink.mass*0.1);
  }
  ArrayList<Agent> rem = new ArrayList<>();
  for(Agent agent : agents){
    
    
    //if(dToClosest(agent) < 15){
    //  fill(85,50,90);
    //  stroke(85,50,90,0);
    //  circle(agent.pos.x + random(-5,5),agent.pos.y +  + random(-5,5),agent.size);
    //}
    
    fill(agent.h,agent.s,agent.b);
    stroke(0,0,100,170);
    stroke(85,50,90);
    circle(agent.pos.x,agent.pos.y,agent.size);
    
    if(agent.size < 5){
      fill(0,0,100,30);
      stroke(0,0,0,0);
      circle(agent.pos.x,agent.pos.y,agent.size+5);
      agent.move();
    }
    
    
    agent.move();
    if(agent.size < 0.3) rem.add(agent);
  }
  agents.removeAll(rem);
}

class Sink{
  float mass;
  PVector pos;
  Sink(float i, float j){
    //mass = random(0,150 + 0.5*(height - j));
    mass = random(0,200 + 0.5*(height - j));
    pos = new PVector(i,j);
  }
  Sink(float i, float j, float m){
    mass = m;
    pos = new PVector(i,j);
  }
}
class Agent{
  PVector pos;
  float angle = radians(random(-120,-60));
  //float angle = 0;
  float size = random(10,25);
  
  float h = random(20,40);
  float s = random(45,50);
  float b = random(60,95);
  
  boolean black = false;
  
  float d = 5;
  
  Agent(){
    pos = new PVector(random(0,width),height);
    if(int(random(0,6))==1) black = true;
  }
  Agent(int x, int y){
    pos = new PVector(x,y);
    if(int(random(0,6))==1) black = true;
  }
  void move(){
    for(Sink sink : sinks){
      //if(sink.pos.y > pos.y) continue;
      //agent.angle += (300/sq(PVector.dist(agent.coord,sink)))*
      //      (angle(sink,agent.coord) - agent.angle);
      angle += (sink.mass/sq(PVector.dist(pos,sink.pos)))*
            (angle(sink.pos,pos) - angle);
    }
    //
    angle  += random(-0.5,0.5);
    //
    pos.x += (size/2) * cos(angle);
    pos.y += (size/2) * sin(angle);
    size-=0.05;
  }
}
float angle(PVector p1, PVector p2){
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
float dToClosest(Agent a){
  PVector p = a.pos;
  float min = PVector.dist(p,sinks.get(0).pos);
  for(Sink sink : sinks){
    float d = PVector.dist(p,sink.pos);
    if(d < min) min = d;
  }
  println(min);
  return min;
}

void keyPressed(){
  endRecord();
}
