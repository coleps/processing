ArrayList<int[]> colors = new ArrayList<>(){{
  add(new int[]{6, 17, 61});
  add(new int[]{255, 140, 50});
}};

void setup(){
  size(600,600);
  //colorMode(HSB,360,100,100);
  
  ArrayList<PVector> starts = new ArrayList<>();
  int numLines = 10;
  float x = 0;
  while(x <= width){
    starts.add(new PVector(x,0));
    x += width/numLines;
    //println(x);
  }
  
  for(PVector start : starts){
    stroke(0,0,0);
    float[] hsb = getColor(start);
    stroke(hsb[0],hsb[1],hsb[2]);
    strokeWeight(20);
    line(start.x,0,start.x,height);
  }
}

float[] getColor(PVector pos){
  float percent = pos.x/width;
  int[] diffs = new int[]{colors.get(1)[0]-colors.get(0)[0],
                          colors.get(1)[1]-colors.get(0)[1],
                          colors.get(1)[2]-colors.get(0)[2]};
  float[] hsb = new float[]{colors.get(0)[0]+(percent*diffs[0]),
                        colors.get(0)[1]+(percent*diffs[1]),
                        colors.get(0)[2]+(percent*diffs[2])};
  return hsb;
}
