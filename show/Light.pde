class Light {
  PVector p1, p2; 
  int id;

  boolean on;

  float time;

  Light(int id, float x1, float y1, float z1, float x2, float y2, float z2) {
    this.id = id;
    p1 = new PVector(x1, y1, z1);
    p2 = new PVector(x2, y2, z2);
  }

  void update() {

    time -= 1000./60;
  }

  void show() {
    if (time < 0) { 
      off();
      return;
    }

    strokeWeight(2);
    stroke(255);
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  }

  void on(int time) {
    this.time = time;
    if (on) return;
    on = true;
    sendSerialMessage('b', 10000, id);
    //sendSerialMessage('a', 5, id);
  }

  void off() {
    if (!on) return; 
    on = false;
    sendSerialMessage('b', 1, id);
  }
}

void sendSerialMessage(char type, int duration, int id) {
  println(type+" "+duration+" "+id);
  serial.write(type+","+duration+","+id+";");
  delay(5); // wait for serial
}
