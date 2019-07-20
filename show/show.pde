import processing.serial.*;
import java.util.*;
import java.io.*;

import peasy.PeasyCam;

//import ddf.minim.*;
//import ddf.minim.ugens.*;

//Minim       minim;
//AudioOutput out;

//Sampler sounds[];


Serial serial;
PeasyCam cam;


ArrayList<Light> lights;



void setup() {
  String portName = Serial.list()[0];
  printArray(Serial.list());
  serial = new Serial(this, portName, 9600);

  size(800, 600, P3D);
  frameRate(60);

//  minim = new Minim(this);
//  out   = minim.getLineOut();

//  sounds = new Sampler[3];

//  for (int i = 0; i < 3; i++) {
//    sounds[i] = new Sampler( "sample"+nf(i+1, 2)+".wav", 4, minim );
//    sounds[i].patch( out );
//  }

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

    if (frameCount%120 < 60) l.on(100);
    else l.off();
  }

  /*
  if (random(1) < 1.2) {
   int lightId = int(random(lights.size()));
   Light l = lights.get(lightId);
   int lightOn = int(random(2));
   l.on(lightOn);
   
   if (lightOn == 1) {
   sendSerialMessage('b', 800, lightId);
   }
   
   sounds[0].trigger();
   }
   */
}

void onLight(int lightId, int time) {
  Light l = lights.get(lightId);
  int lightOn = int(random(2));
  l.on(lightOn);

  if (lightOn == 1) {
    sendSerialMessage('b', time, lightId);
  }

  //sounds[0].trigger();
}

void initLights() {
  for (int i = 0; i < 9; i++) {
    lights.add(new Light(i, i*30, 0, 0, i*30, -100, 0));
  }
}
