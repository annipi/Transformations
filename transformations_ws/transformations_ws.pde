/**
 Mannequin
 by Anni Piragauta.
 This sketch implements the following scene-graph:
 
 World
 ^
 |\
 | \
 L1 Eye
 ^
 |\
 | \
 L2  L3
*/

PGraphics canvas1, canvas2;
boolean showMiniMap = false;
boolean rotate_flag = false;
int detail = 50;

//eye params
PVector eyePosition = new PVector();
float eyeOrientation = 0;
float eyeScaling = 0.5;

//Choose FX2D, JAVA2D, P2D, P3D
String renderer = P3D;

void setup() {
  size(700, 700, renderer);
  canvas1 = createGraphics(width, height, renderer);
  canvas2 = createGraphics(width/2, height/2, renderer);
}

void draw() {
  
  //camera(mouseX, mouseY,10.0,0.0,0.0,0.0,0.0,0.2,0.0);
  canvas1.beginDraw();
  canvas1.background(50);
  // call scene off-screen rendering on canvas 1
  scene(canvas1);
  canvas1.endDraw();
  // draw canvas onto screen
  image(canvas1, 0, 0); 
  
}

float x = 0.0;
void scene(PGraphics pg) {
  //chess
  pg.translate(width/2, height/3);
  pg.scale(2,2);
  pg.fill(238, 198, 153);
  //axes(pg); 
  can(detail,pg);
  //neck
  pg.pushMatrix();
  pg.translate(0, -35);
  pg.scale(0.5,0.5);
  pg.fill(238, 198, 153);
  can(detail,pg);
  //head
  pg.pushMatrix();
  pg.translate(0, -40);
  pg.fill(238, 198, 153);
  custom_sphere(detail,pg);
  // return to chess
  pg.popMatrix();
  pg.popMatrix();
  // left shoulder
  pg.pushMatrix();
  pg.translate(-30, -20);
  pg.scale(0.1,0.1);
  pg.fill(238, 198, 153);  
  custom_sphere(detail,pg);
  // left arm
  pg.pushMatrix();
  pg.translate(-20, 200);
  pg.rotateY(-x+QUARTER_PI/2);
  pg.scale(2,8);
  pg.fill(238, 198, 153);  
  can(detail,pg); 
  // return to left shoulder
  pg.popMatrix();
  // return to chess
  pg.popMatrix();
  // right shoulder
  pg.pushMatrix();
  pg.translate(30, -20);
  pg.scale(0.1,0.1);
  pg.fill(238, 198, 153);  
  custom_sphere(detail,pg);
  // right arm
  pg.pushMatrix();
  pg.translate(20, 200);
  pg.rotateY(-x+QUARTER_PI/2);
  pg.scale(2,6);
  pg.fill(238, 198, 153);  
  can(detail,pg);
  // return to rigth shoulder
  pg.popMatrix();
  // return to chess
  pg.popMatrix();
  // hip
  pg.pushMatrix();
  pg.translate(0, 25);
  pg.scale(0.57,0.2);
  pg.fill(238, 198, 153);
  custom_sphere(detail,pg);
  // right leg
  pg.pushMatrix();
  pg.translate(-20, 150);
  pg.scale(0.5,6); 
  pg.fill(238, 198, 153);
  can(detail,pg);
  // return to hip
  pg.popMatrix();
  // right leg
  pg.pushMatrix();
  pg.translate(20, 150);
  pg.scale(0.5,6); 
  pg.fill(238, 198, 153);  
  can(detail,pg); 
  // return to L5
  pg.popMatrix();
  // return to L5
  pg.popMatrix();
  x = x+0.01;
}

void axes(PGraphics pg) {
  pg.pushStyle();
  // X-Axis
  pg.strokeWeight(4);
  pg.stroke(255, 0, 0);
  pg.fill(255, 0, 0);
  pg.line(0, 0, 100, 0, 0, 0);
  pg.text("X", 100 + 5, 0, 0);
  // Y-Axis
  pg.stroke(0, 0, 255);
  pg.fill(0, 0, 255);
  
  pg.text("Y", 0, 100 + 15, 0);
  // Z-Axis
  pg.stroke(0, 255, 0);
  pg.fill(0, 255, 0);
  pg.line(0, 0, 0, 0, 0, 100);
  pg.text("Z", 0, 0, 100 + 15);
  pg.popStyle();
}

void can(int detail, PGraphics pg) {
  pg.pushStyle();
  // X-Axis
  pg.beginShape(QUAD_STRIP);
  pg.stroke(255, 50);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    pg.normal(x, 0, z);
    pg.vertex(x * 25, -50/2, z * 25, u, 0);
    pg.vertex(x * 25, +50/2, z * 25, u, 1);    
  }
  pg.endShape(); 
  pg.popStyle();
}

void custom_sphere( int detail, PGraphics pg) {
  pg.pushStyle();
  pg.beginShape();
  pg.stroke(255, 50);
  pg.sphereDetail(detail);
  pg.sphere(50);
  pg.endShape(); 
  pg.popStyle();
}

void keyPressed() {
  if (key == 'r'){
    rotate_flag = !rotate_flag;
  }
}