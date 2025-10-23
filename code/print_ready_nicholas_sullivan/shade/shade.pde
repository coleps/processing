import processing.svg.*;
import processing.pdf.*;

ArrayList<Agent> agents = new ArrayList<>();
Sink sink;
PVector[] domain = new PVector[2];
float domainWidth;
float domainHeight;
int scale = 5;

void setup(){
  //beginRecord(PDF, "images/shaded.pdf");
  size(1000,800);
  
  PGraphics hires = createGraphics(
                        width * scale,
                        height * scale,
                        JAVA2D);

  beginRecord(hires);
  hires.scale(scale);
  
  
  
  //beginRecord(SVG, "images/shading.svg");
  
  background(230);
  
  domain[0] = new PVector(0,0);
  domain[1] = new PVector(width,height);
  //drawDomain();
  
  domainWidth =  width;
  domainHeight = height;
  int x = 0;
  while(domainWidth > 0){
    domainWidth -= width * 0.1;
    domainHeight -= height * 0.1;
    for(int i = 0; i < int(random(1,4)); i++){
      float startx = random(0,width-domainWidth);
      float starty = random(0,height-domainHeight);
      domain[0] = new PVector(startx,starty);
      domain[1] = new PVector(startx + domainWidth,starty + domainHeight);
      drawDomain();
    }
    
  }
  endRecord();
  hires.save("images/shaded.png");
  //endRecord();
  //save("images/shade.png");
  
}
void initAgents(float sinkangle){
  float cx = random(domain[0].x,domain[1].x);
  float cy = random(domain[0].y,domain[1].y);
  float agentangle = random(0,2*PI);
  float angle = random(0,2*PI);
  for(int i = 0; i < 8; i++){
    if(i == 0){
      agents.add(new Agent(cx,cy,agentangle));
      continue;
    }
    agents.add(new Agent(cx + 3*i*cos(angle),cy + 3*i*sin(angle),agentangle));
    agents.add(new Agent(cx - 3*i*cos(angle),cy - 3*i*sin(angle),agentangle));
  }
  sinkangle += random(-0.1,0.1);
  sink = new Sink(cx + 100*cos(sinkangle),cy + 100*sin(sinkangle));
}
void drawAgents(){
  //circle(sink.pos.x,sink.pos.y,5);
  for(Agent agent : agents){
    fill(0,random(100,255));
    if(int(random(0,20))==0)fill(random(100,255),random(0,255),random(0,255));
    stroke(255,0);
    
    circle(agent.pos.x,agent.pos.y,agent.size);
    agent.move();
  }
}
void drawDomain(){
  float sinkangle = radians(45);
  for(int i = 0; i < 100; i++){
    agents.clear();
    initAgents(sinkangle);
    while(agents.get(0).age < random(50,50)){
      drawAgents();
    }
  }
}
class Agent{
  float size = 1;
  PVector pos;
  float d = 1;
  float angle;
  int age = 0;
  Agent(float x, float y, float angle){
    pos = new PVector(x,y);
    this.angle = angle;
  }
  void move(){
    angle += (sink.mass/sq(PVector.dist(pos,sink.pos)))*
            (angle(sink.pos,pos) - angle);
    pos.x += d * cos(angle);
    pos.y += d * sin(angle);
    age++;
  }
}
class Sink{
  float mass = 1000;
  PVector pos;
  Sink(float x, float y){
    pos = new PVector(x,y);
  }
}
float angle(PVector p1, PVector p2){
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
