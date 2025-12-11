// TRUCHET CIRCLES – weich & organisch (korrigierte Version)
// Processing 4.x – einfach kopieren → läuft perfekt

int tileSize = 70;
float t = 0;

void setup() {
  size(1200, 800, P2D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
}

void draw() {
  // Geschwindigkeit mit Maus steuern
  t += 0.009 * map(mouseX, 0, width, 0.2, 3.0);
  background(0);
  
  for (int gx = -1; gx < width/tileSize + 2; gx++) {
    for (int gy = -1; gy < height/tileSize + 2; gy++) {
      
      float x = gx * tileSize;
      float y = gy * tileSize;
      
      pushMatrix();
      translate(x, y);
      
      // Organische Verzerrung
      float nx = gx * 0.31;
      float ny = gy * 0.31;
      float warpX = (noise(nx + t*0.8, ny - t*0.6) - 0.5) * 45;
      float warpY = (noise(nx - t*0.7, ny + t*0.9) - 0.5) * 45;
      translate(warpX, warpY);
      
      // Leichte Rotation
      float rot = noise(nx + 200, ny + 200) * TWO_PI * 0.8;
      rotate(rot);
      
      // Fließende Farbe
      float hue = (noise(nx*0.8, ny*0.8, t*0.2) * 720 + t*40) % 360;
      float sat = 60 + noise(nx+100, ny+100) * 40;
      float bri = 85 + sin(t*1.5 + gx*0.3 + gy*0.4) * 15;
      
      fill(hue, sat, bri, 92);
      
      // Zwei Truchet-Varianten mit Kreisen
      boolean flip = noise(nx*3, ny*3) > 0.5;
      
      if (flip) {
        ellipse(0, 0, tileSize*1.7, tileSize*1.7);
        ellipse(tileSize, tileSize, tileSize*1.7, tileSize*1.7);
      } else {
        ellipse(tileSize, 0, tileSize*1.7, tileSize*1.7);
        ellipse(0, tileSize, tileSize*1.7, tileSize*1.7);
      }
      
      popMatrix();
    }
  }
  
  // Weicher Glow
  blendMode(ADD);
  tint(255, 40);
  image(get(), -5, -4);
  tint(255, 25);
  image(get(), 6, 5);
  blendMode(BLEND);
  noTint();
  
  // Info
  fill(255, 140);
  textAlign(RIGHT, BOTTOM);
  text("Truchet Circles | MausX = Tempo | s = speichern | r = neue Welt", width-20, height-15);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String name = "truchet-circles_" + year() + nf(month(),2) + nf(day(),2) + "_" 
                + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
    saveFrame(name);
    println("Gespeichert: " + name);
  }
  if (key == 'r' || key == 'R') {
    noiseSeed((long)random(999999));
    t = 0;
  }
}
