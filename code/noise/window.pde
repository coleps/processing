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
  PVector pos = new PVector(width/2 + random(-100,100),height/2 + random(-100,100));
  float angle = random(2*PI);
  float speed = 1;//0.2;
  
  Window(){
    
    display = getDisplay();
    if(windows.size() < 4 ){
      while(!display.interactive){
        display = getDisplay();
      }
    }
    
    display.window = this;
  }
  void move(){
    pos.x += speed*cos(angle);
    pos.y += speed*sin(angle);
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
  } 
}
boolean inWindow(int i, float x, float y){
  if(x > windows.get(i).pos.x - windowW/2 && x < windows.get(i).pos.x + windowW/2 &&
        y > windows.get(i).pos.y - windowH/2 && y < windows.get(i).pos.y + windowH/2) {
          return true;
        }
   return false;
}
boolean inAWindow(float x, float y){
  boolean b[] = {false};
  windows.stream().forEach(w->{
    if(x > w.pos.x - windowW/2 && x < w.pos.x + windowW/2 &&
        y > w.pos.y - windowH/2 && y < w.pos.y + windowH/2) b[0] = true;
  });
  return b[0];
}
