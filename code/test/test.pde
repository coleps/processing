PImage mask, bg, fg;
float threshold = 150;

void setup(){
  mask = loadImage("data/img.jpg");
  bg = loadImage("data/img.jpg");
  fg = loadImage("data/img2.jpg");
  size(600,600);
  mask.resize(0,height);
  bg.resize(0,height);
  for(int i = 0; i < mask.pixels.length; i++){
    if(brightness(mask.pixels[i]) > threshold) mask.pixels[i] = color(255);
    else mask.pixels[i] = color(0);
    threshold+=random(-0.1,0.1);
    if(int(random(20))==0) mask.pixels[i] = color(0);
    if(int(random(20))==0) mask.pixels[i] = color(255);
    //if(i > 1 && brightness(img.pixels[i-1]) > 0) if(int(random(2))==0)img.pixels[i] = color(255);
  }
  for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      int maskloc = i + mask.width*j;
      int fgloc = i + fg.width*j;
      if(brightness(mask.pixels[maskloc]) > 0) fg.pixels[fgloc] = bg.pixels[maskloc];
    }
  }
  //fg.mask(mask);
  image(fg,0,0);
  
}
