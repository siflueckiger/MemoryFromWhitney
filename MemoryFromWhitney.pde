
//---- LIBRARIES ----
import themidibus.*;


//---- OBJECTS ----
Object1 o1;
Object2 o2;

MidiBus myBus;


//---- VARIABLES ----
int NUM_LINES;
int SCALE;
int STROKE_WEIGHT;

int screenValue;
int objectValue;

float R, G, B, ALPHA_;
color CLR;


void setup() {
  size(800, 800);
  background(0);
  smooth();
  frameRate(20);
  strokeCap(SQUARE);

  //create objects
  o1 = new Object1();
  o2 = new Object2();

  //start listening to midi controller
  //MidiBus.list();
  myBus = new MidiBus(this, 0, 1);

  //start with specific object
  screenValue = 1;
  o1.init();
}


void draw() {
  //object handler (for display)
  if (screenValue == 1) {
    o1.show();
  } else if (screenValue == 2) {
    o2.show();
  }
}



void keyPressed() {
  //object handler (user input)
  if (key == '1') {
    screenValue = 1;

    o1.init();
    background(0);
  } else if (key == '2') {
    screenValue = 2;

    o2.init();
    background(0);
  } else if (key == 'r') {
    screenValue = 1;

    o1.init();
    background(0);
  } else if (keyCode == BACKSPACE) {
    background(0);
    o1.init();
    o2.init();
  } else if(keyCode == RETURN){
    background(0);
  }
}


//---- MIDI CONTROLLER ----

void controllerChange(int channel, int number, int value) {
  //println(number); 

  //for all objects
  switch(number) {
    //color
  case 21:
    R = map(value, 0, 127, 0, 255);
    break;
  case 22:
    G = map(value, 0, 127, 0, 255);
    break;
  case 23:
    B = map(value, 0, 127, 0, 255);
    break;
  case 24:
    ALPHA_ = map(value, 0, 127, 1, 80);
    break;
  }

  CLR = color(R, G, B, ALPHA_);

  //for specific objects
  if (screenValue == 1) {
    //Object1
    switch(number) {
    case 41:
      NUM_LINES = int(map(value, 0, 127, 1, 500));
      break;
    case 42:
      SCALE = int(map(value, 0, 127, 0, height - 100));
      break;
    case 43:
      STROKE_WEIGHT = int(map(value, 0, 127, 0, 10));
      break;
    case 47:
     o1.it1 = map(value, 0, 127, 0, 0.05);
      break;
    case 48:
      o1.it2 = map(value, 0, 127, 0, 0.05);
      break;
    }
  } else if (screenValue == 2) {
    //Object2
    switch(number) {
    case 25:
      o2.xPos1 = int(map(value, 0, 127, -width/2, width/2));
      break;
    case 26:
      o2.yPos1 = int(map(value, 0, 127, -height/2, height/2));
      break;
    case 45:
      o2.xPos2 = int(map(value, 0, 127, -width/2, width/2));
      break;
    case 46:
      o2.yPos2 = int(map(value, 0, 127, -height/2, height/2));
      break;
    case 41:
      NUM_LINES = int(map(value, 0, 127, 0, 500));
      break;
    case 42:
      o2.dia1 = int(map(value, 0, 127, 5, height/2));
      break;
    case 43:
      o2.dia2 = int(map(value, 0, 127, 5, height/2));
      break;
    case 44:
      STROKE_WEIGHT = int(map(value, 0, 127, 1, 20));
      break;
    case 47:
     o2.it1 = map(value, 0, 127, 0, 0.5);
      break;
    case 48:
      o2.it2 = map(value, 0, 127, 0, 0.5);
      break;
    }
  }
}
