//hexagon radius reduced to 100 to make sure the hexagons fit comfortably.
//border thickness: adjusted to 10 for visual balance.
//canvas and spacing adjustments: horizontal and vertical spacing adjusted to ensure there is enough room between the hexagons and they don't overlap.

import processing.embroider.*; 
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

float hexRadius = 100; // reduced radius of hexagon (distance from center to any corner)
float borderThickness = 10; // adjusted thickness of the border hexagon

JSONObject temperatureData;

void setup() {
  size(2300, 2400); // canvas size for 24 hexagons (6 columns x 4 rows)
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Full_Year_Visualization.vp3");
  String pesOutputFilePath = sketchPath("Full_Year_Visualization.pes");
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // save as PES file with the correct name

  // upload the temperature data from JSON file
  temperatureData = loadJSONObject("sydney_temperature_2023.json");

  E.beginDraw(); // start drawing the embroidery; sourced from PEmbroider library
  E.clear(); // clear any previous content from the embroidery canvas

  // draw the hexagons with temperatures from temperature data
  drawAllMonthlyHexagons();

  E.optimize(); // slow but necessary for good output
  E.endDraw(); // write the embroidery file
  E.visualize(); // visualize the embroidery stitches
}

// function to draw all monthly hexagons for the full year
void drawAllMonthlyHexagons() {
  String[] months = {"2023-01", "2023-02", "2023-03", "2023-04", "2023-05", "2023-06",
                     "2023-07", "2023-08", "2023-09", "2023-10", "2023-11", "2023-12"};
                      
  int counter = 0;
  for (int row = 0; row < 2; row++) { // iterate through all 4 rows
    for (int col = 0; col < 6; col++) { // iterate through 6 columns
      String month = months[counter];
      float cx = 200 + col * 300; // adjusted horizontal spacing between columns
      float cy = 200 + row * 500; // increased spacing to fit 4 rows properly
      drawMonthlyHexagons(month, cx, cy);
      counter++;
    }
  }
}

// function to draw hexagons for a specific month
void drawMonthlyHexagons(String monthPrefix, float cx, float cy) {
  // extract temperature data from JSON file
  JSONArray days = temperatureData.getJSONArray("days");
  float extremeLow = Float.MAX_VALUE;
  float extremeHigh = Float.MIN_VALUE;
  float sumHigh = 0;
  float sumLow = 0;
  int count = 0;

  // repeat over all days in the JSON array to find temperatures for the specified month
  for (int i = 0; i < days.size(); i++) {
    JSONObject day = days.getJSONObject(i);
    String date = day.getString("datetime");

    if (date.startsWith(monthPrefix)) {
      float tempMax = day.getFloat("tempmax"); // get maximum temperature of the day
      float tempMin = day.getFloat("tempmin"); // get minimum temperature of the day

      if (tempMax > extremeHigh) extremeHigh = tempMax; // update extreme high if needed
      if (tempMin < extremeLow) extremeLow = tempMin; // update extreme low if needed

      sumHigh += tempMax; // add to sum of daily highs
      sumLow += tempMin; // add to sum of daily lows
      count++; // increase day count
    }
  }

  float averageHigh = sumHigh / count; // calculate average high temperature for the month
  float averageLow = sumLow / count; // calculate average low temperature for the month

  // draw the hexagons for the given month (extremes and averages)
  drawHexagonWithBorder(cx, cy, getSeason(monthPrefix), "extreme", extremeLow, extremeHigh); // extreme low and high
  drawHexagonWithBorder(cx, cy + 225, getSeason(monthPrefix), "average", averageLow, averageHigh); // average low and high
}

// function to determine the season based on the month
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

// function to draw a hexagon with a border, using the season and temperature data for styling
void drawHexagonWithBorder(float cx, float cy, String season, String type, float temperatureLow, float temperatureHigh) {
  // draw the border hexagon
  E.noFill();
  E.stroke(0);
  E.strokeWeight(borderThickness);
  E.strokeMode(PEmbroiderGraphics.PERPENDICULAR);
  E.strokeSpacing(4);
  
  if (season.equals("Autumn")) {
    // running stitch in a wavy pattern for autumn border
    E.setStitch(8, 16, 0.5);
    E.hatchMode(PEmbroiderGraphics.PARALLEL);
    E.hatchAngleDeg(30); // angled offset for a falling leaves impression
  } else if (season.equals("Winter")) {
    // cross-stitch or straight stitch with snowflake-like details for winter border
    E.setStitch(6, 12, 0.2);
    E.hatchMode(PEmbroiderGraphics.PERPENDICULAR);
  } else if (season.equals("Spring")) {
    // light satin border with a simple floral motif for spring
    E.setStitch(4, 8, 0.3);
    E.hatchMode(PEmbroiderGraphics.SATIN);
  } else if (season.equals("Summer")) {
    // thicker zigzag stitch border, reminiscent of sun rays for summer
    E.setStitch(10, 20, 0.4);
    E.hatchMode(PEmbroiderGraphics.ZIGZAG);
  }

  drawHexagon(cx, cy, hexRadius + borderThickness / 2); // draw border hexagon

  // set color based on temperature for the inner hexagon
  float temperature = temperatureHigh;
  if (temperature <= 7.5) {
    E.fill(810); // light lilac
  } else if (temperature <= 10) {
    E.fill(620); // magenta
  } else if (temperature <= 12.5) {
    E.fill(614); // purple
  } else if (temperature <= 15) {
    E.fill(405); // blue
  } else if (temperature <= 17.5) {
    E.fill(19); // sky blue
  } else if (temperature <= 20) {
    E.fill(534); // teal green
  } else if (temperature <= 22.5) {
    E.fill(509); // leaf green
  } else if (temperature <= 25) {
    E.fill(513); // lime green
  } else if (temperature <= 27.5) {
    E.fill(202); // lemon yellow
  } else if (temperature <= 30) {
    E.fill(208); // orange
  } else if (temperature <= 35) {
    E.fill(126); // pumpkin
  } else if (temperature <= 37.5) {
    E.fill(800); // red
  } else {
    E.fill(807); // carmine
  }

  // draw the inner hexagon (center fill)
  E.noStroke();
  
  if (season.equals("Autumn")) {
    // parallel hatch with an angled offset for a falling leaves impression
    E.setStitch(5, 10, 0.5);
    E.hatchMode(PEmbroiderGraphics.PARALLEL);
    E.hatchAngleDeg(30);
  } else if (season.equals("Winter")) {
    // spiral hatch for a swirling snowflake effect
    E.setStitch(5, 15, 0.3);
    E.hatchMode(PEmbroiderGraphics.SPIRAL);
  } else if (season.equals("Spring")) {
    // concentric hatch for a blooming effect
    E.setStitch(4, 12, 0.4);
    E.hatchMode(PEmbroiderGraphics.CONCENTRIC);
  } else if (season.equals("Summer")) {
    // satin hatch for a vibrant, smooth effect
    E.setStitch(6, 14, 0.3);
    E.hatchMode(PEmbroiderGraphics.SATIN);
  }

  drawHexagon(cx, cy, hexRadius - borderThickness); // draw inner hexagon
}

// function to draw a hexagon using trigonometric calculations for vertices
void drawHexagon(float cx, float cy, float radius) {
  float angleOffset = PI / 6; // offset to ensure flat sides are facing each other
  E.beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = angleOffset + i * PI / 3;
    float x = cx + cos(angle) * radius;
    float y = cy + sin(angle) * radius;
    E.vertex(x, y); // add vertex at calculated coordinates
  }
  E.endShape(CLOSE); // complete the hexagon shape
}
