class Object1 {

  float t1, t2;
  float it1, it2;
  float A, B;


  Object1() {
    init();
  }

  void init() {
    //sets start values at the same value every time
    SCALE = width / 3;
    STROKE_WEIGHT = 2;

    t1 = 0;
    t2 = 0;
    it1 = 0.01;
    it2 = 0.005;

    ALPHA_ = 127;
    CLR = color(R_, G_, B_, ALPHA_);

    println("init object 1");

  }

  void show() {
    background(BG_CLR);
    translate(width/2, height/2);
    
    //it1 = map(mouseX,0,width,0.01,5);

    for (int i=0; i < NUM_LINES; i++) {

      strokeWeight(STROKE_WEIGHT);
      stroke(R_, G_, B_);
      line(x1(t1 + i), y1(t1 + i), x1(t2 + i), y1(t2 + i));
    }

    t1 += it1;
    t2 += it2;
  }


  float x1(float _t1) {
    return pow(cos(_t1), 3) * SCALE;
  }

  float y1(float _t1) {
    return pow(sin(_t1), 3) * SCALE;
  }
}
