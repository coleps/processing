int[] xs = new int[4];
int[] ys = new int[4];

float i = 0;
int c1 = 0;
int c2 = 0;

void setup(){
  size(500,500);
  background(255);
  for(int i = 0; i< 4; i++){
    xs[i] = int(random(100,400));
    ys[i] = int(random(100,400));
  }
  colorMode(HSB,360);
}

void draw(){
  quad(xs[0],ys[0],xs[1],ys[1],xs[2],ys[2],xs[3],ys[3]);
  
  fill(255,30);
  fill(c1++,c2++,360,50);
  if(c1 == 360){
    c1 = 0;
    c2 = 0;
  }
  
  int[] incr = new int[4];
  incr[0] = int(10 * sin(i));
  incr[1] = int(10 * cos(i));
  incr[2] = int(10 * cos(i)-sin(i));
  incr[3] = int(10 * cos(i) * sin(i));
  
  for(int i = 0; i<4; i++){
    incr[i] = incr[i]  + int(random(-10,10));
  }
  
  for(int i = 0; i < 4; i++){
    xs[i] = xs[i] + incr[i];
    ys[i] = ys[i] + incr[i];
  }
  
  i += 0.1;
}
