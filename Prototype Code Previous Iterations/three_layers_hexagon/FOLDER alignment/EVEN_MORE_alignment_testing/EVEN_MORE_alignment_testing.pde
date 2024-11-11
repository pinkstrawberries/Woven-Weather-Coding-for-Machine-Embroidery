import processing.embroider.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

JSONObject temperatureData;

void setup() {
  size(1000, 1000); // Adjusted canvas size to accommodate the increased spacing
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Combined_Embroidery.vp3");
  String pesOutputFilePath = sketchPath("Combined_Embroidery.pes");
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // Save as PES file with the correct name

  E.beginDraw();  // Begin drawing in PEmbroider
  E.clear();

  // Draw the registration marks first
  addRegistrationMarks();

  // Draw the hexagons with temperatures from JSON data
  drawMonthlyHexagons("2023-01", 250, 250); // January (Top Left)
  drawMonthlyHexagons("2023-02", 700, 250); // February (Top Right)

  E.optimize(); // Slow but necessary for good output (can be commented out to test)
  E.endDraw();  // End drawing in PEmbroider, write to the file
  E.visualize();
}

void addRegistrationMarks() {
  // Use thicker, visible lines for alignment
  E.strokeWeight(5); // Set thicker lines for better visibility
  E.stroke(0); // Use black for visibility

  // Draw alignment lines at key locations
  float markSize = 50; // Length of the registration lines

  // Horizontal and vertical cross at the center
  E.line(width / 2 - markSize, height / 2, width / 2 + markSize, height / 2); // Horizontal line
  E.line(width / 2, height / 2 - markSize, width / 2, height / 2 + markSize); // Vertical line

  // Registration marks around each corner of the hoop area
  float offset = 50; // Offset from the edges
  // Top-left
  E.line(offset, offset, offset + markSize, offset);
  E.line(offset, offset, offset, offset + markSize);

  // Top-right
  E.line(width - offset, offset, width - offset - markSize, offset);
  E.line(width - offset, offset, width - offset, offset + markSize);

  // Bottom-left
  E.line(offset, height - offset, offset + markSize, height - offset);
  E.line(offset, height - offset, offset, height - offset - markSize);

  // Bottom-right
  E.line(width - offset, height - offset, width - offset - markSize, height - offset);
  E.line(width - offset, height - offset, width - offset, height - offset - markSize);
}

void drawMonthlyHexagons(String monthPrefix, float cx, float cy) {
  // Dummy function to simulate the hexagon drawing (simplified)
  E.noFill();
  E.stroke(0);
  E.strokeWeight(2);
  drawHexagon(cx, cy, 100); // Draw a simple hexagon at the specified location
}

void drawHexagon(float cx, float cy, float radius) {
  float angleOffset = PI / 6; // Offset to ensure flat sides are facing each other
  E.beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = angleOffset + i * PI / 3;
    float x = cx + cos(angle) * radius;
    float y = cy + sin(angle) * radius;
    E.vertex(x, y);
  }
  E.endShape(CLOSE);
}
