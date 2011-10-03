 /**
 * scale shape edited by Kristin Harris assisted by Josh Harle
 * Scale shape

 * Temperature feed changes the scale of the image.
 */ 
import processing.serial.*;
import cc.arduino.*;
import eeml.*;
import pachuino.*;

Pachuino p;


PShape bot;
PImage img;
float averageScale1;

void setup() {
  size(640, 360);
  smooth();
  // The file "cloud.png" must be in the data folder
  // of the current sketch to load successfully
  img = loadImage("cloud.png"); // Load the original image
  
  
   p = new Pachuino(this, Arduino.list()[0], 57600);    
   p.manualUpdate("http://www.pachube.com/api/35553.xml"); // change URL -- this is the feed you want to update
   p.setKey("API KEY");    
   
   // local sensors    
   p.addLocalSensor("analog", 0,"TempSensorOutside");
   p.addLocalSensor("analog", 1,"TempSensorInside");

} 

void draw() {
  background(102);
  translate(width/2, height/2);
  
  
   
        float tempVal1 = p.localSensor[0].value;
        float tempVal2 = p.localSensor[1].value;
        //p.analogWrite(0, p.localSensor[0].value);
       // p.analogWrite(1, p.localSensor[1].value);
        println(tempVal1);
        println(tempVal2);
  
  float scaleValue = map(tempVal1, 18, 23, 0.1, 1.5);
  scaleValue =   constrain(scaleValue, 0.1, 1.5);
  averageScale1 = ((averageScale1 * 100) + scaleValue) / 101;
  scale(averageScale1);
  image(img, -img.width/2, -img.height/2); // Displays the image from point (0,0) 
  

        
  
  
}
