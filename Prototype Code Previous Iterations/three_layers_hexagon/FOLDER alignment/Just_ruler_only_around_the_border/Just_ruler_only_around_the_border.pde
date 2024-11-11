import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  noLoop(); 
  size(1000, 1000); // Adjusted canvas size for alignment ruler

  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("PEmbroider_alignment_ruler.vp3");
  E.setPath(outputFilePath); 

  E.beginDraw(); 
  E.clear();
  E.noFill();
  E.strokeWeight(2); // Thicker for visibility
  E.setStitch(10, 25, 0); 

  // Draw alignment ruler segments around the edges
  float cm = 10 * 10; // 10 mm in a cm, converted for drawing size

  // Top ruler segment
  float x0 = 50; // Starting point on the left
  float y0 = 50; // Offset from the top
  float w = 20 * cm; // 20 cm wide ruler
  float x1 = x0 + w;

  E.line(x0, y0, x1, y0); // Main ruler line
  for (int i = 0; i <= 20; i++) { // 20 cm marks
    float px = x0 + i * cm;
    if (i % 5 == 0) {
      E.line(px, y0, px, y0 + cm * 1.0); // Longer line for every 5 cm
    } else {
      E.line(px, y0, px, y0 + cm * 0.5); // Shorter line for every cm
    }
  }

  // Bottom ruler segment (mirrored)
  float y1 = height - 50; // Offset from the bottom
  E.line(x0, y1, x1, y1);
  for (int i = 0; i <= 20; i++) {
    float px = x0 + i * cm;
    if (i % 5 == 0) {
      E.line(px, y1, px, y1 - cm * 1.0);
    } else {
      E.line(px, y1, px, y1 - cm * 0.5);
    }
  }

  // Vertical alignment rulers on left and right
  // Left
  float y_start = 100;
  float y_end = height - 100;
  E.line(x0, y_start, x0, y_end);
  for (int i = 0; i <= 10; i++) { // 10 cm markers
    float py = y_start + i * cm;
    if (i % 5 == 0) {
      E.line(x0, py, x0 - cm * 1.0, py); // Longer line for every 5 cm
    } else {
      E.line(x0, py, x0 - cm * 0.5, py); // Shorter line for every cm
    }
  }

  // Right (mirrored)
  E.line(x1, y_start, x1, y_end);
  for (int i = 0; i <= 10; i++) {
    float py = y_start + i * cm;
    if (i % 5 == 0) {
      E.line(x1, py, x1 + cm * 1.0, py);
    } else {
      E.line(x1, py, x1 + cm * 0.5, py);
    }
  }

  E.optimize(); // Important for good output
  E.endDraw(); // End and save the file
  E.visualize();
}
