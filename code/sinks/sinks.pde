import processing.pdf.*;

ArrayList<PVector> sinks = new ArrayList<>();
ArrayList<Agent> agents = new ArrayList<>();

void setup(){
  beginRecord(PDF, "images/sinks.pdf");

  size(1000,600);
  background(0);
  
  colorMode(HSB,100,100,100);
  for(int i = 0; i < 5; i++){
    sinks.add(new PVector(random(0,width),random(0,height)));
  }
  
  for(int i = 0; i < 500; i++){
    agents.add(new Agent());
  }
  
}

void draw(){
  
  
  ArrayList<Agent> remove = new ArrayList<>();
  for(Agent agent : agents){
    fill(agent.col,45,90);

    if(agent.black) fill(0);
    stroke(0,agent.size*2);
    circle(agent.coord.x, agent.coord.y,agent.size);
    //fill(0,5000/dToClosest(agent));
    //circle(agent.coord.x, agent.coord.y,agent.size);
    for(PVector sink : sinks){
      //agent.angle += (300/sq(PVector.dist(agent.coord,sink)))*
      //      (angle(sink,agent.coord) - agent.angle);
      agent.angle += (600/sq(PVector.dist(agent.coord,sink)))*
            (angle(sink,agent.coord) - agent.angle);
    }
    agent.coord.x += (agent.size/2) * cos(agent.angle);
    agent.coord.y += (agent.size/2) * sin(agent.angle);
    agent.size-=0.1;
    if(agent.size < 0) {
      remove.add(agent);
      continue;
    }
    if(PVector.dist(agent.coord, sinks.get(0)) < 5) remove.add(agent);
  }
  for(Agent agent : remove){
    agents.remove(agent);
  }
  
  for(PVector sink : sinks){
    fill(255,0,0);
  }
}

class Agent{
  PVector coord;
  float angle = radians(random(-90,120));
  //float angle = 0;
  float size = random(10,25);
  float col = random(40,70);
  boolean black = false;
  
  float d = 5;
  Agent(){
    coord = new PVector(random(0,0),random(0,600));
    if(int(random(0,6))==1) black = true;
  }
  Agent(int x, int y){
    coord = new PVector(x,y);
    if(int(random(0,6))==1) black = true;
  }
}
float angle(PVector p1, PVector p2){
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
float dToClosest(Agent a){
  PVector p = a.coord;
  float min = PVector.dist(p,sinks.get(0));
  for(PVector sink : sinks){
    float d = PVector.dist(p,sink);
    if(d < min) min = d;
  }
  //println(min);
  return min;
}

void keyPressed(){
  endRecord();
}
