import java.util.Map;
//import dmxP512.*;
//import processing.serial.*;


//DmxP512 dmxOutput;
//int universeSize=128;

//boolean LANBOX=false;
//String LANBOX_IP="192.168.1.77";

//boolean DMXPRO=true;
//String DMXPRO_PORT="COM3";//case matters ! on windows port must be upper cased.
//int DMXPRO_BAUDRATE=115000;

PFont dinotRegular, dinotBold;

//IntDict DMXdevices;

//HashMap<Integer, RampObject> rampObjects = new HashMap<Integer, RampObject>();

void setup() {
  size(300, 200);

  //frameRate(30);

  setupOsc();
  
  
  // 1
  //rampObjects.put("/1/gain", new  RampObject(0, 0, 0, "/1/gain" ) );
  

  dinotBold = loadFont("DINOT-Bold-28.vlw");
  dinotRegular = loadFont("DINOT-Regular-28.vlw");
  background(81);
}

void draw() {
  //for (Map.Entry rampObject : rampObjects.entrySet()) {
  //  if (rampObjects.get( rampObject.getKey() ).moving ) {
  //    rampObjects.get( rampObject.getKey() ).send();
  //  }
  //}
  //for (Map.Entry OSC_ALive_rampObject : OSC_ALive_rampObjects.entrySet()) {
  //  if (OSC_ALive_rampObjects.get( OSC_ALive_rampObject.getKey() ).moving ) {
  //    OSC_ALive_rampObjects.get( OSC_ALive_rampObject.getKey() ).send();
  //  }
  //}


  background(81);
  graphicInterface();
}
