import processing.embroider.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

float hexRadius = 200; // Adjusted radius of hexagon (distance from center to any corner)
float borderThickness = 20; // Adjusted thickness of the border hexagon

void setup() {
  size(1000, 1000); // Adjusted canvas size to accommodate the increased spacing
  background(255); // Set background to white for better printing contrast

  // Initialize PEmbroiderGraphics
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Alignment_Dots.vp3");
  String pesOutputFilePath = sketchPath("Alignment_Dots.pes");
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // Save as PES file with the correct name

  // Begin drawing the embroidery
  E.beginDraw();
  E.clear();

  // Draw alignment dots with PEmbroider
  addAlignmentDots();

  E.optimize(); // Slow but necessary for good output
  E.endDraw(); // Write the embroidery file
  E.visualize();

  // Draw the same dots to the main canvas for saving as PNG
  addAlignmentDotsForPrint();

  // Save the visual representation as PNG
  save("Alignment_Dots_Printable.png");
}

void addAlignmentDots() {
  float dotSize = 5; // Size of each alignment dot
  E.strokeWeight(2); // Set the stitch thickness for the dots

  // Alignment dots for the hexagons
  // First hexagon pair (left, at (250, 250))
  float x1 = 250;
  float y1 = 250;

  addFourDotsAroundHexagonE(x1, y1);
  addFourDotsAroundHexagonE(x1, y1 + 450); // Below the first hexagon

  // Second hexagon pair (right, at (700, 250))
  float x2 = 700;
  float y2 = 250;

  addFourDotsAroundHexagonE(x2, y2);
  addFourDotsAroundHexagonE(x2, y2 + 450); // Below the second hexagon
}

void addAlignmentDotsForPrint() {
  float dotSize = 5; // Size of each alignment dot

  // Alignment dots for the hexagons (for print)
  // First hexagon pair (left, at (250, 250))
  float x1 = 250;
  float y1 = 250;

  addFourDotsAroundHexagonPrint(x1, y1);
  addFourDotsAroundHexagonPrint(x1, y1 + 450); // Below the first hexagon

  // Second hexagon pair (right, at (700, 250))
  float x2 = 700;
  float y2 = 250;

  addFourDotsAroundHexagonPrint(x2, y2);
  addFourDotsAroundHexagonPrint(x2, y2 + 450); // Below the second hexagon
}

void addFourDotsAroundHexagonE(float cx, float cy) {
  float dotOffset = hexRadius + borderThickness; // Offset distance for placing dots around the hexagon
  float dotSize = 5; // Size of the alignment dot

  // Top left
  E.ellipse(cx - dotOffset, cy - dotOffset, dotSize, dotSize);
  
  // Top right
  E.ellipse(cx + dotOffset, cy - dotOffset, dotSize, dotSize);

  // Bottom left
  E.ellipse(cx - dotOffset, cy + dotOffset, dotSize, dotSize);

  // Bottom right
  E.ellipse(cx + dotOffset, cy + dotOffset, dotSize, dotSize);
}

void addFourDotsAroundHexagonPrint(float cx, float cy) {
  float dotOffset = hexRadius + borderThickness; // Offset distance for placing dots around the hexagon
  float dotSize = 5; // Size of the alignment dot

  stroke(0);
  strokeWeight(2);
  fill(0);

  // Top left
  ellipse(cx - dotOffset, cy - dotOffset, dotSize, dotSize);
  
  // Top right
  ellipse(cx + dotOffset, cy - dotOffset, dotSize, dotSize);

  // Bottom left
  ellipse(cx - dotOffset, cy + dotOffset, dotSize, dotSize);

  // Bottom right
  ellipse(cx + dotOffset, cy + dotOffset, dotSize, dotSize);
}
