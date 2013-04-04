import oscP5.*;
import proxml.*;

import java.util.Arrays;

PFont font;

OscP5 osc;
int port = 31842;
Timeline timeline;
SceneManager manager;

// background color
color bg = color(70,70,70);
int padding = 50;

// hold all data from XML
ArrayList<Camera> cameras;
ArrayList<Actor> actors;
ArrayList<Light> lights;
ArrayList<Event> events;
  
// length of the scripted scene
int FPS = 30;
int NUMFRAMES = 300;
int CURRENTFRAME = 0; // start at 0

boolean isPlaying = false;
boolean isPositioningCamera = false;

// show timeline and tracks to start
boolean showTimeline = true;
boolean showTracks = true;



  //------------------------------------------------------
void setup() {
  
   font = loadFont("AbadiMT-CondensedLight-24.vlw");
 textFont(font);
  frameRate(FPS);
  
  // draw environment
  background(bg);
  size(displayWidth, displayHeight, P3D);
  smooth();
  
  //create the SceneManager
  manager = new SceneManager();
  timeline = new Timeline();
  

}

  //------------------------------------------------------
void draw() {
  background(bg);

  manager.setActiveCamera();
  
  timeline.drawTracks();
  timeline.drawPlayhead(CURRENTFRAME);

  manager.drawScene();
  
  if(isPlaying) {
    if(CURRENTFRAME < NUMFRAMES) {
      CURRENTFRAME++;
    } 
  } else {
    CURRENTFRAME = CURRENTFRAME;
    isPlaying = false;
  }

}


//**********************************************************
// dummy OSC messages
//*****************************************************

void keyPressed() {
 println("key pressed: " + keyCode);
 
 // SPACEBAR toggles playback
 if (keyCode == 32) {
  if (!isPositioningCamera) {
    // don't allow user to play the scene while positioning a camera
    isPlaying = !isPlaying; 
  }
 }
 
 //BACKSPACE reset playhead
 if (keyCode == 8) {
  isPlaying = false;
  CURRENTFRAME = 0;
 }
 
 // two hands in frame - show the timeline
  if(key== '2') {
  isPositioningCamera = false;  
  showTimeline = true;
  showTracks = true;
 }
 
 // one hand in frame - hide the timeline
  if(key== '1') {
  isPositioningCamera = true;
  showTimeline = false;
  showTracks = false;
  // and stop the movie from playing, if it's playing
  // NOTE: this might not be the effect you want.
  // you might want to view the ongoing scene while positioning a camera
  if(isPlaying) {
    isPlaying = false;
  }
 }
}
