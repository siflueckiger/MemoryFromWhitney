// Transcription of program columnBC
// originally prepared by Paul Rother for John Whitney for the book "Digital Harmony"
// ported to the Processing language by Jim Bumgardner

//**** LIBRARIES ****
import oscP5.*;
import netP5.*;


//**** OSC ****
OscP5[] osc = new OscP5[5];
int[] portIn = {10102,  // counter
                40102,  // sound M 1-3
                20102,  // game youFou
                21102,  // game CrappyBird
                30102}; // cam Pendel


//**** VARIABLES ****
float stepstart = 0; 
float stepend = 1/60.0;
float xleft = 38;
float ybottom = 18;
float iStep;

float radius;
float xcenter = 140;
float ycenter = 96;
float speed = 0.05;

int npoints = 360;
int ilength = 170;

<<<<<<< HEAD
int r = 0, g = 255, b = 130, alpha = 100;
=======
int alpha = 255;
>>>>>>> b7b97bc8fe153f5174e8ff2bf4d0057327dc9918
color BG_CLR = 0;

float CrappyBird = 1;
int drawStyle = 0;

float youFouX = 1;
float youFouY = 1;

PVector points[] = new PVector[npoints];

void setup() {
  fullScreen(3);
  //size(800, 800);
  background(BG_CLR);

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
<<<<<<< HEAD
  background(BG_CLR); // erase

  speed = map(mouseX, 0, width, 0.01, 0.2);
  radius = int(map(mouseY, 0, height, 50, 2000));
  //npoints = int(map(mouseX, 0, width, 3, 4000));
  //println(npoints, radius);

  float ftime = millis() * .001 * speed;
  float step = ftime * stepend + iStep; //stepstart + (ftime * (stepend - stepstart));
=======
  background(BG_CLR);

  float ftime = millis() * .001 * speed;
  float step = ftime * stepend * CrappyBird; //stepstart + (ftime * (stepend - stepstart));

>>>>>>> b7b97bc8fe153f5174e8ff2bf4d0057327dc9918

  for (int i=0; i < points.length; i++) {
    float a = 2 * PI * step * i;

    float radiusi = radius; 
    float x = xcenter + cos(a) * youFouX * (i/(float)npoints) * radiusi; //after cos(a) * 10 isch räch geil oder so ähnlech muess nid 10 si
    float y = ycenter + sin(a) * youFouY * (i/(float)npoints) * radiusi;

    points[i].set(x, height-y);
  }

  for (int i=0; i < points.length-2; i++) {
<<<<<<< HEAD
    switch(drawStyle) {
    case 0:
      //points
      fill(r, g, b);
      noStroke();
      ellipse(points[i].x, points[i].y, 2, 2);
      break;

    case 1:
      //lines
      stroke(r, g, b, 50);
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
      break;

    case 2:
      //triangles
      noStroke();
      fill(r, g, b, 5);
      triangle(points[i].x, points[i].y, points[i+1].x, points[i+1].y, points[i+2].x, points[i+2].y);//points[i+2].x, points[i+2].y);
      break;
    }
=======
    //println(alpha);
    fill(255, alpha);
    //ellipse(points[i].x, points[i].y, 2, 2);
    stroke(0, 200, 110, alpha);
    line(points[i].x, points[i].y, points[i+1].x, points[i+1].y) ;//width/2,height/2);//points[i+1].x, points[i+1].y);
    //noStroke();
    //fill(100*sin(i), 255*tan(i), 250*sin(i), 25);
    fill(0, 255, 0, alpha);
    //triangle(points[i].x, points[i].y, points[i+1].x, points[i+1].y, width/2, height/2);//points[i+2].x, points[i+2].y);
>>>>>>> b7b97bc8fe153f5174e8ff2bf4d0057327dc9918
  }
}

void keyReleased() {
  if (keyCode == UP) {
    drawStyle = int(random(0, 3));
    println(drawStyle);
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

    //println("CrappyBird osc receiving: ", vol, score, highscore, gameStatus);

    //check game gameStatus
    switch(gameStatus) {
    case 0:
      //println("initialize");
      break;

    case 1:
      //println("playing");
      //println(vol);
      CrappyBird = int(map(vol, 0, 1, 1, 5));
      iStep += score / 100;
      break;

    case 2:
      //println("game over");
      break;
    }
  }

<<<<<<< HEAD
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

      if (shotFired == 1) {
        drawStyle = int(random(0, 3));
      }
      break;

    case 2:

      break;
    }

    //println("CamA osc received ", x, y, r);
  }


=======
  //**** CAM PENDEL ****
>>>>>>> b7b97bc8fe153f5174e8ff2bf4d0057327dc9918
  if (theOscMessage.addrPattern().equals("/CamA")) {
    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    float r = theOscMessage.get(2).floatValue();

    //radius = map(r, 0, 1, 200, 300);
    xcenter = map(x, 0, 1, 0, width);
    ycenter = map(y, 0, 1, 0, height);

    r = int(map(x, 0, 1, 0, 255));
    g = int(map(y, 0, 1, 0, 255));
    b = int(map(x+y, 0, 2, 0, 255));
    
    //println("CamA osc received ", x, y, r);
  }
  
  //**** YOUFOU ****
  if (theOscMessage.addrPattern().equals("/YouFou")) {

    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    int gameStatus = theOscMessage.get(2).intValue();
    
    switch(gameStatus) {
    case 0:
      println(0, gameStatus);
      break;
    
    case 1:
      println(1, gameStatus);
      youFouX = x;
      youFouY = y;
      break;
      
    case 2:
      println(2, gameStatus);
      break;
    }
  }
  
  //**** COUNTER ****
  if (theOscMessage.addrPattern().equals("/TotalVolume")) {

    float totVol = theOscMessage.get(0).floatValue();

    //println("TotalVolume osc received: ", totVol);
  }

  //**** SOUND MODUL 1-3 ****
  if (theOscMessage.addrPattern().equals("/M1")) {
    //println(theOscMessage);
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    speed = map(note, 0, 127, 0.01, 0.6);
    BG_CLR = color(note, 0, 0);

<<<<<<< HEAD
    //BG_CLR = int(map(noteStatus, 0, 1, 0, 255));
    //println("M1 osc received: ", note, noteStatus);
=======
    //BG_COLOR = int(map(noteStatus, 0, 1, 0, 255));
    //println("M1 osc received: ", speed);
>>>>>>> b7b97bc8fe153f5174e8ff2bf4d0057327dc9918
  }

  if (theOscMessage.addrPattern().equals("/M2")) {
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    speed = map(note, 0, 127, 0.001, 0.06);
    BG_CLR = color(0, note, 0);
<<<<<<< HEAD

=======
>>>>>>> b7b97bc8fe153f5174e8ff2bf4d0057327dc9918


    //println("M2 osc received: ", speed);
  }

  if (theOscMessage.addrPattern().equals("/M3")) {
    int note = theOscMessage.get(0).intValue();
    int noteStatus = theOscMessage.get(1).intValue();

    speed = map(note, 0, 127, 0.1, 0.6);
    BG_CLR = color(0, note, note);
<<<<<<< HEAD
=======

>>>>>>> b7b97bc8fe153f5174e8ff2bf4d0057327dc9918

    //println("M osc received: ", speed);
  }
}
