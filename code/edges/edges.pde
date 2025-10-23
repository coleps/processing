PImage img;
float threshold = 90;

void setup(){
  size(600,600);
  img = loadImage("rsc/img3.jpg");
  img.resize(0, width);
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
      //img.pixels[loc] = color(diff);
    }
  }
  img.updatePixels();
  image(img,0,0);
}
