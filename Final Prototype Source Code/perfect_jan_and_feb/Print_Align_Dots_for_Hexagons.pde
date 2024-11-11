import processing.embroider.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

float hexRadius = 200; // radius of hexagon (distance from center to any corner of the canvas)
float borderThickness = 20; // thickness of the border hexagon

void setup() {
  size(1000, 1000); // this canvas size matches the one used for the sets of four hexagons and fits the SE245 embroidery hoop
  background(255); // this was grey but i changed it to white for better contrast when it is printed

  // originally sourced from the PEmbroider library and manipulated and expanded to fit my design specifications
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Print_Alignment_Dots.vp3"); // save as VP3 file format
  String pesOutputFilePath = sketchPath("Print_Alignment_Dots.pes"); // save as PES file format (used by SE425)
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // set PES output path

  // Code sourced directly from the PEmbroider library to draw any kind of embroidery design
  E.beginDraw(); // start drawing the embroidery design
  E.clear(); // clear any previous content from the embroidery canvas

  // draw alignment dots to be lightly embroidered in order to position the fabric in real life accurately
  addAlignmentDots(); // this is a function to add alignment dots

  //sourced directly from PEmbroider library
  E.optimize(); // slow but essential for high-quality stitch output
  E.endDraw(); // end the embroidery drawing process and save to file (also for the png)
  E.visualize(); // visualize the embroidery design, showing the arrangement of stitches (but no colour)

  // draw the alignment dots on the canvas so i can save it as a printable PNG that is true to size
  addAlignmentDotsForPrint(); // this is a function to add alignment dots for printable use (not embroidery)

  // save the visual representation of alignment dots as a PNG image file
  save("Alignment_Dots_Printable.png");
}

// this is a function to add alignment dots for embroidery, built on from code in the PEmbroider library
void addAlignmentDots() {
  float dotSize = 5; // set the size of each alignment dot
  E.strokeWeight(2); // set the stitch thickness for the dots to make them more visible (need to experiment with machine to see how thick they actually are in real life)

  // first hexagon pair - top left (positioned at (250, 250))
  float x1 = 250; // x-coordinate for the first pair of hexagons
  float y1 = 250; // y-coordinate for the first hexagon

  // add four dots around the top hexagon at (x1, y1)
  addFourDotsAroundHexagonE(x1, y1);
  
  // add four dots around the bottom hexagon, directly below the first (y1 + 450 spacing)
  addFourDotsAroundHexagonE(x1, y1 + 450);

  // second hexagon pair - top right (positioned at (700, 250))
  float x2 = 700; // x-coordinate for the second pair of hexagons
  float y2 = 250; // y-coordinate for the first hexagon in the second pair

  // add four dots around the top hexagon at (x2, y2)
  addFourDotsAroundHexagonE(x2, y2);

  // add four dots around the bottom hexagon, directly below the first (y2 + 450 spacing)
  addFourDotsAroundHexagonE(x2, y2 + 450);
}

// function to add alignment dots for printable use (not embroidery)
void addAlignmentDotsForPrint() {
  float dotSize = 5; // set the size of each alignment dot for print

  // first hexagon pair - top left (positioned at (250, 250))
  float x1 = 250; // x-coordinate for the first pair of hexagons
  float y1 = 250; // y-coordinate for the first hexagon

  // add four dots around the top hexagon at (x1, y1) for printing
  addFourDotsAroundHexagonPrint(x1, y1);
  
  // add four dots around the bottom hexagon, directly below the first (y1 + 450 spacing) for printing
  addFourDotsAroundHexagonPrint(x1, y1 + 450);

  // second hexagon pair - top right (positioned at (700, 250))
  float x2 = 700; // x-coordinate for the second pair of hexagons
  float y2 = 250; // y-coordinate for the first hexagon in the second pair

  // add four dots around the top hexagon at (x2, y2) for printing
  addFourDotsAroundHexagonPrint(x2, y2);

  // add four dots around the bottom hexagon, directly below the first (y2 + 450 spacing) for printing
  addFourDotsAroundHexagonPrint(x2, y2 + 450);
}

// function to add four alignment dots around a hexagon using the PEmbroider library
void addFourDotsAroundHexagonE(float cx, float cy) {
  float dotOffset = hexRadius + borderThickness; // the offset distance for placing dots around the hexagon, taking into account radius and border thickness
  float dotSize = 5; // the size of each dot for embroidery

  // draw dots around the hexagon using PEmbroider (E.ellipse)
  // top left dot
  E.ellipse(cx - dotOffset, cy - dotOffset, dotSize, dotSize);

  // top right dot
  E.ellipse(cx + dotOffset, cy - dotOffset, dotSize, dotSize);

  // bottom left dot
  E.ellipse(cx - dotOffset, cy + dotOffset, dotSize, dotSize);

  // bottom right dot
  E.ellipse(cx + dotOffset, cy + dotOffset, dotSize, dotSize);
}

// this is a function to add four alignment dots around a hexagon for printing (not embroidery)
void addFourDotsAroundHexagonPrint(float cx, float cy) {
  float dotOffset = hexRadius + borderThickness; // offset distance for placing dots around the hexagon, same as in embroidery version
  float dotSize = 5; // size of each alignment dot for printing

  // set stroke properties for dots to be printed
  stroke(0); // black outline for dots
  strokeWeight(2); // thickness of the outline
  fill(0); // fill the dots with black color

  // draw dots around the hexagon using Processing ellipse function (for printing)
  // top left dot
  ellipse(cx - dotOffset, cy - dotOffset, dotSize, dotSize);

  // top right dot
  ellipse(cx + dotOffset, cy - dotOffset, dotSize, dotSize);

  // bottom left dot
  ellipse(cx - dotOffset, cy + dotOffset, dotSize, dotSize);

  // bottom right dot
  ellipse(cx + dotOffset, cy + dotOffset, dotSize, dotSize);
}
