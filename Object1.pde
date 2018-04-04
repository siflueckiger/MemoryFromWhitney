class Object1 {

  float t1, t2;


  Object1() {
    NUM_LINES = 6;
    SCALE = width / 3;
  }

  void init() {
    NUM_LINES = 6;
    SCALE = width / 3;
    t1 = 0;
    t2 = 0;
  }

  void show() {
    translate(width/2, height/2);

    for (int i=0; i < NUM_LINES; i++) {

      strokeWeight(2);
      stroke(250, 200, 234, 5);
      line(x1(t1 + i), y1(t1 + i), x1(t2 + i), y1(t2 + i));
    }

    t1 += 0.01;
    t2 += 0.005;

    fill(0, 255, 0);
    textSize(10);
    text("ASTEROID - screenValue: " + screenValue, -width/2+20, -height/2+20);
  }


  float x1(float _t1) {
    return pow(cos(_t1), 3) * SCALE;
  }

  float y1(float _t1) {
    return pow(sin(_t1), 3) * SCALE;
  }
}
