boolean boundingCube = false;
boolean rFlag = false;
boolean rotationFlag = false;
boolean esquiFlag = false;
boolean translationFlag = false;
boolean scalFlag = false;
float beta;
int axis_lenght = 250;
ArrayList<PVector> vertices;
float rx1 = 00;
float ry1 = 0;
float rz1 = 0;
float rx2 = 75;
float ry2 = 75;
float rz2 = 75;
PShape shape;
void setup() {
  size(600, 600, P3D);
  //frameRate(1000);
}

void draw() {
  pushStyle();
  int strokeWeight = 2;
  color lineColor = color(192);
  color faceColor = color(192, 192, 192, 100);
  
  strokeWeight(strokeWeight);
  stroke(lineColor);
  fill(faceColor);
  background(0);
  lights();
  translate(width/2, height/2, 0);
  
  camera(0, 0, mouseY, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
  if(rFlag){
    rotateX(mouseY/100.0);
    rotateY(mouseX/100.0);
  }
  
  // mesh draw method
  vertices = new ArrayList<PVector>();
  PShape s = loadShape("wolf.obj");
  
  int children = s.getChildCount();
  for (int i = 0; i < children; i++) {
    PShape child = s.getChild(i);
    int total = child.getVertexCount();
    for(int j=0; j< total;j++){
      vertices.add(child.getVertex(j));
    }
  }    
  shape = createShape();
  shape.beginShape(TRIANGLES);
  for(PVector v : vertices) 
    shape.vertex(v.x, v.y ,v.z);
  shape.endShape();
  
  drawAxes();
  
  //points to define custom axis
  stroke(255,0,255);
  strokeWeight(10);
  point(rx1,ry1,rz1); //p1
  point(rx2,ry2,rz2); //p2
  
  //custom axis 
  stroke(255);  
  strokeWeight(2);
  line(rx1,ry1,rz1,rx2,ry2,rz2);
  
  float av = (rx2-rx1);
  float bv = (ry2-ry1);
  float cv = (rz2-rz1);
  PVector v = new PVector(av,bv,cv);
  PVector u = v.normalize();
  float a = u.x;
  float b = u.y;
  float c = u.z;
  
  if(rotationFlag)
    rotateR(v, a, b, c);
  if(esquiFlag)
    esquiR(a, b, c);
  if(translationFlag)
    translaR( rx2, ry2, rz2);
  if(scalFlag)
    scalR(a,b,c,3);
  
  shape.disableStyle();
  shape(shape,0,-100);
  
  
  // visual hint
  if (boundingCube) {
    pushStyle();
    stroke(255);
    fill(255, 0, 255, 50);
    box(350);
    popStyle();
  }
}

void scalR(float a, float b, float c, float s){
  pushStyle(); 
  applyMatrix(a*s,   0,   0,   0,
              0,   b*s,   0,   0, 
              0,   0,   c*s,   0, 
              0,    0,  0,   1); 
  popStyle();
}

void esquiR(float a, float b, float c){
  pushStyle(); 
  applyMatrix(1,     a*b,   a*c,   0,
              b*a,   1,     b*c,   0, 
              c*a,   c*b,   1,     0, 
              0,     0,     0,     1); 
  popStyle();
}

void translaR(float a, float b, float c){
  pushStyle(); 
  applyMatrix(1,   0,   0,   a,
              0,   1,   0,   b, 
              0,   0,   1,   c, 
              0,    0,  0,   1); 
  popStyle();
}

void rotateR(PVector v, float a, float b, float c){
  pushStyle();
  beta = radians(frameCount);  
  translate(v.x,v.y);
  
  // T(x1,y1,z1)*Rx(−α)*Ry(−λ)*Rz(β)*Ry(λ)*Rx(α)*T(−x1,−y1,−z1)
  applyMatrix(a*a*(1-cos(beta))+cos(beta), b*a*(1-cos(beta))-c*sin(beta), c*a*(1-cos(beta))+b*sin(beta), 0,
              a*b*(1-cos(beta))+c*sin(beta), b*b*(1-cos(beta))+cos(beta), c*b*(1-cos(beta))-a*sin(beta), 0, 
              a*c*(1-cos(beta))-b*sin(beta), b*c*(1-cos(beta))+a*sin(beta), c*c*(1-cos(beta))+cos(beta), 0, 
              0, 0, 0, 1);
 
  popStyle();
} 

void drawAxes() {
  pushStyle();
  stroke(255, 0, 0);
  strokeWeight(3);
  fill(255, 0, 0);
  line(0, 0, 0, axis_lenght, 0, 0);
  text("+X", axis_lenght +10, 0, 0);
  
  stroke(0, 0, 255);
  fill(0, 0, 255);
  line(0, 0, 0, 0, axis_lenght, 0);
  text("+Y", 0, axis_lenght+10, 0);
  
  stroke(0, 255, 0);
  fill(0, 255, 0);
  line(0, 0, 0, 0, 0, -axis_lenght);
  text("-Z", 0, 0, -axis_lenght-10);
  popStyle();
}

void keyPressed() {
  if (key == 'b' || key == 'B')
    boundingCube= !boundingCube;
  if(key == 'r' || key == 'R')
    rFlag =!rFlag;
  if(key == '1'){
    rotationFlag =!rotationFlag;
  }
  if(key == '2'){
    esquiFlag =!esquiFlag;
  }
  if(key == '3'){
    translationFlag =!translationFlag;
  }
  if(key == '4'){
    scalFlag = !scalFlag;
  }
}