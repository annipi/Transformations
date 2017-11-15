int detail = 50;
float beta;
boolean rFlag = false;

//eye params
PVector eyePosition = new PVector();
float eyeOrientation = 0;
float eyeScaling = 0.5;

String renderer = P3D;

void setup() {
  size(700, 700, renderer);
}

void draw() {
  camera(mouseX, mouseY, mouseY, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
  if(rFlag){
    rotateX(mouseY/100.0);
    rotateY(mouseX/100.0);
  }

  pushStyle();
  beta = radians(frameCount);
  //chess
  //translate(width/2, height/3);
  scale(2,2);
  fill(238, 198, 153);
  //axes(pg); 
  can(detail);
  //neck
  pushMatrix();
  translate(0, -35);
  scale(0.5,0.5);
  fill(238, 198, 153);
  can(detail);
  //head
  pushMatrix();
  translate(0, -40);
  fill(238, 198, 153);
  custom_sphere(detail);
  // return to chess
  popMatrix();
  popMatrix();
  // left shoulder
  pushMatrix();
  translate(-30, -20);
  scale(0.07,0.05);
  fill(238, 198, 153);  
  custom_sphere(detail);
  // left arm
  pushMatrix();
  translate(-20, 200);
  rotateY(beta);
  scale(2,8);
  fill(238, 198, 153);  
  can(detail); 
  // return to left shoulder
  popMatrix();
  // return to chess
  popMatrix();
  // right shoulder
  pushMatrix();
  translate(30, -20);
  scale(0.1,0.1);
  fill(238, 198, 153);  
  custom_sphere(detail);
  // right arm
  pushMatrix();
  translate(20, 200);
  rotateY(beta);
  scale(2,6);
  fill(238, 198, 153);  
  can(detail);
  // return to rigth shoulder
  popMatrix();
  // return to chess
  popMatrix();
  // hip
  pushMatrix();
  translate(0, 25);
  scale(0.57,0.2);
  fill(238, 198, 153);
  custom_sphere(detail);
  // right leg
  pushMatrix();
  translate(-20, 150);
  scale(0.5,6); 
  fill(238, 198, 153);
  can(detail);
  // return to hip
  popMatrix();
  // right leg
  pushMatrix();
  translate(20, 150);
  scale(0.5,6); 
  fill(238, 198, 153);  
  can(detail); 
  // return to L5
  popMatrix();
  // return to L5
  popMatrix();
  
  popStyle();
}

void axes() {
  pushStyle();
  // X-Axis
  strokeWeight(4);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  line(0, 0, 100, 0, 0, 0);
  text("X", 100 + 5, 0, 0);
  // Y-Axis
  stroke(0, 0, 255);
  fill(0, 0, 255);
  
  text("Y", 0, 100 + 15, 0);
  // Z-Axis
  stroke(0, 255, 0);
  fill(0, 255, 0);
  line(0, 0, 0, 0, 0, 100);
  text("Z", 0, 0, 100 + 15);
  popStyle();
}

void can(int detail) {
  pushStyle();
  // X-Axis
  beginShape(QUAD_STRIP);
  stroke(255, 50);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    normal(x, 0, z);
    vertex(x * 25, -50/2, z * 25, u, 0);
    vertex(x * 25, +50/2, z * 25, u, 1);    
  }
  endShape(); 
  popStyle();
}

void custom_sphere( int detail) {
  pushStyle();
  beginShape();
  stroke(255, 50);
  sphereDetail(detail);
  sphere(50);
  endShape(); 
  popStyle();
}

void keyPressed() {
  if (key == 'r' || key == 'R')
    rFlag = !rFlag;
}