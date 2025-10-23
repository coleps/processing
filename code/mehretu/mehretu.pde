ArrayList<Agent> agents = new ArrayList<>();
Sink sink;
int[] domain = new int[4];
float domainx;
float domainy;

void setup(){
  size(1000,800);
  background(255);
  
  float cx = random(300,500);
  float cy = random(300,500);
  float angle = random(0,2*PI);
  for(int i = 0; i < 5; i++){
    if(i == 0){
      agents.add(new Agent(cx + 3*i,cy,angle));
      continue;
    }
    agents.add(new Agent(cx + 3*i,cy,angle));
    agents.add(new Agent(cx - 3*i,cy,angle));
  }
  sink = new Sink(cx + 50,cy + 50);
  
}
void draw(){
  circle(sink.pos.x,sink.pos.y,5);
  for(Agent agent : agents){
    if(agent.age > 50) continue;
    fill(0,random(100,255));
    stroke(255,0);
    circle(agent.pos.x,agent.pos.y,agent.size);
    agent.move();
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
