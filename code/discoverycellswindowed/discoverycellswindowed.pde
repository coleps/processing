ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<Projectile> particles = new ArrayList<>();
color[] pallette;
PVector windowPos;
float windowWidth = 200;
float windowHeight = 200;
boolean windowSelected = false;
int it = 0;

void setup() {
  size(600, 600);
  frameRate(20);
  
  windowPos = new PVector(width/2,height/2);
  
  background(216, 216, 216 );
  //background(255, 0, 0 );
  colorMode(HSB, 360, 100, 100);
  pallette = new color[]{color(0,0,0),color(0,0,50),color(0,0,100)};
  for (int i = 0; i < 60; i++) {
    sinks.add(new Sink());
  }
  //for (int i = 0; i < 450; i++) {
  //  color c = pallette[int(random(pallette.length))];
  //  float x = random(width);
  //  float y = random(height);
  //  for (int j = 0; j < 20; j++) {
  //    float px = random(x-50, x+50);
  //    float py = random(y-50, y+50);
  //    particles.add(new Projectile(10, random(0, 2*PI), px, py, c));
  //  }
  //}
  //while (!particles.isEmpty()) {
  //  ArrayList<Projectile> remove = new ArrayList<>();
  //  for (Projectile p : particles) {
  //    noStroke();
  //    stroke(0,70 - p.size*4);
  //    fill(p.c,100);
  //    rect(p.pos.x, p.pos.y, p.size, p.size);
  //    //if (p.size < 0.1) remove.add(p);
  //    p.move();
  //    p.age++;
  //    if (!remove.contains(p) && p.age > 100) remove.add(p);
  //  }
  //  particles.removeAll(remove);
  //}
  //loadPixels();
  
  //for(Sink sink : sinks){
  //  fill(10,80,80);
  //  //circle(sink.pos.x,sink.pos.y,sink.mass*0.1);
  //}
}
void draw(){
  it++;
  //updatePixels();
  //if(frameCount % 10 != 0) return;
  
  sinks.stream().forEach(s -> s.move());
  
  if(true){
  background(0,0,100);
  for (int i = 0; i < 30; i++) {
    color c = pallette[int(random(pallette.length))];
    float x = windowPos.x;
    float y = windowPos.y;
    for (int j = 0; j < 15; j++) {
      float px = random(x-windowWidth/2, x+windowWidth/2);
      float py = random(y-windowHeight/2, y+windowHeight/2);
      particles.add(new Projectile(10, random(0, 2*PI), px, py, c));
    }
  }
  while (!particles.isEmpty()) {
    ArrayList<Projectile> remove = new ArrayList<>();
    for (Projectile p : particles) {
      noStroke();
      stroke(0,70 - p.size*4);
      fill(p.c,100);
      rect(p.pos.x, p.pos.y, p.size, p.size);
      //if (p.size < 0.1) remove.add(p);
      p.move();
      p.age++;
      if (!remove.contains(p) && p.age > 65) remove.add(p);
    }
    particles.removeAll(remove);
  }
  //loadPixels();
  }
  
  //updatePixels();
  //fill(0,0,100);
  //noStroke();
  //rect(0,0,width,windowPos.y - windowHeight/2);
  //rect(0,windowPos.y + windowHeight/2,width,height);
  //rect(0,0,windowPos.x - windowWidth/2,height);
  //rect(windowPos.x + windowWidth/2,0,width,height);
  rectMode(CENTER);
  stroke(0,0,26);
  strokeWeight(2);
  noFill();
  rect(windowPos.x,windowPos.y,windowWidth,windowHeight);
  rectMode(CORNER);
  strokeWeight(1);
}
boolean inWindow(){
  if(mouseX < windowPos.x - windowWidth/2) return false;
  if(mouseX > windowPos.x + windowWidth/2) return false;
  if(mouseY < windowPos.y - windowHeight/2) return false;
  if(mouseY > windowPos.y + windowHeight/2) return false;
  return true;
}
void mouseDragged(){
  it = 0;
  if(inWindow()){
    windowPos.x = mouseX;
    windowPos.y = mouseY;
  }
}

float angle(PVector p1, PVector p2) {
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
