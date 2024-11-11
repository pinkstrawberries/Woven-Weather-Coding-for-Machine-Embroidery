// "Hello World" program for the PEmbroider library for Processing. 
// Generates a smiley face and the words "hello world". 

// Import the library, and declare a PEmbroider renderer. 
import processing.embroider.*;
PEmbroiderGraphics E;

void setup() {
  // Set canvas size to match embroidery hoop dimensions in pixels (10 cm x 10 cm at 10 pixels per mm)
  size(800, 800);
  float cx = width / 2; 
  float cy = height / 2 - 20;

  // Create the PEmbroider object
  E = new PEmbroiderGraphics(this, width, height);

  // Specify the output file path as a .PES file
  String outputFilePath = sketchPath("Hello_PEmbroider.pes");
  E.setPath(outputFilePath);

  // Start rendering to the PEmbroiderer.
  E.beginDraw(); 
  E.clear();
  E.ellipseMode(CENTER);  // Ellipses are specified by their center (not top-left)
  E.CIRCLE_DETAIL = 60;   // Circles are secretly 60-sided polygons; good enough
  E.toggleResample(true); // Turn resampling on (good for embroidery machines)

  // Draw the face outline (scaled to fit within 10 cm)
  E.noFill();
  E.stroke(0, 0, 0);
  E.strokeWeight(15); // Reduced stroke thickness to fit within the hoop
  E.strokeSpacing(2.5);
  E.strokeMode(PEmbroiderGraphics.PERPENDICULAR);
  E.setStitch(5, 20, 0); 
  E.ellipse(cx, cy, 200, 200); // Scaled down face diameter to 5 cm

  // Draw the eyes (scaled appropriately)
  E.fill(0, 0, 0); 
  E.stroke(0, 0, 0); 
  E.strokeWeight(1); 
  E.setStitch(5, 15, 0);
  E.hatchSpacing(2); 
  E.hatchMode(PEmbroiderGraphics.CONCENTRIC);
  E.circle(cx - 30, cy - 20, 40); // Scaled down eye size and positioned
  E.circle(cx + 30, cy - 20, 40); 

  // Draw the mouth (scaled to fit)
  E.noFill(); 
  E.stroke(0, 0, 0); 
  E.strokeWeight(10); // Reduced stroke weight for the mouth
  E.strokeMode(PEmbroiderGraphics.TANGENT);
  E.setStitch(5, 15, 0); 
  E.arc(cx, cy + 30, 100, 100, PI * 0.15, PI * 0.85); // Scaled down mouth

  // Say hello (scaled to fit)
  E.stroke(0, 0, 0); 
  E.textSize(1.5); // Reduced text size
  E.textAlign(CENTER, BOTTOM);
  E.textFont(PEmbroiderFont.SCRIPT_SIMPLEX);
  E.text("Hello World!", cx, cy + 120); // Positioned below the face

  //-----------------------
  // IMPORTANT: Optimize and export the file 
  E.optimize(); // VERY SLOW, but ESSENTIAL for good file output!
  E.endDraw(); // This will write out the PES embroidery file.
  E.visualize(true, false, true); // Display (preview) the embroidery onscreen.

  boolean bAlsoSaveScreenshot = false; 
  if (bAlsoSaveScreenshot) { // Save a screenshot 
    save("Hello_Pembroider.png");
  }
}

void draw() {
  boolean bShowAnimatedProgress = false;
  if (bShowAnimatedProgress) {
    background(255);
    E.visualize(true, false, true, frameCount);
  }
}
