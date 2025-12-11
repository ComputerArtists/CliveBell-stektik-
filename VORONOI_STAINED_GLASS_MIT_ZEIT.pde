// VORONOI STAINED GLASS MIT ZEIT + BILD-AUSWAHL
// Processing 4.x – einfach kopieren und staunen

int numPoints = 60;                    // mehr = feiner
PVector[] points = new PVector[numPoints];
color[] cellColors = new color[numPoints];
PImage backgroundImg;                  // hier kommt dein Foto rein
boolean hasImage = false;
float t = 0;

void setup() {
  size(1200, 800, P2D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  
  initPoints();
  textAlign(RIGHT, BOTTOM);
  textSize(16);
}

void draw() {
  t += 0.004;
  background(0);
  
  // Punkte langsam bewegen + am Rand spiegeln
  for (int i = 0; i < numPoints; i++) {
    points[i].x += sin(t + i*0.8) * 1.2;
    points[i].y += cos(t*0.9 + i*0.6) * 1.2;
    if (points[i].x < 0) points[i].x = width;
    if (points[i].x > width) points[i].x = 0;
    if (points[i].y < 0) points[i].y = height;
    if (points[i].y > height) points[i].y = 0;
  }
  
  // Jede Zelle einmal berechnen und zeichnen
  for (int i = 0; i < numPoints; i++) {
    drawVoronoiCell(i);
  }
  
  // UI
  fill(255, 200);
  text("Voronoi Stained Glass | o = Bild laden | s = speichern | r = neue Punkte", width-20, height-15);
}

void initPoints() {
  for (int i = 0; i < numPoints; i++) {
    points[i] = new PVector(random(width), random(height));
  }
}

void drawVoronoiCell(int index) {
  PVector p = points[index];
  
  // Farbe bestimmen – Bild oder automatischer Verlauf
  color cellColor;
  if (hasImage && backgroundImg.width > 10) {
    int ix = constrain((int)p.x, 0, backgroundImg.width-1);
    int iy = constrain((int)p.y, 0, backgroundImg.height-1);
    cellColor = backgroundImg.get(ix, iy);
  } else {
    // wunderschöner automatischer Sonnenuntergang
    float hue = (t*15 + p.y*0.15 + index*5) % 360;
    cellColor = color(hue, 80 + sin(t + index)*20, 90, 90);
  }
  cellColors[index] = cellColor;
  
  // Zelle als Polygon berechnen (alle Pixel, die näher an p sind als an anderen Punkten)
  beginShape();
  noStroke();
  fill(cellColor);
  
  // Scan über das ganze Bild – nur die Pixel, die zu dieser Zelle gehören
  loadPixels();
  for (int x = 0; x < width; x += 4) {           // 4er-Schritte = schnell genug
    for (int y = 0; y < height; y += 4) {
      int loc = x + y*width;
      float minDist = dist(x, y, p.x, p.y);
      boolean belongs = true;
      
      for (int other = 0; other < numPoints; other++) {
        if (other == index) continue;
        if (dist(x, y, points[other].x, points[other].y) < minDist) {
          belongs = false;
          break;
        }
      }
      
      if (belongs) {
        pixels[loc] = cellColor;
        // auch die Nachbarpixel leicht mitfärben für weichere Übergänge
        if (x > 0) pixels[loc-1] = cellColor;
        if (y > 0) pixels[loc-width] = cellColor;
      }
    }
  }
  updatePixels();
  
  // Glow-Outline um jede Zelle
  stroke(red(cellColor), green(cellColor), blue(cellColor), 180);
  strokeWeight(4);
  noFill();
  drawCellOutline(index);
}

void drawCellOutline(int index) {
  PVector p = points[index];
  beginShape();
  for (float a = 0; a <= TWO_PI+0.1; a += 0.08) {
    float maxR = width;
    for (int other = 0; other < numPoints; other++) {
      if (other == index) continue;
      PVector o = points[other];
      float d = dist(p.x, p.y, o.x, o.y);
      float angleToOther = atan2(o.y - p.y, o.x - p.x);
      float diff = abs((a - angleToOther + TWO_PI) % TWO_PI);
      if (diff < 0.5 || diff > TWO_PI-0.5) {
        maxR = min(maxR, d/2);
      }
    }
    vertex(p.x + cos(a)*maxR, p.y + sin(a)*maxR);
  }
  endShape();
}

// Bild auswählen
void openFileSelector() {
  selectInput("Wähle ein Bild für das Buntglas", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Auswahl abgebrochen.");
  } else {
    backgroundImg = loadImage(selection.getAbsolutePath());
    if (backgroundImg != null) {
      backgroundImg.resize(width, height);
      hasImage = true;
      println("Bild geladen – jetzt als Buntglas sichtbar!");
    }
  }
}

void keyPressed() {
  if (key == 'o' || key == 'O') openFileSelector();
  if (key == 's' || key == 'S') {
    String name = "voronoi-stained-glass_"+(hasImage?"photo":"sunset")+"_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png";
    saveFrame(name);
    println("Gespeichert: " + name);
  }
  if (key == 'r' || key == 'R') {
    initPoints();
    hasImage = false;
  }
}
