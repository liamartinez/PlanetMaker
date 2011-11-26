class Star {

  float theta; 
  float diameter; 
  float distance; 
  float orbitspeed; 

  Star (float distance_, float diameter_) {
    distance = distance_; 
    diameter = diameter_; 
    theta = random (0, 360); 
    orbitspeed = random (0.009, 0.007); 
  }

  void orbit () {
    theta += orbitspeed; 
  }

  void display () {
    pushMatrix (); 
    imageMode (CORNER); 
    rotate (theta); 
    translate (distance, 0); 
    image (star, 0, 0, diameter, diameter); 
     star.mask(starImg);
    star.updatePixels();

    popMatrix () ;
  }
}

