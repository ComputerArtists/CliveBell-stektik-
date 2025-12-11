// FLÜSSIGE METABALLS – finale organische Schönheit
// Processing 4.x – einfach kopieren und losfließen

int numBlobs = 6;
PVector[] pos = new PVector[numBlobs];
float[] speed = new float[numBlobs];
float t = 0;

void setup() {
  size(1400, 900, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  smooth(8);
  resetBlobs();
}

void resetBlobs() {
  for (int i = 0; i < numBlobs; i++) {
    pos[i] = new PVector(random(width), random(height));
    speed[i] = random(0.008, 0.025);
  }
  t = 0;
}

void draw() {
  t += 0.006;
  int activeBlobs = 3 + (int)map(mouseY, 0, height, 0, 4);

  background(0);
  loadPixels();

  for (int x = 0; x < width; x += 3) {
    for (int y = 0; y < height; y += 3) {
      float sum = 0;
      for (int i = 0; i < activeBlobs; i++) {
        float d = dist(x, y, pos[i].x, pos[i].y);
        sum += 80 * 120 / (d + 80);  // Metaball-Formel
      }

      if (sum > 80) {
        float h = (t*30 + sum*2 + pos[0].x*0.1) % 360;
        float s = 70 + sin(t + sum*0.1)*30;
        float b = 80 + sum*0.8;
        pixels[y*width + x] = color(h, s, b, 250);
        // weiche Ränder durch Nachbarpixel
        if (x > 0) pixels[y*width + x-1] = color(h, s, b, 150);
        if (y > 0) pixels[y*width + x-width] = color(h, s, b, 150);
      }
    }
  }
  updatePixels();

  // Kerne bewegen
  for (int i = 0; i < activeBlobs; i++) {
    pos[i].x += sin(t * speed[i] + i) * 4;
    pos[i].y += cos(t * speed[i]*1.3 + i) * 4;
    if (pos[i].x < 0 || pos[i].x > width) speed[i] *= -1;
    if (pos[i].y < 0 || pos[i].y > height) speed[i] *= -1;
  }

  // Glow
  blendMode(ADD);
  tint(255, 60);
  image(get(), -12, -8);
  blendMode(BLEND);
  noTint();

  fill(255, 200);
  textAlign(RIGHT, BOTTOM);
  textSize(18);
  text("Flüssige Metaballs | MausX = Tempo | MausY = Anzahl | r = neu | s = speichern", width-30, height-25);
}

void keyPressed() {
  if (key == 'r') resetBlobs();
  if (key == 's' || key == 'S') saveFrame("metaballs_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png");
}
