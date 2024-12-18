import processing.embroider.*;
PEmbroiderGraphics E;

float hexRadius = 25; // Adjusted radius of hexagon (distance from center to any corner)
float borderThickness = 5; // Adjusted thickness of the border hexagon

void setup() {
  size(720, 720); // Maximum canvas size for 4 inches at 72 DPI
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("hexagons.vp3");
  String pesOutputFilePath = sketchPath("hexagons.pes");
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // Save as PES file as well

  E.beginDraw();
  E.clear();

  // Draw the four hexagons with adjusted positions for better spacing
  drawHexagonWithBorder(180, 180, "Autumn", "extreme", 15); // March Extreme (Top Left)
  drawHexagonWithBorder(180, 540, "Autumn", "average", 10); // March Average (Bottom Left)
  drawHexagonWithBorder(540, 180, "Autumn", "extreme", 18); // April Extreme (Top Right)
  drawHexagonWithBorder(540, 540, "Autumn", "average", 12); // April Average (Bottom Right)

  E.optimize(); // Slow but necessary for good output
  E.visualize();
  // E.endDraw(); // Uncomment to write the embroidery file
}

void drawHexagonWithBorder(float cx, float cy, String season, String type, float temperature) {
  // Draw the border hexagon
  E.noFill();
  E.stroke(0);
  E.strokeWeight(borderThickness);
  E.strokeMode(PEmbroiderGraphics.PERPENDICULAR);
  E.strokeSpacing(4);
  
  if (season.equals("Autumn")) {
    // Running stitch in a wavy pattern for autumn border
    E.setStitch(8, 16, 0.5);
    E.hatchMode(PEmbroiderGraphics.PARALLEL);
    E.hatchAngleDeg(30); // Angled offset for a falling leaves impression
  }

  drawHexagon(cx, cy, hexRadius + borderThickness / 2);

  // Set color based on temperature for the inner hexagon
  if (temperature <= 5) {
    E.fill(168, 0, 107); // Dark Fuchsia
  } else if (temperature <= 10) {
    E.fill(138, 43, 226); // Violet
  } else if (temperature <= 15) {
    E.fill(135, 206, 235); // Sky Blue
  } else if (temperature <= 20) {
    E.fill(0, 128, 128); // Teal Green
  } else if (temperature <= 25) {
    E.fill(50, 205, 50); // Leaf Green
  } else if (temperature <= 30) {
    E.fill(255, 255, 0); // Yellow
  } else if (temperature <= 35) {
    E.fill(255, 165, 0); // Tangerine
  } else {
    E.fill(255, 0, 0); // Red
  }

  // Draw the inner hexagon (center fill)
  E.noStroke();
  
  if (season.equals("Autumn")) {
    // Parallel Hatch with an angled offset for a falling leaves impression
    E.setStitch(5, 10, 0.5);
    E.hatchMode(PEmbroiderGraphics.PARALLEL);
    E.hatchAngleDeg(30);
  }

  drawHexagon(cx, cy, hexRadius - borderThickness);
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
