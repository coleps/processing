float speed = 0.01;
float bobbleRate = 1.5;
class Alien {
  PVector pos;
  boolean alive = true;
  int timeout;
  float shift = random(0,1);
  Alien(PVector p) {
    pos = new PVector(p.x, p.y);
  }
  void kill() {
    alive = false;
    timeout = 60*30;
    for (int i = 0; i < 15; i++) {
      float d = random(alienR);
      float a = random(2*PI);
      Projectile p = new Projectile(20, a, pos.x+d*cos(a), pos.y+d*sin(a), color(0));
      p.changeSize = false;
      p.speed = 7;
      particles.add(p);
      //println(i);
    }
    echo = createGraphics(width*bgScale, height*bgScale);
    echo.beginDraw();
    echo.fill(255, 0, 0);
    echo.noStroke();

    while (!particles.isEmpty()) {
      ArrayList<Projectile> remove = new ArrayList<>();
      for (Projectile p : particles) {
        echo.rect(p.pos.x, p.pos.y, p.size, p.size);
        p.move();
        p.size-=1;
        if (p.age > random(15, 20)) remove.add(p);
      }
      particles.removeAll(remove);
    }
    echo.endDraw();
    particleUpdate = true;
  }
  void revive() {
    timeout--;
    if (timeout == 0) {
      pos = new PVector(random(width*2), random(height*2));
      alive = true;
    }
  }
}
void drawAlien(Alien a) {
  //float x = width/2 - (width*bgScale*0.5 - a.x);
  //  float y = height/2 - (height*bgScale*0.5 - a.y);
  fill(0, 0, 0);
  stroke(0, 0, 100);
  PVector p = absoluteToScreen(a.pos);
  float x = p.x;
  float y = p.y;
  beginShape();
  float phase = t*speed;
  for (float i = 0; i <= TWO_PI; i += PI/180) {
    float xoff = map(cos(i), -1, 1, 0, bobbleRate);
    float yoff = map(sin(i), -1, 1, 0, bobbleRate);
    float noise = noise(xoff + phase + a.shift, yoff + phase  + a.shift);

    float r = map(noise, 0, 1, 10, 20);
    float xs = x + r  * cos(i);
    float ys = y + r  * sin(i);

    vertex(xs, ys);
  }
  endShape();
}
boolean inAlien(PVector a, PVector p) {
  boolean in = false;
  if (PVector.dist(a, p) < alienR + 5) in = true;
  return in;
}
