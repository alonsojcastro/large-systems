import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float p1W;
float p1H;
float p1X;
float p1Y;

float p2W;
float p2H;
float p2X;
float p2Y;

float posXchange;
float posYchange;
float ballX;
float ballY;
float ballspeed;
int ball;

int right_score = 0;
int left_score = 0;


String p1scorestring = "";
String p2scorestring = "";

void setup(){
  smooth();
  size(500, 500);
  
  p1W= 10;
  p1H = 100;
  p1X= 480;
  p1Y = 200;

  p2W= 10;
  p2H = 100;
  p2X = 10;
  p2Y = 100;

  posXchange = 1;
  posYchange = 0;
  ballX = 0;
  ballY = 0;
  ballspeed = 5;
  ball = 20;
  
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
  myRemoteLocation = new NetAddress("149.31.197.79",14000);
   
  
}

void draw(){
  background(0, 255, 0);
  p1scorestring = "" + right_score;
  p2scorestring = "" + left_score;
  PFont fontp1;
  PFont fontp2;
  fontp1 = loadFont("LinotypeSyntaxOsF-Black-48.vlw");
  fontp2 = loadFont("LinotypeSyntaxOsF-Black-48.vlw");
  textFont(fontp1);
  textFont(fontp2);
  text(p1scorestring, 255, 10, 75, 50);
  text(p2scorestring, 180, 10, 75, 50);  

  
  //paddle1
  noStroke();
  fill(120, 30, 200);
  shapeMode(CENTER);
  rect(p1X, p1Y, p1W, p1H);
    if(keyPressed){
      if(keyCode == UP){
      p1Y = constrain(p1Y - 4, -25, 475);
      }
    }
    if(keyPressed){
      if(keyCode == DOWN){
      p1Y = constrain(p1Y + 4, -25, 475);
      }
    }
  
  //paddle2
  noStroke();
  fill(120, 30, 200);
  shapeMode(CENTER);
  rect(p2X, p2Y, p2W, p2H);
    if(keyPressed){
      if(key == 'e'){
      p2Y = constrain(p2Y - 4, -25, 475);
      }
    }
    if(keyPressed){
      if(key == 'd'){
      p2Y = constrain(p2Y + 4, -25, 475);
      }
    }
    
  //ball
  noStroke();
  fill(255, 255, 255);
  shapeMode(CENTER);
  ellipse(ballX, ballY, ball, ball);
  
    ballX = ballX + posXchange * ballspeed;
    
    ballY = ballY + posYchange * ballspeed;
    if (ballY > height - ball/2){
    posYchange = -1;
    }
    if(ballY < 0 + ball/2){
    posYchange = 1;
    }
    
    if(ballY - ball/2 <= p1Y + p1H/2
    && ballY + ball/2 >= p1Y - p1H/2
    && ballX + ball/2 <= p1X - p1W/2
    && ballX + ball/2 >= p1X - p1W/2 - ballspeed){
    posXchange = -1;
    //ballspeed = dist(ballX, ballY, p1X, p1Y)/2;
    }

    if(ballY - ball/2 <= p2Y + p2H/2
    && ballY + ball/2 >= p2Y - p2H/2
    && ballX - ball/2 >= p2X + p2W/2
    && ballX - ball/2 <= p2X + p2W/2 + ballspeed){
    posXchange = 1;
    //ballspeed = dist(ballX, ballY, p2X, p2Y)/2;
    }
    
    if (ballX < -50){
    posXchange = 1;
    right_score = right_score+1;
    }
    if (ballX > 550){
    posXchange = -1;
    left_score = left_score+1;
    }

  /* in the following different ways of creating osc messages are shown by example */
  //osc messages have names that start with forward slashes
  OscMessage myMessage = new OscMessage("/player/position");
  
  //messages have names and parameters- order is important 
  //you need to know the order of stuff you are sending over
 
  myMessage.add(p1X); 
  myMessage.add(p1Y);

  //myMessage.add(new byte[] {0x00, 0x01, 0x10, 0x20}); /* add a byte blob to the osc message */
  //myMessage.add(new int[] {1,2,3,4}); /* add an int array to the osc message */

  oscP5.send(myMessage, myRemoteLocation);

  OscMessage myMessage2 = new OscMessage("/ball/position");
  
  //messages have names and parameters- order is important 
  //you need to know the order of stuff you are sending over
 
  myMessage2.add(ballX); /* add a string to the osc message */
  myMessage2.add(ballY);

  oscP5.send(myMessage2, myRemoteLocation);
  
  }
  


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  if(theOscMessage.checkAddrPattern("/player/position")==true){
  p2X = theOscMessage.get(0).floatValue();
  p2Y = map(theOscMessage.get(1).floatValue(), 500, 0, 0, 500); 
  println("received");
  return;
  }
  if(theOscMessage.checkAddrPattern("/ball/position")==true){
  ballX = theOscMessage.get(0).floatValue();
  ballY = map(theOscMessage.get(1).floatValue(), 500, 0, 0, 500); 
  return;
  }

}