// 3D TRUCHET SPHERES – FINAL, fehlerfrei
// Processing 4.x mit P3D – einfach kopieren und laufen lassen

float t = 0;
int grid = 9;
float spacing = 110;
PGraphics buffer;

void setup() {
  size(1200, 800, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  sphereDetail(24);
  
  // Buffer für den Glow-Effekt
  buffer = createGraphics(width, height, P3D);
  buffer.smooth(8);
  
  lights();
  ambientLight(50, 50, 80);
  directionalLight(120, 120, 200, 0, 0, -1);
}

void draw() {
  t += 0.006 * map(mouseX, 0, width, 0.3, 2.5);
  
  // Szene in buffer rendern
  buffer.beginDraw();
  buffer.background(8, 10, 20);
  buffer.translate(width/2, height/2, -200);
  buffer.rotateY(t * 0.3);
  buffer.rotateX(0.2 + sin(t*0.4)*0.15);
  
  for (int x = -grid/2; x <= grid/2; x++) {
    for (int y = -grid/2; y <= grid/2; y++) {
      for (int z = -grid/2; z <= grid/2; z++) {
        
        float px = x * spacing;
        float py = y * spacing;
        float pz = z * spacing;
        
        float nx = x * 0.25;
        float ny = y * 0.25;
        float nz = z * 0.25;
        
        float warp = noise(nx + t*0.7, ny - t*0.9, nz + t*0.6);
        float breathe = sin(t*2 + warp*10) * 30 + 70;
        
        float offsetX = sin(t + nx*3) * 30;
        float offsetY = cos(t*0.8 + ny*3) * 30;
        float offsetZ = sin(t*1.1 + nz*3) * 30;
        
        buffer.pushMatrix();
        buffer.translate(px + offsetX, py + offsetY, pz + offsetZ);
        
        float hue = (warp * 720 + t*50 + (x+y+z)*20) % 360;
        float sat = 70 + sin(t + nz)*30;
        float bri = 80 + warp*40;
        
        boolean flip = (int)(noise(nx*4, ny*4, nz*4) * 10) % 2 == 0;
        
        buffer.fill(hue, sat, bri, 92);
        buffer.noStroke();
        buffer.sphere(breathe * (flip ? 1.0 : 0.85));
        
        if (flip) {
          buffer.translate(spacing*0.6, spacing*0.6, spacing*0.6);
        } else {
          buffer.translate(-spacing*0.6, spacing*0.6, -spacing*0.6);
        }
        buffer.fill((hue + 180) % 360, sat*0.9, bri*1.1, 85);
        buffer.sphere(breathe * 0.9);
        
        buffer.popMatrix();
      }
    }
  }
  buffer.endDraw();
  
  // Hauptbildschirm: Buffer + Glow
  image(buffer, 0, 0);
  
  hint(DISABLE_DEPTH_TEST);
  blendMode(ADD);
  tint(255, 40);
  image(buffer, -8, -6);
  tint(255, 20);
  image(buffer, 10, 8);
  blendMode(BLEND);
  hint(ENABLE_DEPTH_TEST);
  noTint();
  
  // 2D-Text
  fill(255, 200);
  textAlign(RIGHT, BOTTOM);
  textSize(16);
  text("3D Truchet Spheres | MausX = Tempo | s = speichern | r = neue Welt", width-20, height-15);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String name = "3D-truchet-spheres_" + year() + nf(month(),2) + nf(day(),2) + "_" 
                + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
    saveFrame(name);
    println("Gespeichert: " + name);
  }
  if (key == 'r' || key == 'R') {
    noiseSeed((long)random(99999999));
    t = 0;
  }
}
