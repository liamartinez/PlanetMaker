class Note {
float noteX; 
float noteY; 


Note (float noteX_, float noteY_){
noteX = noteX_; 
noteY = noteY_; 
  }



  void display () {
image (note, noteX, noteY); 
  }
}


