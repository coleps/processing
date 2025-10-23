PImage img;
int csize = 23;
void setup(){
  size(480,640);
  background(0);
  colorMode(HSB,360,100,100);
  noStroke();
  img = loadImage("data/img.jpg");
  img.resize(width, 0);
  img.loadPixels();
  for(int i = 1; i < img.width; i+=csize){
    for(int j = 0; j < img.height; j+=csize){
      int loc = i + img.width * j; 
      for(int x = 0; x < 5; x++){
        float h = hue(img.pixels[loc]);
        h += random(-20,20);
        if(int(random(7))==0) h += random(-70,70);;
        float s = saturation(img.pixels[loc+5*x]);
        float b = brightness(img.pixels[loc+5*x]);
        b += random(-10,10);
        fill(h,s,b);
        rect(i+2.5*x,j+2.5*x,csize-5*x,csize-5*x);
      }
    }
  }
}
