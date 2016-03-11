import processing.net.*; 

Client c; 
int input;
int data[]; 

void setup() { 
  size(650, 500); 
  background(204);
  stroke(0);
  // Connect to the server’s IP address and port­
  c = new Client(this, "149.31.226.219", 12345); // Replace with your server’s IP and port
} 

void draw() {         
   println("socket is on " + c);
  // Receive data from server
  if (c.available() > 0) { 
    input = c.read(); 
    println(input);

//alonso does something here
  fill(2,132,125);
  stroke(input+10);
  ellipse(width/2, height/2, input, input);
  
  fill(255, 127, 80);
  stroke(input + 3);
  rect(width/2, height/2, input, input);
  
  fill(153, 50, 204);
  stroke(input/2);
  bezier(width/2.5, height/2.5, 120, 135, 150, 165, input, input);
  } 
}