float centx = 50;
float centy = 50;
float radius = 40;
float angle = TWO_PI / 6;
 
beginShape();
for (float a = PI/6; a < TWO_PI; a += angle) {
 float vx = centx + cos(a) * radius;
 float vy = centy + sin(a) * radius;
 vertex(vx, vy);
 }
endShape(CLOSE);
