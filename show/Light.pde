class Light {
  PVector p1, p2; 


  float time;

  Light(float x1, float y1, float z1, float x2, float y2, float z2) {
    p1 = new PVector(x1, y1, z1);
    p2 = new PVector(x2, y2, z2);
  }

  void update() {

    time -= 1./60;
  }

  void show() {

    if (time < 0) return;

    strokeWeight(2);
    stroke(255);
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  }

  void on(float time) {
    this.time = time;
  }
}
