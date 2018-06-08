class Object3 {
  float t1, t2;
  float it1, it2;


  Object3() {
    init();
  }


  void init() {
    it1 = 0.001;
    it2 = 0.02;
  }

  void show() {
    background(BG_CLR);

    translate(width/2, height/2);

    for (int i=0; i < NUM_LINES; i++) {
      noStroke();
      fill(R_, G_, B_, 15);
      triangle(x1(t2+i, t1+1), y1(t1+i, t2+i), x1(t1+i, t2+1), y1(t1+i, t2+i), x1(t2+i, t1+1), y1(t2+i, t1+1));
    }

    t1 += it1;
    t2 += it2;
  }


  float x1(float _t1, float _t2) {
    return pow(sin(_t1), 3) * 300 + pow(cos(_t2), 3) * 200 ;
  }

  float y1(float _t1, float _t2) {
    return cos(_t1) * 500 + pow(sin(_t2), 3) + 90;
  }
}
