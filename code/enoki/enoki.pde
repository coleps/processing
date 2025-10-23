ArrayList<Agent> agents = new ArrayList<>();
ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<int[]> colors = new ArrayList<>(){
            {
                add(new int[]{0, 65, 100});
                add(new int[]{232, 37, 64});
                add(new int[]{220, 20, 100});
                add(new int[]{226, 7, 100});
            }
        };

int numAgents = 3000;
int numSinks = 20;
PGraphics hires;
int scale = 5;

void setup(){
  //beginRecord(PDF,"images/img.pdf");
  size(480,640);
  
  hires = createGraphics(
                        width * scale,
                        height * scale,
                        JAVA2D);

  beginRecord(hires);
  hires.scale(scale);

  colorMode(HSB,360,100,100);
  
  background(232, 37, 64);
  
  for(int i = 0; i < numAgents; i++){
    agents.add(new Agent());
  }
  for(int i = 0; i < numSinks; i++){
    sinks.add(new Sink());
  }
  
  while(!agents.isEmpty()){
    ArrayList<Agent> remove = new ArrayList<>();
    for(Agent agent : agents){
      stroke(0,0);
      fill(agent.hsb[0],agent.hsb[1],agent.hsb[2],agent.size * 6);
      if(dToClosest(agent) < 30) {
        fill(0,0,100,40);
        stroke(0,0,0,40);
      }
      fill(0,0,100,40);
      stroke(28, 49, 53,40);
      circle(agent.pos.x,agent.pos.y,agent.size);
      agent.move();
    
      if(agent.maxSize - agent.size < 10) circle(agent.pos.x,agent.pos.y,agent.size);
      
      if(agent.size > agent.maxSize) {
        //fill(0,0,100,100);
        //stroke(28, 49, 53,200);
        //circle(agent.pos.x,agent.pos.y,agent.size);
        remove.add(agent);
      }
    } 
    agents.removeAll(remove);
  }
  
  endRecord();
  hires.save("images/img.png");
}

class Agent{
  PVector pos;
  float size = 1;
  float angle = radians(45);
  float d = 1;
  int[] hsb = colors.get(int(random(colors.size())));
  float maxSize = random(10,20);
  
  Agent(){
    pos = new PVector(random(-100,width+100),random(-100,height+100));
    //pos = new PVector(random(width),random(height));
  }
  void move(){
    for(Sink sink : sinks){
      angle += (sink.mass/sq(PVector.dist(pos,sink.pos)))*
            (angle(sink.pos,pos) - angle);
    }
    pos.x += d * cos(angle);
    pos.y += d * sin(angle);
    size+=0.1;
    //angle+=random(-0.1,0.1);
  }
}
class Sink{
  float mass = 700;
  PVector pos;
  Sink(){
    //mass = random(0,150 + 0.5*(height - j));
    pos = new PVector(random(width),random(height));
    //mass = random(100,200);
  }
  Sink(float i, float j, float m){
    mass = m;
    pos = new PVector(i,j);
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
  return min;
}
