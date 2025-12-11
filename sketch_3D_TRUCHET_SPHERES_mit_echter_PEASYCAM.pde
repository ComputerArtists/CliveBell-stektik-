// 3D TRUCHET SPHERES mit echter PEASYCAM – FINAL & LEHRREICH
// Processing 4.x + Bibliothek "PeasyCam" (einmalig installieren!)

import peasy.PeasyCam;        // ← RICHTIG geschrieben: PeasyCam

PeasyCam cam;
float t = 0;
int grid = 9;
float spacing = 130;

void setup() {
  size(1200, 800, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  sphereDetail(28);

  // Kamera starten
  cam = new PeasyCam(this, 900);     // Abstand zum Ursprung
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(2500);

  // Beleuchtung
  ambientLight(60, 60, 90);
  directionalLight(180, 180, 255, 0, 0, -1);
}

void draw() {
  t += 0.008 * map(mouseX, 0, width, 0.2, 2.5);
  background(8, 12, 25);

  // ——— Hier passiert die ganze Magie ———
  for (int x = -grid/2; x <= grid/2; x++) {
    for (int y = -grid/2; y <= grid/2; y++) {
      for (int z = -grid/2; z <= grid/2; z++) {

        float px = x * spacing;
        float py = y * spacing;
        float pz = z * spacing;

        float nx = x * 0.22;
        float ny = y * 0.22;
        float nz = z * 0.22;

        float warp = noise(nx + t*0.8, ny - t*0.9, nz + t*0.6);
        float breathe = sin(t*2.5 + warp*12) * 32 + 72;

        float ox = sin(t*1.3 + nx*4) * 28;
        float oy = cos(t*0.9 + ny*4) * 28;
        float oz = sin(t*1.1 + nz*4) * 28;

        pushMatrix();
        translate(px + ox, py + oy, pz + oz);

        float hue = (warp * 800 + t*60 + (x+y+z)*15) % 360;
        float sat = 75 + sin(t + nz*2)*25;
        float bri = 85 + warp*35;

        boolean flip = noise(nx*5, ny*5, nz*5) > 0.5;

        fill(hue, sat, bri, 94);
        noStroke();
        sphere(breathe * (flip ? 1.0 : 0.88));

        if (flip) {
          translate(spacing*0.65, spacing*0.65, spacing*0.65);
        } else {
          translate(-spacing*0.65, spacing*0.55, -spacing*0.7);
        }
        fill((hue + 160) % 360, sat*0.95, bri*1.15, 88);
        sphere(breathe * 0.92);

        popMatrix();
      }
    }
  }

  // Glow + HUD
  cam.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  blendMode(ADD);
  tint(255, 50);
  image(get(), -10, -8);
  tint(255, 30);
  image(get(), 12, 10);
  blendMode(BLEND);
  hint(ENABLE_DEPTH_TEST);

  fill(255, 220);
  textAlign(RIGHT, BOTTOM);
  textSize(16);
  text("PeasyCam 3D Truchet Spheres | Links-Ziehen = Drehen | Rad = Zoom | s = speichern | r = neue Welt", 
       width-20, height-15);
  cam.endHUD();
}

void keyPressed() {
  if (key == 's' || key == 'S') saveFrame("truchet3D_" + nf(frameCount, 5) + ".png");
  if (key == 'r' || key == 'R') {
    noiseSeed((long) random(999999));
    t = 0;
  }
}
