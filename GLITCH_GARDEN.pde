// GLITCH GARDEN – optimiert + Fortschrittsbalken
// Processing 4.x – läuft jetzt spürbar flüssiger

float t = 0;
float nextGlitchIn = 0;        // Countdown bis nächster Glitch
float glitchDuration = 0;      // wie lange der aktuelle Glitch noch läuft
boolean isGlitching = false;
PGraphics garden;

void setup() {
  size(1200, 800, P2D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  
  garden = createGraphics(width, height, P2D);
  garden.smooth(8);
  garden.colorMode(HSB, 360, 100, 100, 100);
  
  resetGlitchTimer();
}

void draw() {
  t += 0.012;
  
  // Countdown managen
  if (!isGlitching) {
    nextGlitchIn -= 0.012;
    if (nextGlitchIn <= 0) {
      isGlitching = true;
      glitchDuration = 1.8;                    // Glitch dauert ca. 1,8 Sekunden
    }
  } else {
    glitchDuration -= 0.012;
    if (glitchDuration <= 0) {
      isGlitching = false;
      resetGlitchTimer();
    }
  }
  
  // Garten zeichnen (immer flüssig)
  garden.beginDraw();
  garden.background(0, 0, 8);
  garden.translate(width/2, height/2);
  drawFractalGarden(garden, 0, 0, 300 + sin(t*1.2)*45, 8, t);
  garden.endDraw();
  
  image(garden, 0, 0);
  
  // Glitch nur wenn aktiv – und jetzt deutlich schneller!
  if (isGlitching) {
    fastGlitch( map(glitchDuration, 0, 1.8, 1.0, 0) );  // Stärke von 1→0
  }
  
  // Fortschrittsbalken + Info
  drawProgressUI();
}

void resetGlitchTimer() {
  nextGlitchIn = 6 + random(8);    // nächster Glitch in 6–14 Sekunden
}

// —— viel schnellerer Glitch (weniger Pixel-Sorting) ——
void fastGlitch(float strength) {
  loadPixels();
  
  // 1. RGB-Shift
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int i = y*width + x;
      color c = pixels[i];
      
      if (random(1) < strength*0.25) {
        int offset = (int)(random(-30,30)*strength);
        int nx = constrain(x + offset, 0, width-1);
        pixels[i] = garden.pixels[y*width + nx];
      }
    }
  }
  
  // 2. Scanlines + Noise (nur jede 5. Zeile = 5× schneller)
  for (int y = 0; y < height; y += 5) {
    if (random(1) < strength*0.6) {
      for (int x = 0; x < width; x++) {
        int i = y*width + x;
        if (random(1) < 0.4) {
          pixels[i] = color(random(360), 100, 100, 200);
        } else {
          pixels[i] = lerpColor(pixels[i], color(0), 0.7);
        }
      }
    }
  }
  
  updatePixels();
}

// ——— gleicher wunderschöner Garten wie vorher ———
void drawFractalGarden(PGraphics pg, float x, float y, float r, int depth, float time) {
  if (depth == 0) return;
  
  float hue = (time*20 + depth*30 + r*0.1) % 360;
  pg.fill(hue, 60, 90, 15);
  pg.noStroke();
  pg.ellipse(x, y, r*2, r*2);
  
  pg.stroke(hue, 80, 95, 30);
  pg.strokeWeight(depth * 1.5);
  pg.noFill();
  pg.ellipse(x, y, r*2.2, r*2.2);
  
  int branches = 6 + (int)(sin(time + depth)*2);
  for (int i = 0; i < branches; i++) {
    float angle = i * TWO_PI / branches + time * 0.2;
    float nx = x + cos(angle) * r * 0.8;
    float ny = y + sin(angle) * r * 0.8;
    pg.line(x, y, nx, ny);
    drawFractalGarden(pg, nx, ny, r * 0.55, depth - 1, time + i);
  }
}

// ——— Fortschrittsanzeige ———
void drawProgressUI() {
  float barY = height - 50;
  
  // Hintergrundbalken
  noStroke();
  fill(0, 0, 0, 180);
  rect(50, barY, width-100, 16, 8);
  
  // Fortschrittsbalken
  fill(200, 80, 100);
  if (isGlitching) {
    float progress = map(glitchDuration, 0, 1.8, 0, 1);
    rect(50, barY, (width-100) * (1-progress), 16, 8);
    fill(255);
    textAlign(CENTER, CENTER);
    text("GLITCH – heilt in " + nf(glitchDuration,1,1) + "s", width/2, barY+8);
  } else {
    float progress = map(nextGlitchIn, 0, 14, 0, 1);
    rect(50, barY, (width-100) * (1-progress), 16, 8);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Ruhe – nächster Glitch in " + nf(nextGlitchIn,1,1) + "s", width/2, barY+8);
  }
  
  // Standard-Info
  fill(255, 180);
  textAlign(RIGHT, BOTTOM);
  textSize(14);
  text("Glitch Garden | s = speichern | r = neuer Garten", width-20, height-15);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("glitch-garden_" + year() + nf(month(),2) + nf(day(),2) + "_" + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png");
  }
  if (key == 'r' || key == 'R') {
    t = 0;
    resetGlitchTimer();
  }
}
