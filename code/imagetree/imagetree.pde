PImage img;
float angleDiff = radians(20);

void setup(){
  size(480,640);
  background(255);
  strokeCap(SQUARE);
  img = loadImage("data/img3.png");
  img.resize(width, 0);
  img.loadPixels();
  
  Branch root = new Branch(13,100);
  drawBranch(root,img.pixels);
  
  root = new Branch(13,60);
  drawBranch(root,img.pixels);
  
}

void drawBranch(Branch branch, color[] pix){
  int loc = int(branch.start.x) + width*int(branch.start.y);
  if(loc < 0 || loc > pix.length) loc = (int(img.height) - 1) * int(img.width) 
                                                  + int(img.width/2);
  if(loc >= pix.length) loc = 0;
  
  color c = pix[loc];
  
  float endx = branch.start.x + branch.len*cos(branch.angle); 
  float endy = branch.start.y + branch.len*sin(branch.angle); 
  
  float sw = branch.d * exp(-branch.d * 0.02);
  if(sw < 0.6) sw = 0.6;
  
  strokeWeight(sw*1.15);
  stroke(0);
  if(sw > 1) line(branch.start.x,branch.start.y,endx,endy);
  
  strokeWeight(sw);
  stroke(red(c),green(c),blue(c));

  line(branch.start.x,branch.start.y,endx,endy);
  
  if(branch.children[0] != null && branch.children[1] != null){
    drawBranch(branch.children[0],pix);
    drawBranch(branch.children[1],pix);
  }
  
}
enum Dir {LEFT, RIGHT}
class Branch{
  int d;
  PVector start;
  float angle;
  float len;
  Branch[] children = new Branch[2];
  // root branch
  Branch(int d, float len){
    this.d = d;
    start = new PVector(width/2,height);
    angle = radians(-90);
    this.len = len;
    children[0] = new Branch(this, Dir.LEFT);
    children[1] = new Branch(this, Dir.RIGHT);
  }
  // non-root
  Branch(Branch parent, Dir dir){
    d = parent.d - 1;
    float sx = parent.start.x + parent.len*cos(parent.angle);
    float sy = parent.start.y + parent.len*sin(parent.angle);
    start = new PVector(sx,sy);
    if(dir == Dir.LEFT) angle = parent.angle - angleDiff + random(-0.5,0.5);
    else angle = parent.angle + angleDiff;
    //len = parent.len * 0.8;
    len = parent.len * 0.82 * random(0.8,1.2);
    if(d > 0){
      children[0] = new Branch(this, Dir.LEFT);
      children[1] = new Branch(this, Dir.RIGHT);
    }
  }
}
