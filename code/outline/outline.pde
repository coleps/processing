import processing.pdf.*;

// 200 x pos
ArrayList<PVector> outline = new ArrayList<>();
int num = 100;

void setup(){
  beginRecord(PDF,"images/img.pdf");
  size(640,480);
  background(255);
  colorMode(HSB,100,100,100);
  background(60,90,90);
  
  for(int i = 1000; i > 0; i--){
    fill(0,0,random(0,100));
    stroke(0,0,0,0);
    circle(width/2,height/2,i);
    //rect(random(-100,width-100),random(-100,height-100),random(100,300),random(100,200));
  }
  
  float y = -100;
  while(y < height + 100){
    initOutline(y);
    shapeOutline();
    drawOutline();
    y += 40;
  }
  endRecord();
}
void initOutline(float y){
  outline.clear();
  for(int i = 0; i <= num + 20; i++){
    outline.add(new PVector(i * (width/num),y));
  }
  
}
void shapeOutline(){
  for(int i = 1; i < outline.size(); i++){
    float neighborY = outline.get(i-1).y;
    float thisY = outline.get(i).y;
    int sign;
    if(neighborY > thisY) sign = -1;
    else sign = 1;
    
    if(int(random(0,10))!=0) thisY = neighborY;
    else thisY = neighborY + sign;
    
    if(int(random(0,2))==0) thisY += random(-5,5);
    if(int(random(0,5))==0) thisY += random(-5,5);
    //if(int(random(0,10))==0) thisY += random(-20,20);
    
    outline.get(i).y = thisY;
  }
}
void drawOutline(){
  float[] hsb = new float[]{0,0,random(0,100)};
  for(PVector pos : outline){
    stroke(0,0,20);
    strokeWeight(5);
    line(pos.x,pos.y + 1,pos.x,height);
    
    stroke(hsb[0],hsb[1],hsb[2]);
    strokeWeight(1.5);
    line(pos.x,pos.y,pos.x,height);
    
    
  }
}
