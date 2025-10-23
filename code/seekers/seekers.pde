import java.nio.file.Files;

PImage img;
int sampleDist = 20;
int size = 2;
int[][] dirs = {{-1, 0}, {0, -1}, {1, 0}, {0, 1}};
Seeker seeker;
ArrayList<Seeker> seekers = new ArrayList<>();
color[] pixelsCpy;
boolean animate = false;
boolean blankbg = false;
String expl = "This is cycling through images I already generated. To have the sketch animate instead, press animate.";
float[] buttonPos = new float[2];
int scale = 1;
PGraphics hires;
int numGeneratedImages = 0;
int currImg = 1;
void setup() {
  size(600, 600);
  buttonPos[0] = width/2;
  buttonPos[1] = 10;

  generatedImages();
  if(!animate) {dispGenImg(); return;}


  hires = createGraphics(
    width * scale,
    height * scale,
    JAVA2D);
  beginRecord(hires);
  hires.scale(scale);

  noStroke();

  img = loadImage("data/img.jpg");
  img.resize(width, 0);
  image(img, 0, 0);
  loadPixels();
  if (blankbg)background(255);

  pixelsCpy = new color[pixels.length];
  arrayCopy(pixels, pixelsCpy);
  for (int i = 0; i < 1000; i++) {
    seekers.add(new Seeker(random(width), random(height)));
  }
}
void dispGenImg(){
  println(currImg);
  background(255);
  img = loadImage("images/seekers"+currImg+".png");
  img.resize(0, height);
  image(img, 0, 0);
  drawButton();
  currImg++;
  if(currImg >= numGeneratedImages) currImg = 1;
}
void draw() {
  if (animate) {
    for(Seeker seeker : seekers){
      fill(seeker.c);
      rect(seeker.pos.x,seeker.pos.y,2,2);
      seeker.move();
    }
    return;
  }
  if(frameCount % 80 < 79) return;
  dispGenImg();
}
void drawButton(){
  textAlign(CENTER);
  fill(255);
  rect(buttonPos[0]-60,buttonPos[1],120,20);
  fill(0);
  textSize(20);
  text("animate",buttonPos[0],buttonPos[1]+17);
  fill(255);
  for(int x = -2; x < 3; x++){
    text(expl, 50+x,buttonPos[1]+30,500,200);
    text(expl, 50,buttonPos[1]+30+x,500,200);
}
fill(0);
  text(expl,50,buttonPos[1]+30,500,200);
}
void mousePressed(){
  if(animate) return;
  if(mouseX > buttonPos[0]-60 && mouseX < buttonPos[0]+60 
    && mouseY > buttonPos[1] && mouseY < buttonPos[1]+20){
      animate = true;
      setup();
  }
}

void keyPressed() {
  endRecord();
  hires.save("images/seekers"+(numGeneratedImages)+".png");
}
class Seeker {
  PVector pos;
  color c;
  boolean changeColor = true;
  Seeker(float x, float y) {
    pos = new PVector(x, y);
    loadPixels();
    c = pixels[loc(int(x), int(y))];
    if (int(random(5))==0) changeColor = false;
    //if (!changeColor  && int(random(3))==0) c = color(0);
    if (int(random(10))==0) c = color(random(255), random(255), random(255));
  }
  void move() {
    float[] neighborDiffs = new float[4];
    color[] neighborColors = new color[4];
    int maxNeighborIndex = 0;
    for (int i = 0; i < 4; i++) {
      int startx = int(pos.x + sampleDist*dirs[i][0]);
      int starty = int(pos.y + sampleDist*dirs[i][1]);
      if (startx < 0 || startx > width || starty < 0 || starty > height) {
        neighborDiffs[i] = -1;
        continue;
      }
      color nc = avgColor(startx, starty, 5, pixelsCpy);
      neighborColors[i] = nc;
      neighborDiffs[i] = colorDiff(c, nc);
    }
    maxNeighborIndex = getMaxIndex(neighborDiffs);
    pos.x += 5*dirs[maxNeighborIndex][0] + random(-1, 1);
    pos.y += 5*dirs[maxNeighborIndex][1] + random(-5, 5);
    //if (int(random(50))==0) pos.x += random(-50, 50);

    if (pos.x < 0 || pos.x > width || pos.y < 0|| pos.y > height) pos = new PVector(random(width), random(height));
    //if (int(random(100))==0) pos = new PVector(random(width), random(height));
    if (changeColor) {
      color moveColor = neighborColors[maxNeighborIndex];
      if (int(random(200))==0) c = color(random(255), random(255), random(255));
      c = avgColor(c, moveColor);
    }
  }
}
color avgColor(color c1, color c2) {
  float r = (red(c1) + red(c2))/2;
  float g = (green(c1) + green(c2))/2;
  float b = (blue(c1) + blue(c2))/2;
  return color(r, g, b);
}
color avgColor(int startx, int starty, int w, color[] pixels) {
  int endx = startx + w;
  int endy = starty + w;
  ArrayList<Float> reds = new ArrayList<>();
  ArrayList<Float> greens = new ArrayList<>();
  ArrayList<Float> blues = new ArrayList<>();
  loadPixels();
  while (starty < endy) {
    int loc = loc(startx, starty);
    try {
      reds.add(red(pixels[loc]));
      greens.add(green(pixels[loc]));
      blues.add(blue(pixels[loc]));
    }
    catch(Exception e) {
    }
    startx++;
    if (startx > endx) starty++;
  }
  float red = reds.stream().reduce(0.0, (a, b) -> a + b)/reds.size();
  float green = greens.stream().reduce(0.0, (a, b) -> a + b)/greens.size();
  float blue = blues.stream().reduce(0.0, (a, b) -> a + b)/blues.size();
  return color(red, green, blue);
}
float colorDiff(color c1, color c2) {
  float diff = 0;
  diff += abs(red(c1) - red(c2));
  diff += abs(green(c1) - green(c2));
  diff += abs(blue(c1) - blue(c2));
  return diff;
}
int getMaxIndex(float[] a) {
  float max = -1;
  ArrayList<Integer> maxIndex = new ArrayList<>();
  for (int i = 0; i < a.length; i++) {
    if (a[i] < 0) return i;
    if (a[i] > max) {
      max = a[i];
      maxIndex.clear();
      maxIndex.add(i);
    }
    if (a[i] == max) {
      maxIndex.add(i);
    }
  }
  return maxIndex.get(int(random(maxIndex.size())));
}
int loc(int x, int y) {
  return x + y * width;
}
void generatedImages() {
  numGeneratedImages = 1;
  while (true) {
    PImage p = loadImage("images/seekers"+numGeneratedImages+".png");
    if (p == null)break;
    numGeneratedImages++;
  }
}
