import processing.serial.*;
import java.util.*;
import java.io.*;

import peasy.PeasyCam;

Serial serial;

PeasyCam cam;


ArrayList<Light> lights;

void setup() {
  String portName = Serial.list()[3];
  printArray(Serial.list());
  serial = new Serial(this, portName, 9600);

  size(800, 600, P3D);

  cam = new PeasyCam(this, 400);

  lights = new ArrayList<Light>();


  initLights();
}


void draw() {

  background(0);

  noFill();
  stroke(255);
  rect(-200, -200, 400, 400);

  for (int i = 0; i < lights.size(); i++) {
    Light l = lights.get(i);
    l.update();
    l.show();
  }


  if (random(1) < 0.1) {
    int lightId = int(random(lights.size()));
    Light l = lights.get(lightId);
    int lightOn = int(random(2));
    l.on(lightOn);
    if (lightOn == 1) {
      sendSerialMessage('b', 300, lightId);
    }
  }
}

void initLights() {
  lights.add(new Light(0, 0, 0, -100, -100, 0));
  lights.add(new Light(0, 0, 0, +100, -100, 0));
  lights.add(new Light(0, 0, 0, +100, +100, 0));
  lights.add(new Light(0, 0, 0, -100, +100, 0));
  lights.add(new Light(0, 0, 0, 0, 0, 100));
}

int sleepMessage = 15;
char type = 'a';
int time = 90;

void sendSerialMessage(char type, int duration, int id) {
  println(type+" "+duration+" "+id);
  serial.write(type+","+duration+","+id+";");
  delay(sleepMessage); // wait for serial
}
