import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  size(1000, 1000); // Set the canvas size to match your embroidery hoop size
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Alignment_Dots.vp3");
  String pesOutputFilePath = sketchPath("Alignment_Dots.pes");
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // Save as PES file with the correct name

  E.beginDraw(); 
  E.clear();

  // Add alignment dots for embroidery alignment
  addAlignmentDots();

  E.optimize(); // Slow but necessary for good output
  E.endDraw(); // Write the embroidery file
  E.visualize();
}

void addAlignmentDots() {
  float dotSize = 5; // Size of each alignment dot
  E.strokeWeight(2); // Set the stitch thickness for the dots
  E.noFill(); // No fill, as we're using only outline stitches

  // Placement of the dots for alignment between vertical sets of hexagons
  // Example positions, adjust based on your actual design

  // First pair of dots (left)
  float x1 = 250;
  float y1 = 700; // Position below the first vertical pair of hexagons

  E.ellipse(x1 - 100, y1, dotSize, dotSize); // Left alignment dot
  E.ellipse(x1 + 100, y1, dotSize, dotSize); // Right alignment dot

  // Second pair of dots (right)
  float x2 = 700;

  E.ellipse(x2 - 100, y1, dotSize, dotSize); // Left alignment dot
  E.ellipse(x2 + 100, y1, dotSize, dotSize); // Right alignment dot
}
