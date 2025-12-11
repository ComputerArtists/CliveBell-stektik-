// SOFT GEOMETRY COLLAPSE – finale variierte Version
// Processing 4.x

int cols = 38;
int rows = 28;
PVector[][] points;
float[][] baseAlpha;
float t = 0;
int style = 0;                    // 0–4 = fünf verschiedene Looks
float globalNoiseScale = 0.004;   // jetzt richtig genutzt!

void setup() {
  size(1400, 1000, P2D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  resetGrid();
}

void resetGrid() {
  points = new PVector[cols+1][rows+1];
  baseAlpha = new float[cols+1][rows+1];
  float cellW = width / (float)cols;
  float cellH = height / (float)rows;

  for (int x = 0; x <= cols; x++) {
    for (int y = 0; y <= rows; y++) {
      float px = x * cellW;
      float py = y * cellH;
      // leichte Startwelligkeit je nach Stil
      points[x][y] = new PVector(px + sin(y*0.05)*15, py + sin(x*0.05)*15);
      points[x][y] = new PVector(px, py);
      baseAlpha[x][y] = 100;
    }
  }
  t = 0;
}

void draw() {
  t += 0.0008;

  background(style == 4 ? 0 : 255);

  float driftSpeed = (style == 3 || style == 4) ? 4.0 : 1.8;
  float collapseStart = (style == 32) ? 2.0 : 6.0;   // Space gedrückt = sofort

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      PVector a = points[x][y];
      PVector b = points[x+1][y];
      PVector c = points[x+1][y+1];
      PVector d = points[x][y+1];

      // Drift mit globalNoiseScale
      float nx = globalNoiseScale;
      a.add(PVector.fromAngle(noise(a.x*nx, a.y*nx, t)*TWO_PI).mult(driftSpeed));
      b.add(PVector.fromAngle(noise(b.x*nx, b.y*nx, t+100)*TWO_PI).mult(driftSpeed));
      c.add(PVector.fromAngle(noise(c.x*nx, c.y*nx, t+200)*TWO_PI).mult(driftSpeed));
      d.add(PVector.fromAngle(noise(d.x*nx, d.y*nx, t+300)*TWO_PI).mult(driftSpeed));

      // Collapse-Logik
      float centerX = (a.x + b.x + c.x + d.x) / 4;
      float centerY = (a.y + b.y + c.y + d.y) / 4;
      float distFromCenter = dist(width/2, height/2, centerX, centerY);
      float fade = (t > collapseStart) ? map(distFromCenter, 0, width*0.7, 0, 1) : 0;
      fade = constrain(fade, 0, 1);
      baseAlpha[x][y] = lerp(baseAlpha[x][y], 100 * (1 - fade*1.5), 0.02);

      // ——— Fünf komplett unterschiedliche Stile ———
      if (style == 0) {           // Klassisch pastell
        float h = 200 + sin(t + x*0.15)*60;
        fill(h, 40, 98, baseAlpha[x][y]);
        stroke(h, 60, 100, baseAlpha[x][y]*0.7);
        strokeWeight(1.2);
      } else if (style == 1) {    // Neon auf Schwarz
        float h = (t*30 + distFromCenter*0.2) % 360;
        fill(h, 90, 100, baseAlpha[x][y]);
        stroke(h, 100, 100, baseAlpha[x][y]);
        strokeWeight(2);
      } else if (style == 2) {    // Gold auf Weiß
        fill(45, 80, 98, baseAlpha[x][y]*0.8);
        stroke(45, 100, 100, baseAlpha[x][y]);
        strokeWeight(1.8);
      } else if (style == 3) {    // Chaos-Modus (schnell + wild)
        float h = noise(x*0.02, y*0.02, t*3)*360;
        fill(h, 100, 100, baseAlpha[x][y]);
        noStroke();
      } else if (style == 4) {        // Inverted: Schwarz auf Weiß mit Loch
        fill(0, 0, 0, 100 - baseAlpha[x][y]);
        stroke(0, 0, 100, baseAlpha[x][y]*0.5);
        strokeWeight(1);
      }

      quad(a.x, a.y, b.x, b.y, c.x, c.y, d.x, d.y);
    }
  }

  // sanfter Glow
  blendMode(ADD);
  tint(255, style == 4 ? 30 : 20);
  image(get(), -4, -3);
  blendMode(BLEND);
  noTint();

  // UI
  fill(style == 4 ? 255 : 0, 200);
  textAlign(RIGHT, BOTTOM);
  textSize(18);
  String[] names = {"Pastell", "Neon Night", "Golden Dream", "Chaos Mode", "Black Hole"};
  text("Soft Geometry Collapse – "+names[style]+" | 1–5 = Stil | Space = sofort zerfallen | s = speichern | r = neu", width-30, height-25);
}

void keyPressed() {
  if (key >= '1' && key <= '5') style = key - '1';
  if (key == ' ') t = 100;                         // sofortiger Collapse
  if (key == 's' || key == 'S') {
    String[] names = {"pastell", "neon", "gold", "chaos", "blackhole"};
    saveFrame("soft-collapse_"+names[style]+"_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png");
  }
  if (key == 'r' || key == 'R') resetGrid();
}
