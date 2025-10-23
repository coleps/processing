Display getDisplay() {
  int i = int(random(1, 10));
  //i = 9;
  if (i == 1 && random(1) > 0.2) i = int(random(1, 10));
  //int i = 3;
  switch(i) {
  case 1:
    return new D1();
  case 2:
    return new D2();
  case 3:
    return new D3();
  case 4:
    return new D4();
  case 5:
    return new D5();
  case 6:
    return new D6();
  case 7:
    return new D7();
  case 8:
    return new D8();
  case 9:
    return new D9();
  }
  return new D1();
}
abstract class Display {
  Window window;
  PGraphics pg;
  boolean interactive;
  abstract void init();
  abstract void draw();
  Display() {
    init();
  }
}

class D1 extends Display {
  void init() {
    interactive = false;
    pg = createGraphics(int(windowW), int(windowH));
  }
  void draw() {
    pg.beginDraw();
    pg.background(color(random(360), 80, 100));
    pg.endDraw();
  }
}
class D2 extends Display {

  void init() {
    interactive = true;
    pg = createGraphics(int(windowW), int(windowH));
  }
  void draw() {
    pg.beginDraw();
    PImage img = loadImage("data/cursor.png");
    img.resize(15, 0);
    pg.image(img, mouseX-(window.pos.x-window.w/2), mouseY-(window.pos.y-window.h/2));
    pg.endDraw();
  }
}
class D3 extends Display {
  ArrayList<R> rs;

  void init() {
    interactive = false;
    rs = new ArrayList<>();
    pg = createGraphics(int(windowW), int(windowH));
    for (int i = 0; i < 20; i++) {
      rs.add(new R());
    }
    for(int i = 0; i < 40; i++){
      draw();
    }
  }
  void draw() {
    pg.beginDraw();
    rs.stream().forEach(r -> {
      pg.noStroke();
      pg.fill(r.c, 10);
      pg.rect(r.pos.x, r.pos.y, 30, 30);
      r.move();
    }
    );
    pg.endDraw();
  }
  class R {
    float w = 30;
    float angle = random(2*PI);
    float speed = 5;
    PVector pos = new PVector(random(15, windowW-15), random(15, windowH-15));
    color c = color(random(360), 60, 80);
    void move() {
      pos.x += speed*cos(angle);
      pos.y += speed*sin(angle);
      if (pos.x <= 0 || pos.x + w >= windowW ||
        pos.y <= 0 || pos.y + w >= windowH) angle += PI/2;

      c = color(hue(c) + 4 % 360, 60, 80);
    }
  }
}
class D4 extends Display {
  float t;
  float speed;
  float bobbleRate;
  PVector pos;
  float angle;
  void init() {
    interactive = false;
    angle = random(2*PI);
    pos = new PVector(windowW/2, windowH/2);
    t = 0;
    speed = 0.02;
    bobbleRate = 1.5;
    pg = createGraphics(int(windowW), int(windowH));
  }
  void draw() {
    pos.x += 2*cos(angle);
    pos.y += 2*sin(angle);
    angle += random(-0.8, 0.8);

    if (pos.x - 30 < 0) pos.x = 0 + 30;
    if (pos.x + 30 > windowW) pos.x = windowW - 30;
    if (pos.y - 30 < 0) pos.y = 0 + 30;
    if (pos.y + 30> windowH) pos.y = windowH - 30;

    float x = pos.x;
    float y = pos.y;

    pg.beginDraw();
    pg.beginShape();
    float phase = t*speed;
    for (float i = 0; i <= TWO_PI; i += PI/180) {
      // Playing with bobble rate
      float xoff = map(cos(i), -1, 1, 0, bobbleRate);
      float yoff = map(sin(i), -1, 1, 0, bobbleRate);
      float noise = noise(xoff + phase, yoff + phase);

      float r = map(noise, 0, 1, 20, 50);
      float xs = x + r  * cos(i);
      float ys = y + r  * sin(i);
      pg.noStroke();
      color c = color((i/2.0*PI)*70, 80, 100);
      pg.fill(c);
      pg.circle(xs, ys, 5);
      pg.fill(0);
      pg.stroke(255);
      pg.noStroke();
      pg.vertex(xs, ys);
    }
    pg.endShape();
    pg.endDraw();
    t += 2;
  }
}
class D5 extends Display {
  float t;
  float speed;
  float bobbleRate;
  PVector pos;
  float angle;
  int n = 1;
  void init() {
    interactive = false;
    angle = random(2*PI);
    pos = new PVector(windowW/2, windowH/2);
    t = 0;
    speed = 0.02;
    bobbleRate = 1.5;
    pg = createGraphics(int(windowW), int(windowH));
  }
  void draw() {
    pos.x += 2*cos(angle);
    pos.y += 2*sin(angle);
    angle += random(-0.8, 0.8);

    if (pos.x - 30 < 0) pos.x = 0 + 30;
    if (pos.x + 30 > windowW) pos.x = windowW - 30;
    if (pos.y - 30 < 0) pos.y = 0 + 30;
    if (pos.y + 30> windowH) pos.y = windowH - 30;

    float x = pos.x;
    float y = pos.y;

    pg.beginDraw();
    pg.beginShape();
    float phase = t*speed;
    for (float i = 0; i <= TWO_PI; i += PI/180) {
      // Playing with bobble rate
      float xoff = map(cos(i), -1, 1, 0, bobbleRate);
      float yoff = map(sin(i), -1, 1, 0, bobbleRate);
      float noise = noise(xoff + phase, yoff + phase);

      float r = map(noise, 0, 1, 20, 50);
      float xs = x + r  * cos(i);
      float ys = y + r  * sin(i);
      pg.noStroke();
      color c = color(0, 0, int(random(2))*100);
      pg.fill(c);
      pg.circle(xs, ys, 2);
      pg.noFill();
      pg.noStroke();
      pg.vertex(xs, ys);
    }
    pg.endShape();
    pg.endDraw();
    t += 2;
  }
}
class D6 extends Display {
  PGraphics mirror;
  void init() {
    interactive = false;
    pg = createGraphics(int(windowW), int(windowH));

    mirror = createGraphics(int(width), int(height));
    mirror.beginDraw();
    mirror.background(0, 0, 0);
    mirror.endDraw();
  }
  void draw() {
    loadPixels();
    arrayCopy(pixels, mirror.pixels);
    mirror.updatePixels();
    pg.beginDraw();
    //pg.background(0,0,100);
    pg.image(mirror, 0, 0, windowW, windowH);
    pg.endDraw();
  }
}
class D7 extends Display {
  ArrayList<C> cs;
  void init() {
    interactive = true;
    cs = new ArrayList<>();
    pg = createGraphics(int(windowW), int(windowH));
    for (int i = 0; i < 5; i++) {
      cs.add(new C());
      //println(cs.get(i).pos);
    }
  }
  void draw() {
    pg.beginDraw();
    pg.background(0);
    pg.noStroke();
    cs.stream().forEach(c-> {
      float d = PVector.dist(new PVector(mouseX-(window.pos.x-window.w/2), mouseY-(window.pos.y-window.h/2)), c.pos);
      d/=5;
      if (d == 0) d = 0.0001;
      float r = 800/d;
      //println(r);
      pg.fill(c.c);
      pg.circle(c.pos.x, c.pos.y, r);
      pg.circle(c.pos.x, c.pos.y, 5);
    }
    );
    pg.endDraw();
  }
  class C {
    PVector pos = new PVector(random(windowW), random(windowH));
    color c = color(random(180,205), random(0, 60), random(40, 120));
  }
}
class D8 extends Display {
  ArrayList<Bubble> bubbles;
  float bubR;
  void init() {
    interactive = true;
    pg = createGraphics(int(windowW), int(windowH));
    bubbles = new ArrayList<>();
    bubR = 30;

    for (float x = 10; x < windowW; x+= bubR) {
      for (float y = 15; y < windowH; y += bubR) {
        bubbles.add(new Bubble(x, y));
      }
    }
  }
  void draw() {
    pg.beginDraw();

    pg.background(0);

    bubbles.stream().forEach(b -> {
      if (!b.alive) {
        if(b.countdown > 0) {
          b.drawPop();
          b.countdown--;
        }
        return;
      }
      b.draw();
    }
    );

    popB();

    pg.endDraw();
  }
  void popB() {
    for (int i = 0; i < bubbles.size(); i++) {
      PVector mouse = new PVector(mouseX-(window.pos.x-window.w/2), mouseY-(window.pos.y-window.h/2));
      if (PVector.dist(bubbles.get(i).pos, mouse) < bubR/2) {
        bubbles.get(i).alive = false;
      }
    }
  }
  class Bubble {
    float p = random(2);
    boolean alive = true;
    PVector pos;
    int countdown = 2;
    float t = 0;
    float speed = 0.03;
    float bobbleRate = 1.5;
    Bubble(float x, float y) {
      pos = new PVector(x, y);
    }
    void draw() {
      pg.beginShape();
      float phase = t*speed;
      for (float i = 0; i <= TWO_PI; i += PI/180) {
        // Playing with bobble rate
        float xoff = map(cos(i), -1, 1, 0, bobbleRate);
        float yoff = map(sin(i), -1, 1, 0, bobbleRate);
        float noise = noise(xoff + phase + p, yoff + phase + p);

        float r = map(noise, 0, 1, bubR/1.5-10, bubR/1.5);
        float xs = pos.x + r  * cos(i);
        float ys = pos.y + r  * sin(i);
        pg.noStroke();
        pg.fill(0);
        pg.stroke(255);
        pg.vertex(xs, ys);
      }
      pg.endShape();
      t += 2;
    }
    void drawPop() {
      for (float i = 0; i < 2*PI; i+=0.6) {
        PVector start = new PVector(pos.x+8*cos(i), pos.y+8*sin(i));
        PVector end = new PVector(pos.x+20*cos(i), pos.y+20*sin(i));
        pg.stroke(255);
        pg.line(start.x,start.y,end.x,end.y);
      }
    }
  }
}
class D9 extends Display {
  int numRows;
  int numCols;
  ArrayList<R2> rs;
  void init() {
    interactive = true;
    pg = createGraphics(int(windowW), int(windowH));
    numRows = 10;
    numCols = 10;
    rs = new ArrayList<>();
    
    for(float x = 0; x < windowW; x+= windowW/numCols){
      for(float y = 0; y < windowH; y+= windowH/numRows){
        rs.add(new R2(x,y,x+windowW/numCols,y+windowH/numRows));
      }
    }

  }
  void draw() {
    pg.beginDraw();
    rs.stream().forEach(r->{
      if(in(r)) r.c = color((frameCount)%360,random(100),80);
      pg.fill(r.c);
      pg.noStroke();
      pg.rect(r.start.x,r.start.y,r.end.x,r.end.y);
    });
    pg.endDraw();
  }
  class R2{
    PVector start;
    PVector end;
    color c = color(random(360),0,random(100));
    R2(float x1, float y1, float x2, float y2){
      start = new PVector(x1,y1);
      end = new PVector(x2,y2);
    }
  }
  boolean in(R2 r){
    float x = mouseX-(window.pos.x-window.w/2);
    float y = mouseY-(window.pos.y-window.h/2);
    if(x > r.start.x && x < r.end.x && 
            y > r.start.y && y < r.end.y) return true;
    return false;
  }
}

//absttract text moving down screen
