class Object4 {
  float t1, t2;
  float it1, it2;
  float A, B, C;


  Object4() {
    init();
  }


  void init() {
    A = 15;
    B = 9;
    C = 6;
    
    it1 = 0.001;
    it2 = 0.04;
  }

  void show() {
    background(BG_CLR);

    translate(width/2, height/2);

    strokeWeight(STROKE_WEIGHT);
    stroke(R_, G_, B_);
    fill(R_, B_, G_, 20);
    beginShape();
    for(int i=0; i < NUM_LINES; i++){

      vertex(x1(t1+i), y1(t1+i));
      //println(x1(t1+i), y1(t1+i));
    }

    endShape();

    t1 += it1;
    t2 += it2;
  }


  float x1(float _t1) {
    return  (cos(A * _t1) + cos(B * _t1) / 2 + sin(C * _t1) / 3) * 200;
  }

  float y1(float _t1) {
    return  (sin(A * _t1) + sin(B * _t1) / 2 + cos(C * _t1) / 3) * 200;
  }
}
