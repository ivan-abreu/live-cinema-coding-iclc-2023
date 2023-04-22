class RampObject {
  int framesTransition = 30;
  int frameStart, frameEnd;
  float start, end;
  String OSCaddress;
  boolean moving = false;

  RampObject(float start, float end, int framesTransition, String OSCaddress) {
    frameStart = frameCount;
    frameEnd = frameCount+framesTransition;
    this.start = start;
    this.end = end;
    this.framesTransition = framesTransition;
    this.OSCaddress =  OSCaddress;
  }

  void reset(float start, float end, int framesTransition) {
    frameStart = frameCount;
    frameEnd = frameCount+framesTransition;
    this.start = start;
    this.end = end;
    this.framesTransition = framesTransition;
    moving = true;
  }

  void send() {
    if (moving) {
      float interpolatedValue = map(frameCount, frameStart, frameEnd, start, end );
      interpolatedValue = constrain( constrain(interpolatedValue, min(start, end), max(start, end) ), 0, 1);
      //println( interpolatedValue );
      OscMessage alive_message = new OscMessage(OSCaddress);
      alive_message.add( interpolatedValue );
      tidalcyclesOSC.send(alive_message, AbletonLiveOSC);
      if ( frameCount >= frameEnd   ) {
        moving = false;
      }
    }
  }
}
