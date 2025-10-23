ArrayList<int[]> yrangesA = new ArrayList<>();
ArrayList<int[]> xrangesA = new ArrayList<>();
ArrayList<int[]> yrangesB = new ArrayList<>();
ArrayList<int[]> xrangesB = new ArrayList<>();

void setup(){
  size(640,480);
  colorMode(HSB,100,100,100);
  
  int a = 0, b = 0;
  while(b < height){
    b += int(random(20,100));
    yrangesA.add(new int[]{a,b});
    a = b;
  }
  xrangesA.add(new int[]{0,width});
  
  a = 0; b = 0;
  while(b < height){
    b += int(random(20,100));
    yrangesB.add(new int[]{a,b});
    a = b;
  }
  
  a = int(random(50,200)); b = a;
  while(b < width){
    b += int(random(50,200));
    xrangesB.add(new int[]{a,b});
    b += int(random(50,200));
    a = b;
  }
  
  //xrangesB.add(new int[]{0,50});
  //xrangesB.add(new int[]{70,200});
  //xrangesB.add(new int[]{300,400});
  
  //for(int[] yrange : yrangesA){
  //  float hue = random(0,100);
  //  //if(int(random(1,3))==1) hue = 0;
  //  fill(hue,20,random(60,70));
  //  stroke(0,0,0,0);
  //  rect(0,yrange[0],width,yrange[1]-yrange[0]);
  //  for(int i = yrange[0]; i < yrange[1]; i++){
  //    stroke(hue,random(0,50),random(50,70),95);
  //    strokeWeight(2);
  //    line(0,i,width,i);
    
  //    stroke(hue,random(0,50),random(50,70),95);
  //    strokeWeight(2);
  //    line(random(-50,width),i,random(0,width + 50),i);
  //  }
  //}
  drawLines(yrangesA,xrangesA,new int[]{0,50},new int[]{50,70});
  drawLines(yrangesB,xrangesB,new int[]{0,50},new int[]{50,70});
  
  int numWhite = int(random(1,5));
  for(int i = 0; i < numWhite; i++){
    ArrayList<int[]> yranges  = new ArrayList<>();
    ArrayList<int[]> xranges  = new ArrayList<>();
    
    yranges.add(new int[]{0,height});
    
    int start = int(random(0,width));
    int w = int(random(5,10));
    
    xranges.add(new int[]{start,start+w});
    drawLines(yranges,xranges,new int[]{0,0},new int[]{70,80});
  }
  int numBlack = int(random(7,10));
  for(int i = 0; i < numBlack; i++){
    ArrayList<int[]> yranges  = new ArrayList<>();
    ArrayList<int[]> xranges  = new ArrayList<>();
    
    yranges.add(new int[]{0,height});
    
    int start = int(random(0,width));
    int w = int(random(5,25));
    
    xranges.add(new int[]{start,start+w});
    drawLines(yranges,xranges,new int[]{0,0},new int[]{10,15});
  }
}
void drawLines(ArrayList<int[]> yranges, ArrayList<int[]> xranges, int[] s, int[] b){
  for(int[] yrange : yranges){
    float hue = random(0,100);
    fill(hue,20,random(60,70));
    stroke(0,0,0,0);
    
    //for(int[] xrange : xranges){
    //    rect(xrange[0],yrange[0],xrange[1]-xrange[0],yrange[1]-yrange[0]);
    //}
    //rect(0,yrange[0],width,yrange[1]-yrange[0]);
    
    for(int i = yrange[0]; i < yrange[1]; i++){
      stroke(hue,random(s[0],s[1]),random(b[0],b[1]));
      strokeWeight(2);
      //line(0,i,width,i);
      for(int[] xrange : xranges){
        line(xrange[0],i,xrange[1],i);
      }
    
      stroke(hue,random(s[0],s[1]),random(b[0],b[1]));
      strokeWeight(2);
      float left = random(-50,width);
      float right = random(0,width + 50);
      for(int[] xrange : xranges){
        float endpoint1, endpoint2;
      
        if(left >= xrange[0] && left <= xrange[1]){
          endpoint1 = left;
          if(right < xrange[1]) endpoint2 = right;
          else endpoint2 = xrange[1];
          
          line(endpoint1,i,endpoint2,i);
        }
      }
      
    }
  }
}
