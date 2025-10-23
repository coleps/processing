/**

  ARROW KEYS OR WASD TO MOVE
  SPACEBAR TO SHOOT
  
**/

ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<Projectile> particles = new ArrayList<>();
ArrayList<Shot> shots = new ArrayList<>();
color[] pallette;
//color[] guts = {color(255, 0, 0)};
PGraphics pg;
PGraphics effects;
int bgScale = 2;
PVector cameraPos;
ArrayList<Alien> aliens = new ArrayList<>();
float alienR = 10;
boolean particleUpdate = false;

float t = 0;
PVector playerPos;

boolean start = true;
boolean loading = true;


void setup() {
  size(600, 600);
  background(255);
  frameRate(60);
  colorMode(HSB, 360, 100, 100, 100);
  pallette = new color[]{color(0, 0, 0), color(0, 0, 50), color(0, 0, 100)};
  for (int i = 0; i < 200; i++) {
    sinks.add(new Sink());
  }
  playerPos = new PVector(width/2, height - 100);
  pg = createGraphics(width*bgScale, height*bgScale);
  effects = createGraphics(width*bgScale, height*bgScale);
  cameraPos = new PVector(width*bgScale*0.5, height*bgScale*0.5);

  //initbg();
  image(effects, -cameraPos.x/2, -cameraPos.y/2);
  for (int i = 0; i < 10; i++) aliens.add(
    new Alien(new PVector(random(width*bgScale), random(height*bgScale))));
  aliens.add(new Alien(new PVector(width*bgScale*0.5, height*bgScale*0.5)));
}
void draw() {
  if (start) {
    start = false;
    thread("initbg");
  }
  if (loading) {
    drawLoading();
    return;
  }

  if (keyPressed) kp();
  image(pg, -cameraPos.x/2, -cameraPos.y/2);
  drawPlayer();

  ArrayList<Shot> remove = new ArrayList<>();
  for (Shot shot : shots) {
    drawShot(shot);
    shot.move();
    if (shot.age > 200)  remove.add(shot);
  }
  shots.removeAll(remove);


  killAliens();
  drawAliens();
  drawParticles();


  t += 1;
}
void drawLoading() {
  background(0, 0, 100);
  float w = 200;
  rectMode(CENTER);

  fill(0,0,0);
  rect(width/2,height/2,w,w);
  
  fill(0, 100, 100, 50 + 55*sin(frameCount/20.0));
  stroke(0, 0, 0);
  float px = width/2;
  float py = height/2 - 15;
  triangle(px, py, px - 15, py + 30, px + 15, py + 30);

  rectMode(CORNER);
}
void drawPlayer() {
  fill(0, 100, 100);
  stroke(0, 0, 0);
  float px = playerPos.x;
  float py = playerPos.y;
  triangle(px, py, px - 15, py + 30, px + 15, py + 30);
}
void killAliens() {
  for (Shot shot : shots) {
    for (Alien alien : aliens) {
      if (!alien.alive) continue;
      if (inAlien(alien.pos, shot.pos)) {
        alien.kill();
        shots.clear();
        return;
      }
    }
  }
}
void drawAliens() {
  for (Alien alien : aliens) {
    if (alien.alive) drawAlien(alien);
    else alien.revive();
  }
}
void drawParticles() {
  if (!particleUpdate) return;
  pg.loadPixels();
  effects.loadPixels();
  for (int i = 0; i < pg.pixels.length; i++) {
    color c = effects.pixels[i];
    if (red(c) > 0 && brightness(pg.pixels[i]) > 0) {
      //println("yes");
      pg.pixels[i] = c;
      pg.updatePixels();
    }
  }
  particleUpdate = false;
}
PVector absoluteToScreen(PVector a) {
  //camera = (600,600)
  //(0,0) -> (-300,-300)
  //(300,300) -> (0,0)
  //(900,900) -> (600,600)
  //a - camera + width/2
  float x = a.x - cameraPos.x/2;
  float y = a.y - cameraPos.y/2;

  //float x = a.x - cameraPos.x + width; parallax
  //float y = a.y - cameraPos.y + height;
  return new PVector(x, y);
}
PVector screenToAbsolute(PVector s) {
  float x = s.x + cameraPos.x/2;
  float y = s.y + cameraPos.y/2;
  return new PVector(x, y);
}
void kp() {
  float d = 2;
  if (keyCode == LEFT || key == 'a') cameraPos.x -= d;
  if (keyCode == RIGHT || key == 'd') cameraPos.x += d;
  if (keyCode == UP || key == 'w') cameraPos.y -= d;
  if (keyCode == DOWN || key == 's') cameraPos.y += d;

  if (key == ' ') {
    if (shots.isEmpty()) shots.add(new Shot(screenToAbsolute(playerPos)));
  }
}
void initbg() {
  pg.beginDraw();
  pg.background(255);
  for (int i = 0; i < 100*bgScale; i++) {
    color c = pallette[int(random(pallette.length))];
    float x = random(width*bgScale);
    float y = random(height*bgScale);
    for (int j = 0; j < 50*bgScale; j++) {
      float px = random(x-50, x+50);
      float py = random(y-50, y+50);
      particles.add(new Projectile(10, random(0, 2*PI), px, py, c));
    }
  }
  while (!particles.isEmpty()) {
    ArrayList<Projectile> remove = new ArrayList<>();
    for (Projectile p : particles) {
      //noStroke();
      pg.fill(p.c);
      pg.rect(p.pos.x, p.pos.y, p.size, p.size);
      //if (p.size < 0.1) remove.add(p);
      p.move();
      p.age++;
      if (!remove.contains(p) && p.age > 100) remove.add(p);
    }
    particles.removeAll(remove);
  }
  pg.endDraw();
  loading = false;
}

float angle(PVector p1, PVector p2) {
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
