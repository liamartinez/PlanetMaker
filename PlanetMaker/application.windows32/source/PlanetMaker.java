import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import processing.serial.*; 
import ddf.minim.analysis.*; 
import ddf.minim.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class PlanetMaker extends PApplet {






Serial myPort;        // The serial port

float tangkad;

boolean pushed = false; 
boolean touch; 

///////VIDEO
PImage picture; 

PImage bg; 
PImage note; 
PFont f; 
PImage startover; 
PImage star; 
PImage blankearth;

float buttonX =  (width - (width/5)); 
float buttonY =  (height - (height/4)); 
float buttonsizeX = 130; 
float buttonsizeY = 80; 

float thingSizeX = 90;
float thingSizeY = 70; 
float planetsize = 325;

int planetCount = 0;

float distance; 
float zoomout; // = 25; 
float zoomoutValue; 

//Lightning lightning; 

Planet [] planets = new Planet [0];
Thing [] things = new Thing [0]; 
//Note [] notes = new Note [0];
Star [] stars = new Star [40];
PImage[] pictures = new PImage[54];
boolean[] usedthetas = new boolean[360];

Startover startbutton; 
Earth earth; 


//////AUDIO



FFT fft; 
Minim minim;



float height3;
float height23;

float waver; 
float highest; 
float highestPlace; 

AudioInput input; 

int lasthighestplace;

PImage circleImg;
PImage starImg;





//////////////////////////// SETUP/////////////////////////////////////////////////////////////


public void setup () {

  size (600, 600, OPENGL ); 
  smooth (); 

  blankearth = loadImage ("planetblank.png"); 

  // List all the available serial ports
  println(Serial.list());
  // I know that the fisrt port in the serial list on my mac
  // is usually my Arduino module, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);


  pictures[0] =  loadImage ("house.png");
  pictures[1] = loadImage ("tallhouse.png");
  pictures[2] =loadImage ("castlebig.png");
  pictures[3] = loadImage ("castletower.png");
  pictures[4] = loadImage ("castletower2.png");
  pictures[5] = loadImage ("castletower3.png");
  pictures[6] = loadImage ("brownstone.png");
  pictures[7] = loadImage ("building.png");
  pictures[8] = loadImage ("volcano.png");
  pictures[9] = loadImage ("volcano.png");
  pictures[10] =  loadImage ("pig.png");
  pictures[11] =  loadImage ("pig.png");
  pictures[12] = loadImage ("tree.png");
  pictures[13] = loadImage ("cactus.png");
  pictures[14] =  loadImage ("flower.png");
  pictures[15] =  loadImage ("flower.png");
  pictures[16] = loadImage ("rose.png");
  pictures[17] = loadImage ("rose.png");
  pictures[18] =  loadImage ("mushroom.png");
  pictures[19] = loadImage ("cherry.png");
  pictures [20] =  loadImage ("strawberry.png");
  pictures [21] =  loadImage ("strawberry.png");
  pictures[22] =loadImage ("banana.png");
  pictures[23] = loadImage ("coffee.png");
  pictures[24] = loadImage ("coffee.png");
  pictures[25] = loadImage ("converse.png");
  pictures [26] = loadImage ("converse.png");
  pictures[27] = loadImage ("sneakers.png");
  pictures[28] = loadImage ("flipflop.png");
  pictures [29] = loadImage ("streetlamp.png");
  pictures [30] = loadImage ("streetlamp.png");
  pictures[31] = loadImage ("car.png");
  pictures[32] = loadImage ("car.png");
  pictures[33] = loadImage ("snowman.png");
  pictures[34] = loadImage ("snowman.png");
  pictures[35] = loadImage ("drink.png");
  pictures[36] = loadImage ("drink.png");
  pictures[37] = loadImage ("bowling.png");
  pictures[38] = loadImage ("paperclip.png");
  pictures[39] = loadImage ("stapler.png");
  pictures[40] = loadImage ("elephant.png");
  pictures[41] = loadImage ("alarm.png");
  pictures[42] = loadImage ("hydrant.png");
  pictures[43] = loadImage ("hydrant.png");
  pictures[44] = loadImage ("bomb.png");



  //initialize STARS
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star (random (300, 900), random (30,100)); 
  }


  startbutton = new Startover(); 
  earth = new Earth(0,0,470,470); 

  bg = loadImage ("BG.png"); 
  startover = loadImage ("startover.png"); 
  note = loadImage ("note.png"); 
  star = loadImage ("star.png"); 

  f = createFont ("Serif-48.vlw", 48, true);



  ///////AUDIO
  height3 = height/3;
  height23 = 550;

  minim = new Minim(this);
  input = minim.getLineIn (); 
  fft = new FFT(input.bufferSize(), input.sampleRate());

  rectMode(CORNERS);

  /////END AUDIO
}


//////////////////////////////////////////////// VOID DRAW //////////////////////////////////////////////////

public void draw () {
  background (255); 

  pushMatrix ();  

  imageMode(CORNER);


  ///////////TRANSLATE WITH RANGEFINDER/////////////////////

  translate (width/2, height/2, zoomout); 
  imageMode(CENTER);
  noTint(); 

  earth.display (); 
  earth.orbit(); 

  for ( int i = 0; i < things.length; i++) {
    things[i].orbit (); 

    // the most recently drawn item to the stage
    if (i == things.length-1)
    {
      things[i].display(waver*10, random (200,220),random (100,220), random(100,220));

    }

    // all other items that have previously been drawn
    else
    {
      things[i].display(1, 255,255,255);   
    }
  }

  for (int i = 0; i < stars.length; i++) {
    stars[i].orbit(); 
    stars[i].display();
  }


  popMatrix (); 

  ///////////AUDIO

  fft.forward(input.mix);
  fft.window (FFT.HAMMING); 
  noStroke();
  fill(150);
  
  // draw the linear averages
  int w = PApplet.parseInt(width/fft.specSize());

  float highest = 0;
  int highestPlace = 0;

  for(int k = fft.specSize()-1; k >= 0; k--) 
  {

    float logAvgHeight = height23 - fft.getFreq(k)*10;
    tangkad = logAvgHeight/3; 

    imageMode (CENTER); 

    pushMatrix();

    float ourheight = height23 - (fft.getFreq(k)*10);
    if (ourheight > 600)
    {
      ourheight = height23-20; 
    }

    translate (k*w + w, ourheight);
    rotate(radians(-90));

    popMatrix();

    float amp =fft.getFreq(k);
    waver = (amp*2); 

    if (amp > highest){
      highest = amp;
      highestPlace = k;

    }
  }

  if (highest > 3) {  //if value of highest peak is loud enough

    println("HIGHEST PLACE: " + highestPlace);

    boolean oktoplace = false;
    int counter = 0;

    while (!oktoplace) {
      float randomlocation = random(5,350);
      oktoplace = checkLocation1(randomlocation);

      //      println (oktoplace + " -- " + highestPlace + " != " + lasthighestplace);

      if (oktoplace && highestPlace != lasthighestplace) {
        boolean oktoplace2 = checkLocation2(randomlocation);
        // store that we have dropped this item
        lasthighestplace = highestPlace;

        if (highestPlace <100) {
          highestPlace = 100; 
        } 
        else if (highestPlace >512) {
          highestPlace = 512;
        }

        //        float highestPlaceMapped = lerp (highestPlaceMapped, highestPlace, 0.5); 
        int highestPlaceMapped = PApplet.parseInt(map (highestPlace, 100, 512, 0, 44) + random(-3,3)); 
        highestPlaceMapped = constrain(highestPlaceMapped,0,44);

        //        map (highestPlace, 0,54,0,10); 
        Thing newThing = new Thing (190,  degrees (randomlocation), pictures[highestPlaceMapped],thingSizeX, thingSizeY);
        things = (Thing[]) append (things, newThing);

      }

      counter++;

      if (counter > 100) {
        oktoplace = true;
      }
    }
  }


}







/////////////////////////////////////////////////////////////////////////////////END DRAW///////



public boolean checkLocation1(float testtheta) {
  // turn our degree into an integer
  int ttheta = PApplet.parseInt(testtheta);

  // assume that we can place an item here
  boolean returnvalue = true;

  for (int i = ttheta - 4; i < ttheta+7; i++)
  {
 
    if (usedthetas[i] == true)
    {
      returnvalue = false;
    }
  }

  return returnvalue;
}




public boolean checkLocation2(float testtheta) {
  // turn our degree into an integer
  int ttheta = PApplet.parseInt(testtheta);

  // assume that we can place an item here
  boolean returnvalue = true;

  for (int i = ttheta - 4; i < ttheta+7; i++)
  {

    if (usedthetas[i] == true)
    {
      returnvalue = false;
    }
  }
  
 if (returnvalue == true)
  {
    usedthetas[ttheta] = true;
  }
  //  }

  return returnvalue;
}


public void mousePressed() {

  ////////// STARTOVER //////
  if (zoomout > 27 && !pushed){ 

    things = new Thing [0]; 
    //    notes = new Note [0]; 

    pushed = true; 
    println ("ZOOMOUT IN PUSH " + zoomout); 
    for (int i = 0; i < 360; i++) {
      usedthetas[i] = false;
    }
  } 
  else if (pushed && zoomout < 27) { 
    pushed = false; 
  } 

}



/////////////////VOID SERIAL//////////////////////

public void serialEvent (Serial myPort) {
  // get the byte:
  float inByte = myPort.read(); 
   println ("INBYTE " + inByte); 
  if (inByte < 25) {
    inByte = 25; 
  } 
  else if (inByte > 31) {
    inByte = 31;
  }
  float raw = map(inByte,25,31,-800,0);

  //  float smaller = constrain (raw, 25, 31); 
  zoomout = lerp(zoomout,raw,0.5f);

  if (inByte > 28 && !pushed){ 

    things = new Thing [0]; 
    //    notes = new Note [0]; 

    pushed = true; 
    println ("ZOOMOUT IN PUSH " + zoomout); 
    for (int i = 0; i < 360; i++) {
      usedthetas[i] = false;
    }
  } 
  else if (pushed && inByte < 28) { 
    pushed = false; 
  } 

}


//////////////////MINIM STOP/////////////////////

public void stop()
{
  // always close Minim audio classes when you are done with them
  input.close();
  // always stop Minim before exiting
  minim.stop();

  super.stop();
}








class Earth {
  float theta; 
  float diameter; 
  float distance; 
  float orbitspeed; 
  PImage picture;
  float sizeX, sizeY; 
  float alfa = 255; 


  float time = - 0.0f; 
  float increment = 0.025f; 

  float z = 1; 

  Earth (float distance_, float theta_, float sizeX_, float sizeY_) {
    distance = distance_; 
    theta = theta_; 
    orbitspeed = (.006f); 
    sizeX = sizeX_;
    sizeY = sizeY_;
  }

  public void orbit () {
    theta += orbitspeed;
  }

  public void display () 
  {
    pushMatrix (); 
    rotate ( (theta)); 
    translate (distance, 0, z); 
    stroke (0); 
    fill (175); 
    imageMode (CENTER); 
    image (blankearth, 0, 0, 400, 400); 

    float sizemodifier = 1;
    float n = sizeX + sizemodifier; 

    time += increment; 
    tint (255, alfa); 

    popMatrix ();
  }
}

class Note {
  float noteX; 
  float noteY; 

  Note (float noteX_, float noteY_) {
    noteX = noteX_; 
    noteY = noteY_;
  }

  public void display () {
    image (note, noteX, noteY);
  }
}

class Planet {
  float theta; 
  float diameter; 
  float distance; 
  float orbitspeed; 
  PImage picture;
  float sizeX, sizeY; 
  float alfa = 255; 

  float time = - 0.0f; 
  float increment = 0.025f; 

  float z = 1; 

  Planet (float distance_, float theta_, PImage picture_, float sizeX_, float sizeY_) {
    distance = distance_; 
    theta = theta_; 
    orbitspeed = (.006f); 
    picture = picture_; 
    sizeX = sizeX_;
    sizeY = sizeY_; 
  }

  public void orbit () {
    theta += orbitspeed; 
  }

public void display () 
  {
    pushMatrix (); 
    rotate ( (theta)); 
    translate (distance, 0, z); 
    stroke (0); 
    fill (175); 
    imageMode (CENTER); 
    float sizemodifier = 1;

    float n = sizeX + sizemodifier; 

    time += increment; 
    tint (255, alfa); 
    image (picture, 0,0, n, n);

    popMatrix (); 
  }
}

class Star {

  float theta; 
  float diameter; 
  float distance; 
  float orbitspeed; 

  Star (float distance_, float diameter_) {
    distance = distance_; 
    diameter = diameter_; 
    theta = random (0, 360); 
    orbitspeed = random (0.009f, 0.007f); 
  }

  public void orbit () {
    theta += orbitspeed; 
  }

  public void display () {
    pushMatrix (); 
    rotate (theta); 
    translate (distance, 0); 
    image (star, 0, 0, diameter, diameter); 

    popMatrix () ;
  }
}

class Startover {

  float xpos, ypos, xSize, ySize; 
  
Startover(){
  float xpos = 0; //width/.5;
  float ypos = 0; //height/.5;
  float xSize = 130; 
  float ySzie = 80; 
}
  

  public void display () {
    imageMode (CENTER); 
image (startover, xpos, ypos, xSize, ySize); 
  }
}


class Thing {
  float theta; 
  float diameter; 
  float distance; 
  float orbitspeed; 
  PImage picture;
  float sizeX, sizeY; 
  float alfa = 255; 
  float time = - 0.0f; 
  float increment = 0.025f; 

  float z = 1; 

  Thing (float distance_, float theta_, PImage picture_, float sizeX_, float sizeY_) {
    distance = distance_; 
    theta = radians(theta_); 
    //theta = (theta_); 
    orbitspeed = (.006f); 
    picture = picture_; 
    sizeX = sizeX_;
    sizeY = sizeY_;
  }

  public void orbit () {
    theta += orbitspeed;
  }

  public void display (float sizemodifier, float tintR, float tintG, float tintB) 
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


  public void animate () {

    distance +=50; 
    ellipse (width/2, height/2, 50, 50);
  }

  public void zoomout () {

    translate (0, 0, 10); 
    println ("Z IS " + z); 

  }

}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "PlanetMaker" });
  }
}
