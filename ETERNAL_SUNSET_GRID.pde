// ETERNAL SUNSET GRID – 8 Traumwelten Edition
// Processing 4.x + PeasyCam

import peasy.PeasyCam;

PeasyCam cam;
float t = 0;
int world = 0;  // 0-7 = 8 verschiedene Welten

void setup() {
  size(1400, 900, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);

  cam = new PeasyCam(this, 1200);
  cam.setMinimumDistance(300);
  cam.setMaximumDistance(3500);
}

void draw() {
  t += 0.007;
  background(0);

  // Beleuchtung je nach Welt
  if (world == 7) ambientLight(10,10,20);
  else ambientLight(40,30,60);
  directionalLight(30,70,100, 0.4,1,-0.7);

  rotateX(PI/3.6 + sin(t*0.3)*0.1);
  translate(-width*0.9, -height*1.3, -1000);

  int gridSize = 45;
  float spacing = 90;
  float speed = map(mouseX, 0, width, 1, 15);  // MausX steuert Scroll-Speed

  // 8 Welten – komplett unterschiedliche Stimmungen
  String[] names = {
    "Classic Sunset", "Cotton Candy", "Blood Moon", "Arctic Fire",
    "Miami Vice", "Cyber Peach", "Golden Hour Extreme", "Midnight Aurora"
  };

  float[][] palettes = {
    {15, 330, 280},   // Classic: Orange-Pink-Violett
    {300, 340, 270},  // Cotton Candy
    {0, 20, 340},     // Blood Moon
    {180, 60, 300},   // Arctic Fire
    {310, 200, 180},  // Miami Vice
    {20, 340, 280},   // Cyber Peach
    {35, 45, 55},     // Golden Hour Extreme
    {120, 180, 240}   // Midnight Aurora
  };

  float[] pal = palettes[world];

  for (int x = -gridSize; x <= gridSize; x++) {
    for (int z = -gridSize; z <= gridSize; z++) {
      float px = x * spacing;
      float pz = z * spacing + (t * speed * 120) % (spacing*2);

      // Höhe mit Welt-spezifischen Wellen
      float wave1 = sin(x*0.04 + t*0.9) * 120;
      float wave2 = cos(z*0.03 - t*1.3) * 100;
      float wave3 = sin((x+z)*0.02 + t*2) * (world == 6 ? 300 : 80);
      float py = wave1 + wave2 + wave3;

      // Farbe je nach Welt
      float h, s = 85, b = 95;
      if (world == 0)      h = lerp(pal[0], pal[1], sin(t + x*0.05)*0.5+0.5);
      else if (world == 1) h = (t*20 + py*0.2) % 360;
      else if (world == 2) h = map(py, -200, 200, 0, 40);
      else if (world == 3) h = map(sin(t + x*0.1), -1, 1, 160, 340);
      else if (world == 4) h = (t*30 + z*0.1) % 360;
      else if (world == 5) h = lerp(pal[0], pal[2], cos(t + z*0.08)*0.5+0.5);
      else if (world == 6) h = 30 + sin(t*3 + x*0.02)*25;  // super intensives Gold
      else                 h = (py*0.3 + t*15) % 360;     // Aurora

      strokeWeight(world == 6 ? 7 : 3.5 + sin(t*2 + x*0.1)*2);
      stroke(h, s + sin(t + z*0.1)*15, b + sin(t*1.5)*10, 220);

      point(px, py - 800, pz);

      // horizontale Linien
      if (x < gridSize) {
        float nx = (x+1)*spacing;
        float ny = sin((x+1)*0.04 + t*0.9)*120 + cos(z*0.03 - t*1.3)*100 + wave3;
        stroke(h+20, s*0.9, b*1.1, 180);
        line(px, py-800, pz, nx, ny-800, pz);
      }
    }
  }

  // Nebel + Glow
  cam.beginHUD();
  blendMode(ADD);
  tint(pal[0], 70, 90, 60);
  image(get(), -25, -18);
  tint(pal[1], 60, 100, 40);
  image(get(), 30, 22);
  blendMode(BLEND);
  noTint();

  fill(255, 230);
  textAlign(RIGHT, BOTTOM);
  textSize(22);
  text("Eternal Sunset Grid – " + names[world] +
       " | 1-8 Welt | MausX = Geschwindigkeit | s = speichern", width-40, height-30);
  cam.endHUD();
}

void keyPressed() {
  if (key >= '1' && key <= '8') world = key - '1';
  if (key == 's' || key == 'S') {
    String[] files = {"classic","cotton","bloodmoon","arctic","miami","cyber","golden","aurora"};
    saveFrame("eternal-sunset_"+files[world]+"_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png");
  }
}
