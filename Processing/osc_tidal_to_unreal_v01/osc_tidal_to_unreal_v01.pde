import java.util.Map;

PFont dinotRegular, dinotBold;

//HashMap<Integer, RampObject> rampObjects = new HashMap<Integer, RampObject>();

void setup() {
  size(400, 280);

  setupOsc();

  dinotBold = loadFont("DINOT-Bold-28.vlw");
  dinotRegular = loadFont("DINOT-Regular-28.vlw");
  background(81);
}

void draw() {
  background(42);
  graphicInterface();
}
