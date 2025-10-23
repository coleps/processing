PImage img;
int numRings = 35;
float ringWidth = 10;
float ringSpacing = 12;
float theta = 0;
PVector cent;

void setup(){
  size(600,600);
  cent = new PVector(width/2,height/2);
  
  img = loadImage("data/img.jpg");
  img.resize(width,0);
  noStroke();
  
  image(img,0,0);
  if(img.width>img.height)image(img,0,img.height);
}
void draw(){
  for(int i = 0; i < img.width; i++){
    for(int j = 0; j < img.height; j++){
      PVector pos = new PVector(i,j);
      if(!inRing(pos)) continue;
      if(int(random(2))==0) continue;
      int loc = i + img.width * j;
      color c = img.pixels[loc];
      if(loc%3==0) rotate(pos,cent,theta);
      else rotate(pos,cent,-theta);
      fill(c,50);
      rect(pos.x,pos.y,1,1);
    }
  }
  theta+=0.05;
}
void rotate(PVector v, PVector pivot, float theta){
  v.x -= pivot.x;
  v.y -= pivot.y;
  v.rotate(theta);
  v.x += pivot.x;
  v.y += pivot.y;
}
boolean inRing(PVector pos){
   float d = 0;
   boolean in = false;
   float dist = PVector.dist(pos,cent);
   //println(dist);
   for(int i = 0; i < numRings; i++){
     d = (i+1)*ringSpacing;
     if(dist >= d - ringWidth*0.5 && dist <= d + ringWidth*0.5){
       in = true;
       break;
     }
   }
   return in;
}
