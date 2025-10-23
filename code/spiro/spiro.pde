ArrayList<Float[]> list = new ArrayList<>();
int num = 30;
float it = 0;
float w = 600;

void setup(){
  size(600,600);
  background(255);
  frameRate(20);
  
  for(int i = 0; i < num; i++){
    for(int j = 0; j < num; j++){
      list.add(new Float[]{50 + i*(500.0/num), 50 + j*(500.0/num)});
    }
  }
}
void draw(){
  //fill(0,30);
  //background(255,0);
  float mod = 1;
  for(Float[] coords : list){
    circle(coords[0],coords[1],10);
    
    coords[0] = coords[0] + mod*cos(it) + random(-0.5,0.5);
    coords[1] = coords[1] + mod*0.5*sin(it) + random(-0.5,0.5);
    //mod+=0.01*cos(it*1.5) + 0.01*sin(it);
    mod+=0.01*cos(it*1.5) + 0.01*sin(it);
  }
  it+=0.1;
}
