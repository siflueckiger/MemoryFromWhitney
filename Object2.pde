class Object2 {

  float t1, t2;
  float it1, it2;
  float dia1, dia2;
  float xPos1, yPos1, xPos2, yPos2;


  Object2() {
    init();
  }


  void init() {
    NUM_LINES = 100;
    SCALE = 2;
    
    R = 255;
    G = 255;
    B = 255;
    ALPHA_ = 100;
    CLR = color(R, G, B);//, ALPHA_);
    
    STROKE_WEIGHT = 2;
    
    xPos1 = 0;
    yPos1 = 0;
    dia1 = 50;

    xPos2 = 0;
    yPos2 = 0;    
    dia2 = 200;
    
    it1 = 0.2;
    it2 = 0.05;

    frameRate(20);
    
    println(xPos1, yPos1, dia1, xPos2, yPos2, dia2);
  }

  void show() {
    background(0);

    translate(width/2, height/2);
    
    for (int i=0; i < NUM_LINES; i++) {
     
     strokeWeight(STROKE_WEIGHT);
     stroke(CLR);
     line(xPos1 + x1(t1+i, dia1), yPos1 + y1(t1+i, dia1), xPos2 + x1(t2+i, dia2), yPos2 + y1(t2+i, dia2));
     }
     
    t1 -= it1;
    t2 += it2;

    fill(0, 255, 0);
    textSize(10);
    text("Double Circle - screenValue: " + screenValue, -width/2+20, -height/2+20);
  }


  float x1(float _t1, float _d1) {
    return cos(_t1)  * _d1;
  }

  float y1(float _t1, float _d1) {
    return sin(_t1) * _d1;
  }
}
