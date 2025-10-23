PImage mask;
PImage maskcpy;
PImage img;
float threshold = 90;

void setup(){
  size(480,640);
  mask = loadImage("data/img4.jpg");
  mask.resize(width, 0);
  mask.filter(BLUR,2);
  
  maskcpy = loadImage("data/img4.jpg");
  maskcpy.resize(width, 0);
  maskcpy.filter(GRAY);
  
  img = loadImage("data/img3.jpg");
  img.resize(width, 0);
  
  edges(mask);
  edges(mask);
  //image(mask,0,0);
  imask(img,mask);
  image(img,0,0);
  
}
void imask(PImage img, PImage mask){
  for(int i = 1; i < img.width; i++){
    for(int j = 0; j < img.height; j++){
      int loc = i + img.width * j;
      float maskB = brightness(mask.pixels[loc]);
      
      if(maskB == 0) img.pixels[loc] = maskcpy.pixels[loc];
    }
  }
  img.updatePixels();
}
void edges(PImage img){
  img.loadPixels();
  img.filter(GRAY);
  //img.filter(BLUR,2);
  for(int i = 1; i < img.width; i++){
    for(int j = 0; j < img.height; j++){
      int loc = i + img.width * j;
      float diff = abs(brightness(img.pixels[loc]) - brightness(img.pixels[loc-1]));
      
      color c;
      if(diff > threshold) c = color(0);
      else c = color(255);
      img.pixels[loc] = c;
    }
  }
  img.updatePixels();
}
