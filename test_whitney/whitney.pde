// Transcription of program columnBC
// originally prepared by Paul Rother for John Whitney for the book "Digital Harmony"
// ported to the Processing language by Jim Bumgardner

//**** LIBRARIES ****
import oscP5.*;
import netP5.*;


//**** OSC ****
OscP5[] osc = new OscP5[4];
int[] portIn = {10400, 10100, 20100, 30100};


//**** VARIABLES ****
float stepstart = 0; 
float stepend = 1/60.0;
float  xleft = 38;
float  ybottom = 18;

float  radius = 85;
float  xcenter = 140;
float  ycenter = 96;
float  speed = 0.1;

int  npoints = 360;
int ilength = 170;

int r = 0, g = 255, b = 130, alpha = 10;
color BG_COLOR = 0;


void setup() {
  fullScreen();
  //size(500, 500);
  radius = height*.9/2;
  xcenter = width/2;
  ycenter = height/2;
  noStroke();
  fill(255);

  //start oscP5, listening for incoming message at portIn
  for (int i=0; i<osc.length; i++) {
    osc[i] = new OscP5(this, portIn[i]);
  }
}

void draw() {
  background(BG_COLOR); // erase
  radius = int(map(mouseY, 0, height, 50, 850));
  npoints = int(map(mouseX, 0, width, 3, 1000));

  float ftime = millis()*.001*speed;
  float step = stepstart + (ftime * (stepend - stepstart));

  for (int i = 0; i < npoints; ++i)
  {

    float a = 2*PI * step * i;
    float b = 2*PI * step * (i+1);
    float c = 2*PI * step * (i+2);

    float radiusi =  radius; //radius*sin(a*ftime); //VERY NICE
    float x = xcenter + cos(a) * (i/(float)npoints) * radiusi; //after cos(a) * 10 isch räch geil oder so ähnlech muess nid 10 si
    float y = ycenter + sin(a) * (i/(float)npoints) * radiusi;

    float x2 = xcenter + cos(b) * (i/(float)npoints) * radiusi;
    float y2 = ycenter + sin(b) * (i/(float)npoints) * radiusi;

    float x3 = xcenter + cos(c) * (i/(float)npoints) * radiusi;
    float y3 = ycenter + sin(c) * (i/(float)npoints) * radiusi;

    ellipse(int(x), height-int(y), 4, 4);

    //stroke(255, 70);
    line(int(x), height-int(y), int(x2), height-int(y2));

    //noStroke();
    fill(r, g, b, alpha);
    triangle(int(x), height-int(y), int(x2), height-int(y2), width/2, height/2);
    triangle(int(x), height - int(y), int(x2), height-int(y2), int(x3), height-int(y3));
  }
}

void keyReleased() {
  if (keyCode == UP) {
    speed+= 0.1;
  } else if (keyCode == DOWN) {
    speed-=0.1;
  }
}

//**** OSC receiver ****
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.addrPattern().equals("/CrappyBird")) {
    float vol = theOscMessage.get(0).floatValue();
    int score = theOscMessage.get(1).intValue();
    int highscore = theOscMessage.get(2).intValue();
    int gameStatus = theOscMessage.get(3).intValue();

    //println("osc receiving: ", vol, score, highscore, gameStatus);

    //check game gameStatus
    switch(gameStatus) {
    case 0:
      //println("initialize");
      break;

    case 1:
      //println("playing");
      alpha = int(map(vol, 0, 1, 5, 100));
      break;

    case 2:
      //println("game over");
      break;
    }
  }


  if (theOscMessage.addrPattern().equals("/CamA")) {
    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    float r = theOscMessage.get(2).floatValue();

    radius = map(r, 0, 1, 60, 100);

    //println("CamA osc received ", x, y, r);
  }


  if (theOscMessage.addrPattern().equals("/TotalVolume")) {
    float totVol = theOscMessage.get(0).floatValue();

    //println("TotalVolume osc received: ", totVol);
  }


  if (theOscMessage.addrPattern().equals("/M1")) {

    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();
    r = int(map(note, 0, 127, 40, 255));
    BG_COLOR = int(map(noteStatus, 0, 1, 0, 255));
    //println("M1 osc received: ", note, noteStatus);
  }


  if (theOscMessage.addrPattern().equals("/M2")) {
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();
    b = int(map(note, 0, 127, 40, 255));
    BG_COLOR = int(map(noteStatus, 0, 1, 0, 255));

    //println("M2 osc received: ", note, noteStatus);
  }
}
