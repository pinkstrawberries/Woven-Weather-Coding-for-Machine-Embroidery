import processing.embroider.*;
PEmbroiderGraphics E;

final int hexSize = 25; // Radius of the hexagon

// Set up a smaller canvas size for a single hexagon
final int canvasWidth = 200;
final int canvasHeight = 200;

void settings() {
  size(canvasWidth, canvasHeight); // Set up the canvas size here, using settings()
}

void setup() {
  background(255); // Set the background color to white

  // Initialize PEmbroiderGraphics
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("single_hexagon_test.vp3");
  E.setPath(outputFilePath);
  E.beginDraw();
  E.clear();

  // Manually set the test colors for the hexagon
  color borderColor = color(255, 0, 0); // Example color for border
  color middleColor = color(0, 255, 0); // Example color for middle layer
  color centerColor = color(0, 0, 255); // Example color for center

  // Set up the position for the hexagon
  float x = canvasWidth / 2;
  float y = canvasHeight / 2;

  // Draw a single hexagon with the given colors
  drawHexagon(x, y, hexSize, borderColor, middleColor, centerColor);

  // Visualize the embroidery
  E.visualize();

  // Save the embroidery file
  E.endDraw();
}

void drawHexagon(float x, float y, float radius, color borderColor, color middleColor, color centerColor) {
  // Draw the border hexagon (Outer Layer)
  E.stroke(borderColor);
  E.strokeWeight(2); // Set a higher stroke weight to make the outline more visible
  E.fill(borderColor);
  drawSingleHexagon(x, y, radius);

  // Draw the middle hexagon (Middle Layer, slightly smaller)
  E.stroke(middleColor);
  E.strokeWeight(1);
  E.fill(middleColor);
  drawSingleHexagon(x, y, radius * 0.7); // Middle layer smaller to make center more prominent

  // Draw the center hexagon (Inner Layer, even smaller)
  E.stroke(centerColor);
  E.strokeWeight(1);
  E.fill(centerColor);
  drawSingleHexagon(x, y, radius * 0.5); // Smaller center for emphasis on highest temperature
}

void drawSingleHexagon(float x, float y, float radius) {
  E.beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = PI / 3 * i; // Adjust angle for flat edge alignment
    float xOffset = cos(angle) * radius;
    float yOffset = sin(angle) * radius;
    E.vertex(x + xOffset, y + yOffset);
  }
  E.endShape(CLOSE);
}
