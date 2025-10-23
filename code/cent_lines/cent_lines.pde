ArrayList<PVector> anchors = new ArrayList<>();
PVector c = new PVector(200,200);
PVector c2 = new PVector(100,200);
PVector c3 = new PVector(50,200);
PVector cent = new PVector(300,300);
float theta = 0.05;
void setup(){
  frameRate(30);
  size(600,600);
  int i = 0,j = 0;
  while(i <= 600 && j <= 600){
    if(i == 0 || i == width || j == 0 || j == width)anchors.add(new PVector(i,j));
    i += 20;
    if(i > 600){
      i = 0;
      j += 20;
    }
  }
  strokeWeight(0.4);
}
void draw(){
  //background(255);
  fill(255,40);
  rect(0-10,0-10,width+20,width+20);
  for(PVector v : anchors){
    line(v.x,v.y,c.x,c.y);
    line(v.x,v.y,c2.x,c2.y);
    
    //line(v.x,v.y,c3.x,c3.y);

  }
  float beforex = c.x;
  float beforey = c.y;
  rotate(c,cent,theta);
  float afterx = c.x;
  float aftery = c.y;
  c2.x += afterx - beforex;
  c2.y += aftery - beforey;
  //circle(c2.x,c2.y,20);
  
  rotate(c2,c,theta*1.5);

}
void rotate(PVector v, PVector pivot, float theta){
  v.x -= pivot.x;
  v.y -= pivot.y;
  
  v.rotate(theta);
  
  v.x += pivot.x;
  v.y += pivot.y;
}
