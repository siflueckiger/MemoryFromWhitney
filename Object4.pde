class Object4 {
  float t1, t2;
  float it1;
  float A, B, C;


  Object4() {
    init();
  }


  void init() {
    A = 6;
    B = 9;
    C = 6;
    println("init object 4");
  }

  void show() {
    background(0);

    translate(width/2, height/2);

    strokeWeight(2);
    stroke(0, 255, 0);
    //line(x1(t1), y1(t1), x1(t1+0.05), y1(t1+0.05));
    for (int i=0; i < 20; i++) {
      //line(x1(t1+i), y1(t1+i), x1(t1+i+0.05), y1(t1+i+0.05));
     // line(x1(t1+i), y1(t1+i),x1(t1+i)+1, y1(t1+i)+1);
      line(x1(t1 + i), y1(t1 + i), x1(t2 + i), y1(t2 + i));
    }

    println("A: " + A + "B: " + B + "C: " + C);

    t1 += 0.01;
    t2 += 0.04;
  }


  float x1(float _t1) {
    return  (cos(A * _t1) + cos(B * _t1) / 2 + sin(C * _t1) / 3) * 200;
  }

  float y1(float _t1) {
    return  (sin(A * _t1) + sin(B * _t1) / 2 + cos(C * _t1) / 3) * 200;
  }
}
