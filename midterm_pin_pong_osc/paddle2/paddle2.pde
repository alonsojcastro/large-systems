import processing.net.*;
Server s;
Client c;

int x = 0;
int y = 1;
int bx = 2;
int by = 3;

float speedx = random(5,12);
float speedy = random(5,12);

float pongballx, pongbally, p1pongballx, p1pongbally,
      qpongbally = pongbally/4,
      qpongballx = pongbally/4;

float sendpongballx = qpongballx, sendpongbally = qpongbally;

float player1x = 490, player1y;
float player2x = 0, player2y;

void setup() {
   s = new Server(this, 1234); 
   size(500, 500);
   ellipseMode(CENTER);
   noStroke();
}

void draw() {

  byte[] buffer = new byte[4];
  float p2Buffy = (mouseY-50)/4;
  
  buffer[x] = (byte)player2x;
  buffer[y] = (byte)p2Buffy;
  buffer[bx] = (byte)sendpongballx;
  buffer[by] = (byte)sendpongbally;
  
  s.write(buffer);
  
  Client c = s.available();
  if(c != null) {
    byte[] bufferIn = new byte[4];
    c.readBytes(bufferIn);
    player1y = bufferIn[y]*4;
    p1pongballx = bufferIn[bx]*4;
    p1pongbally = bufferIn[by]*4;
    
    println(bufferIn);
   }
  
  println("Player 1:  " + player1x + "x, " + player1y + "y");
  println("Ball: " + p1pongballx +"x, "+ p1pongbally + "y");

  background(4, 106, 58);
  pongballx = p1pongballx;
  pongbally = p1pongbally;
  fill(255, 255, 50);
  ellipse(pongballx, pongbally, 20, 20);
  
  player2y= mouseY-50;
  
  fill(120, 50, 200);  
  rect(player1x, player1y, 10, 100);
  
  fill(0, 195, 255); 
  rect(player2x, player2y, 10, 100);
}