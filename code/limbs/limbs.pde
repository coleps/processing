PImage img;
ArrayList<Limb> limbs = new ArrayList<>();
void setup(){
  size(600,600);
  img = loadImage("data/dream.jpg");
  img.resize(0,height);
  image(img,0,0);
  loadPixels();
  background(255);
  
  for(int i = 0; i < 500; i++){
    limbs.add(new Limb());
  }
  //for(Limb limb : limbs){
  //  //float x = random(width);
  //  //float y = random(height);
  //  float x = limb.pos.x;
  //  float y = limb.pos.y;
  //  for(color c : limb.colors){
  //    fill(c);
  //    rect(x,y,20,20);
  //    y+= 20;
  //  }
  //}
}
void draw(){
  for(Limb limb : limbs){
    //float x = random(width);
    //float y = random(height);
    float x = limb.pos.x;
    float y = limb.pos.y;
    for(color c : limb.colors){
      fill(c);
      rect(x,y,20,20);
      y+= 20;
    }
    //limb.pos.x += random(-2,2);
    //limb.pos.y += random(-2,2);
  }
}

class Limb{
  int numJoints = int(random(2,6));
  color[] colors;
  float jointLen = 20;
  PVector pos;
  Limb(){
    colors = new color[numJoints];
    PVector pos = new PVector(random(width),random(height));
    while(pos.y + numJoints * jointLen > height) {
      pos = new PVector(random(width),random(height));
    }
    this.pos = pos;
    for(int i = 1; i < numJoints + 1; i++){
      int loc = int(pos.x) + width * int(pos.y + jointLen * i);
      colors[i-1] = pixels[loc];
    }
  }
}
