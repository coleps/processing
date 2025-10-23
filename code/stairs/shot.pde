class Shot{
  PVector pos;
  float angle;
  float speed = 2;
  color c;
  float size = 10;
  int age = 0;
  Shot(PVector p){
    pos = new PVector(p.x,p.y);
    angle = radians(-90);
  }
  void move(){
    age++;
    pos.x += speed * cos(angle);
    pos.y += speed * sin(angle);
  }
}
void drawShot(Shot shot){
  //pg.beginDraw();
  //PVector p = shot.pos;
  ////p = screenToAbsolute(p);
  //pg.fill(255);
  //pg.stroke(255);
  //pg.rect(p.x-2,p.y-2,4,4);
  //pg.endDraw();
  
  PVector p = shot.pos;
  p = absoluteToScreen(p); 
  fill(0,0,0);
  noStroke();
  stroke(0,0,100);
  rect(p.x-5,p.y-5,10,10);
}
