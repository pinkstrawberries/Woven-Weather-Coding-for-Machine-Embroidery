//https://forum.processing.org/two/discussion/21083/creating-a-simple-function-to-draw-a-hexagon.html

//my old version


void setup() {

  size(1200, 800);

  drawHex(400, 400, 44);
}

void drawHex(float x, float y, float gs) {
  beginShape();
  vertex(x - gs, y - sqrt(3) * gs);
  vertex(x + gs, y - sqrt(3) * gs);
  vertex(x + 2 * gs, y);
  vertex(x + gs, y + sqrt(3) * gs);
  vertex(x - gs, y + sqrt(3) * gs);
  vertex(x - 2 * gs, y);
  endShape(CLOSE);
}
