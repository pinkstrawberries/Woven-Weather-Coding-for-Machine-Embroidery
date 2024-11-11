import processing.embroider.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

float hexRadius = 200; // Adjusted radius of hexagon (distance from center to any corner)
float borderThickness = 20; // Adjusted thickness of the border hexagon

JSONObject temperatureData;

void setup() {
  size(1000, 1000); // Adjusted canvas size to accommodate the increased spacing
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Jan_and_Feb.vp3");
  String pesOutputFilePath = sketchPath("Jan_and_Feb.pes");
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // Save as PES file with the correct name

  // Load the temperature data from JSON file
  temperatureData = loadJSONObject("sydney_temperature_2023.json");

  E.beginDraw();
  E.clear();

  // Draw the hexagons with temperatures from JSON data
  drawMonthlyHexagons("2023-01", 250, 250); // January (Top Left)
  drawMonthlyHexagons("2023-02", 700, 250); // February (Top Right)

  E.optimize(); // Slow but necessary for good output
  E.endDraw(); // Write the embroidery file
  E.visualize();
}

void drawMonthlyHexagons(String monthPrefix, float cx, float cy) {
  // Extract temperature data from JSON
  JSONArray days = temperatureData.getJSONArray("days");
  float extremeLow = Float.MAX_VALUE;
  float extremeHigh = Float.MIN_VALUE;
  float sumHigh = 0;
  float sumLow = 0;
  int count = 0;

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
    E.hatchMode(PEmbroiderGraphics.PERPENDICULAR); // Corrected to use PEmbroiderGraphics.PERPENDICULAR
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

  // Set color based on temperature for the inner hexagon (using high temperature)
  float temperature = temperatureHigh;
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
