/**
 * Cat Schmitz and Alonso- Large Systems Homework 
 * code apapted from:
 * oscP5message by andreas schlegel
 * and from the sound amplitude example in Processing Example Library
 */
 
//import all necessary libraries
import processing.sound.*;
import oscP5.*;
import netP5.*;

Amplitude amp;
AudioIn in;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(640, 360);
  background(255);
  //sound code below  
  // Create an Input stream which is routed into the Amplitude analyzer
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  frameRate(10);
  
  //osc code below
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
   //alonso's computer
  myRemoteLocation = new NetAddress("149.31.139.35",12000);
 
}


void draw() {
  background(0);  
   /* in the following different ways of creating osc messages are shown by example */
  //osc messages have names that start with forward slashes
  OscMessage myMessage = new OscMessage("/music");
  
  //messages have names and parameters- order is important 
  //you need to know the order of stuff you are sending over
 
  myMessage.add("Cat's computer:"); /* add a string to the osc message */
  myMessage.add(0); /* add a string to the osc message */
  myMessage.add(amp.analyze()*100); 


  oscP5.send(myMessage, myRemoteLocation);

  OscMessage myMessage2 = new OscMessage("/music2");
  
  //messages have names and parameters- order is important 
  //you need to know the order of stuff you are sending over
 
  myMessage2.add("Cat's computer:"); /* add a string to the osc message */
  myMessage2.add(1); /* add a string to the osc message */
  myMessage2.add(amp.analyze()*100); 
  /* send the message */
  oscP5.send(myMessage2, myRemoteLocation);
  
  OscMessage myMessage3 = new OscMessage("/music3");
  
  //messages have names and parameters- order is important 
  //you need to know the order of stuff you are sending over
 
  myMessage3.add("Cat's computer:"); /* add a string to the osc message */
  myMessage3.add(2); /* add a string to the osc message */
  myMessage3.add(amp.analyze()*100); 
  /* send the message */
  oscP5.send(myMessage3, myRemoteLocation);
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  

}