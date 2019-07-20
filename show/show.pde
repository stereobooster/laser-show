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
  String portName = Serial.list()[3];
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

  float time = millis()*0.001;
  for (int i = 0; i < lights.size(); i++) {
    Light l = lights.get(i);
    l.update();
    l.show();

    //color(random(255), random(255), random(255));

    if (cos(time*(2+i*0.1)) < 0.5) l.on(100);
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
    float y = i*30-4.5*30;
    lights.add(new Light(0, y, 0, 0, y, -100, 0));
  }
}
