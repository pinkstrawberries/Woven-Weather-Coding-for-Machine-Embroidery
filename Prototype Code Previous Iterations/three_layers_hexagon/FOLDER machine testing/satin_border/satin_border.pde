import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  size(700, 700);
  background(200);  // Set a background color to differentiate the drawn elements

  // Create PEmbroiderGraphics object
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("satin_stitch_border.vp3");
  E.setPath(outputFilePath);
  
  // Begin drawing with PEmbroiderGraphics
  E.beginDraw();
  E.clear();  // Clear any pre-existing drawings on the embroidery graphics context

  // Set properties for satin stitching
  E.strokeWeight(15);  // Adjust stroke thickness to see clearly
  E.stroke(0, 0, 255);  // Blue border for testing
  E.hatchMode(PEmbroiderGraphics.SATIN);  // Set stitch mode to satin
  
  // Draw the hexagon with the calculated radius of 250 pixels, centered on the canvas
  drawHexagon(width / 2, height / 2, 250);

  // Finish rendering
  E.visualize();  // This will visualize the embroidery onscreen
  E.endDraw();    // This line saves the embroidery file to disk
}

void draw() {
  // Use the draw() loop to ensure the embroidery is visualized correctly
  background(200);  // Refresh background color if needed
  E.visualize();  // Draw the embroidery graphics onto the canvas
}

void drawHexagon(float x, float y, float radius) {
  E.beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = PI / 3 * i;
    float xOffset = cos(angle) * radius;
    float yOffset = sin(angle) * radius;
    E.vertex(x + xOffset, y + yOffset);
  }
  E.endShape(CLOSE);
}
