final int hexSize = 25; // Radius of each hexagon
final int rows = 15; // Number of hexagons per column
final int columns = ceil(365.0 / rows); // Calculate number of columns to fit all days

// Set up a larger canvas size to fit all hexagons properly
final int canvasWidth = (int)(columns * (1.5 * hexSize)) + 100; // Calculate width dynamically based on columns
final int canvasHeight = 900; // Fixed canvas height

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
  float horizontalSpacing = hexSize * 1.5; // Adjusted for perfect tessellation
  float verticalSpacing = sqrt(3) * hexSize; // Vertical spacing for hexagons

  // Loop through the data and draw hexagons for each day
  for (int i = 0; i < days.size(); i++) {
    JSONObject day = days.getJSONObject(i);
    String date = day.getString("datetime");
    float high = day.getFloat("tempmax");
    float low = day.getFloat("tempmin");
    float avg = (high + low) / 2.0; // Calculate the average temperature for the day (using 2.0 to ensure float division)

    // Determine the season and assign a color to the border based on average temperature of the season
    color borderColor;
    int month = PApplet.parseInt(date.substring(5, 7));
    if (month == 12 || month == 1 || month == 2) {
      borderColor = lerpColor(color(255, 100, 100), color(255, 0, 0), map(avg, 20, 35, 0, 1)); // Red for summer
    } else if (month >= 3 && month <= 5) {
      borderColor = lerpColor(color(255, 200, 100), color(255, 165, 0), map(avg, 15, 25, 0, 1)); // Orange for autumn
    } else if (month >= 6 && month <= 8) {
      borderColor = lerpColor(color(100, 100, 255), color(0, 0, 255), map(avg, 5, 15, 0, 1)); // Blue for winter
    } else {
      borderColor = lerpColor(color(100, 255, 100), color(0, 255, 0), map(avg, 10, 25, 0, 1)); // Green for spring
    }

    color middleColor = color(255); // Set the middle color to white for now (Average Temperature)
    color centerColor;
    if (high <= 10) {
      centerColor = lerpColor(color(148, 0, 211), color(75, 0, 130), map(high, 0, 15, 0, 1)); // Violet to Indigo for very low temperatures
    } else if (high <= 15) {
      centerColor = lerpColor(color(75, 0, 130), color(0, 0, 255), map(high, 15, 17.5, 0, 1)); // Indigo to Blue for low temperatures
    } else if (high <= 20) {
      centerColor = lerpColor(color(0, 0, 255), color(0, 255, 0), map(high, 17.5, 20, 0, 1)); // Blue to Green for moderate temperatures
    } else if (high <= 25) {
      centerColor = lerpColor(color(0, 255, 0), color(255, 255, 0), map(high, 20, 22.5, 0, 1)); // Green to Yellow for warm temperatures
    } else if (high <= 30) {
      centerColor = lerpColor(color(255, 255, 0), color(255, 127, 0), map(high, 22.5, 25, 0, 1)); // Yellow to Orange for warmer temperatures
    } else {
      centerColor = lerpColor(color(255, 127, 0), color(255, 0, 0), map(high, 25, 40, 0, 1)); // Orange to Red for very hot temperatures
    }

    // Calculate x and y positions for each hexagon
    int row = i % rows;
    int col = i / rows;
    float x = xOffset + col * horizontalSpacing;
    float y = yOffset + row * verticalSpacing;

    // Offset every other row for a hexagonal layout
    if (col % 2 == 1) {
      y += verticalSpacing / 2;
    }

    // Draw the hexagon layers
    drawHexagon(x, y, hexSize, borderColor, middleColor, centerColor);
  }
}

void drawHexagon(float x, float y, float radius, color borderColor, color middleColor, color centerColor) {
  // Draw the border hexagon (Outer Layer)
  stroke(borderColor);
  strokeWeight(1.5);
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
