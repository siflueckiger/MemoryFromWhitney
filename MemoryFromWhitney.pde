
//**** LIBRARIES ****
import oscP5.*;
import netP5.*;

//**** OBJECTS ****
Object1 o1;
Object2 o2;
Object3 o3;
Object4 o4;


//**** OSC ****
OscP5[] osc = new OscP5[5];
int[] portIn = {10101, 40101, 20101, 21101, 30101};

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
  NUM_LINES = 127;

  //create objects
  o1 = new Object1();
  o2 = new Object2();
  o3 = new Object3();
  o4 = new Object4();

  //start listening to midi controller
  //MidiBus.list();

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

void keyReleased() {
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
      o1.it2 = map(vol, 0, 1, 0.001, 0.1);
      o1.t1 += score/100;

      //object2
      o2.it1 = map(vol, 0, 1, 0.0001, 0.2);
      o2.it2 = map(vol, 0, 1, 0.001, 0.05);
      o2.t1 += score/100;
      o2.dia2 = highscore / 10;

      //object3
      o3.it1 = map(vol, 0, 1, 0.0001, 0.2);
      o3.it2 = map(vol, 0, 1, 0.001, 0.05);
      o3.t1 += score/100;


      //object4
      o4.it1 = map(vol, 0, 1, 0.0001, 0.002);
      o4.it2 = map(vol, 0, 1, 0.0005, 0.01);
      o4.t1 += score/100;
      break;

    case 2:
      /*
      //object1
       o1.it1 = 0.0001;
       o1.it2 = 0.01;
       
       //object2
       o2.it1 = 0.0001;
       o2.it2 = 0.01;
       
       //object3
       o3.it1 = 0.0001;
       o3.it2 = 0.01;
       */
      //println("game over");
      break;
    }
  }

  if (theOscMessage.addrPattern().equals("/YouFou")) {
    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    int shotFired = theOscMessage.get(2).intValue();
    int gameScreen = theOscMessage.get(3).intValue();

    switch(gameScreen) {
    case 0:
      //println("initialize");

      break;

    case 1:
      //println("playing");
      o2.xPos2 = x * width;
      o2.yPos2 = y * height;

      if (shotFired == 1) {
        screenValue = int(random(1, 4));
      }
      break;

    case 2:

      break;
    }

    //println("CamA osc received ", x, y, r);
  }

  if (theOscMessage.addrPattern().equals("/CamA")) {
    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    float r = theOscMessage.get(2).floatValue();

    //general variables
    SCALE = int(r * (height - 100));
    R_ = int(map(x, 0, 1, 0, 255));
    G_ = int(map(y, 0, 1, 0, 255));
    B_ = int(map(x+y, 0, 2, 0, 255));

    //object1
    STROKE_WEIGHT = int(map(r, 0, 1, 1, 10));

    //object2
    o2.xPos1 = map(x, 0, 1, - width/2, width/2);
    o2.yPos1 = map(y, 0, 1, - height/2, height/2);
    o2.dia1 = r * height/2;

    //println("CamA osc received ", x, y, r);
  }

  if (theOscMessage.addrPattern().equals("/TotalVolume")) {

    float totVol = theOscMessage.get(0).floatValue();
    o1.t2 += totVol / 100;
    o2.t2 += totVol / 100;
    o3.t2 += totVol / 100;
    o4.t2 += totVol / 100;

    //println("TotalVolume osc received: ", totVol);
  }

  if (theOscMessage.addrPattern().equals("/M1")) {

    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();
    //println("MIDI: ", note, noteStatus);
    
    if(noteStatus > 0){
      o4.A = random(10, 329);
      o4.B = random(2, 4312);
      o4.C = random(54, 8745);
    }
    
    BG_CLR = color(note, 0, 0);
    NUM_LINES = int(map(note, 0, 127, 10, 100));
  }

  if (theOscMessage.addrPattern().equals("/M2")) {

    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();
    
    if(noteStatus > 0){
      o4.A = random(10, 329);
      o4.B = random(2, 4312);
      o4.C = random(54, 8745);
    }

    BG_CLR = color(0, note, 0);
    NUM_LINES = int(map(note, 0, 127, 10, 100));
    //println("MIDI: ", note, noteStatus);
  }

  if (theOscMessage.addrPattern().equals("/M3")) {

    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();
    //println("MIDI: ", note, noteStatus);
    
    if(noteStatus > 0){
      o4.A = random(10, 329);
      o4.B = random(2, 4312);
      o4.C = random(54, 8745);
    }
    
    BG_CLR = color(0, note, note);
    NUM_LINES = int(map(note, 0, 127, 10, 100));
  }
}
