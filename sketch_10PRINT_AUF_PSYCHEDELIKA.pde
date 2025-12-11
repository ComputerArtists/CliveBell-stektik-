// 10PRINT AUF PSYCHEDELIKA – finale saubere Version
// Processing 4.x – läuft sofort

int cell = 24;
float t = 0;

void setup() {
  size(1200, 800, P2D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  strokeCap(SQUARE);
}

void draw() {
  t += 0.004 * map(mouseX, 0, width, 0.2, 4.0);   // Maus = Tempo
  
  background(0);
  blendMode(ADD);
  
  for (int x = 0; x <= width + cell; x += cell) {
    for (int y = 0; y <= height + cell; y += cell) {
      pushMatrix();
      translate(x, y);
      
      float n = noise(x*0.008, y*0.008, t*0.3);
      boolean backslash = n > 0.5;
      
      float hue = (n*900 + t*40 + x*0.03 + y*0.02) % 360;
      float sat = 70 + sin(t + n*10)*30;
      float bri = 80 + sin(t*1.3 + x*0.02)*20;
      
      stroke(hue, sat, bri, 70);
      strokeWeight(4 + sin(t + n*8)*2.5);
      rotate(sin(t*0.5 + n*12)*0.3);
      
      if (backslash) {
        line(4, 4, cell-4, cell-4);        // \
      } else {
        line(4, cell-4, cell-4, 4);        // /
      }
      
      popMatrix();
    }
  }
  
  // Glow / Depth-of-Field
  blendMode(ADD);
  tint(255, 40);  image(get(), -6, -4);
  tint(255, 25);  image(get(),  8,  6);
  blendMode(BLEND);
  noTint();
  
  // Info
  fill(255, 180);
  textAlign(RIGHT, BOTTOM);
  textSize(16);
  text("10PRINT auf Psychedelika | s = speichern | r = neue Welt", width-20, height-15);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("10print-psy_" + year() + nf(month(),2) + nf(day(),2) + "_" + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png");
  }
  if (key == 'r' || key == 'R') {
    noiseSeed((long)random(99999999));
    t = 0;
  }
}
