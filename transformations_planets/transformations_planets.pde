// Example 14-16: Simple solar system

// Angle of rotation around sun and planets
float theta = 0;
PImage bg;
PImage sun;
PImage planet;
PImage moon;
boolean rFlag = false;

void setup() {
  size(740, 463, P3D);
  bg = loadImage("universe.jpg");
  sun = loadImage("sun.jpg");  
  planet = loadImage("planet.jpg");
  moon = loadImage("moon.jpg");
}

void draw() {
  background(bg);  
  noStroke();
  
  
  // Translate to center of window to draw the sun.
  translate(width/2, height/2);
  
  camera(0, 0, mouseY, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
  if(rFlag){
    rotateX(mouseY/100.0);
    rotateY(mouseX/100.0);
  }
  //fill(96);
  createEllipse(100,sun);

  // The earth rotates around the sun
  pushMatrix();
  rotate(theta);
  translate(150, 0);
  //fill(0,51,102,25);
  createEllipse(50,planet);

  // Moon #1 rotates around the earth
  pushMatrix(); 
  rotate(-theta*4);
  translate(60, 0);
  //fill(192);
  createEllipse(20,moon);
  popMatrix();

  // Moon #2 also rotates around the earth
  pushMatrix();
  rotate(theta*2);
  translate(35, 0);
  //fill(192);
  createEllipse(16,moon);
  popMatrix();

  popMatrix();

  theta += 0.01;
}

void createEllipse(float s, PImage img){
  PShape sh = createShape(SPHERE, s/2);
  sh.setTexture(img);
  shape(sh);
}

void keyPressed() {
  if(key == 'r' || key == 'R')
    rFlag =!rFlag;
}