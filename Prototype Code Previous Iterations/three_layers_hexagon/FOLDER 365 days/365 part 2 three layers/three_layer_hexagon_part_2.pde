final int hexSize = 25; // Radius of each hexagon
final int columns = 15; // Number of hexagons per row
final int rows = ceil(365.0 / columns); // Calculate number of rows to fit all days

// Set up a larger canvas size to fit all hexagons properly
final int canvasWidth = 900; // Fixed canvas width
final int canvasHeight = (int)(rows * (sqrt(3) * hexSize)) + 100; // Calculate height dynamically based on rows

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
  float horizontalSpacing = hexSize * 1.75; // Adjusted for better spacing to avoid overlap
  float verticalSpacing = sqrt(3) * hexSize; // Vertical spacing for hexagons

  // Loop through the data and draw hexagons for each day
  for (int i = 0; i < days.size(); i++) {
    JSONObject day = days.getJSONObject(i);
    String date = day.getString("datetime");
    float high = day.getFloat("tempmax");
    float low = day.getFloat("tempmin");
    float avg = (high + low) / 2.0; // Calculate the average temperature for the day (using 2.0 to ensure float division)

    // Map temperatures to gradient colors specific to each day
    color borderColor = lerpColor(color(0, 0, 20), color(173, 216, 230), map(low, 0, 25, 0, 1)); // Dark Blue to Light Blue for Border (Lowest Temperature)
    color middleColor = color(255); // Set the middle color to white for now (Average Temperature)
    color centerColor;
    if (high <= 10) {
      centerColor = lerpColor(color(148, 0, 211), color(75, 0, 130), map(high, 0, 10, 0, 1)); // Violet to Indigo for very low temperatures
    } else if (high <= 15) {
      centerColor = lerpColor(color(75, 0, 130), color(0, 0, 255), map(high, 10, 15, 0, 1)); // Indigo to Blue for low temperatures
    } else if (high <= 20) {
      centerColor = lerpColor(color(0, 0, 255), color(0, 255, 0), map(high, 15, 20, 0, 1)); // Blue to Green for moderate temperatures
    } else if (high <= 25) {
      centerColor = lerpColor(color(0, 255, 0), color(255, 255, 0), map(high, 20, 25, 0, 1)); // Green to Yellow for warm temperatures
    } else if (high <= 30) {
      centerColor = lerpColor(color(255, 255, 0), color(255, 127, 0), map(high, 25, 30, 0, 1)); // Yellow to Orange for warmer temperatures
    } else {
      centerColor = lerpColor(color(255, 127, 0), color(255, 0, 0), map(high, 30, 40, 0, 1)); // Orange to Red for very hot temperatures
    }

    // Calculate x and y positions for each hexagon
    int col = i % columns;
    int row = i / columns;
    float x = xOffset + col * horizontalSpacing;
    float y = yOffset + row * verticalSpacing;

    // Offset every other row for a hexagonal layout
    if (row % 2 == 1) {
      x += horizontalSpacing / 2;
    }

    // Draw the hexagon layers
    drawHexagon(x, y, hexSize, borderColor, middleColor, centerColor);
  }
}

void drawHexagon(float x, float y, float radius, color borderColor, color middleColor, color centerColor) {
  // Draw the border hexagon (Outer Layer)
  stroke(borderColor);
  strokeWeight(3);
  fill(borderColor, 180); // Slight opacity for the border color
  drawSingleHexagon(x, y, radius);

  // Draw the middle hexagon (Middle Layer, slightly larger)
  stroke(middleColor);
  strokeWeight(2);
  fill(middleColor);
  drawSingleHexagon(x, y, radius * 0.6); // Middle layer smaller to make center more prominent

  // Draw the center hexagon (Inner Layer, larger)
  stroke(centerColor);
  strokeWeight(1);
  fill(centerColor, 200); // Slight opacity for the center color
  drawSingleHexagon(x, y, radius * 0.8); // Larger center for emphasis on highest temperature
}

void drawSingleHexagon(float x, float y, float radius) {
  beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = TWO_PI / 6 * i;
    float xOffset = cos(angle) * radius;
    float yOffset = sin(angle) * radius;
    vertex(x + xOffset, y + yOffset);
  }
  endShape(CLOSE);
}
