// Transcription of program columnBC
// originally prepared by Paul Rother for John Whitney for the book "Digital Harmony"
// ported to the Processing language by Jim Bumgardner

//**** LIBRARIES ****
import oscP5.*;
import netP5.*;


//**** OSC ****
OscP5[] osc = new OscP5[3];
int[] portIn = {10401, 30101, 10101};


//**** VARIABLES ****
float stepstart = 0; 
float stepend = 1/60.0;
float xleft = 38;
float ybottom = 18;

float radius;
float xcenter = 140;
float ycenter = 96;
float speed = 0.05;

int npoints = 360;
int ilength = 170;

int r = 0, g = 255, b = 130, alpha = 100;
color BG_COLOR = 0;

float CrappyBird = 1;

PVector points[] = new PVector[npoints];

void setup() {
  fullScreen(3);
  //size(800, 800);
  background(BG_COLOR);

  radius = height*.9/2;
  xcenter = width/2;
  ycenter = height/2;

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
  background(BG_COLOR); // erase

  speed = map(mouseX, 0, width, 0.01, 0.2);
  //radius = int(map(mouseY, 0, height, 50, 2000));
  //npoints = int(map(mouseX, 0, width, 3, 4000));
  //println(npoints, radius);

  float ftime = millis() * .001 * speed;
  float step = ftime * stepend; //stepstart + (ftime * (stepend - stepstart));

  println(millis() * .001 * 0.1 * stepend);
  println(millis() * .001 * 1 * stepend);

  for (int i=0; i < points.length; i++) {
    float a = 2 * PI * step * i;

    float radiusi = radius; 
    float x = xcenter + cos(a) * CrappyBird * (i/(float)npoints) * radiusi; //after cos(a) * 10 isch räch geil oder so ähnlech muess nid 10 si
    float y = ycenter + sin(a) * (i/(float)npoints) * radiusi;

    points[i].set(x, height-y);
  }

  for (int i=0; i < points.length-2; i++) {
    fill(255);
    //ellipse(points[i].x, points[i].y, 2, 2);
    stroke(0, 200, 110);
    line(points[i].x, points[i].y, points[i+1].x, points[i+1].y) ;//width/2,height/2);//points[i+1].x, points[i+1].y);
    //noStroke();
    //fill(100*sin(i), 255*tan(i), 250*sin(i), 25);
    fill(0, 255, 0, 5);
    //triangle(points[i].x, points[i].y, points[i+1].x, points[i+1].y, width/2, height/2);//points[i+2].x, points[i+2].y);
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

    //println("CrappyBird osc receiving: ", vol, score, highscore, gameStatus);

    //check game gameStatus
    switch(gameStatus) {
    case 0:
      //println("initialize");
      break;

    case 1:
      //println("playing");
      CrappyBird = int(map(vol, 0, 1, 1, 5));
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

    //radius = map(r, 0, 1, 200, 300);
    xcenter = map(x, 0, 1, 0, width);
    ycenter = map(x, 0, 1, 0, height);
    //println("CamA osc received ", x, y, r);
  }


  if (theOscMessage.addrPattern().equals("/TotalVolume")) {
    float totVol = theOscMessage.get(0).floatValue();

    //println("TotalVolume osc received: ", totVol);
  }


  if (theOscMessage.addrPattern().equals("/M1")) {
    //println(theOscMessage);
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();
    speed = map(note, 0, 127, 0.01, 0.6);
    r = int(map(note, 0, 127, 150, 255));
    g = 0;
    b = 0;

    //BG_COLOR = int(map(noteStatus, 0, 1, 0, 255));
    //println("M1 osc received: ", note, noteStatus);
  }


  if (theOscMessage.addrPattern().equals("/M2")) {
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    speed = map(note, 0, 127, 0.001, 0.06);
    r = 0;
    g = int(map(note, 0, 127, 150, 255));
    b = 0;

    //println("M2 osc received: ", note, noteStatus);
  }

  if (theOscMessage.addrPattern().equals("/M3")) {
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();
    speed = map(note, 0, 127, 0.1, 0.6);
    r = 0;
    g = int(map(note, 0, 127, 150, 255));
    b = int(map(note, 0, 127, 150, 255));

    //println("M2 osc received: ", note, noteStatus);
  }
}
