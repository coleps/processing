class Sink {
  float mass = random(100, 500);
  PVector pos = new PVector(random(-100, width + 100), random(-100, height + 100));
  float speed = 1;
  float angle = random(2*PI);
  //Sink(float x, float y){
  //  pos = new PVector(x,y);
  //}
  void move(){
    pos.x += speed * cos(angle);
    pos.y += speed * sin(angle);
    if(int(random(2))==0) angle += random(-0.5,0.5);
    if(pos.x < -100) pos.x = -100;
    if(pos.x > width + 100) pos.x = width + 100;
    if(pos.y < -100) pos.y = -100;
    if(pos.y > height + 100) pos.y = height + 100;
  }
}
