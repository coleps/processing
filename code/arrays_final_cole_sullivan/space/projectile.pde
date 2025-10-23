class Projectile {
  PVector pos;
  float mass;
  float angle;
  float speed = 10;
  color c;
  float size = 10;
  int age = 0;
  boolean changeSize = true;
  Projectile(float mass, float angle, float x, float y, color c) {
    this.mass = mass;
    this.angle = angle;
    pos = new PVector(x, y);
    this.c = c;
  }
  void setSize(float size) {
    this.size = size;
  }
  void move() {
    age++;
    if (mass == 0) {
      pos.x += speed * cos(angle);
      pos.y += speed * sin(angle);
    } else {
      PVector dir = new PVector(5*cos(angle), 5*sin(angle));
      for (Sink sink : sinks) {
        //if(int(random(3))==0) continue;
        //angle += ((sink.mass * mass)/sq(PVector.dist(pos,sink.pos)*5))*
        //    (angle(sink.pos,pos) - angle);
        float a = angle(pos, sink.pos);
        //float d = 150/PVector.dist(pos,sink.pos);
        float d = (900*mass)/sq(PVector.dist(pos, sink.pos));

        PVector p = new PVector(d*cos(a), d*sin(a));
        dir = dir.add(p);
      }
      pos.x += speed * cos(atan2(dir.y, dir.x));
      pos.y += speed * sin(atan2(dir.y, dir.x));
      angle += (angle - atan2(dir.y, dir.x))*0.05;
    }
    if(!changeSize) return;
    if (size > -1) size -= 1;
    if (int(random(2))==0) size+=2;
  }
}
