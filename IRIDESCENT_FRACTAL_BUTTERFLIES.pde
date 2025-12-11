// IRIDESCENT FRACTAL BUTTERFLIES – magischer Schwarm
// Processing 4.x + PeasyCam (einmal installieren!)

import peasy.PeasyCam;

PeasyCam cam;
Butterfly[] swarm;
int num = 1200;
float t = 0;

void setup() {
  size(1400, 900, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);

  cam = new PeasyCam(this, 800);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(2000);

  swarm = new Butterfly[num];
  for (int i = 0; i < num; i++) {
    swarm[i] = new Butterfly();
  }
}

void draw() {
  t += 0.012;
  background(8, 15, 20);

  ambientLight(60, 60, 90);
  directionalLight(200, 80, 255, 0.2, 0.6, -1);

  for (Butterfly b : swarm) {
    b.update();
    b.display();
  }

  // Schiller-Glow Overlay
  cam.beginHUD();
  blendMode(ADD);
  tint(255, 60);
  image(get(), -12, -8);
  tint(255, 35);
  image(get(), 14, 10);
  blendMode(BLEND);
  noTint();

  fill(255, 220);
  textAlign(RIGHT, BOTTOM);
  textSize(18);
  text("Iridescent Fractal Butterflies | Linksziehen = drehen | Rad = zoom | s = speichern", width-30, height-20);
  cam.endHUD();
}

class Butterfly {
  PVector pos, vel, acc;
  float phase, wingSpeed, size;
  int depth;

  Butterfly() {
    pos = new PVector(random(-600, 600), random(-400, 400), random(-400, 400));
    vel = PVector.random3D().mult(random(0.5, 2));
    acc = new PVector();
    phase = random(TWO_PI);
    wingSpeed = random(0.08, 0.18);
    size = random(8, 22);
    depth = (int)random(3, 7);  // Fraktaltiefe
  }

  void update() {
    phase += wingSpeed;
    float n = noise(pos.x*0.003, pos.y*0.003, t*0.3);
    acc = PVector.fromAngle(n * TWO_PI).mult(0.08);
    vel.add(acc).limit(3);
    pos.add(vel);

    // sanftes Loopen im Raum
    if (abs(pos.x) > 800) pos.x *= -0.95;
    if (abs(pos.y) > 600) pos.y *= -0.95;
    if (abs(pos.z) > 600) pos.z *= -0.95;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(vel.heading() + HALF_PI);
    rotateX(sin(phase*4) * 0.4);  // Flügelschlag

    float hueBase = (t*20 + pos.mag()*0.15 + phase*30) % 360;
    float iridescence = sin(pos.x*0.02 + t*2) * 0.5 + 0.5;

    noStroke();
    drawFractalWing(hueBase, iridescence, depth, size);

    scale(-1, 1, 1);  // Spiegelung für zweiten Flügel
    drawFractalWing(hueBase, iridescence, depth, size);
    popMatrix();
  }

  void drawFractalWing(float hueBase, float iri, int level, float s) {
    if (level <= 0) return;

    float h1 = (hueBase + iri*120) % 360;
    float h2 = (hueBase + 180 + iri*80) % 360;

    fill(h1, 90 + iri*30, 95 + iri*25, 90);
    triangle(0, 0, s, -s*0.6, s*1.4, s*0.8);

    fill(h2, 100, 100, 80);
    triangle(0, 0, s*0.7, -s*0.3, s*1.2, s*0.5);

    // Rekursion für Fraktal-Struktur
    pushMatrix();
    translate(s*0.9, 0);
    scale(0.6);
    drawFractalWing(hueBase + 60, iri, level-1, s);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("iridescent-butterflies_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png");
  }
}
