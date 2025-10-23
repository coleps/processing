import processing.pdf.*;
import java.util.ArrayDeque;
import java.util.Collections;
import java.awt.Color;

//rgb vals
int[] bg = new int[]{71, 148, 179};
ArrayList<int[]> colors0 = new ArrayList<>(){{
  add(new int[]{152, 50, 117});
  add(new int[]{253, 47, 36});
}};
ArrayList<int[]> colors1 = new ArrayList<>(){{
  add(new int[]{255, 111, 1});
  add(new int[]{254, 216, 0});
}};

ArrayList<Agent> agents = new ArrayList<>();
ArrayList<Sink> sinks = new ArrayList<>();
ArrayDeque<PVector> queue = new ArrayDeque<>();
int numAgents = 10;
float y = 0;
int inc = 0;
boolean draw = true;
int hue = 197;
void setup(){
  beginRecord(PDF,"images/img.pdf");
  size(640,480);
  colorMode(HSB,360,100,100);
  rectMode(CENTER);
  background(hue,60,70);
  strokeWeight(0.4);
  //sink = new Sink(random(100,200),random(100,200));
  float x = 0;
  int i = 0;
  while(x <= width){
    x = i*(width/numAgents);
    agents.add(new Agent(x,-30,90));
    sinks.add(new Sink(random(0,width),random(0,height)));
    i++;
  }
  
}
void draw(){
  
  for(int i = 0; i < agents.size(); i++){
    Agent agent = agents.get(i);
    Sink sink = sinks.get(i);
    //stroke(agent.hsb[0],agent.hsb[1],agent.hsb[2]);
    stroke(hue,60,70);
    float[] hsb = getColor(bg,getColor(agent));
    //stroke(0,0,100);
    colorMode(RGB,255,255,255);
    //fill(0,0,agent.b);
    float[] rgb = getColor(agent);
    fill(rgb[0],rgb[1],rgb[2]);
    
    //fill(agent.hsb[0],agent.hsb[1],agent.hsb[2]);
    //if(int(random(0,20))==0) fill(random(360),100,100);
    circle(agent.pos.x,agent.pos.y,20);
    rect(agent.pos.x,agent.pos.y,20,20);
    
    colorMode(HSB,360,100,100);
    
    agent.move(sink);
  }
  if(inc == 50) {
    inc = 0;
    for(int i = 0; i < sinks.size(); i++){
      //circle(sinks.get(i).pos.x,sinks.get(i).pos.y,5);
      float sx = random(-800,width+200);
      float sy = random(y,height);
      //if(int(random(0,2))==0) sy -= (random(100,300));
      if(y < height*3 && int(random(0,2))==0) sy = (random(0,100));
      sinks.set(i,new Sink(sx,sy));
    }
    for(int i = 0; i < 100; i++){
      Collections.swap(agents, int(random(numAgents)), int(random(numAgents)));
    }
  }
  y+=2;
  inc++;
  
}

float[] getColor(Agent agent){
  float percent = agent.pos.y/height;
  if(agent.colorNum == 0) percent = agent.pos.x/width;
  ArrayList<int[]> colors;
  if(agent.colorNum == 0) colors = colors0;
  else colors = colors1;
  
  int[] diffs = new int[]{colors.get(1)[0]-colors.get(0)[0],
                          colors.get(1)[1]-colors.get(0)[1],
                          colors.get(1)[2]-colors.get(0)[2]};
  float[] rgb = new float[]{colors.get(0)[0]+(percent*diffs[0]),
                          colors.get(0)[1]+(percent*diffs[1]),
                          colors.get(0)[2]+(percent*diffs[2])};
  return rgb;
}
float[] getColor(int[] c1, float[] c2){
  float[] hsb1 = Color.RGBtoHSB(int(c1[0]),int(c1[1]),int(c1[2]),null);
  float[] hsb2 = Color.RGBtoHSB(int(c2[0]),int(c2[1]),int(c2[2]),null);
  for(int i = 0; i < 3; i++){
    if(i == 0){
      hsb1[i] *= 360;
      hsb2[i] *= 360;
    }
    else{
      hsb1[i] *= 100;
      hsb2[i] *= 100;
    }
  }
  
  float percent = 0.5;
  
  float[] diffs = new float[]{hsb2[0]-hsb1[0],
                          hsb2[1]-hsb1[1],
                          hsb2[2]-hsb1[2]};
  float[] hsb = new float[]{hsb1[0]+(percent*diffs[0]),
                          hsb1[1]+(percent*diffs[1]),
                          hsb1[2]+(percent*diffs[2])};
  return hsb;
}

class Agent{
  float size = 1;
  PVector pos;
  float d = 3;
  float angle;
  int age = 0;
  float[] hsb = new float[]{40,random(40,70),random(80,120)};
  int b = int(random(70,100));
  int colorNum = int(random(2));
  Agent(float x, float y, float angle){
    pos = new PVector(x,y);
    this.angle = angle;
  }
  void move(Sink sink){
    //angle += (sink.mass/sq(PVector.dist(pos,sink.pos)))*
    //        (angle(sink.pos,pos) - angle);
    angle += (angle(sink.pos,pos) - angle)*0.05;
    pos.x += d * cos(angle);
    pos.y += d * sin(angle);
    age++;
  }
}
class Sink{
  float mass = 5000;
  PVector pos;
  Sink(float x, float y){
    pos = new PVector(x,y);
  }
}
float angle(PVector p1, PVector p2){
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
void keyPressed(){
  endRecord();
}
