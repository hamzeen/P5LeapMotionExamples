import codeanticode.glgraphics.*;
import saito.*;

import com.leapmotion.leap.Hand;
import com.onformative.leap.LeapMotionP5;

OBJModel model;
LeapMotionP5 leap;PVector posSphere;
private float LEAP_WIDTH = 200.0f; // in mm
private float LEAP_HEIGHT = 500.0f; // in mm
private float LEAP_DEPTH = 200.0f; // in mm

float rotX;
float rotY;

boolean bTexture = true;
boolean bStroke = false;
boolean bMaterial = false;

void setup()
{
    size(800, 800, P3D);
    model = new OBJModel(this,"Lancer.obj", "relative", POLYGON);
    leap = new LeapMotionP5(this);

    model.enableDebug();
    model.translateToCenter();
    model.scale(.7);
    noStroke();
}

void draw()
{
    background(25,85,100);
    lights();
    posSphere = new PVector(width/2,height/2,-10);

    if(leap.getHandList().size()==1){
      Hand hand = leap.getHandList().get(0);
      PVector handNorm = new PVector(hand.palmNormal().getX(), hand.palmNormal().getY(), hand.palmNormal().getZ());
      PVector handDir = new PVector(hand.direction().getX(), hand.direction().getY(), hand.direction().getZ());

      float posX = toScreenX(hand.sphereCenter().getX());
      float posY = toScreenY(hand.sphereCenter().getY());
      posSphere = new PVector(posX,posY,-10);
    
      float roll = hand.palmNormal().roll()*.05;
      float pitch = hand.direction().pitch()*.05;
      float yaw = hand.direction().yaw()*.05;

      if(hand.direction().getY()<0.45){
        rotY = (float)Math.toDegrees(yaw);
        rotX = (float)Math.toDegrees(pitch);
      }
    }

    pushMatrix();
    translate(width/2, height/2, 0);
    rotateX(rotX);
    rotateY(rotY);
    model.draw();
    popMatrix();
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
void mouseDragged() {
    rotX += (mouseX - pmouseX) * 0.01;
    rotY -= (mouseY - pmouseY) * 0.01;
}

