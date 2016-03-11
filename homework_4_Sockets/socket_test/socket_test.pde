//import all necessary libraries
import processing.sound.*;
import processing.net.*;


Amplitude amp;
AudioIn in;


Server s; 
Client c;
String input;

void setup() { 
  size(450, 255);
  background(204);
  stroke(0);
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  s = new Server(this, 12345);  // Start a simple server on a port
} 
void draw() { 
  s.write((int)(amp.analyze()*10000));
  // Receive data from client
  c = s.available();

}