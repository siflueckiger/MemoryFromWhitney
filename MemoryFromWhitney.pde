// ----- TO DO ----- //
// how many variables
// develop super formula (john whitney = 20 variables)
// make massiv GUI
// get rich



float t1, t2;



int NUM_LINES = 1;

void setup() {
  //size(400, 400);
  fullScreen();
  background(0);

  //frameRate(10);
}

void draw() {
  background(0);

  translate(width/2, height/2);

  for (int i=0; i < NUM_LINES; i++) {
    strokeWeight(4);
    stroke(0, 255, 0, 100);
    //point(x1(t1 + i), y1(t1 + i));
    //point(x2(t2 + i), y2(t2 + i));

    strokeWeight(2.5);
    stroke(0, 255, 0, 90);
    line(x1(t1 + i), y1(t1 + i), x2(t2 + i), y2(t2 + i));
  }

  t1 += 0.2;
  t2 += 0.2;
}

float x1(float t1) {
  return cos(t1 / 10) * 60 + sin(t1 /5) * 80;
}

float y1(float t1) {
  return sin(t1 / 10) * 60 + sin(t1 / 21) * 85;
}

float x2(float t2) {
  return sin(t2 / 23) * 75 + cos(t2 /5) * 35;
}

float y2(float t1) {
  return cos(t2 / 8) * 89 + sin(t2 / 21) * 60;
}
