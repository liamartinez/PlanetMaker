
import processing.opengl.*;

import processing.serial.*;

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
import ddf.minim.analysis.*;
import ddf.minim.*;

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


void setup () {

  size (600, 600, OPENGL ); 
  smooth (); 

  //  circleImg = loadImage("planetmask.jpg");
  //  starImg = loadImage("starmask.png");
  blankearth = loadImage ("planetblank.png"); 

  // List all the available serial ports
  println(Serial.list());
  // I know that the fisrt port in the serial list on my mac
  // is usually my Arduino module, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);


  //  pictures[0] = loadImage ("pig.png");
  //  pictures[1] = loadImage ("cactus.png");
  //  pictures[2] = loadImage ("house.png");
  //  pictures[3] = loadImage ("tree.png");
  //  pictures[4] = loadImage ("mushroom.png");
  //  pictures[5] = loadImage ("banana.png");
  //  pictures[6] = loadImage ("cherry.png");
  //  pictures[7] = loadImage ("flower.png");
  //  pictures[8] = loadImage ("strawberry.png");
  //  pictures[9] = loadImage ("tallhouse.png");
  //  pictures[10] = loadImage ("volcano.png");
  //  pictures[11] = loadImage ("rose.png");
  //  pictures[12] = loadImage ("castlebig.png");
  //  pictures[13] = loadImage ("castletower.png");
  //  pictures[14] = loadImage ("castletower2.png");
  //  pictures[15] = loadImage ("castletower3.png");
  //  pictures [16] = loadImage ("coffee.png");
  //  pictures[17] = loadImage ("brownstone.png");
  //  pictures[18] = loadImage ("building.png");
  //  pictures[19] = loadImage ("converse.png");
  //  pictures[20] = loadImage ("sneakers.png");
  //  pictures[21] = loadImage ("flipflop.png");
  //  pictures [22] = loadImage ("streetlamp.png");
  //  pictures[23] = loadImage ("car.png");
  //  pictures[24] = loadImage ("snowman.png");
  //  pictures[25] = loadImage ("drink.png");
  //  pictures[26] = loadImage ("bowling.png");
  //  pictures[27] = loadImage ("paperclip.png");
  //  pictures[28] = loadImage ("stapler.png");
  //  pictures[29] = loadImage ("elephant.png");
  //  pictures[30] = loadImage ("alarm.png");
  //  pictures[31] = loadImage ("hydrant.png");
  //  pictures[32] = loadImage ("bomb.png");


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








  //  pictures[33] = loadImage ("pig.png");
  //  pictures[34] = loadImage ("cactus.png");
  //  pictures[35] = loadImage ("house.png");
  //  pictures[36] = loadImage ("tree.png");
  //  pictures[37] = loadImage ("mushroom.png");
  //  pictures [38] = loadImage ("banana.png");
  //  pictures[39] = loadImage ("cherry.png");
  //  pictures[40] = loadImage ("flower.png");
  //  pictures[41] = loadImage ("strawberry.png");
  //  pictures[42] = loadImage ("tallhouse.png");
  //  pictures[43] = loadImage ("volcano.png");
  //  pictures [44] = loadImage ("pig.png");
  //  pictures[45] = loadImage ("cactus.png");
  //  pictures[46] = loadImage ("house.png");
  //  pictures[47] = loadImage ("tree.png");
  //  pictures[48] = loadImage ("mushroom.png");
  //  pictures[49] = loadImage ("banana.png");
  //  pictures[50] = loadImage ("cherry.png");
  //  pictures[51] = loadImage ("flower.png");
  //  pictures[52] = loadImage ("strawberry.png");
  //  pictures[53] = loadImage ("tallhouse.png");





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



  // create an FFT object that has a time-domain buffer the same size as input's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  //  fftLin = new FFT(input.bufferSize(), input.sampleRate());
  //  // calculate the averages by grouping frequency bands linearly. use 30 averages.
  //  fftLin.linAverages(30);
  //  fftLog = new FFT(input.bufferSize(), input.sampleRate());
  //  // calculate averages based on a miminum octave width of 22 Hz
  //  // split each octave into three bands
  //  // this should result in 30 averages
  //  fftLog.logAverages(12, 4);
  rectMode(CORNERS);

  /////END AUDIO
}


//////////////////////////////////////////////// VOID DRAW //////////////////////////////////////////////////

void draw () {
  background (255); 

  //  image (startover, width/5, height/5, 130, 80);

 // image (bg, 0, 0, 600, 600); 

  pushMatrix ();  
  //  imageMode(CENTER);
  //image (bg, 0, 0, 1000, 1000); 
  imageMode(CORNER);
  // image (bg, 0, 0, 1000, 1000); 

  ///////////TRANSLATE WITH RANGEFINDER/////////////////////

  translate (width/2, height/2, zoomout); 
  imageMode(CENTER);
  noTint(); 
 // image (bg, 0, 0, 900, 900); 
  //  zoomout = map (mouseY, 0, 600, 25, -525); 

  //    println ("ZOOMOUT IN PUSH " + zoomout); 
  //
  //  
  //    if (zoomout > 28  && !pushed){ 
  //    
  //    things = new Thing [0]; 
  //    notes = new Note [0]; 
  //    
  //    pushed = true; 
  //    println ("ZOOMOUT IN PUSH " + zoomout); 
  //    for (int i = 0; i < 360; i++) {
  //      usedthetas[i] = false;
  //    }
  //  } else if (pushed && zoomout < 28) { 
  ////} else if (zoomout <28); 
  //    pushed = false; 
  //  } 






  //  stroke (0); 
  //  noFill(); 
  //  ellipse (0, 0, planetsize, planetsize); 


  earth.display (); 
  earth.orbit(); 




  //println ("mouse is at" + " " + mouseX + " " + mouseY); 
  for ( int i = 0; i < things.length; i++) {
    things[i].orbit (); 

    // the most recently drawn item to the stage
    if (i == things.length-1)
    {
      things[i].display(waver*10, random (200,220),random (100,220), random(100,220));


      //      println ("WAVER TO " + waver); 
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






  ////////NOTES//////////


  //  if (notes.length >= 15) {
  //    textFont (f, 30); 
  //
  //    text ("planet!", width/2 - 70, height/2);
  //
  //
  //  }


  popMatrix (); 
  //  //////LIGHTNING//////
  //
  //
  //
  //  for ( int i = 0; i < things.length; i++) {
  //    if (mouseAngle() > 0 && mouseAngle() > (things[i].theta))  {
  //      things[i].animate(); 
  //
  //    } 
  //    if 
  //      (mouseAngle() < 0 && mouseAngle() < (things[i].theta))  {
  //      things[i].animate(); 
  //    }
  //
  //
  //    println ("MOUSEANGLE IS " + mouseAngle() + " AND THETA IS " + things[i].theta); 
  //  }
  //



  ///////////AUDIO

  fft.forward(input.mix);
  fft.window (FFT.HAMMING); 
  noStroke();
  fill(150);
  //  println(fftLin.specSize());
  // draw the linear averages
  int w = int(width/fft.specSize());
  //  println(fft.specSize());

  float highest = 0;
  int highestPlace = 0;
  //  for(int k = pictures.length-1; k >= 0; k--) {
  //for(int k = fftLin.specSize()-1; k >= 0; k--) {
  //println(fft.specSize());
  for(int k = fft.specSize()-1; k >= 0; k--) 
  {
    //   for(int k = 10; k >= 0; k--) {
    // draw a rectangle for each average, multiply the value by 10 so we can see it better
    float logAvgHeight = height23 - fft.getFreq(k)*10;
    tangkad = logAvgHeight/3; 
//    rect(k*w, height23, k*w + w,logAvgHeight );
    imageMode (CENTER); 
    //    for (int i = pictures.length-1; i>=0 ; i--) {



    //pushMatrix ();   


    //translate (k*w + w, height23 - ((fft.getFreq(k)*10)));
    //rotate (radians (180)); 

    pushMatrix();

    float ourheight = height23 - (fft.getFreq(k)*10);
    if (ourheight > 600)
    {
      ourheight = height23-20; 
    }

    //println (ourheight);

    translate (k*w + w, ourheight);
    rotate(radians(-90));
    //   image ((pictures[k]), 0,0, 40,40); 
    //  image ((pictures[k]), 0,0, 30,30); 

    popMatrix();
    //    image ((pictures[k]), k*w + w, height23 - ((fft.getFreq(k)*10) + 10) , 40,40); 
    //    image ((pictures[k]), 0,0, 30,30); 

    //    popMatrix (); 
    //    }
    float amp =fft.getFreq(k);
    waver = (amp*2); 



    if (amp > highest){
      highest = amp;
      highestPlace = k;

//      println ("HIGHEST " + highest); 
    }
  }



  if (highest > 3) {  //if value of highest peak is loud enough

    println("HIGHEST PLACE: " + highestPlace);

    //println ("AMP IS " + highestPlace + " logAvgHeight IS " + tangkad); 



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
        int highestPlaceMapped = int(map (highestPlace, 100, 512, 0, 44) + random(-3,3)); 
        highestPlaceMapped = constrain(highestPlaceMapped,0,44);




        //        map (highestPlace, 0,54,0,10); 
        Thing newThing = new Thing (190,  degrees (randomlocation), pictures[highestPlaceMapped],thingSizeX, thingSizeY);
        things = (Thing[]) append (things, newThing);
        //println ("GO! " + "ARRAY NUMBER " + things.length + " IMAGE NUMBER " + highestPlaceMapped + " HIGHEST PLACE" + highestPlace);   

        //        Note newNote = new Note (random (30, 35)*notes.length, random ((height-height/13), ((height-height/13)+30)));
        //        notes = (Note[]) append (notes, newNote);


      }

      counter++;

      if (counter > 100) {
        oktoplace = true;
      }
    }
  }



  //  for ( int j = 0; j < things.length; j++) {
  //    notes[j].display ();
  //      println (things[0].theta); 

  //  }



}







/////////////////////////////////////////////////////////////////////////////////END DRAW///////






boolean checkLocation1(float testtheta) {
  // turn our degree into an integer
  int ttheta = int(testtheta);

  // assume that we can place an item here
  boolean returnvalue = true;

  // check to see if this position in our usedthetas array has been used.  in addition, check the 5 positions to the right and to the l

  //  if (ttheta > 15 && ttheta < 345)
  //  {
  for (int i = ttheta - 4; i < ttheta+7; i++)
  {
    //println (" checking " + i + " -- current equal to " + usedthetas[i]);

    if (usedthetas[i] == true)
    {
      returnvalue = false;
    }
  }
  //  }

  return returnvalue;
}




boolean checkLocation2(float testtheta) {
  // turn our degree into an integer
  int ttheta = int(testtheta);

  // assume that we can place an item here
  boolean returnvalue = true;

  // check to see if this position in our usedthetas array has been used.  in addition, check the 5 positions to the right and to the l

  //  if (ttheta > 15 && ttheta < 345)
  //  {
  for (int i = ttheta - 4; i < ttheta+7; i++)
  {
    //println (" checking " + i + " -- current equal to " + usedthetas[i]);

    if (usedthetas[i] == true)
    {
      returnvalue = false;
    }
  }

  // if we have gone through all of our positions and we have found that we can safely place an item here, mark this spot as being used
  if (returnvalue == true)
  {
    usedthetas[ttheta] = true;
  }
  //  }

  return returnvalue;
}


void mousePressed() {

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

  //////////SAVE////////////
  //  if (mouseX > width) {
  //
  //    int finalPlanetSizeX = int(planetsize) + int(thingSizeX*2);
  //    int finalPlanetsizeY = int(planetsize) + int(thingSizeY*2); 
  //    println (planetsize + thingSizeY); 
  //
  //    planetCount ++; 
  //
  //    PImage sub = get ((width/2 - ((finalPlanetSizeX)/2)), (height/2 - ((finalPlanetsizeY)/2)), finalPlanetSizeX, finalPlanetsizeY);
  //    println(sub.width + " " + sub.height);
  //    
  //    println(circleImg.width + " " + circleImg.height);
  //    sub.mask(circleImg);
  //    sub.updatePixels();
  //
  //
  //
  //
  //
  //    println ("saved!");
  //
  //
  //
  //
  //
  //
  //    float randomlocation = random(TWO_PI);
  //    Planet newPlanet = new Planet (random (400, 1200),  randomlocation, sub,random (100, 300), random (50, 200));
  //    planets = (Planet[]) append (planets, newPlanet); 
  //
  //  }  


}




/////////////////VOID SERIAL//////////////////////

void serialEvent (Serial myPort) {
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
  zoomout = lerp(zoomout,raw,0.5);

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

void stop()
{
  // always close Minim audio classes when you are done with them
  input.close();
  // always stop Minim before exiting
  minim.stop();

  super.stop();
}



















