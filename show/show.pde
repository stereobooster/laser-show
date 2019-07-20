import processing.serial.*;
import java.util.*;
import java.io.*;

import peasy.PeasyCam;

Serial serial;

PeasyCam cam;


ArrayList<Light> lights;


void setup() {
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
    Light l = lights.get(int(random(lights.size())));
    l.on(random(2));
  }
}

void initLights() {
  lights.add(new Light(0, 0, 0, -100, -100, 0));
  lights.add(new Light(0, 0, 0, +100, -100, 0));
  lights.add(new Light(0, 0, 0, +100, +100, 0));
  lights.add(new Light(0, 0, 0, -100, +100, 0));
  lights.add(new Light(0, 0, 0, 0, 0, 100));
}

//void sendSerial
