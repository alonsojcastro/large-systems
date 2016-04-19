float playerX = 0;
float playerY = 0;
float playerSpeed = 20;
float playerRadius = 20;

float goalX = 0;
float goalY = 0;
float goalRadius = 100;

// endpoint
String baseUrl = "http://tranquil-springs-84599.herokuapp.com/";
// api
String setUrl = baseUrl + "set-cost?cost=";
String getUrl = baseUrl + "get-cost";

int cost = 0;

boolean touching(float x1, float y1, float r1, float x2, float y2, float r2) {
  float d = dist(x1, y1, x2, y2);
  return d < (r1 + r2);
}

PFont myFont;

void updateCostOnServer(int cost) {
  loadJSONObject(setUrl + cost);
  return;
}

int costFromServer() {
  JSONObject serverCost = loadJSONObject(getUrl);
  return serverCost.getInt("cost");
}

void setup () {
  size(600, 600);
  myFont = createFont("AppleColorEmoji-48.vlw", 24);
  textFont(myFont);
  text("\u1f603",100,100);
  playerX = width/2;
  playerY = height/2;
  goalX = random(width);
  goalY = random(height);
  ellipseMode(RADIUS);
  cost = costFromServer();
}

void draw() {
  background(0);
  noStroke();

  println("Cost: " + cost);

  if (touching(goalX, goalY, goalRadius, playerX, playerY, playerRadius)) {
    cost++;
    updateCostOnServer(cost);
    fill(0, 0, 255);
  } else {
    fill(255, 0, 0);
  }
  ellipse(goalX, goalY, goalRadius, goalRadius);

  fill(0, 255, 0);
  ellipse(playerX, playerY, playerRadius, playerRadius);
}

void keyPressed() {
  if (keyCode == LEFT) {
    playerX -= playerSpeed;
  } else if (keyCode == RIGHT) {
    playerX += playerSpeed;
  } else if (keyCode == UP) {
    playerY -= playerSpeed;
  } else if (keyCode == DOWN) {
    playerY += playerSpeed;
  }
}