import netP5.*;
import oscP5.*;

/**
 * oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
 //the protocol to use for real-time communication
 //uses udp
 //real time music visuals 
 
OscP5 oscP5;
NetAddress myRemoteLocation;
float[] audio_data = new float[12];

void setup() {
  size(700,700);
  colorMode(HSB, 360, 500, 100, 100);
  frameRate(10);
  /* start oscP5, listening for incoming messages at port 12000- they just made up 1200- number doesn't matter */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
   //specify the remote address that you want to talk to 
   //this specific one is the localhost ip address
  myRemoteLocation = new NetAddress("149.31.226.118",12000);
}


void draw() {
  background(0);
  ellipse(width/2, height/2, audio_data[0]*500, audio_data[0]*500);
  rect(width/2, height/2, audio_data[1]*300, audio_data[1]*300);
  bezier(100, 300, 400, 500, 200, 300, audio_data[2]*150, audio_data[2]*150);
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  //osc messages have names that start with forward slashes
  OscMessage myMessage = new OscMessage("/test");
  
  //messages have names and parameters- order is important 
  //you need to know the order of stuff you are sending over
 
  myMessage.add("some text"); /* add a string to the osc message */
  myMessage.add(112); /* add a string to the osc message */


  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  println(" value: "+theOscMessage.get(0).stringValue());
  println(" value: "+theOscMessage.get(1).intValue());
  println(" value: "+theOscMessage.get(2).floatValue());
  audio_data[theOscMessage.get(1).intValue()] = theOscMessage.get(2).floatValue();

}