
JSONObject json;
float wind_degrees;
float r = 100;
float theta = 0;

void setup() {
  size(600, 600);
  json = loadJSONObject ("http://api.wunderground.com/api/76196b5fe43f0d2e/conditions/q/HI/MAUI.json");//location is Hawaii - Maui
  //json = loadJSONObject ("https://api.brewerydb.com/v2/?beers&key=a6903ac851cb86e92290fcf163d0743a&format=json"); //beer api did not work...
  wind_degrees = json.getJSONObject("current_observation").getFloat("wind_degrees");//320 degrees of the wind.
  //float ibumax = json.getJSONObject("data").getFloat("ibumax");
  background(0,25);
  smooth();
}

void draw() {
  fill(0,10);
  //rect(0,0,width,height);
  
  float x = r * cos(theta);
  float y = r * sin(theta);
  //int weight = int(random(12, 25));
  //strokeWeight(weight);
  float sideIncrement = 0.1;
  float shapeRadius = width/3;
  int numberOfSides = int(random(2, 8));
  beginShape();
  while (sideIncrement < TWO_PI) {
    
  float xPos = sin(sideIncrement)*shapeRadius;
  float yPos = cos(sideIncrement)*shapeRadius;
  vertex(xPos+width*0.5, yPos+height*0.5);
  sideIncrement += TWO_PI/numberOfSides;
  }
  endShape(CLOSE);
  
  
  fill(0,255,255);
  noStroke();
  ellipse(x+width/2, y+height/2, (wind_degrees-200), (wind_degrees-200));
  
  theta += 0.03;
}