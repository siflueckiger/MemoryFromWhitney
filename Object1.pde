

class Object1 {

  float t1, t2;
  float it1, it2;


  Object1() {
    init();
  }

  void init() {
    //sets start values at the same value every time
    NUM_LINES = 6;
    SCALE = width / 3;
    STROKE_WEIGHT = 2;

    t1 = 0;
    t2 = 0;
    it1 = 0.01;
    it2 = 0.005;

    R = 250;
    G = 130;
    B = 90;
    ALPHA_ = 40;
    CLR = color(R, G, B, ALPHA_);
  }

  void show() {
    background(0);
    translate(width/2, height/2);

    for (int i=0; i < NUM_LINES; i++) {

      strokeWeight(STROKE_WEIGHT);
      stroke(CLR);
      line(x1(t1 + i), y1(t1 + i), x1(t2 + i), y1(t2 + i));
    }
    
    t1 += it1;
    t2 += it2;


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
