ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<Projectile> particles = new ArrayList<>();
ArrayList<color[]> history = new ArrayList<>();
int t = 0;
PVector pos = new PVector(300,300);
float r = 25;
void setup() {
  size(600, 600);
  background(255);
  frameRate(15);
  colorMode(HSB, 360, 100, 100);
  for (int i = 0; i < 400; i++) {
    sinks.add(new Sink());
  }
  for (int i = 0; i < 200; i++) {
    color c = color(0, 0, int(random(5))*100);
    int d = int(random(2));
    float x;
    float y;
    if(d == 0){
      x = random(-100,width+100);
      y = int(random(2))*height;
    }
    else{
      x = int(random(2))*width;
      y = random(-100,height+100);
      
    }
    
    for (int j = 0; j < 10; j++) {
      float px = x;//random(x-10, x+10);
      float py = y;//random(y-10, y+10);
      particles.add(new Projectile(10, -angle(new PVector(px,py),new PVector(width/2,height/2)), px, py, c));
    }
  }
  while (!particles.isEmpty()) {
    
    loadPixels();
    color[] pi = new color[width*height];
    arrayCopy(pixels,pi);
    history.add(pi);
    
    t++;
    //sinks.stream().forEach(s -> s.move());
    ArrayList<Projectile> remove = new ArrayList<>();
    int i =-1;
    for (Projectile p : particles) {
      i++;
      //fill(p.c);
      //rect(p.pos.x, p.pos.y, p.size, p.size);
      if(p.prevpos != null){
        strokeCap(PROJECT);
        stroke(0, 0, 80 + sin(t/5.0)*20);
        stroke(random(360), 35, 100);

        strokeWeight(abs(p.size/3)+0.5);
        //strokeWeight(0.4);
        line(p.prevpos.x,p.prevpos.y,p.pos.x,p.pos.y);
      }
      //if (p.size < 0.1) remove.add(p);
      p.move();
      p.age++;
      if (!remove.contains(p) && p.age > 200) remove.add(p);
    }
    particles.removeAll(remove);
  }
  //outline();
  //updatePixels();
}
void outline(){
  //loadPixels();
  float w = 1;
  background(0,0,0);
  color c = color(0,0,100);
  for(int i = 0; i < pixels.length; i++){
    if(i > 0){
      if(pixels[i-1] == color(0,0,100) && pixels[i] != color(0,0,100)) {
        //pixels[i] = color(0,0,0);
        noStroke();
        fill(c);
        rect(i%width,floor(i/width),w,w);
      }
    }
    if(i < pixels.length-1) {
      if(pixels[i+1] == color(0,0,100) && pixels[i] != color(0,0,100)) {
        //pixels[i] = color(0,0,0);
        noStroke();
        fill(c);
        rect(i%width,floor(i/width),w,w);
      }
    }
    if(i - width > 0){
      if(pixels[i-width] == color(0,0,100) && pixels[i] != color(0,0,100)) {
        //pixels[i] = color(0,0,0);
        noStroke();
        fill(c);
        rect(i%width,floor(i/width),w,w);
      }
    }
    if(i + width < pixels.length){
      if(pixels[i+width] == color(0,0,100) && pixels[i] != color(0,0,100)) {
        //pixels[i] = color(0,0,0);
        noStroke();
        fill(c);
        rect(i%width,floor(i/width),w,w);
      }
    }
  }
}
//void draw(){
//  arrayCopy(history.get(history.size()-1),pixels);
//  updatePixels();
//  //if(keyPressed) kp();
  
//  //loadPixels();
//  //for(int i = 0; i < pixels.length; i++){
//  //  int x = i%width;
//  //  int y = floor(i/width);
//  //  if(PVector.dist(pos,new PVector(x,y))>r) pixels[i] = color(0,0,100);
//  //}
//  //updatePixels();

  
//  //outline();
//}
void kp(){
  //if(history.size() == 1) return;
  //history.remove(history.size()-1);
  
  float d = 2;
  if (keyCode == LEFT || key == 'a') pos.x -= d;
  if (keyCode == RIGHT || key == 'd') pos.x += d;
  if (keyCode == UP || key == 'w') pos.y -= d;
  if (keyCode == DOWN || key == 's') pos.y += d;

}
class Projectile {
  PVector pos;
  PVector prevpos;
  float mass;
  float angle;
  float speed = 10;
  color c;
  float size = 10;
  int age = 0;
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
    prevpos = new PVector(pos.x,pos.y);
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
        float d = (350 )/pow(PVector.dist(pos, sink.pos),1.95);

        PVector p = new PVector(d*cos(a), d*sin(a));
        dir = dir.add(p);
      }
      pos.x += 5 * cos(atan2(dir.y, dir.x));
      pos.y += 5 * sin(atan2(dir.y, dir.x));
      if(int(random(3))!=0) angle += (angle - atan2(dir.y, dir.x))*0.05;

    }
    if (size > -1) size -= 1.2;
    if (int(random(2))==0) size+=2;
  }
}
class Sink {
  float angle = random(2*PI);
  float speed = 5;
  float mass = random(100, 500);
  PVector pos = new PVector(random(0, width - 0), random(0, height - 0));
  //Sink(float x, float y){
  //  pos = new PVector(x,y);
  //}
  void move(){
    pos.x += speed*cos(angle);
    pos.y += speed*sin(angle);
    angle += random(-0.1,0.1);
  }
}
float angle(PVector p1, PVector p2) {
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
