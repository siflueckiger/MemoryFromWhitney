class Object2 {

  float t1, t2;
  float d1, d2;


  Object2() {
    NUM_LINES = 100;
    
    d1 = width ;
    d2 = width / 13;
  }

  void init() {
    NUM_LINES = 100;
    SCALE = 120;
    
    frameRate(5);
  }

  void show() {
    background(0);

    translate(width/2, height/2);

    for (int i=0; i < NUM_LINES; i++) {

      strokeWeight(2);
      stroke(250, 200, 234, 100 );
      line(-210 + x1(t1*i, d1), 88 - y1(t1*i, d1), x1(213+t2*i, d2), y1(t2*i, d2));
    }


    stroke(255);
    strokeWeight(2);

    //point(-210 + x1(t1, d1), 88 - y1(t1, d1));
    //2point(x1(t2, d2), y1(t2, d2));

    t1 += 0.001;
    t2 += 0.005;

    fill(0, 255, 0);
    textSize(10);
    text("Double Circle - screenValue: " + screenValue, -width/2+20, -height/2+20);
  }


  float x1(float _t1, float _d1) {
    return cos(_t1) * _d1;
  }

  float y1(float _t1, float _d1) {
    return sin(_t1) * _d1;
  }
}
