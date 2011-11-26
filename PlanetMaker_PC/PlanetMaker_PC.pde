import processing.opengl.*;

float tangkad;

boolean touch; 

///////VIDEO
PImage picture; 

PImage bg; 
PImage note; 
PFont f; 
PImage startover; 
PImage gallery; 
PImage saveme; 
PImage star; 


float buttonX =  (width - (width/5)); 
float buttonY =  (height - (height/4)); 
float buttonsizeX = 130; 
float buttonsizeY = 80; 


float thingSizeX = 90;
float thingSizeY = 90; 
int planetsize = 450;

int planetCount = 0; 

float distance; 
float zoomout = 25; 
float zoomoutValue; 

//Lightning lightning; 


Planet [] planets = new Planet [0];
Thing [] things = new Thing [0]; 
Note [] notes = new Note [0];
Star [] stars = new Star [40];
PImage[] pictures = new PImage[54];
boolean[] usedthetas = new boolean[360];

Startover startbutton; 


//////AUDIO
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;

FFT fftLin;
FFT fftLog;
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

  size (800, 500, OPENGL); 
  smooth (); 

  circleImg = loadImage("planetmask.jpg");
  starImg = loadImage("starmask.png");


  pictures[0] = loadImage ("pig.png");
  pictures[1] = loadImage ("cactus.png");
  pictures[2] = loadImage ("house.png");
  pictures[3] = loadImage ("tree.png");
  pictures[4] = loadImage ("mushroom.png");
  pictures[5] = loadImage ("banana.png");
  pictures[6] = loadImage ("cherry.png");
  pictures[7] = loadImage ("flower.png");
  pictures[8] = loadImage ("strawberry.png");
  pictures[9] = loadImage ("tallhouse.png");
  pictures[10] = loadImage ("volcano.png");
  pictures[11] = loadImage ("rose.png");
  pictures[12] = loadImage ("castlebig.png");
  pictures[13] = loadImage ("castletower.png");
  pictures[14] = loadImage ("castletower2.png");
  pictures[15] = loadImage ("castletower3.png");
  pictures [16] = loadImage ("coffee.png");
  pictures[17] = loadImage ("brownstone.png");
  pictures[18] = loadImage ("building.png");
  pictures[19] = loadImage ("converse.png");
  pictures[20] = loadImage ("sneakers.png");
  pictures[21] = loadImage ("flipflop.png");
  pictures [22] = loadImage ("streetlamp.png");
  pictures[23] = loadImage ("car.png");
  pictures[24] = loadImage ("snowman.png");
  pictures[25] = loadImage ("drink.png");
  pictures[26] = loadImage ("bowling.png");
  pictures[27] = loadImage ("paperclip.png");
  pictures[28] = loadImage ("stapler.png");
  pictures[29] = loadImage ("elephant.png");
  pictures[30] = loadImage ("alarm.png");
  pictures[31] = loadImage ("hydrant.png");
  pictures[32] = loadImage ("bomb.png");
  pictures[33] = loadImage ("pig.png");
  pictures[34] = loadImage ("cactus.png");
  pictures[35] = loadImage ("house.png");
  pictures[36] = loadImage ("tree.png");
  pictures[37] = loadImage ("mushroom.png");
  pictures [38] = loadImage ("banana.png");
  pictures[39] = loadImage ("cherry.png");
  pictures[40] = loadImage ("flower.png");
  pictures[41] = loadImage ("strawberry.png");
  pictures[42] = loadImage ("tallhouse.png");
  pictures[43] = loadImage ("volcano.png");
  pictures [44] = loadImage ("pig.png");
  pictures[45] = loadImage ("cactus.png");
  pictures[46] = loadImage ("house.png");
  pictures[47] = loadImage ("tree.png");
  pictures[48] = loadImage ("mushroom.png");
  pictures[49] = loadImage ("banana.png");
  pictures[50] = loadImage ("cherry.png");
  pictures[51] = loadImage ("flower.png");
  pictures[52] = loadImage ("strawberry.png");
  pictures[53] = loadImage ("tallhouse.png");


  //initialize STARS
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star (random (450, 1500), random (30,100)); 
  }


  //lightning = new Lightning (50); 
  startbutton = new Startover(); 

  bg = loadImage ("BG.png"); 
  startover = loadImage ("startover.png"); 
  note = loadImage ("note.png"); 
  star = loadImage ("star.png"); 
  saveme = loadImage ("save.png"); 

  f = createFont ("Serif-48.vlw", 48, true);



  ///////AUDIO
  height3 = height/3;
  height23 = 870;

  minim = new Minim(this);
  input = minim.getLineIn (); 

  fftLin = new FFT(input.bufferSize(), input.sampleRate());
  fftLin.linAverages(30);
  fftLog = new FFT(input.bufferSize(), input.sampleRate());

  fftLog.logAverages(12, 4);
  rectMode(CORNERS);

  /////END AUDIO
}


//////////////////////////////////////////////// VOID DRAW //////////////////////////////////////////////////

void draw () {


  background (255); 

  pushMatrix (); 

  if (mouseY < height/2 && mouseX > width/2) {

    zoomout = map (mouseY, 0, height/2,  0, -800); 
    zoomout = constrain(zoomout,-800,0);

  }
  
  translate (width/2, height/2, zoomout); 
  imageMode(CENTER);
  image (bg, 0, 0, 2900, 2600); 

  stroke (0); 
  noFill(); 
  ellipse (0, 0, planetsize, planetsize); 

  for ( int i = 0; i < things.length; i++) {
    things[i].orbit (); 

    // the most recently drawn item to the stage
    if (i == things.length-1)
    {
      things[i].display(waver*10);
      //      println ("WAVER TO " + waver); 
    }
    // all other items that have previously been drawn
    else
    {
      things[i].display(1);        
    }
  }


  for (int i = 0; i < stars.length; i++) {
    stars[i].orbit(); 
    stars[i].display();

  }

  for (int i = 0; i < planets.length; i++) {
    planets[i].orbit(); 
    planets[i].display();
  }



  popMatrix (); 


  ///////////AUDIO////// DRAW FFT///////

  fftLog.forward(input.mix);
  noStroke();
  fill(150);
  //  println(fftLin.specSize());
  // draw the linear averages
  int w = int(width/fftLog.avgSize());
  //  println(fftLog.avgSize());

  float highest = 0;
  int highestPlace = 0;

  for(int k = fftLog.avgSize()-1; k >= 0; k--) 
  {
    // draw a rectangle for each average, multiply the value by 10 so we can see it better
    float logAvgHeight = height23 - fftLog.getAvg(k)*10;
    tangkad = logAvgHeight; 
    rect(k*w, height23, k*w + w,logAvgHeight );
    imageMode (CENTER); 

    pushMatrix();

    float ourheight = height23 - (fftLog.getAvg(k)*10);
    if (ourheight > 600)
    {
      ourheight = height23-20; 
    }

    //println (ourheight);

    translate (k*w + w, ourheight);
    rotate(radians(-90));
    image ((pictures[k]), 0,0, 40,40); 
    image ((pictures[k]), 0,0, 30,30); 

    popMatrix();

    float amp =fftLog.getAvg(k);
    waver = amp; 


    // println ("LOG AVG " + fftLog.getAvg(k)); 
    if (amp > highest){
      highest = amp;
      highestPlace = k;
    }
  }


  if (highest > 10) {  //if value of highest peak is loud enough

    boolean oktoplace = false;
    int counter = 0;

    while (!oktoplace) {
      float randomlocation = random(5,350);
      oktoplace = checkLocation1(randomlocation);

     if (oktoplace && highestPlace != lasthighestplace) {
        boolean oktoplace2 = checkLocation2(randomlocation);
        // store that we have dropped this item
        lasthighestplace = highestPlace;

        //        map (highestPlace, 0,54,0,10); 
        Thing newThing = new Thing (246,  degrees (randomlocation), pictures[highestPlace],thingSizeX, thingSizeY);
        things = (Thing[]) append (things, newThing);
        println ("GO! " + "ARRAY NUMBER " + things.length + " IMAGE NUMBER " + highestPlace + " AMP IS " + highest);   

        Note newNote = new Note (random (30, 35)*notes.length, random ((height-height/13), ((height-height/13)+30)));
        notes = (Note[]) append (notes, newNote);

      }

      counter++;

      if (counter > 100) {
        oktoplace = true;
      }
    }
  }


  startbutton.display (); 
  imageMode (CORNER); 
  image (startover, (width - (width/5)), (height - (height/4)), buttonsizeX, buttonsizeY); 
  image (saveme, (width - (width/5) + (buttonsizeX + 5)), (height - (height/4)), buttonsizeX, buttonsizeY); 

}







/////////////////////////////////////////////////////////////////////////////////END DRAW///////


void lightningTouch () {
  for ( int i = 0; i < things.length; i++) {

    if (mouseAngle() < width/2) {
      touch =  true; 
    } 
    else {
      touch = false;
    }
  }
}




float mouseAngle () {

  float angol = degrees (atan2 (mouseY - height/2, mouseX - width/2));  //this is the angle. but then you need to translate the matrix in order to get the same values. 

  pushMatrix (); 
  translate (180, 0); 
  rotate (angol); 

  popMatrix (); 
  return angol; 

}


boolean checkLocation1(float testtheta) {
  // turn our degree into an integer
  int ttheta = int(testtheta);

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




boolean checkLocation2(float testtheta) {
  // turn our degree into an integer
  int ttheta = int(testtheta);

  // assume that we can place an item here
  boolean returnvalue = true;

  for (int i = ttheta; i < ttheta+5; i++)
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

  return returnvalue;
}


void mousePressed() {

  ////////// STARTOVER //////
  if (mouseX > (width - width/5) && mouseX < ((width - width/5) + buttonsizeX) && mouseY > (height - height/4) && mouseY < (height - height/4)+buttonsizeY) {
    things = new Thing [0]; 
    notes = new Note [0]; 
    for (int i = 0; i < 360; i++) {
      usedthetas[i] = false;
    }
  }

  //////////SAVE////////////
  if (mouseX > (width - width/5) + ((buttonsizeX) + 5) && mouseX < ((width - width/5)+(buttonsizeX*2)) && mouseY > (height - height/4) && mouseY < (height - height/4)+buttonsizeY) {

    int finalPlanetSizeX = int(planetsize) + int(thingSizeX*2);
    int finalPlanetsizeY = int(planetsize) + int(thingSizeY*2); 
    println (planetsize + thingSizeY); 

    planetCount ++; 

    PImage sub = get ((width/2 - ((finalPlanetSizeX)/2)), (height/2 - ((finalPlanetsizeY)/2)), finalPlanetSizeX, finalPlanetsizeY);
    println(sub.width + " " + sub.height);
    println(circleImg.width + " " + circleImg.height);
    sub.mask(circleImg);
    sub.updatePixels();

    println ("saved!");

    float randomlocation = random(TWO_PI);
    Planet newPlanet = new Planet (random (400, 1200),  randomlocation, sub,random (100, 300), random (50, 200));
    planets = (Planet[]) append (planets, newPlanet); 

  }  

}


void keyPressed () {

  for ( int i = 0; i < things.length; i++) {
    things[i].zoomout (); 

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



















