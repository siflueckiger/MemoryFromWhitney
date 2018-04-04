Object1 o1;
Object2 o2;

int NUM_LINES;
int SCALE;

int screenValue;
int objectValue;

void setup() {
  size(800, 800);

  background(0);
  smooth();

  frameRate(20);

  o1 = new Object1();
  o2 = new Object2();
  
  screenValue = 1;
  
  o1.init();
}


void draw() {
  if (screenValue == 1) {
    o1.show();
  } else if (screenValue == 2) {
    o2.show();
  }
}



void keyPressed() {
  if (key == '1') {
    screenValue = 1;
    
    o1.init();
    background(0);
  } else if (key == '2') {
    screenValue = 2;
    
    o2.init();
    background(0);
  } else if (key == 'r') {
    screenValue = 0;
    background(0);
  }
}
