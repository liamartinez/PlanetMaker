class Earth {
  float theta; 
  float diameter; 
  float distance; 
  float orbitspeed; 
  PImage picture;
  float sizeX, sizeY; 
  float alfa = 255; 


  float time = - 0.0; 
  float increment = 0.025; 

  float z = 1; 

  Earth (float distance_, float theta_, float sizeX_, float sizeY_) {
    distance = distance_; 
    theta = theta_; 
    //theta = (theta_); 
    orbitspeed = (.006); 
    //    picture = picture_; 
    sizeX = sizeX_;
    sizeY = sizeY_; 

  }

  void orbit () {
    theta += orbitspeed; 
  }

  void display () 
  {
    pushMatrix (); 
    rotate ( (theta)); 
    translate (distance, 0, z); 
    stroke (0); 
    fill (175); 
    imageMode (CENTER); 
  image (blankearth, 0,0, 400,400); 
    //    if (sizemodifier > 15) {
    //      sizemodifier = 15; 
    //    }
    //    println ("SIZE MODIFIER " + sizemodifier); 
    //println ("theta is " + theta);
    float sizemodifier = 1;
    //    float n = (noise(time) * sizeX) + sizemodifier; 
    float n = sizeX + sizemodifier; 
    //println (n); 

    //    if (n >= 60) {
    //      n = 60; 
    //    } //else if (n <= 40) {
    //      n = 40;
    //    }

    time += increment; 
    tint (255, alfa); 
//    image (picture, 0,0, n, n);
    //    ellipse (0, 0, diameter, diameter); 

    popMatrix (); 
  }
}


