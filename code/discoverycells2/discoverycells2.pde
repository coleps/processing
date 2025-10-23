import processing.pdf.*;
ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<Projectile> particles = new ArrayList<>();
color[] pallette;
ArrayList<Data> particleInit = new ArrayList<>();
boolean animate = true;
int scale = 5;
int imgNum = 1;
PImage[] imgs = new PImage[300];
void setup() {
  size(800, 800);
  frameRate(20);
  background(216, 216, 216 );
  colorMode(HSB, 360, 100, 100);
  pallette = new color[]{color(0,0,0),color(0,0,50),color(0,0,100)};
  for (int i = 0; i < 60; i++) {
    sinks.add(new Sink());
  }
  for (int i = 0; i < 450; i++) {
    color c = pallette[int(random(pallette.length))];
    float x = random(width);
    float y = random(height);
    for (int j = 0; j < 20; j++) {
      float px = random(x-50, x+50);
      float py = random(y-50, y+50);
      particleInit.add(new Data(10, random(0, 2*PI), px, py, c));
    }
  }
  if(!animate){
    for(int i = 1; i < frameRate * 10; i++){
      PGraphics hires = createGraphics(
                        width * scale,
                        height * scale,
                        JAVA2D);

      beginRecord(hires);
      hires.scale(scale);
      
      drawParticles();
      //sinks.stream().forEach(s -> s.move());
      for(Sink sink : sinks){
        sink.move();
      }
    
      endRecord();
      hires.save("images/img"+i+".png");
    }
  }
  //if(animate){
  //  int i = 1;
  //  PImage img;
  //  while(true){
  //    println(i);
  //    img = loadImage("images/img"+i+".png");
  //    if(img != null) imgs[i] = img;
  //    else break;
  //    i++;
  //  }
  //}
}
void draw(){
  if(animate){
    PImage img = loadImage("images/img"+imgNum+".png");
    try{
      img.resize(width,0);
      image(img,0,0);
      imgNum++;
    } catch(Exception e){imgNum = 1;}
    
  }
  //if(animate){
  //  PImage img = imgs[imgNum];
  //  image(img,0,0);
  //  if(imgNum < 200 - 1) imgNum++;
  //  else imgNum = 1;
  //}
}
void drawSinks(){
  background(255);
  for(Sink sink : sinks){
    noStroke();
    fill(10,80,80);
    circle(sink.pos.x,sink.pos.y,sink.mass*0.1);
    sink.move();
  }
}
void drawParticles(){
  colorMode(RGB, 255, 255, 255);
  background(216, 216, 216 );
  colorMode(HSB, 360, 100, 100);
  //particles.clear();
  for(Data init : particleInit){
    particles.add(new Projectile(init));
  }
  while (!particles.isEmpty()) {
    ArrayList<Projectile> remove = new ArrayList<>();
    for (Projectile p : particles) {
      noStroke();
      stroke(0,70 - p.size*4);
      fill(p.c,100);
      rect(p.pos.x, p.pos.y, p.size, p.size);
      p.move();
      p.age++;
      if (!remove.contains(p) && p.age > 100) remove.add(p);
    }
    particles.removeAll(remove);
  }
  
}
class Data{
  float mass;
  float angle;
  float x;
  float y;
  color c;
  Data(float mass, float angle, float x, float y, color c){
    this.mass = mass;
    this.angle = angle;
    this.x = x;
    this.y = y;
    this.c = c;
  }
}
class Projectile {
  PVector pos;
  float mass;
  float angle;
  float speed = 2;
  color c;
  float size = 5;
  int age = 0;
  Projectile(Data data){
    mass = data.mass;
    angle = data.angle;
    pos = new PVector(data.x,data.y);
    c = data.c;
  }
  Projectile(float mass, float angle, float x, float y, color c) {
    this.mass = mass;
    this.angle = angle;
    pos = new PVector(x, y);
    this.c = c;
  }
  void setSize(float size) {
    this.size = size;
  }
  void move() {
    if (mass == 0) {
      pos.x += speed * cos(angle);
      pos.y += speed * sin(angle);
    } else {
      PVector dir = new PVector(5*cos(angle), 5*sin(angle));
      for (Sink sink : sinks) {
        //if(int(random(3))==0) continue;
        //angle += ((sink.mass * mass)/sq(PVector.dist(pos,sink.pos)*5))*
        //    (angle(sink.pos,pos) - angle);
        float a = angle(pos, sink.pos);
        //float d = 150/PVector.dist(pos,sink.pos);
        float d = (9000 + sink.mass)/sq(PVector.dist(pos, sink.pos));
        //float d = (200 * sink.mass)/sq(PVector.dist(pos, sink.pos));

        PVector p = new PVector(d*cos(a), d*sin(a));
        dir = dir.add(p);
      }
      pos.x += speed * cos(atan2(dir.y, dir.x));
      pos.y += speed * sin(atan2(dir.y, dir.x));
      angle += (angle - atan2(dir.y, dir.x))*0.05;
    }
    if (size > -1) size -= 1;
    //if (int(random(2))==0) size+=0.1;
  }
  
}
class Sink {
  float angle = random(0,2*PI);
  float speed = 5;
  float mass = random(100, 500);
  PVector pos = new PVector(random(-100, width + 100), random(-100, height + 100));
  //Sink(float x, float y){
  //  pos = new PVector(x,y);
  //}
  void move(){
    pos.x += speed * cos(angle);
    pos.y += speed * sin(angle);
    if(int(random(2))==0) angle += random(-0.5,0.5);
    if(pos.x < -100) pos.x = -100;
    if(pos.x > width + 100) pos.x = width + 100;
    if(pos.y < -100) pos.y = -100;
    if(pos.y > height + 100) pos.y = height + 100;
  }
}
float angle(PVector p1, PVector p2) {
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
