// LIQUID MIRROR – finale Version mit Steuerung & Speichern
// Processing 4.x – einfach kopieren → läuft sofort perfekt

PGraphics a, b, c;
boolean paused = false;
int palette = 0;  // 0=silber, 1=gold, 2=holo, 3=deep purple

void setup() {
  size(1200, 800, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  smooth(8);
  
  a = createGraphics(width, height, P2D);
  b = createGraphics(width, height, P2D);
  c = createGraphics(width, height, P2D);
  
  a.colorMode(HSB, 360, 100, 100, 100);
  b.colorMode(HSB, 360, 100, 100, 100);
  c.colorMode(HSB, 360, 100, 100, 100);
  
  textAlign(RIGHT, BOTTOM);
  textSize(16);
}

void draw() {
  float t = millis() * 0.0002 * (paused ? 0 : map(mouseX, 0, width, 0.2, 2.5));
  
  // --- 4 Farbpaletten ---
  float[][] palettes = {
    {0, 80, 90, 20,   160, 70, 90, 18,   240, 80, 95, 22},  // Silber-Chrom
    {30, 90, 95, 22,   50, 90, 90, 20,   20, 70, 90, 18},  // Gold
    {280, 90, 90, 25,  180, 90, 90, 20,  80, 90, 95, 22},  // Holo
    {270, 90, 70, 18,  300, 90, 80, 20,  200, 90, 90, 25}   // Deep Purple
  };
  float[] p = palettes[palette];

  // Layer A (rot-dominiert)
  a.beginDraw(); a.background(0);
  a.translate(width/2, height/2);
  for (int i = 0; i < 14; i++) {
    float ph = t*1.3 + i*0.9;
    float amp = 90 + sin(ph*2)*60;
    a.stroke(p[0], p[1], p[2], p[3]);
    a.strokeWeight(5 + sin(ph)*2);
    a.noFill();
    a.beginShape();
    for (float j = 0; j < TWO_PI; j += 0.07) {
      float r = 120 + sin(j*11 + ph*4)*amp;
      a.vertex(cos(j)*r, sin(j)*r);
    }
    a.endShape();
  }
  a.endDraw();

  // Layer B (grün-dominiert)
  b.beginDraw(); b.background(0);
  b.translate(width/2, height/2);
  for (int i = 0; i < 16; i++) {
    float ph = t*0.9 - i*0.7;
    float amp = 100 + cos(ph*1.8)*70;
    b.stroke(p[4], p[5], p[6], p[7]);
    b.strokeWeight(4);
    b.ellipse(0, 0, 280 + sin(ph*3)*amp, 280 + cos(ph*3)*amp);
  }
  b.endDraw();

  // Layer C (blau-dominiert)
  c.beginDraw(); c.background(0);
  c.translate(width/2, height/2);
  for (int i = 0; i < 12; i++) {
    float ph = -t*1.1 + i*0.8;
    float amp = 80 + sin(ph*2.2)*65;
    c.stroke(p[8], p[9], p[10], p[11]);
    c.strokeWeight(6);
    c.noFill();
    c.beginShape();
    for (float j = 0; j < TWO_PI; j += 0.09) {
      float r = 140 + cos(j*9 + ph*3.5)*amp;
      c.vertex(cos(j)*r, sin(j)*r);
    }
    c.endShape();
  }
  c.endDraw();

  // Zusammenbau
  background(0);
  blendMode(ADD);
  tint(255, mouseY < height/2 ? 80 : 140); image(a, -9, -6);
  tint(255, 180);                         image(b, 0, 0);
  tint(255, mouseY < height/2 ? 140 : 90); image(c, 9, 6);
  blendMode(BLEND);
  noTint();

  // Info
  fill(255, 150);
  text("mouseX = Geschwindigkeit   mouseY = Helligkeit   SPACE = Pause   s = Speichern   c = Palette wechseln   r = Reset", width-20, height-15);
}

void keyPressed() {
  if (key == ' ') paused = !paused;
  if (key == 's' || key == 'S') {
    String name = "liquid-mirror_" + year() + nf(month(),2) + nf(day(),2) + "_" + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
    saveFrame(name);
    println("Gespeichert: " + name);
  }
  if (key == 'c' || key == 'C') palette = (palette + 1) % 4;
  if (key == 'r' || key == 'R') noiseSeed((long)random(999999));
}
