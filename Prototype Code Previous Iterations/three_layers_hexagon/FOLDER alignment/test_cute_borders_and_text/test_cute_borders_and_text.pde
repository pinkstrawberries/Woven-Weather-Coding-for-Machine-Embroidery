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

  // Draw the corner borders for the month
  drawCornerBorders(cx, cy, cy + 450, monthPrefix);

  // Add the month name text
  E.textSize(24);
  E.textAlign(CENTER, CENTER);
  E.fill(0); // Black for visibility
  E.text(monthPrefix.substring(5), cx, cy + 225); // Place in between the two hexagons
}

void drawCornerBorders(float cx, float topCy, float bottomCy, String monthPrefix) {
  float markSize = 25; // Length of the corner marks, half the width of the original alignment lines

  // Determine the season style
  String season = getSeason(monthPrefix);

  // Set the stitch based on the season
  if (season.equals("Autumn")) {
    E.setStitch(8, 16, 0.5);
  } else if (season.equals("Winter")) {
    E.setStitch(6, 12, 0.5);
  } else if (season.equals("Spring")) {
    E.setStitch(4, 8, 0.5);
  } else if (season.equals("Summer")) {
    E.setStitch(10, 20, 0.5);
  }

  // Top-left corner
  E.line(cx - hexRadius - borderThickness / 2, topCy - hexRadius - borderThickness / 2, 
         cx - hexRadius - borderThickness / 2 + markSize, topCy - hexRadius - borderThickness / 2);
  E.line(cx - hexRadius - borderThickness / 2, topCy - hexRadius - borderThickness / 2, 
         cx - hexRadius - borderThickness / 2, topCy - hexRadius - borderThickness / 2 + markSize);

  // Top-right corner
  E.line(cx + hexRadius + borderThickness / 2, topCy - hexRadius - borderThickness / 2, 
         cx + hexRadius + borderThickness / 2 - markSize, topCy - hexRadius - borderThickness / 2);
  E.line(cx + hexRadius + borderThickness / 2, topCy - hexRadius - borderThickness / 2, 
         cx + hexRadius + borderThickness / 2, topCy - hexRadius - borderThickness / 2 + markSize);

  // Bottom-left corner
  E.line(cx - hexRadius - borderThickness / 2, bottomCy + hexRadius + borderThickness / 2, 
         cx - hexRadius - borderThickness / 2 + markSize, bottomCy + hexRadius + borderThickness / 2);
  E.line(cx - hexRadius - borderThickness / 2, bottomCy + hexRadius + borderThickness / 2, 
         cx - hexRadius - borderThickness / 2, bottomCy + hexRadius + borderThickness / 2 - markSize);

  // Bottom-right corner
  E.line(cx + hexRadius + borderThickness / 2, bottomCy + hexRadius + borderThickness / 2, 
         cx + hexRadius + borderThickness / 2 - markSize, bottomCy + hexRadius + borderThickness / 2);
  E.line(cx + hexRadius + borderThickness / 2, bottomCy + hexRadius + borderThickness / 2, 
         cx + hexRadius + borderThickness / 2, bottomCy + hexRadius + borderThickness / 2 - markSize);
}
