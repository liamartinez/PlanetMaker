class Thing {
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

  Thing (float distance_, float theta_, PImage picture_, float sizeX_, float sizeY_) {
    distance = distance_; 
    theta = radians(theta_); 
    //theta = (theta_); 
    orbitspeed = (.006); 
    picture = picture_; 
    sizeX = sizeX_;
    sizeY = sizeY_;
  }

  void orbit () {
    theta += orbitspeed;
  }

  void display (float sizemodifier, float tintR, float tintG, float tintB) 
  {
    pushMatrix (); 
    rotate ( (theta)); 
    translate (distance, 0, z); 
    stroke (0); 
    fill (175); 
    imageMode (CENTER); 

    float n = sizeX + sizemodifier; 


    time += increment; 
    tint (tintR, tintG, tintB); 
    image (picture, 0, 0, n, n);
     popMatrix ();
  }


  void animate () {

    distance +=50; 
    ellipse (width/2, height/2, 50, 50);
  }

  void zoomout () {

    translate (0, 0, 10); 
    println ("Z IS " + z); 

  }

}





