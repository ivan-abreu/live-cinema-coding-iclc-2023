float alpha = 100;

void graphicInterface() {
  textAlign(LEFT, BASELINE);
  fill(255);
  textFont(dinotRegular, 18);
  text("Bridge Tidal>UE  (v0.1)", 10, 25);
  textFont(dinotRegular, 14);
  text("TidalCycles (v3.x)  to  Unreal Engine (v4.x | v5.x)", 10, 45);
  textFont(dinotBold, 14);
  text("Iván Abreu, 2022-2023", 10, 65);

  textAlign(CENTER, CENTER);
  fill(118);
  pushMatrix();
  translate(385, height*.5);
  rotate(-HALF_PI);
  text("LONG  LIFE  TO  LIVECODING", 0, 0);
  popMatrix();

  textAlign(LEFT, CENTER);
  fill(255);
  textFont(dinotRegular, 14);
  text("Listening to Tidal in socket port: "+receivingSocket, 10, height*0.54-10);
  text("Sending Unreal Engine on socket port: "+sendingSocket, 10, height*0.54+10);

  textAlign(LEFT, BOTTOM);
  textFont(dinotBold, 14);
  fill(255, 0, 0);
  text("LIVECINEMACODING.XYZ", 10, 250);
  fill(118);
  text("BY MALITZIN CORTES (CNDSD) & IVAN ABREU", 10, 270);
}

void mousePressed() {
  link("https://livecinemacoding.xyz");
}
