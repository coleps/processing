float sqSize = 5;
int numRowAliens = 6;
int numRows = 4;
int alienW = 10;
int alienH = 5;
Player player;
ArrayList<Alien> aliens = new ArrayList<>();
ArrayList<Projectile> playerShots = new ArrayList<>();
ArrayList<Projectile> particles = new ArrayList<>();
ArrayList<Sink> sinks = new ArrayList<>();
ArrayList<Alien> deadAliens = new ArrayList<>();
boolean loading = true;
void setup(){
  size(600,600);
  background(0);
  frameRate(15);
  colorMode(HSB,360,100,100);
  player = new Player();
  initAliens();
  for(int i = 0; i < 70; i++){
    sinks.add(new Sink());
  }
}
void initAliens(){
  float x = (width - numRowAliens * sqSize * (alienW + 5))/3;
  float y = 60;
  for(int i = 0; i < numRows; i++){
    for(int j = 0; j < numRowAliens; j++){
      float ax = x + j * sqSize * (alienW + 10);
      float ay = y + (i * sqSize * (alienH + 10));
      aliens.add(new Alien(ax,ay,color(random(360),80,80)));
    }
  }
}
void draw(){
  if(loading){
    PImage img = loadImage("data/instructions.jpg");
    img.resize(width,0);
    image(img,0,0);
    return;
  }
  //background(0);
  fill(0,30);
  rect(0,player.pos.y,width,height);
  drawSinks();
  drawPlayer();
  drawAliens();
  drawProjectiles();
  
}
void drawSinks(){
  for(Sink sink : sinks){
    fill(0,0);
    stroke(0,0,20);
    strokeWeight(0.4);
    circle(sink.pos.x,sink.pos.y,sink.mass/10);
  }
}
void drawAliens(){
  int i = 0;
  ArrayList<Integer> revive = new ArrayList<>();
  for(Alien alien : aliens){
    if(!alien.alive) {
      if(alien.timeout > 0) alien.timeout -= 1;
      else revive.add(i);      
    }
    if(alien.alive) drawAlien(alien);
    i++;
  }
  for(int r : revive) aliens.set(r,new Alien(aliens.get(r)));
}
void drawProjectiles(){
  ArrayList<Projectile> remove = new ArrayList<>();
  for(Projectile p : playerShots){
    fill(0,0,100);
    //fill(p.c);
    rect(p.pos.x,p.pos.y,sqSize,sqSize);
    Alien alien = onAlien(p.pos);
    if(alien != null) {
      addAlienParticles(alien);
      alien.alive = false;
      deadAliens.add(alien);
    }
    p.move();
    p.age++;
    if(p.pos.x < 0 || p.pos.x > width || p.pos.y < 0 || p.pos.y > height){
      remove.add(p);
    }
    if(!remove.contains(p) && p.age > 15*7) remove.add(p);
  }
  playerShots.removeAll(remove);
  
  remove = new ArrayList<>();
  for(Projectile p : particles){
    fill(p.c);
    rect(p.pos.x,p.pos.y,p.size,p.size);
    if(p.size < 0.1) remove.add(p);
    p.move();
    p.age++;
    if(!remove.contains(p) && p.age > 15*5) remove.add(p);
  }
  particles.removeAll(remove);
  
}
void addAlienParticles(Alien alien){
  float x = alien.pos.x;
  float y = alien.pos.y;
  for(int i = 0; i < alien.body.length; i++){
    for(int j = 0; j < alien.body[0].length; j++){
      if(alien.body[i][j] == 0) continue;
      Projectile p1 = new Projectile(10,radians(-90 + random(-30,30)),x - (j*sqSize + sqSize),y + i*sqSize,alien.c);
      Projectile p2 = new Projectile(10,radians(-90 + random(-30,30)),x + j*sqSize,y + i * sqSize,alien.c);
      p1.setSize(sqSize);
      p2.setSize(sqSize);
      p1.speed = 4;
      p2.speed = 4;
      particles.add(p1);
      particles.add(p2);
    }
  }
}
Alien onAlien(PVector pos){
  for(Alien alien : aliens){
    if(!alien.alive) continue;
    if(pos.x > (alien.pos.x-25) && pos.x < (alien.pos.x + 25) 
         && pos.y > alien.pos.y && pos.y < (alien.pos.y + 25)) return alien;
  }
  return null;
}
void drawPlayer(){
  float x = player.pos.x;
  float y = player.pos.y;
  for(int i = 0; i < player.body.length; i++){
    for(int j = 0; j < player.body[0].length; j++){
      if(player.body[i][j] == 0) continue;
      noStroke();
      fill(0,0,100);
      rect(x - (j*sqSize + sqSize),y + i*sqSize,sqSize,sqSize);
      rect(x + j*sqSize,y + i * sqSize,sqSize,sqSize);
     
    }
  }
}
void keyPressed(){
  if(loading){
    loading = false;
    background(0);
    return;
  }
  if(keyCode == LEFT) player.pos.x -= 5;
  if(keyCode == RIGHT) player.pos.x += 5;
  if(keyCode == UP) {
    for(int i = 0; i < 2; i++){
      playerShots.add(
      new Projectile(10,radians(-90 + i),player.pos.x - sqSize/2,player.pos.y,color(0,0,100)));
      playerShots.add(
      new Projectile(10,radians(-90 - i),player.pos.x - sqSize/2,player.pos.y,color(0,0,100)));

    }
    
  }
}
void drawAlien(Alien alien){
  float x = alien.pos.x;
  float y = alien.pos.y;
  
  for(int i = 0; i < alien.body.length; i++){
    for(int j = 0; j < alien.body[0].length; j++){
      if(alien.body[i][j] == 0) continue;
      noStroke();
      
      fill(alien.c);
      fill(0,0,0);
      rect(x - (j*sqSize + sqSize) - 2,y + i*sqSize - 2,sqSize + 4,sqSize + 4);
      rect(x + j*sqSize - 2,y + i * sqSize - 2,sqSize + 4,sqSize + 4);
    }
  }
  
  for(int i = 0; i < alien.body.length; i++){
    for(int j = 0; j < alien.body[0].length; j++){
      if(alien.body[i][j] == 0) continue;
      noStroke();
      
      fill(0,0,100);
      rect(x - (j*sqSize + sqSize),y + i*sqSize,sqSize,sqSize);
      rect(x + j*sqSize,y + i * sqSize,sqSize,sqSize);
    }
  }
}
class Player{
  PVector pos = new PVector(width/2,height - 40);
  int[][] body = {{1,0,0,0,0},
                  {1,0,0,0,0},
                  {1,1,1,1,0},
                  {1,1,1,1,1},
                  {1,1,1,1,1}};
}
class Alien{
  PVector pos = new PVector(width/2,20);
  int[][] body = new int[5][5];
  color c;
  boolean alive = true;
  float timeout = random(15*15,15*30);
  
  Alien(float x, float y, color c){
    this.c = c;
    pos = new PVector(x,y);
    for(int i = 0; i < body.length; i ++){
      for(int j = 0; j < body[0].length; j++){
        if(int(random(2))==0) body[i][j] = 1;
        if(j > 0 && body[i][j-1] == 1) if(int(random(2))==0) body[i][j] = 1;
      }
    }
  }
  Alien(Alien a){
    this(a.pos.x,a.pos.y,color(random(360),80,80));
  }
}
class Projectile{
  PVector pos;
  float mass;
  float angle;
  float speed = 10;
  color c;
  float size = -100;
  int age = 0;
  Projectile(float mass, float angle, float x, float y, color c){
    this.mass = mass;
    this.angle = angle;
    pos = new PVector(x,y);
    this.c = c;
  }
  void setSize(float size){this.size = size;}
  void move(){
    if(mass == 0) {
      pos.x += speed * cos(angle);
      pos.y += speed * sin(angle);
    }
    else{
      PVector dir = new PVector(5*cos(angle),5*sin(angle));
      for(Sink sink : sinks){
        //if(int(random(3))==0) continue;
        //angle += ((sink.mass * mass)/sq(PVector.dist(pos,sink.pos)*5))*
        //    (angle(sink.pos,pos) - angle);
        float a = angle(pos,sink.pos);
        //float d = 150/PVector.dist(pos,sink.pos);
        float d = (200 + (width-pos.y)*5)/sq(PVector.dist(pos,sink.pos));

        PVector p = new PVector(d*cos(a),d*sin(a));
        dir = dir.add(p);
        
      }
      pos.x += speed * cos(atan2(dir.y,dir.x));
      pos.y += speed * sin(atan2(dir.y,dir.x));
      angle += (angle - atan2(dir.y,dir.x))*0.05;
    }
    if(size > -1) size -= 1;
    if(int(random(2))==0) size+=2;
  }
}
class Sink{
  float mass = random(100,500);
  PVector pos = new PVector(random(-100, width + 100),random(-100,height - 100));
  //Sink(float x, float y){
  //  pos = new PVector(x,y);
  //}
}
float angle(PVector p1, PVector p2){
  return atan2(-(p2.y-p1.y), -(p2.x-p1.x));
}
