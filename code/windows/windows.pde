float holdDuration = 0;
float beaconW = 70;
ArrayList<Window> windows = new ArrayList<>();
float lightR = 0;
boolean lightOn = false;
PImage bg;
PGraphics light;
PGraphics wall;
PVector prevMouse;
PVector cent;

float windowDelay = 15000;
float delayV = 1000;

/*
a first just background. you can explore and stuff
 then a window appears. first few are ineractive so you can start to get
 into playing w the windows
 then more appear, then more and more until it's a barrage of stimuli
 */
void setup() {
  size(1000, 700);
  frameRate(30);
  cent = new PVector(width/2, height/2);
  background(0);
  colorMode(HSB, 360, 100, 100, 100);
  //for(int i = 0; i < 5; i++){
  //  windows.add(new Window());
  //}
  bg = loadImage("data/bg.jpg");
  bg.resize(width, height);
  //bg = createGraphics(width, height);
  light = createGraphics(width, height);
  wall = createGraphics(width, height);

  
  light.beginDraw();
  light.background(255);
  light.endDraw();

  thread("genWindows");
}

synchronized Window accessWindow(int i, String type) {
  switch(type) {
  case "draw":
    if(i < windows.size() && !windows.isEmpty()) windows.get(i).draw();
    break;
  case "move":
    windows.get(i).move();
    break;
  case "add":
    windows.add(new Window());
    break;
  case "get":
    if(i < windows.size() && !windows.isEmpty()) return windows.get(i);
    break;
  case "remove":
    if(i < windows.size() && !windows.isEmpty()) windows.remove(i);
    break;
  case "infect":
    windows.get(i).display = new D11();
    windows.get(i).display.window = windows.get(i);
    break;
  }
  return null;
}


void draw() {
  count++;
  if (count > numOffsets) count = 0;
  background(0);
  
  image(wall,0,0);
  wall.beginDraw();
  wall.fill(0,15);
  wall.rect(-10,-10,width+20,height+20);
  wall.endDraw();
  
  //drawBeacon();
  if (mousePressed) mousePressed();

  for(int i = 0; i < windows.size(); i++){
    accessWindow(i,"draw");
    if(!lightOn) accessWindow(i,"move");
  }
  //windows.stream().forEach(w -> {
  //  w.draw();
  //  if (!lightOn)w.move();
  //}
  //);
  if (lightOn) {
    drawLight();
    strokeWeight(0.4);
    stroke(0, 0, 100);
    noFill();
    circle(width/2, height/2, lightR*2);
  }
  //if(mousePressed) mousePressed();
}
void genWindows() {
  while (true) {
    delay(int(windowDelay));
    accessWindow(0,"add");
    //windows.add(new Window());
    if (windowDelay > 100) {
      if(windowDelay > 7000) windowDelay -= 1000;
      else {
        windowDelay -= delayV;
        if(delayV > 50)delayV /= 1.3;
      }
    }
    
  }
}
void drawBeacon() {
  float beaconW = 70;
  float w = beaconW;
  float r = 20;

  noStroke();
  fill(0, 0, 100, 60 + 90*sin(frameCount/20.0));
  if (mouseX > width/2 - beaconW/2 && mouseX < width/2 + beaconW/2 &&
    mouseY > height/2 - beaconW/2 && mouseY < height/2 + beaconW/2) fill(0, 0, 100);
  circle(width/2, height/2, r + holdDuration);

  fill(0, 0, 0);
  rect(width/2 - w - 20, 0, w/2+20, height);
  rect(0, height/2 - w - 20, width, w/2+20);
  rect(0, height/2 + w/2, width, w/2+20);
  rect(width/2 + w/2, 0, w/2+20, height);


  stroke(0, 0, 100);
  strokeWeight(5);
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, beaconW, beaconW);
  rectMode(CORNER);
}

void mousePressed() {
  prevMouse = new PVector(mouseX,mouseY);
  
  for (int i = 0; i < windows.size(); i++) {
    Window w = accessWindow(i,"get");
      PVector m = new PVector(mouseX,mouseY);
      if(PVector.dist(m,w.exit) < 20){
        accessWindow(i,"remove");
        //return;
  }
  }
  
  for (int i = 0; i < windows.size(); i++) {
    if (inWindow(i, mouseX, mouseY)) {
      selectedWindow = i;
      windowSelected = true;
    }
  }
  //if (mouseX > width/2 - beaconW/2 && mouseX < width/2 + beaconW/2 &&
  //  mouseY > height/2 - beaconW/2 && mouseY < height/2 + beaconW/2) {
  //  if (holdDuration < beaconW * 1.15) holdDuration += 1.5;
  //  else thread("light");
  //}
}
void mouseDragged() {
  
  if (windowSelected) {
    Window w = accessWindow(selectedWindow,"get");
    if(w != null) {
      w.pos = new PVector(mouseX, mouseY);
      windowSelected = false;
      return;
    }
    
  }
  wall.beginDraw();
  wall.stroke(255);
  wall.strokeWeight(3);
  wall.line(prevMouse.x,prevMouse.y,mouseX,mouseY);
  prevMouse = new PVector(mouseX,mouseY);
  wall.endDraw();
}
//void keyPressed() {
//  accessWindow(0,"add");
//  //windows.add(new Window());
//}
void light() {
  lightOn = true;
  while (lightR < width/2) {
    lightR += 5;
    delay(100);
  }
  delay(4000);
  while (lightR > 0) {
    lightR -= 5;
    delay(100);
  }
  lightR = 0;
  lightOn = false;
}
void drawLight() {
  light.loadPixels();
  arrayCopy(bg.pixels, light.pixels);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      PVector loc = new PVector(x, y);
      if (!inAWindow(x, y) || PVector.dist(loc, cent) >= lightR) {
        light.pixels[x + y*width] = color(0, 0, 0, 0);
      }
    }
  }
  light.updatePixels();
  image(light, 0, 0);
}
//void genWindows(){
//  while(true){
//    if(!lightOn) windows.add(new Window());
//    delay(int(random(3000,10000)));
//  }
//}
void mouseReleased() {
  windowSelected = false;
  if (holdDuration > 0) holdDuration = 0;
}
