import processing.embroider.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
PEmbroiderGraphics E;

float hexRadius = 200; // adjust the radius of hexagon (distance from center to any corner)
float borderThickness = 20; // adjust the thickness of the border hexagon

JSONObject temperatureData;

void setup() {
  size(1000, 1000); // this adjusts the canvas size to match the 4x4 inch embroidery hoop on the Brother SE425 Embroidery Machine
  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("Final_Jan_and_Feb.vp3"); //saves as a VP3 file
  String pesOutputFilePath = sketchPath("Final_Jan_and_Feb.pes"); //saves as a PES file, which is what is uploaded into the SE425
  E.setPath(outputFilePath);
  E.setPath(pesOutputFilePath); // save as PES file with the correct name

  // upload the temperature data from JSON file
  temperatureData = loadJSONObject("sydney_temperature_2023.json"); // data sourced from Visual Crossing Weather API

  E.beginDraw(); //sourced from PEmbroider library)
  E.clear();

  // draw the hexagons with temperatures from temperature data
  drawMonthlyHexagons("2023-01", 250, 250); // january (top left hexagon) (two hexagons stacked vertically on top of each other)
  drawMonthlyHexagons("2023-02", 700, 250); // february (top right hexagon) (two hexagons stacked vertically on top of each other)

// sourced from PEmbroider library
  E.optimize(); // slow but necessary for good output. if there is too much code then removing this line can make it run faster.
  E.endDraw(); // write the embroidery file
  E.visualize(); //too see the embroidery stitches and how they are arranged
}

// function which is used to draw hexagons with different temperature values for a given month in 2023
// method for temperature extraction and averaging based on Processing.org
void drawMonthlyHexagons(String monthPrefix, float cx, float cy) {
  // extract temperature data from JSON file
  JSONArray days = temperatureData.getJSONArray("days"); // extract the "days" array from the JSON object containing temperature data

float extremeLow = Float.MAX_VALUE; // used to find the lowest temperature of the month
float extremeHigh = Float.MIN_VALUE; // used to find the highest temperature of the month
float sumHigh = 0; // variable to combine the daily high temperatures for calculating the average highest temperature of the month
float sumLow = 0; // variable to combine the daily low temperatures for calculating the average lowest temperature of the month
int count = 0; // this is a counter to keep a record of the number of days processed in the month

// repeat over all days in the JSON array to find temperatures for the specified month that i want
for (int i = 0; i < days.size(); i++) {
    JSONObject day = days.getJSONObject(i); // extract the current day’s JSON object
    String date = day.getString("datetime"); // get the date string in a "yyyy-MM-dd" format (another reminder im glad to not be in america)

    if (date.startsWith(monthPrefix)) { // check if the date actually belongs to the given month
        float tempMax = day.getFloat("tempmax"); // find out the maximum temperature for the day
        float tempMin = day.getFloat("tempmin"); // find out the minimum temperature for the day

        if (tempMax > extremeHigh) extremeHigh = tempMax; // update extremeHigh if the current day's maximum temperature is higher (conditional)
        if (tempMin < extremeLow) extremeLow = tempMin; // update extremeLow if the current day's minimum temperature is lower (conditional)

        sumHigh += tempMax; // add the current day's maximum highest temperature to the total sum for averaging
        sumLow += tempMin; // add the current day's minimum lowest temperature to the total sum for averaging
        count++; // increase the counter to keep track of how many days are processed
    }
}

float averageHigh = sumHigh / count; // calculate the average high temperature for the month
float averageLow = sumLow / count; // calculate the average low temperature for the month


  // draw the hexagons for the given month (extremes and averages)
  drawHexagonWithBorder(cx, cy, getSeason(monthPrefix), "extreme", extremeLow, extremeHigh); // extreme low and high
  drawHexagonWithBorder(cx, cy + 450, getSeason(monthPrefix), "average", averageLow, averageHigh); // average low and high
}

// this is a function that determines the season based on what month of the year it is
// I just assigned month-to-season mapping based on what normally happens in southern hemisphere 
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

// this is a function that draws a hexagon with a border around it, with special stitch styling based on the season
// the stitch styles and border patterns are based on source code found in the PEmbroidery library- i have just altered and manipulated them to my own design choices
void drawHexagonWithBorder(float cx, float cy, String season, String type, float temperatureLow, float temperatureHigh) {
  // draw the border hexagon which has the lower temperatures (cant overlap)
  E.noFill();
  E.stroke(0);
  E.strokeWeight(borderThickness);
  E.strokeMode(PEmbroiderGraphics.PERPENDICULAR);
  E.strokeSpacing(4);
  
  if (season.equals("Autumn")) {
    // running stitch in a wavy pattern for autumn border
    E.setStitch(8, 16, 0.5);
    E.hatchMode(PEmbroiderGraphics.PARALLEL);
    E.hatchAngleDeg(30); // angled offset it kind of looks like falling leaves
  } else if (season.equals("Winter")) {
    // cross-stitch/straight stitch with snowflake-like details for winter border
    E.setStitch(6, 12, 0.2);
    E.hatchMode(PEmbroiderGraphics.PERPENDICULAR); // uses PEmbroiderGraphics.PERPENDICULAR
  } else if (season.equals("Spring")) {
    // light satin border with a cute floral motif for spring vibes
    E.setStitch(4, 8, 0.3);
    E.hatchMode(PEmbroiderGraphics.SATIN);
  } else if (season.equals("Summer")) {
    // thicker zigzag stitch border, vaguely reminiscent of sun rays for summer
    E.setStitch(10, 20, 0.4);
    E.hatchMode(PEmbroiderGraphics.ZIGZAG);
  }

  drawHexagon(cx, cy, hexRadius + borderThickness / 2);

  // set the colour based on temperature for the centre hexagon (using the higher temperature)
  // colour-coding for temperature inspired by various crocheted/knitted/hand-embroidered temperature blankets made for sydney (images in GitHub)
  // these colours and their values are based on the SimThread 63 Spools Colour Chart (also linked in GitHub)
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

  // draw the inner hexagon (center fill) (needs space away from the border so the machine has room for the complex stitching)
  E.noStroke();
  // stitch fills are sourced from the PEmbroider library, but their dimensions have been manipulated by me
  if (season.equals("Autumn")) {
    // parallel hatch with an angled offset for a falling leaves vibes again
    E.setStitch(5, 10, 0.5);
    E.hatchMode(PEmbroiderGraphics.PARALLEL);
    E.hatchAngleDeg(30);
  } else if (season.equals("Winter")) {
    // spiral hatch which could be interpreted as a swirling snowflake
    E.setStitch(5, 15, 0.3);
    E.hatchMode(PEmbroiderGraphics.SPIRAL);
  } else if (season.equals("Spring")) {
    // concentric hatch, reminds me of blooming and flowers
    E.setStitch(4, 12, 0.4);
    E.hatchMode(PEmbroiderGraphics.CONCENTRIC);
  } else if (season.equals("Summer")) {
    // satin hatch because its very vibrant, smooth, and the stitches are condensely packed so the colour will pop
    E.setStitch(6, 14, 0.3);
    E.hatchMode(PEmbroiderGraphics.SATIN);
  }

  drawHexagon(cx, cy, hexRadius - borderThickness);
}

// this is a function which is used to draw a hexagon, defining the vertices of the hexagon with trigonometric calculations 
// based on Processing.org Regular Polygon Examples
void drawHexagon(float cx, float cy, float radius) {
  float angleOffset = PI / 6; // offset to ensure flat sides are facing each other AND NOT THE POINTY SIDES
  E.beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = angleOffset + i * PI / 3;
    float x = cx + cos(angle) * radius;
    float y = cy + sin(angle) * radius;
    E.vertex(x, y);
  }
  E.endShape(CLOSE); // done!!! :D
}
