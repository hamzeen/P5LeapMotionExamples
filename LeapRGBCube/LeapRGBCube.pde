import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Hand;

LeapMotionP5 leap;
float rotX;float rotY;
PVector posSphere;

private float LEAP_WIDTH = 200.0f; // in mm
private float LEAP_HEIGHT = 500.0f; // in mm
private float LEAP_DEPTH = 200.0f; // in mm

void setup(){
  size(500,500,P3D);
  colorMode(RGB, 1);
  leap = new LeapMotionP5(this);
  noStroke();
}

float toScreenX(float x) {
    float c = width / 2.0f;
    if (x > 0.0) {
      return lerp(c, width, x / LEAP_WIDTH);
    } else {
      return lerp(c, 0.0f, -x / LEAP_WIDTH);
    }
}

float toScreenY(float y) {
  return PApplet.lerp(height, 0.0f, y / LEAP_HEIGHT);
}

void draw(){
  background(.3);
  lights();
  posSphere = new PVector(width/2,height/2,-10);

  if(leap.getHandList().size()==1){
    Hand hand = leap.getHandList().get(0);
    PVector handNorm = new PVector(hand.palmNormal().getX(), hand.palmNormal().getY(), hand.palmNormal().getZ());
    PVector handDir = new PVector(hand.direction().getX(), hand.direction().getY(), hand.direction().getZ());

    float posX = toScreenX(hand.sphereCenter().getX());
    float posY = toScreenY(hand.sphereCenter().getY());
    posSphere = new PVector(posX,posY,-10/*hand.sphereCenter().getZ()*/);
    
    /*float roll = hand.palmNormal().roll()*.09;
    rotY = (float)Math.toDegrees(roll);
    float pitch = hand.direction().pitch()*.09;
    rotX = (float)Math.toDegrees(pitch);
    float yaw = hand.direction().yaw()*.09;*/
    
    float roll = hand.palmNormal().roll()*.05;
    float pitch = hand.direction().pitch()*.05;
    float yaw = hand.direction().yaw()*.1;
    if(hand.direction().getY()<0.45){
      rotY = 2*PI-(float)Math.toDegrees(yaw);
      rotX = (float)Math.toDegrees(pitch);
    }
  }
  pushMatrix();
  translate(posSphere.x,posSphere.y,posSphere.z);
  rotateX(rotX);
  rotateY(rotY);
  scale(50);

  beginShape(QUADS);

  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);

  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);

  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);
  fill(0, 0, 0); vertex(-1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(0, 1, 1); vertex(-1,  1,  1);

  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);
  endShape();
  popMatrix();
}

void mouseDragged() {
    rotY += (mouseX - pmouseX) * 0.01;
    rotX -= (mouseY - pmouseY) * 0.01;
}

