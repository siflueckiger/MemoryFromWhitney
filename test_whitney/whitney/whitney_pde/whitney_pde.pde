// Transcription of program columnBC
// originally prepared by Paul Rother for John Whitney for the book "Digital Harmony"
// ported to the Processing language by Jim Bumgardner

//**** LIBRARIES ****
import oscP5.*;
import netP5.*;


//**** OSC ****
OscP5[] osc = new OscP5[4];
int[] portIn = {40102, // sound M 1-3
  20102, // game youFou
  21102, // game CrappyBird
  30102}; // cam Pendel


//**** VARIABLES ****
float stepstart = 0; 
float stepend = 1/60.0;
float xleft = 38;
float ybottom = 18;
float iStep;
float mspeed;
float radius;
float xcenter = 140;
float ycenter = 96;
float speed = 0.05;

int npoints = 360;
int ilength = 170;

int tempScore;

float diameter = 4;

int r = 0, g = 255, b = 130;
int alpha = 125;
color BG_CLR = 0;

float CrappyBird = 1;
int drawStyle = 0;

float youFouX = 1;
float youFouY = 1;

PVector points[] = new PVector[npoints];

void setup() {
  fullScreen(3); // if more than one screen choose screen
  //size(800, 800);
  noCursor();

  background(BG_CLR);

  radius  = height * 0.9 / 2;
  xcenter = width  / 2;
  ycenter = height / 2;

  noStroke();
  fill(255);

  for (int i=0; i < points.length; i++) {
    points[i] = new PVector(0, 0, 0);
  }

  //start oscP5, listening for incoming message at portIn
  for (int i=0; i<osc.length; i++) {
    osc[i] = new OscP5(this, portIn[i]);
  }
}

void draw() {
  background(BG_CLR); // clear background every frame

  float ftime = millis() * 0.0001 * speed;
  float step = ftime * stepstart + (ftime * (stepend - stepstart)); //stepend + iStep;
  background(BG_CLR);

  // calculate points
  for (int i=0; i < points.length; i++) {
    float a = 2 * PI * step * i;

    float radiusi = radius; 
    float x = xcenter + cos(a) * (i/(float)npoints) * radiusi; //  * youFouX; //after cos(a) * 10 isch räch geil oder so ähnlech muess nid 10 si
    float y = ycenter + sin(a) * (i/(float)npoints) * radiusi; // * youFouY;

    points[i].set(x, height-y);
  }

  // draw points/lines/triangles
  for (int i=0; i < points.length-2; i++) {
    switch(drawStyle) {
    case 0:
      //points
      fill(r, g, b, 255);//alpha);
      noStroke();
      ellipse(points[i].x, points[i].y, diameter, diameter);
      break;

    case 1:
      //lines
      int alpha1_ = int(map(alpha, 125, 5, 40, 100));
      strokeWeight(3);
      stroke(r, g, b, 100);// alpha1_);
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
      break;

    case 2:
      //triangles
      noStroke();
      fill(r, g, b, 5);
      triangle(points[i].x, points[i].y, points[i+1].x, points[i+1].y, points[i+2].x, points[i+2].y);//points[i+2].x, points[i+2].y);
      break;
    }
  }
}

void keyReleased() {
  if (keyCode == UP) {
    drawStyle = int(random(0, 3));
  }
}

//**** OSC receiver ****
void oscEvent(OscMessage theOscMessage) {

  //**** CRAPPYBIRD ****
  if (theOscMessage.addrPattern().equals("/CrappyBird")) {
    float vol = theOscMessage.get(0).floatValue();
    int score = theOscMessage.get(1).intValue();
    int highscore = theOscMessage.get(2).intValue();
    int gameStatus = theOscMessage.get(3).intValue();


    //check game gameStatus
    switch(gameStatus) {
    case 0: // init screen?
      alpha = 255;
      break;

    case 1: // when someone is playing
      CrappyBird = int(map(vol, 0, 1, 1, 5));
      diameter = map(vol, 0, 1, 1, 100);
      alpha = int(map(vol, 0, 1, 125, 5));
      break;

    case 2: // gameover?
      diameter = 4;
      alpha = 5;
      break;
    }
  }

  if (theOscMessage.addrPattern().equals("/YouFou")) {
    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    int shotFired = theOscMessage.get(2).intValue();
    int gameScreen = theOscMessage.get(3).intValue();
    int score = theOscMessage.get(4).intValue();

    switch(gameScreen) {
    case 0:

      break;

    case 1:

      if (score != tempScore) {
        if (drawStyle <= 1) {
          drawStyle++;
          tempScore = score;
        } else {
          drawStyle=0;
          tempScore = score;
        }
      }

      youFouX = map(x, 0, 1, -1, 1);
      youFouY = map(y, 0, 1, -1, 1);
      //youFouX = x * width;
      //youFouY = y * height;
      break;

    case 2:
      //youFouX = width/2;
      //youFouY = height/2;
      break;

    case 3:
      //youFouX = width/2;
      //youFouY = height/2;
      break;

    case 4:
      //youFouX = width/2;
      //youFouY = height/2;
      break;
    }
  }


  //**** CAM PENDEL ****
  if (theOscMessage.addrPattern().equals("/CamA")) {
    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    float radius = theOscMessage.get(2).floatValue();


    r = int(map(x, 0, 1, 0, 255));
    g = int(map(y, 0, 1, 0, 255));
    b = int(map(x+y, 0, 2, 0, 255));
  }
  //**** COUNTER ****
  if (theOscMessage.addrPattern().equals("/Master")) { //wert zwischen -1 und 1
    float master = theOscMessage.get(0).floatValue();

    mspeed += master;
  }
  //**** SOUND MODUL 1-3 ****
  if (theOscMessage.addrPattern().equals("/M1")) {
    //println(theOscMessage);
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    speed = map(note, 0, 127, 0.01, 0.6);
    BG_CLR = color(note, 0, 0);
  }

  if (theOscMessage.addrPattern().equals("/M2")) {
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    speed = map(note, 0, 127, 0.001, 0.06);
    BG_CLR = color(0, note, 0);
  }

  if (theOscMessage.addrPattern().equals("/M3")) {
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    speed = map(note, 0, 127, 0.1, 0.6);
    BG_CLR = color(0, note, note);
  }
}
