import processing.net.*;
Client c;

int x = 0;
int y = 1;
int bx = 2;
int by = 3;

float paddle1x = 590, paddle1y;
float paddle2x = 0, player2y;

float pongballx, pongbally;

float speedx = random(2,8);
float speedy = random(2,8);

void setup(){
  c = new Client(this, "127.0.0.1", 1234);
  size(500, 500);
  ellipseMode(CENTER);
  noStroke();
}

void draw(){
  background(4, 106, 58);

  c = new Client(this, "127.0.0.1", 1234);
  float p1Buffy = (mouseY-50)/4,
        updatepongbally = pongballx /4,
        updatepongballx = pongbally /4;
  float sendpongballx = updatepongballx, sendpongbally = updatepongbally;

  byte[] buffer = new byte[4];
  float sendP1x=paddle1x/4;
  
  buffer[x] = (byte)sendP1x;
  buffer[y] = (byte)p1Buffy;
  buffer[bx] = (byte)sendpongballx;
  buffer[by] = (byte)sendpongbally;
  c.write(buffer);
  println(buffer);
  
  if(c.available() > 0) {
  byte[] bufferIn = new byte[4];
  c.readBytes(bufferIn);
  paddle2x = bufferIn[x];
  player2y = bufferIn[y]*4;
  println(bufferIn);
  }
    
    fill(255, 255, 50);
    ellipse(pongballx, pongbally, 20, 20);
    pongballx = pongballx + speedx;
    pongbally = pongballx + speedy;
    
    
    paddle1y= mouseY-50;
    
    fill(120, 50, 200);
    rect(paddle1x, paddle1y, 10, 100);
    fill(0, 195, 255); 
    rect(paddle2x, player2y, 10, 100);
  


      if(pongballx > 5 && pongballx < 10 && pongbally > mouseY-50 && pongbally < mouseY+50 ){
      speedx = speedx * -1.0;
      pongballx = pongballx + speedx;
      fill(255);
    }
    

    if(pongballx > width-10 && pongballx < width-5 && pongbally > mouseY-50 && pongbally < mouseY+50 ){
      speedx = speedx * -1.0;
      pongballx = pongballx + speedx;

    }
  

    if (pongbally < 0 || pongbally > height) {
      speedy = speedy * -1.0;
      pongbally = pongbally + speedy;
    }

     if (pongballx < 0 || pongballx > width) {
      speedy = speedy * (random(1)*-1.0);
      pongbally = 250;
      pongballx = 250;
    }
 }