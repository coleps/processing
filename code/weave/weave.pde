import processing.pdf.*;

ArrayList<Agent> grid = new ArrayList<>();
int numAgents = 10;
ArrayList<int[]> colorsH = new ArrayList<>(){{
  add(new int[]{27, 60, 89});
  add(new int[]{69, 97, 115});
}};
ArrayList<int[]> colorsV = new ArrayList<>(){{
  add(new int[]{215, 127, 161});
  add(new int[]{214, 229, 250});
}};

void setup(){
  beginRecord(PDF,"images/img.pdf");
  size(600,600);
  background(255);
  rectMode(CENTER);
  strokeCap(SQUARE);
  
  ArrayList<Agent> agents = new ArrayList<>();
  float x = width/numAgents;
  while(x < width){
    //agents.add(new Agent(x,0));
    //agents.add(new Agent(0,x));
    grid.add(new Agent(x,0));
    grid.add(new Agent(0,x));
    x += width/numAgents;
  }
  
  for(Agent agent : grid){
    while(agent.pos.x < width && agent.pos.y < height){
      drawRect(agent);
      agent.move();
    }
  }
  //for(Agent agent : agents){
  //  grid.add(int(random(grid.size())),agent);
  //}
}
//void draw(){
//  for(Agent agent : grid){
//    drawRect(agent);
//    agent.move();
//  }
//}
void drawRect(Agent agent){
  float[] hsb = getColor(agent);
  fill(hsb[0],hsb[1],hsb[2]);
  stroke(0,0);
  rect(agent.pos.x,agent.pos.y,agent.size,agent.size);
  
  stroke(0);
  
  float f = agent.size*0.5;
  if(agent.dir == Direction.HORIZONTAL){
    line(agent.pos.x-f,agent.pos.y-f,agent.pos.x+f,agent.pos.y-f);
    line(agent.pos.x-f,agent.pos.y+f,agent.pos.x+f,agent.pos.y+f);
  }
  else{
    line(agent.pos.x-f,agent.pos.y-f,agent.pos.x-f,agent.pos.y+f);
    line(agent.pos.x+f,agent.pos.y-f,agent.pos.x+f,agent.pos.y+f);
  }
}
float[] getColor(Agent agent){
  float percent;
  if(agent.dir == Direction.HORIZONTAL) percent = agent.pos.x/width;
  else percent = agent.pos.y/height;
  
  float[] hsb = new float[3];
  
  if(agent.dir == Direction.HORIZONTAL){
    int[] diffs = new int[]{colorsH.get(1)[0]-colorsH.get(0)[0],
                          colorsH.get(1)[1]-colorsH.get(0)[1],
                          colorsH.get(1)[2]-colorsH.get(0)[2]};
    hsb = new float[]{colorsH.get(0)[0]+(percent*diffs[0]),
                          colorsH.get(0)[1]+(percent*diffs[1]),
                          colorsH.get(0)[2]+(percent*diffs[2])};
  }
  else{
    int[] diffs = new int[]{colorsV.get(1)[0]-colorsV.get(0)[0],
                          colorsV.get(1)[1]-colorsV.get(0)[1],
                          colorsV.get(1)[2]-colorsV.get(0)[2]};
    hsb = new float[]{colorsV.get(0)[0]+(percent*diffs[0]),
                          colorsV.get(0)[1]+(percent*diffs[1]),
                          colorsV.get(0)[2]+(percent*diffs[2])};
  }
  
  return hsb;
}
enum Direction{HORIZONTAL,VERTICAL}
class Agent{
  Direction dir;
  PVector pos;
  float size = 30;
  float d = 1;
  Agent(float x, float y){
    pos = new PVector(x,y);
    if(x == 0) dir = Direction.HORIZONTAL;
    else dir = Direction.VERTICAL;
  }
  void move(){
    if(dir == Direction.HORIZONTAL){
      pos.x += d;
      pos.y += random(-1,1);
    }
    else{
      pos.y += d;
      pos.x += random(-1,1);
    }
  }
}
void keyPressed(){
  endRecord();
}
