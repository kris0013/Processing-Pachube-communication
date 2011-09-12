import processing.serial.*;
import cc.arduino.*;
import eeml.*;
import pachuino.*;

Pachuino p;
float lastUpdate;


void setup(){    
    p = new Pachuino(this, Arduino.list()[0], 57600);    
    p.manualUpdate("http://www.pachube.com/api/35553.xml"); // change URL -- this is the feed you want to update
    p.setKey("API KEY");    
    
    // local sensors    
    p.addLocalSensor("analog", 0,"TempSensorOutside");
    p.addLocalSensor("analog", 1,"TempSensorInside");
}

void draw(){
  
    if ((millis() - lastUpdate) > 15000){
        lastUpdate = millis();
        float tempVal1 = p.localSensor[0].value;
        float tempVal2 = p.localSensor[1].value;
        p.analogWrite(0, p.localSensor[0].value);
        p.analogWrite(1, p.localSensor[1].value);
        println(tempVal1);
        println(tempVal2);
    } 
  
    
    
    //p.debug();
}



// you don't need to change any of these

void onReceiveEEML(DataIn d){  
    p.updateRemoteSensors(d); 
}

