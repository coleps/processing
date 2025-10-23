float windowW = 200;
float windowH = 150;
int selectedWindow;
boolean windowSelected = false;
int numOffsets = 2;
int count = 0;
class Window{
  int offset = int(random(2));
  Display display;
  float w = windowW;
  float h = windowH;
  PVector pos = new PVector(random(10+windowW/2,width-windowW/2-10),
                            random(10+windowH/2,height-windowH/2-10));
  PVector center;
  float angle = random(2*PI);
  float speed = 1;//0.2;
  PVector exit = new PVector(width,height);
  float exitD = 15;
  
  Window(){
    center = new PVector(pos.x+windowW/2,pos.y+windowH/2);
    display = getDisplay();
    if(windows.size() < 4 ){
      while(!display.interactive){
        display = getDisplay();
      }
    }
    
    display.window = this;
  }
  void move(){
    if(pos.x - w/2 <= -5 || pos.x + w/2 >= width+5) return;
    if(pos.y - h/2 <= -5 || pos.y + h/2 >= height+5) return;
    pos.x += speed*cos(angle);
    pos.y += speed*sin(angle);
    center.x += speed*cos(angle);
    center.y += speed*sin(angle);
    if(pos.x - w/2 <= 0 || pos.x + w/2 >= width || 
        pos.y - h/2 <= 0 || pos.y + h/2 >= height) angle += PI/2;
  }
  void draw(){
    noStroke();
    fill(0,0,0);
    rectMode(CENTER);
    rect(pos.x,pos.y,w,h);
    rectMode(CORNER);
    
    if(count == offset && !lightOn) display.draw();
    image(display.pg,pos.x-w/2,pos.y-h/2);
    
    strokeWeight(2);
    stroke(0,0,100);
    noStroke();
    noFill();
    rectMode(CENTER);
    rect(pos.x,pos.y,w,h);
    rectMode(CORNER);
    drawX();
  } 
  void drawX(){
    exit.x = pos.x+w/2;
    exit.y = pos.y-h/2;
    exit.x -= 20;
    exit.y += 20;
    
    for(int i = 0; i < 4; i++){
      float x = exit.x + exitD*cos(PI/4 + i*PI/2);
      float y = exit.y + exitD*sin(PI/4 + i*PI/2);
      
      stroke(0,0,100);
      strokeWeight(2);
      line(x,y,exit.x,exit.y);
    }
  }
}
boolean inWindow(int i, float x, float y){
  Window w = accessWindow(i,"get");
  if(x > w.pos.x - windowW/2 && x < w.pos.x + windowW/2 &&
        y > w.pos.y - windowH/2 && y < w.pos.y + windowH/2) {
          return true;
        }
   return false;
}
boolean inAWindow(float x, float y){
  boolean b[] = {false};
  for(int i = 0; i < windows.size(); i++){
    Window w = accessWindow(i,"get");
    if(x > w.pos.x - windowW/2 && x < w.pos.x + windowW/2 &&
        y > w.pos.y - windowH/2 && y < w.pos.y + windowH/2) b[0] = true;
  }
  return b[0];
}
Window inWindowW(){
  float x = mouseX;
  float y = mouseY;
  Window win = null;
  for(int i = 0; i < windows.size(); i++){
    Window w = accessWindow(i,"get");
    if(x > w.pos.x - windowW/2 && x < w.pos.x + windowW/2 &&
        y > w.pos.y - windowH/2 && y < w.pos.y + windowH/2) win = w;
  }
  return win;
}
