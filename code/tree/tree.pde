Branch root;
float angleDiff = radians(20);
boolean b = true;

void setup(){
  size(900,600);
  root = new Branch(14);
  background(255);
  drawBranch(root);

}
void draw(){
  
}

void drawBranch(Branch branch){
  float endx = branch.start.x + branch.len*cos(branch.angle); 
  float endy = branch.start.y + branch.len*sin(branch.angle); 
  strokeWeight(branch.d * exp(-branch.d * 0.01));
  stroke(0);
  //stroke(0,branch.d*20);
  line(branch.start.x,branch.start.y,endx,endy);
  
  if(branch.d < random(1,10)) {
    strokeWeight(branch.d * exp(-branch.d * 0.01) * 0.7);
    stroke(7, 166, 22);
    line(branch.start.x,branch.start.y,endx,endy);
  }
  if(branch.d == 0) {
    noStroke();
    fill(255, 97, 134);
    circle(endx,endy,3);
  }
  //branch.angle += random(-0.01,0.01);
  if(branch.children[0] != null && branch.children[1] != null){
    drawBranch(branch.children[0]);
    drawBranch(branch.children[1]);
  }
}

enum Dir {LEFT, RIGHT}
class Branch{
  int d;
  PVector start;
  float angle;
  float len;
  Branch[] children = new Branch[2];
  Branch(int d){
    this.d = d;
    start = new PVector(width/2,height);
    angle = radians(-90);
    len = 80;
    children[0] = new Branch(this, Dir.LEFT);
    children[1] = new Branch(this, Dir.RIGHT);
  }
  Branch(Branch parent, Dir dir){
    d = parent.d - 1;
    //if(d != 0 && int(random(10))==0) d--;
    //if(d != 0 && int(random(10))==0) d++;
    //if(b && d == 7) {d=14; len = 50; b = false;}
    //else len = parent.len * 0.8 * random(0.8,1.2);
    float sx = parent.start.x + parent.len*cos(parent.angle);
    float sy = parent.start.y + parent.len*sin(parent.angle);
    start = new PVector(sx,sy);
    if(dir == Dir.LEFT) angle = parent.angle - angleDiff + random(-0.7,0.7);
    else angle = parent.angle + angleDiff;
    //len = parent.len * 0.8;
    len = parent.len * 0.8 * random(0.8,1.2);
    if(d > 0){
      children[0] = new Branch(this, Dir.LEFT);
      children[1] = new Branch(this, Dir.RIGHT);
    }
  }
}
