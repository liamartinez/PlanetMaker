//class Lightning {
//  float r;   // radius
//  color col; // color
//  float x,y; // location
//  
//  Lightning(float tempR) {
//    r = tempR;
//    col = color(50,10,10,150);
//    x = 0;
//    y = 0;
//  }
//  
//  void setLocation(float tempX, float tempY) {
//    x = tempX;
//    y = tempY;
//  }
//
//  void display() {
//    stroke(0);
//    fill(col);
//    ellipse(x,y,r*2,r*2);
//  }
//  
//  // A function that returns true or false based on
//  // if the catcher intersects a raindrop
//  boolean intersect(Thing t) {
//    // Calculate distance
//    float distance = dist(x,y,t.x,t.y); 
//    
//    // Compare distance to sum of radii
//    if (distance < r + t.r) { 
//      return true;
//    } else {
//      return false;
//    }
//  }
//}
