
// ----- variables -----
float t1, t2;
int NUM_LINES;
int z;


// ----- ControlP5 -----
import controlP5.*;

public float A = 20;

void setup() {
  //size(800, 800);
  fullScreen();
  background(0);
  smooth();

  frameRate(15);

  //set number
  NUM_LINES = 6;
  
}

void draw() {
  //background(0);

  translate(width/2, height/2);
  
  for (int i=0; i < NUM_LINES; i++) {

    strokeWeight(2);
    stroke(250, 200, 234, 5);
    line(x1(t1 + i), y1(t1 + i), z, x1(t2 + i), y1(t2 + i), z);
  }
  

  t1 += 0.01;
  t2 += 0.005;
  

}

float x1(float t1) {
  return pow(cos(t1), 3)*200;
}

float y1(float t1) {
  return pow(sin(t1), 3)*200;
}
