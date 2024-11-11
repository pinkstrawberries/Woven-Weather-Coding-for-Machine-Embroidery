//Canvas Size: 2400 x 2700 pixels
//Hexagon Radius: Reduced to 150 pixels to make sure everything fits.
//Spacing: Adjusted spacing for both columns and rows to ensure all hexagons are aligned properly.

import processing.embroider.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

float hexRadius = 150; // Adjusted radius of hexagon (distance from center to any corner)
float borderThickness = 20; // Thickness of the border hexagon

JSONObject temperatureData;

void setup() {
  size(2400, 2700); // Adjusted canvas size for 24 hexagons (6 columns x 4 rows)
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Full_Year_Visualization.vp3");
  String pesOutputFilePath = sketchPath("Full_Year_Visualization.pes");
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // Save as PES file with the correct name

  // Upload the temperature data from JSON file
  temperatureData = loadJSONObject("sydney_temperature_2023.json");

  E.beginDraw(); // Start drawing the embroidery; sourced from PEmbroider library
  E.clear(); // Clear any previous content from the embroidery canvas

  // Draw the hexagons with temperatures from temperature data
  drawAllMonthlyHexagons();

  E.optimize(); // Slow but necessary for good output
  E.endDraw(); // Write the embroidery file
  E.visualize(); // Visualize the embroidery stitches
}

void drawAllMonthlyHexagons() {
  int counter = 0;
  for (int col = 0; col < 6; col++) {
    for (int row = 0; row < 2; row++) {
      String month = String.format("2023-%02d", counter + 1);
      float cx = 300 + col * 400; // Adjusted spacing between columns
      float cy = 300 + row * 1300; // Adjusted spacing between rows for stacked hexagons
      drawMonthlyHexagons(month, cx, cy);
      counter++;
    }
  }
}

void drawMonthlyHexagons(String monthPrefix, float cx, float cy) {
  // Extract temperature data from JSON file
  JSONArray days = temperatureData.getJSONArray("days");
  float extremeLow = Float.MAX_VALUE;
  float extremeHigh = Float.MIN_VALUE;
  float sumHigh = 0;
  float sumLow = 0;
  int count = 0;

  // Repeat over all days in the JSON array to find temperatures for the specified month
  for (int i = 0; i < days.size(); i++) {
    JSONObject day = days.getJSONObject(i);
    String date = day.getString("datetime");

    if (date.startsWith(monthPrefix)) {
      float tempMax = day.getFloat("tempmax");
      float tempMin = day.getFloat("tempmin");

      if (tempMax > extremeHigh) extremeHigh = tempMax;
      if (tempMin < extremeLow) extremeLow = tempMin;

      sumHigh += tempMax;
      sumLow += tempMin;
      count++;
    }
  }

  float averageHigh = sumHigh / count;
  float averageLow = sumLow / count;

  // Draw the hexagons for the given month (extremes and averages)
  drawHexagonWithBorder(cx, cy, getSeason(monthPrefix), "extreme", extremeLow, extremeHigh); // Extreme Low and High
  drawHexagonWithBorder(cx, cy + 450, getSeason(monthPrefix), "average", averageLow, averageHigh); // Average Low and High
}

String getSeason(String month) {
  switch(month) {
    case "2023-03":
    case "2023-04":
    case "2023-05":
      return "Autumn";
    case "2023-06":
    case "2023-07":
    case "2023-08":
      return "Winter";
    case "2023-09":
    case "2023-10":
    case "2023-11":
      return "Spring";
    case "2023-12":
    case "2023-01":
    case "2023-02":
      return "Summer";
    default:
      return "";
  }
}

void drawHexagonWithBorder(float cx, float cy, String season, String type, float temperatureLow, float temperatureHigh) {
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
  } else if (season.equals("Winter")) {
    // Cross-stitch or straight stitch with snowflake-like details for winter border
    E.setStitch(6, 12, 0.2);
    E.hatchMode(PEmbroiderGraphics.PERPENDICULAR);
  } else if (season.equals("Spring")) {
    // Light satin border with a simple floral motif for spring
    E.setStitch(4, 8, 0.3);
    E.hatchMode(PEmbroiderGraphics.SATIN);
  } else if (season.equals("Summer")) {
    // Thicker zigzag stitch border, reminiscent of sun rays for summer
    E.setStitch(10, 20, 0.4);
    E.hatchMode(PEmbroiderGraphics.ZIGZAG);
  }

  drawHexagon(cx, cy, hexRadius + borderThickness / 2);

  // Set color based on temperature for the inner hexagon
  float temperature = temperatureHigh;
  if (temperature <= 7.5) {
    E.fill(810); // Light Lilac
  } else if (temperature <= 10) {
    E.fill(620); // Magenta
  } else if (temperature <= 12.5) {
    E.fill(614); // Purple
  } else if (temperature <= 15) {
    E.fill(405); // Blue
  } else if (temperature <= 17.5) {
    E.fill(19); // Sky Blue
  } else if (temperature <= 20) {
    E.fill(534); // Teal Green
  } else if (temperature <= 22.5) {
    E.fill(509); // Leaf Green
  } else if (temperature <= 25) {
    E.fill(513); // Lime Green
  } else if (temperature <= 27.5) {
    E.fill(202); // Lemon Yellow
  } else if (temperature <= 30) {
    E.fill(208); // Orange
  } else if (temperature <= 35) {
    E.fill(126); // Pumpkin
  } else if (temperature <= 37.5) {
    E.fill(800); // Red
  } else {
    E.fill(807); // Carmine
  }

  // Draw the inner hexagon (center fill)
  E.noStroke();
  
  if (season.equals("Autumn")) {
    // Parallel Hatch with an angled offset for a falling leaves impression
    E.setStitch(5, 10, 0.5);
    E.hatchMode(PEmbroiderGraphics.PARALLEL);
    E.hatchAngleDeg(30);
  } else if (season.equals("Winter")) {
    // Spiral Hatch for a swirling snowflake effect
    E.setStitch(5, 15, 0.3);
    E.hatchMode(PEmbroiderGraphics.SPIRAL);
  } else if (season.equals("Spring")) {
    // Concentric Hatch for a blooming effect
    E.setStitch(4, 12, 0.4);
    E.hatchMode(PEmbroiderGraphics.CONCENTRIC);
  } else if (season.equals("Summer")) {
    // Satin Hatch for a vibrant, smooth effect
    E.setStitch(6, 14, 0.3);
    E.hatchMode(PEmbroiderGraphics.SATIN);
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
