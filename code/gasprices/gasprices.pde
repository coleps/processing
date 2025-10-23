Table table;
float[] prices;
float theta = -15;
ArrayList<PVector> similarStarts = new ArrayList<>();
ArrayList<Branch> branches = new ArrayList<>();
Branch root;
void setup(){
  size(700,700);
  table = loadTable("data/monthly_csv.csv", "header");

  println(table.getRowCount() + " total rows in table");

  prices = new float[table.getRowCount()];
  int i = 0;
  for (TableRow row : table.rows()) {
    if(i > prices.length - 1) break;
    float price = row.getFloat("Price");
    prices[i] = price;
    i++;
  }
  //println(prices);
  root = new Branch(null);
  //drawSimilar(root);
  drawBranch(root);
  
}
void drawBranch(Branch branch){
  //println(branch.start);
  //println(branch.len);
  float endx = branch.start.x + branch.len*cos(branch.angle); 
  float endy = branch.start.y + branch.len*sin(branch.angle); 
  
  stroke(0);
  strokeWeight(5);
  stroke(255,branch.depth - 10,0);
  line(branch.start.x,branch.start.y,endx,endy);
  
  if (branch.child != null) drawBranch(branch.child);
  
  
}
void drawSimilar(Branch branch){
  fillSimilarStarts(prices[branch.depth]);
  for(PVector p : similarStarts){
    stroke(255,branch.depth/prices.length,0);
    strokeWeight(1);
    line(branch.start.x,branch.start.y,p.x,p.y);
  }
  
  if (branch.child != null) drawSimilar(branch.child);
}
class Branch{
  PVector start;
  int depth;
  float len;
  float angle;
  
  Branch child;
  
  Branch(Branch parent){
    if(parent == null) {
      start = new PVector(width/2 - 70,height-200);
      depth = 0;
      angle = radians(-25);
    }
    else{
      float startx = parent.start.x + parent.len*cos(parent.angle);
      float starty = parent.start.y + parent.len*sin(parent.angle);
      start = new PVector(startx,starty);
      depth = parent.depth + 1;
      angle = parent.angle +radians(theta);
    }
    len = prices[depth] * 8;
    
    branches.add(this);
    
    if(depth < prices.length-1) child = new Branch(this);
  }
}
void fillSimilarStarts(float price){
  for(Branch branch : branches){
    //println(abs(price - prices[branch.depth])/price );
    if(abs(price - prices[branch.depth])/price > 5) similarStarts.add(branch.start);
    //if(price == prices[branch.depth]) similarStarts.add(branch.start);

  }
  
  //if(branch.child != null) fillSimilarStarts(price,branch.child);
}
