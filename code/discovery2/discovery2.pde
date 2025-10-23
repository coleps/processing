ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<Projectile> particles = new ArrayList<>();
color[] pallette;
color[] pixels1;
void setup() {
  size(600, 600);
  
  pixels1 = new color[width*height];
  PImage img = loadImage("data/img1.jpg");
  img.resize(width,0);
  image(img,0,0);
  //filter(BLUR,20);
  loadPixels();
  arrayCopy(pixels,pixels1);
  
  
  //background(216, 216, 216 );
  colorMode(HSB, 360, 100, 100);
  pallette = new color[]{color(0,0,0),color(0,0,50),color(0,0,100)};
  for (int i = 0; i < 60; i++) {
    sinks.add(new Sink());
  }
  for (int i = 0; i < 200; i++) {
    color c = pallette[int(random(pallette.length))];
    float x = random(width);
    float y = random(height);
    for (int j = 0; j < 20; j++) {
      float px = random(x-50, x+50);
      float py = random(y-50, y+50);
      particles.add(new Projectile(10, random(0, 2*PI), px, py, c));
    }
  }
  while (!particles.isEmpty()) {
    ArrayList<Projectile> remove = new ArrayList<>();
    for (Projectile p : particles) {
      noStroke();
      stroke(0,70 - p.size*4);
      fill(p.c,30);
      rect(p.pos.x, p.pos.y, p.size, p.size);
      //if (p.size < 0.1) remove.add(p);
      p.move();
      p.age++;
      if (!remove.contains(p) && p.age > 100) remove.add(p);
    }
    particles.removeAll(remove);
  }
  //for(Sink sink : sinks){
  //  fill(10,80,80);
  //  circle(sink.pos.x,sink.pos.y,10);
  //}
  //image(img,0,0);
  
  //filter(BLUR,1);
  //int range = 20;
  //loadPixels();
  //for(int i = 0; i < pixels.length; i++){
  //  float b = brightness(pixels[i]);
  //  for(int r = 1; r < range + 1; r++){
  //    if (b < 100*r*(1.0/(range - 1))) {
  //      pixels[i] = color(100*r*(1.0/(range - 1)));
  //      break;
  //    }
  //  }
  //}
  //updatePixels();
  
  loadPixels();
  for(int i = 0; i < pixels.length; i++){
    float b = brightness(pixels[i]);
    fill(pixels1[i],(b/100)*255);
    rect(i%width,floor(i/width),1,1);
    //if(brightness(pixels[i])<10) pixels[i] = pixels1[i];
  }
  //updatePixels();
}




class Projectile {
  PVector pos;
  float mass;
  float angle;
  float speed = 2;
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

        PVector p = new PVector(d*cos(a), d*sin(a));
        dir = dir.add(p);
      }
      pos.x += speed * cos(atan2(dir.y, dir.x));
      pos.y += speed * sin(atan2(dir.y, dir.x));
      angle += (angle - atan2(dir.y, dir.x))*0.05;
    }
    if (size > -1) size -= 1;
    if (int(random(2))==0) size+=1.5;
  }
  
}
class Sink {
  float mass = random(100, 500);
  PVector pos = new PVector(random(-100, width + 100), random(-100, height + 100));
  //Sink(float x, float y){
  //  pos = new PVector(x,y);
  //}
}
float angle(PVector p1, PVector p2) {
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
