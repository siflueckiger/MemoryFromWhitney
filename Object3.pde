class Object3 {
  float t1, t2;
  float it1, it2;


  Object3() {
    init();
  }


  void init() {
  }

  void show() {
    background(0);
    
    translate(width/2, height/2);

    strokeWeight(1);
    stroke(255, 0, 0);

    for (int i=0; i < 50; i++) {
      line(x1(t1+i, t2+1), y1(t1+i, t2+i), x1(t2+i, t1+1), y1(t2+i, t1+1));
    }


    t1 += 0.02;
    t2 += 0.05;
  }


  float x1(float _t1, float _t2) {
    println(sin(_t1) * 200 + 24);

    return pow(sin(_t1), 3) * 200 + pow(cos(_t2), 3) * 200 ;
  }

  float y1(float _t1, float _t2) {
    return cos(_t1) * 50 + pow(sin(_t2), 3) + 90;
  }
}
