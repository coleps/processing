void setup(){
  size(600,600);
  colorMode(HSB,100,100,100);
  int[] yrange = new int[]{50,300};
  fill(40,20,random(60,70));
  rect(0,yrange[0],width,yrange[1]-yrange[0]);
  for(int i = yrange[0]; i < yrange[1]; i++){
    stroke(40,40,random(50,70),95);
    strokeWeight(2);
    line(0,i,width,i);
    
    stroke(40,40,random(50,70),95);
    strokeWeight(2);
    line(random(width),i,random(width),i);
  }
}
