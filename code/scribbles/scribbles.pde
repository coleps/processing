import processing.pdf.*;
import java.util.ArrayDeque;

float hue = random(360);
ArrayList<PVector> sinks = new ArrayList<>();

PVector[] domain = new PVector[2];
float domainWidth;
float domainHeight;

ArrayDeque<PVector[]> colors = new ArrayDeque<>();

void setup(){
  beginRecord(PDF,"images/img.pdf");
  size(1000,800);
  colorMode(HSB,360,100,100);
  
  background(44,14,90);
  //background(44,14,40);

  
  //for(int i = 0; i < 200; i++){
  //  PVector init = new PVector(random(width),random(height));
  //  PVector terminal = new PVector(init.x + random(-200,200), init.y + random(-200,200));
  //  fill(hue,10,80);
  //  stroke(0,0);
  //  curve(random(width),random(height),
  //    init.x,init.y,
  //    terminal.x,terminal.y,
  //    random(width),random(height));
  //}
  
  for(int i = 0; i < 10; i++){
    sinks.add(new PVector(random(width),random(height)));
  }
  
  
  
  domainWidth =  width;
  domainHeight = height;
  int x = 0;
  while(domainWidth > 0){
    domainWidth -= width * 0.05;
    domainHeight -= height * 0.05;
    for(int i = 0; i < int(random(1,4)); i++){
      float startx = random(0,width-domainWidth);
      float starty = random(0,height-domainHeight);
      domain[0] = new PVector(startx,starty);
      domain[1] = new PVector(startx + domainWidth,starty + domainHeight);
      drawDomain(500);
      
    }
    
  }
  //filter(THRESHOLD, 0.6);
  
  
  endRecord();
  
  
}
void drawDomain(int numArcs){
  for(int i = 0; i < numArcs; i++){
    PVector init = new PVector(random(domain[0].x,domain[1].x),random(domain[0].y,domain[1].y));
    if(int(random(0,7))==0) init = sinks.get(int(random(sinks.size())));
    PVector terminal = new PVector(init.x + random(-100,100), init.y + random(-100,100));
    if(int(random(0,7))==0) terminal = sinks.get(int(random(sinks.size())));
    
    PVector c1 = new PVector(random(width),random(height));
    if(int(random(0,5))==0) c1 = sinks.get(int(random(sinks.size())));
    PVector c2 = new PVector(random(width),random(height));
    if(int(random(0,5))==0) c2 = sinks.get(int(random(sinks.size())));
    //PVector c1 = new PVector(random(domain[0].x,domain[1].x),random(domain[0].y,domain[1].y));
    //PVector c2 = new PVector(random(domain[0].x,domain[1].x),random(domain[0].y,domain[1].y));
    fill(0,0);
    //stroke(0,0,0,60);
    stroke(0,0,0,90);
    stroke(random(360),80,80,230);

    if(int(random(0,10))==0) stroke(0,0,0,250);//stroke(random(360),80,80,230);

    strokeWeight(0.4);
    curve(c1.x, c1.y,
      init.x,init.y,
      terminal.x,terminal.y,
      c2.x,c2.y);
      
  }
}
void drawCurve(){
  //fill(random(360),80,90);
  fill(0,0);
  stroke(random(360),80,90);
  strokeWeight(7);
  PVector sink = sinks.get(int(random(sinks.size())));
  float dist = random(50);
  float angle = random(0,2*PI);
  PVector init = new PVector(sink.x + dist*cos(angle), sink.y + dist*sin(angle));
  PVector terminal = new PVector(random(width),random(height));
  
  PVector c1 = new PVector(random(width),random(height));
  PVector c2 = new PVector(random(width),random(height));
  
  //curve(c1.x, c1.y,
  //    init.x,init.y,
  //    terminal.x,terminal.y,
  //    c2.x,c2.y);
  //line(init.x,init.y,
  //    terminal.x,terminal.y);
  
}
void drawTri(){
  fill(random(360),80,90,200);
  stroke(0,0);
  PVector sink = sinks.get(int(random(sinks.size())));
  
  float dist = random(20,50);
  float angle = random(0,2*PI);
  
  float len = random(20,400);
  
  PVector v1 = new PVector(sink.x + dist*cos(angle), sink.y + dist*sin(angle));
  
  float diff = 0.1;
  PVector v2 = new PVector(sink.x + (dist+len)*cos(angle-diff), sink.y + (dist+len)*sin(angle-diff));
  
  PVector v3 = new PVector(sink.x + (dist+len)*cos(angle+diff), sink.y + (dist+len)*sin(angle+diff));
  
  triangle(v1.x,v1.y,v2.x,v2.y,v3.x,v3.y);
  
  
}
