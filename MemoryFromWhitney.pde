
//**** LIBRARIES ****
import themidibus.*;
import oscP5.*;
import netP5.*;

//**** OBJECTS ****
Object1 o1;
Object2 o2;
Object3 o3;
Object4 o4;

MidiBus myBus;

//**** OSC ****
OscP5[] osc = new OscP5[4];
int[] portIn = {10400, 10100, 20100, 30100};

//**** VARIABLES ****
int NUM_LINES;
int SCALE;
int STROKE_WEIGHT;

int screenValue;
int objectValue;

float R_, G_, B_, ALPHA_;
color CLR;
color BG_CLR;


void setup() {
  //size(400, 400);
  fullScreen(2);


  //frameRate(20);
  strokeCap(SQUARE);
  smooth();

  BG_CLR = color(0, 0, 10);
  background(BG_CLR);
  R_ = 360;
  G_ = 60;
  B_ = 60;
  ALPHA_ = 80;
  CLR = color(R_, G_, B_, ALPHA_);

  //create objects
  o1 = new Object1();
  o2 = new Object2();
  o3 = new Object3();
  o4 = new Object4();

  //start listening to midi controller
  //MidiBus.list();
  myBus = new MidiBus(this, 0, 1);

  //start with specific object
  screenValue = 1;
  o1.init();

  //start oscP5, listening for incoming message at portIn
  for (int i=0; i<osc.length; i++) {
    osc[i] = new OscP5(this, portIn[i]);
  }
}


void draw() {
  CLR = color(R_, G_, B_, ALPHA_);
  //object handler (for display)
  if (screenValue == 1) {
    o1.show();
  } else if (screenValue == 2) {
    o2.show();
  } else if (screenValue == 3) {
    o3.show();
  } else if (screenValue == 4) {
    o4.show();
  }
}


void keyPressed() {
  //object handler (user input)
  if (key == '1') {
    screenValue = 1;

    o1.init();
    background(BG_CLR);
  } else if (key == '2') {
    screenValue = 2;

    o2.init();
    background(BG_CLR);
  } else if (key == '3') {
    screenValue = 3;

    o3.init();
    background(BG_CLR);
  } else if (key == '4') {
    screenValue = 4;

    o4.init();
    background(BG_CLR);
  } else if (key == 'r') {
    screenValue = 1;

    o1.init();
    background(BG_CLR);
  } else if (keyCode == BACKSPACE) {
    background(BG_CLR);
    o1.init();
    o2.init();
    o3.init();
    o4.init();
  } else if (keyCode == RETURN) {
    background(BG_CLR);
  }
}


//**** MIDI CONTROLLER ****
void controllerChange(int channel, int number, int value) {
  //println(number);

  //for all objects
  switch(number) {
    //color
  case 21:
    R_ = map(value, 0, 127, 0, 360);
    break;
  case 22:
    G_ = map(value, 0, 127, 0, 100);
    break;
  case 23:
    B_ = map(value, 0, 127, 0, 100);
    break;
  case 24:
    ALPHA_ = map(value, 0, 127, 1, 80);
    break;
  }

  CLR = color(R_, G_, B_, ALPHA_);

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
  } else if (screenValue == 4) {
    //Object4
    switch(number) {
    case 41:
      o4.A = int(map(value, 0, 127, 1, 100));
      break;
    case 42:
      o4.B = int(map(value, 0, 127, 1, 100));
      break;
    case 43:
      o4.C = int(map(value, 0, 127, 1, 100));
      break;
    }
  }
}


//**** OSC receiver ****
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.addrPattern().equals("/CrappyBird")) {

    float vol = theOscMessage.get(0).floatValue();
    int score = theOscMessage.get(1).intValue();
    int highscore = theOscMessage.get(2).intValue();
    int gameStatus = theOscMessage.get(3).intValue();

    //println("CrappyBird osc receiving: ", vol, score, highscore, gameStatus);

    //check game gameStatus
    switch(gameStatus) {
    case 0:
      //println("initialize");
      break;

    case 1:
      //println("playing");

      //object1
      o1.it1 = map(vol, 0, 1, 0.0001, 0.06);
      o1.it2 = map(vol, 0, 1, 0.001, 0.01);

      //object2
      o2.it1 = map(vol, 0, 1, 0.0001, 0.2);
      o2.it2 = map(vol, 0, 1, 0.001, 0.05);

      //object3
      o3.it1 = map(vol, 0, 1, 0.0001, 0.2);
      o3.it2 = map(vol, 0, 1, 0.001, 0.05);

      //object4
      o4.it1 = map(vol, 0, 1, 0.0001, 0.002);
      o4.it2 = map(vol, 0, 1, 0.0005, 0.01);

      break;

    case 2:
      //object1
      o1.it1 = 0.0001;
      o1.it2 = 0.01;

      //object2
      o2.it1 = 0.0001;
      o2.it2 = 0.01;

      //object3
      o3.it1 = 0.0001;
      o3.it2 = 0.01;
      //println("game over");
      break;
    }
  }

  if (theOscMessage.addrPattern().equals("/CamA")) {

    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    float r = theOscMessage.get(2).floatValue();

    //general variables
    SCALE = int(x * (height - 100));

    //object2
    o2.xPos1 = map(x, 0, 1, - width/2, width/2);
    o2.yPos1 = map(y, 0, 1, - height/2, height/2);
    o2.dia1 = r * height/2;

    //println("CamA osc received ", x, y, r);
  }

  if (theOscMessage.addrPattern().equals("/TotalVolume")) {

    float totVol = theOscMessage.get(0).floatValue();

    println("TotalVolume osc received: ", totVol);
  }

  if (theOscMessage.addrPattern().equals("/M2")) {

    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    BG_CLR = color(note, 0, 0);
    println("MIDI: ", note, noteStatus);
  }

  if (theOscMessage.addrPattern().equals("/M1")) {

    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    BG_CLR = color(note, 0, 0);
  }

  if (theOscMessage.addrPattern().equals("/M2")) {

    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    BG_CLR = color(0, 0, note);
  }
}