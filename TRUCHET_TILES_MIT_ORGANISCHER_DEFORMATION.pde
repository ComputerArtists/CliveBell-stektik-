// TRUCHET TILES MIT ORGANISCHER DEFORMATION
// Processing 4.x – sofort lauffähig, wunderschön hypnotisch

int tileSize = 60;
float time = 0;

void setup() {
  size(1200, 800, P2D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  strokeCap(SQUARE);
}

void draw() {
  time += 0.007;
  background(0);
  
  for (int x = 0; x < width + tileSize; x += tileSize) {
    for (int y = 0; y < height + tileSize; y += tileSize) {
      
      pushMatrix();
      translate(x, y);
      
      // Organische Deformation mit Perlin-Noise
      float nx = x * 0.004;
      float ny = y * 0.004;
      float deformX = noise(nx + time, ny + time*0.7) * 2 - 1;
      float deformY = noise(nx - time*0.8, ny + time) * 2 - 1;
      float deformAmount = 18;
      translate(deformX * deformAmount, deformY * deformAmount);
      
      // Leichte Rotation durch Noise
      float rot = noise(nx + 100, ny + 100) * TWO_PI;
      rotate(rot);
      
      // Zufälliger Truchet-Typ (0 oder 1)
      boolean type = (int)(noise(nx*0.5, ny*0.5) * 8) % 2 == 0;
      
      // Farbe fließend über Zeit & Position
      float hue = (noise(nx, ny, time*0.3) * 360 + time*30) % 360;
      float sat = 40 + noise(nx+200, ny+200) * 60;
      float bri = 80 + sin(time + nx*5) * 20;
      
      stroke(hue, sat, bri, 90);
      strokeWeight(9 + sin(time*2 + x*0.01)*4);
      noFill();
      
      // Truchet-Bögen zeichnen
      if (type) {
        arc(0, 0, tileSize*2, tileSize*2, 0, HALF_PI);
        arc(tileSize, tileSize, tileSize*2, tileSize*2, PI, PI+HALF_PI);
      } else {
        arc(tileSize, 0, tileSize*2, tileSize*2, HALF_PI, PI);
        arc(0, tileSize, tileSize*2, tileSize*2, PI+HALF_PI, TWO_PI);
      }
      
      popMatrix();
    }
  }
  
  // Leichter Glow-Effekt durch zweiten Durchlauf
  blendMode(ADD);
  tint(255, 30);
  image(get(), -3, -2);
  tint(255, 20);
  image(get(), 4, 3);
  blendMode(BLEND);
  noTint();
  
  // Info
  fill(255, 120);
  textAlign(RIGHT,BOTTOM);
  text("Truchet-Tiles mit organischer Deformation | s = speichern | r = neue Seed", width-20, height-15);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String name = "truchet-organic_" + year() + nf(month(),2) + nf(day(),2) + "_" + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
    saveFrame(name);
    println("Gespeichert: " + name);
  }
  if (key == 'r' || key == 'R') {
    noiseSeed((long)random(999999));
    time = 0;
  }
}
