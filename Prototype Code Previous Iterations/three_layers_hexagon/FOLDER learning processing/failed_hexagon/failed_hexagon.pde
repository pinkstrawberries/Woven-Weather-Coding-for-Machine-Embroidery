void setup() {

  size(600, 300);

}

void draw() {

  background(188, 110, 117);  //light red background color
  hexagon(130, 150, 100);

}

void hexagon(int x, int y, int tall) {  // (center x-coordinate, center y-coordinate, height)

  fill(109, 185, 153);  //light green fill
  stroke(79, 142, 115);
  strokeWeight(6);
  // Draw a hexagon by creating (x, y) vertices
  beginShape();
  vertex(x - 3/10 * tall, y - 1/2 * tall);
  vertex(x + 3/10 * tall, y - 1/2 * tall);
  vertex(x + 3/5 * tall, y);
  vertex(x + 3/10 * tall, y + 1/2 * tall);
  vertex(x - 3/10 * tall, y + 1/2 * tall);
  vertex(x - 3/5 * tall, y);
  endShape(CLOSE);  //closes the first and last point
}
