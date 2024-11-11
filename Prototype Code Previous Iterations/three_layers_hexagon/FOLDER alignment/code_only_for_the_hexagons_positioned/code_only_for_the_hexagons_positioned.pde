import processing.embroider.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

float hexRadius = 200; // Adjusted radius of hexagon (distance from center to any corner)
float borderThickness = 20; // Adjusted thickness of the border hexagon

void setup() {
  size(1000, 1000); // Adjusted canvas size to accommodate the increased spacing
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

  addFourDotsAroundHexagon(x1, y1);
  addFourDotsAroundHexagon(x1, y1 + 450); // Below the first hexagon

  // Second hexagon pair (right, at (700, 250))
  float x2 = 700;
  float y2 = 250;

  addFourDotsAroundHexagon(x2, y2);
  addFourDotsAroundHexagon(x2, y2 + 450); // Below the second hexagon
}

void drawFourDots(float cx, float cy) {
  float dotOffset = hexRadius + borderThickness; // Offset distance for placing dots around the hexagon
  float dotSize = 5; // Size of the alignment dot

  // Top left
  ellipse(cx - dotOffset, cy - dotOffset, dotSize, dotSize);
  
  // Top right
  ellipse(cx + dotOffset, cy - dotOffset, dotSize, dotSize);

  // Bottom left
  ellipse(cx - dotOffset, cy + dotOffset, dotSize, dotSize);

  // Bottom right
  ellipse(cx + dotOffset, cy + dotOffset, dotSize, dotSize);
}
