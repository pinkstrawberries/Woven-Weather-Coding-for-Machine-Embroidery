final int hexSize = 25; // Radius of each hexagon
final int rows = 14; // Number of hexagons per row (representing a fortnight)
final int columns = 26; // Number of hexagons per column (14 fortnights)

// Set up a larger canvas size to fit all hexagons properly
final int canvasWidth = (int)((rows + 1) * (2 * hexSize * 1.5)) + 2000; // Adjusted width to include spacing between hexagons and ensure all hexagons fit
final int canvasHeight = (int)(columns * (sqrt(3) * hexSize * 1.5)) + 300; // Adjusted height to include spacing between hexagons and ensure all hexagons fit

void settings() {
  size(canvasWidth, canvasHeight); // Set up the canvas size here, using settings()
}

void setup() {
  background(255); // Set the background color to white

  // Load the JSON file from the data folder
  JSONObject jsonData = loadJSONObject("sydney_temperature_2023.json");

  // Get the array of daily data
  JSONArray days = jsonData.getJSONArray("days");
  
  // Set up drawing parameters
  int xOffset = 40; // X-axis start offset
  int yOffset = 50; // Y-axis start offset
  float horizontalSpacing = hexSize * 2 * 1.5; // Adjusted for equidistant spacing between hexagons
  float verticalSpacing = sqrt(3) * hexSize * 1.5; // Adjusted for equidistant spacing between hexagons

  // Loop through the data and draw hexagons for each day
  for (int i = 0; i < days.size(); i++) {
    JSONObject day = days.getJSONObject(i);
    String date = day.getString("datetime");
    float high = day.getFloat("tempmax");
    float low = day.getFloat("tempmin");
    float avg = (high + low) / 2.0; // Calculate the average temperature for the day (using 2.0 to ensure float division)

    // Map temperatures to gradient colors specific to each day for the border (low temperature)
    color borderColor;
    if (low <= 5) {
      borderColor = lerpColor(color(255, 182, 193), color(255, 0, 255), map(low, 0, 5, 0, 1)); // Baby Pink to Fuchsia for very low temperatures
    } else if (low <= 10) {
      borderColor = lerpColor(color(148, 0, 211), color(75, 0, 130), map(low, 5, 10, 0, 1)); // Violet to Indigo for low temperatures
    } else if (low <= 15) {
      borderColor = lerpColor(color(0, 0, 255), color(144, 238, 144), map(low, 10, 15, 0, 1)); // Blue to Light Green for moderate temperatures
    } else if (low <= 20) {
      borderColor = lerpColor(color(144, 238, 144), color(255, 255, 0), map(low, 15, 20, 0, 1)); // Light Green to Yellow for warm temperatures
    } else if (low <= 25) {
      borderColor = lerpColor(color(255, 255, 0), color(255, 127, 0), map(low, 20, 25, 0, 1)); // Yellow to Orange for warmer temperatures
    } else if (low <= 30) {
      borderColor = lerpColor(color(255, 127, 0), color(255, 0, 0), map(low, 25, 30, 0, 1)); // Orange to Red for hot temperatures
    } else {
      borderColor = lerpColor(color(255, 0, 0), color(139, 0, 0), map(low, 30, 40, 0, 1)); // Red to Dark Red for very hot temperatures
    }

    color middleColor = color(255); // Set the middle color to white for now (Average Temperature)
    color centerColor;
    if (high <= 7.5) {
      centerColor = lerpColor(color(255, 182, 193), color(255, 0, 255), map(high, 0, 7.5, 0, 1)); // Baby Pink to Fuchsia for very low temperatures
    } else if (high <= 15) {
      centerColor = lerpColor(color(148, 0, 211), color(75, 0, 130), map(high, 7.5, 15, 0, 1)); // Violet to Indigo for low temperatures
    } else if (high <= 20) {
      centerColor = lerpColor(color(0, 0, 255), color(144, 238, 144), map(high, 15, 20, 0, 1)); // Blue to Light Green for moderate temperatures
    } else if (high <= 22.5) {
      centerColor = lerpColor(color(144, 238, 144), color(255, 255, 0), map(high, 20, 22.5, 0, 1)); // Light Green to Yellow for warm temperatures
    } else if (high <= 25) {
      centerColor = lerpColor(color(255, 255, 0), color(255, 127, 0), map(high, 22.5, 25, 0, 1)); // Yellow to Orange for warmer temperatures
    } else if (high <= 30) {
      centerColor = lerpColor(color(255, 127, 0), color(255, 0, 0), map(high, 25, 30, 0, 1)); // Orange to Red for hot temperatures
    } else {
      centerColor = lerpColor(color(255, 0, 0), color(139, 0, 0), map(high, 30, 40, 0, 1)); // Red to Dark Red for very hot temperatures
    }

    // Calculate x and y positions for each hexagon
    int row = i / rows;
    int col = i % rows;
    float x = xOffset + row * horizontalSpacing;
    float y = yOffset + col * verticalSpacing;

    // Draw the hexagon layers
    drawHexagon(x, y, hexSize, borderColor, middleColor, centerColor);
  }
}

void drawHexagon(float x, float y, float radius, color borderColor, color middleColor, color centerColor) {
  // Draw the border hexagon (Outer Layer)
  stroke(borderColor);
  strokeWeight(1);
  fill(borderColor, 191); // 75% opacity for the border color
  drawSingleHexagon(x, y, radius);

  // Draw the middle hexagon (Middle Layer, slightly smaller)
  stroke(middleColor);
  strokeWeight(1);
  fill(middleColor);
  drawSingleHexagon(x, y, radius * 0.7); // Middle layer smaller to make center more prominent

  // Draw the center hexagon (Inner Layer, larger)
  stroke(centerColor);
  strokeWeight(1);
  fill(centerColor, 200); // Slight opacity for the center color
  drawSingleHexagon(x, y, radius * 0.5); // Larger center for emphasis on highest temperature
}

void drawSingleHexagon(float x, float y, float radius) {
  beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = PI / 3 * i; // Adjust angle for flat edge alignment
    float xOffset = cos(angle) * radius;
    float yOffset = sin(angle) * radius;
    vertex(x + xOffset, y + yOffset);
  }
  endShape(CLOSE);
}
