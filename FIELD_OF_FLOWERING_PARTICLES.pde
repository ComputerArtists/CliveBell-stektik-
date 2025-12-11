// FIELD OF FLOWERING PARTICLES – poetischer Frühlingsflow
// Processing 4.x – kopieren → F5 → blühe auf

int numParticles = 2000;              // Anzahl Blüten (mehr = dichter)
Particle[] particles = new Particle[numParticles];
float t = 0;

void setup() {
  size(1200, 800, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  smooth(8);
  
  // Partikel initialisieren
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
  
  blendMode(ADD);                       // für den zarten Glow
  noStroke();
}

void draw() {
  t += 0.003 * map(mouseX, 0, width, 0.1, 2.0);  // MausX = Flow-Geschwindigkeit
  
  background(0, 0, 10, 50);             // langsames Verblassen für Trails
  
  for (int i = 0; i < numParticles; i++) {
    particles[i].update(t);
    particles[i].display();
  }
  
  // Leichter globaler Glow
  blendMode(ADD);
  tint(255, 30);
  image(get(), -4, -3);
  blendMode(BLEND);
  noTint();
  
  // Info
  fill(255, 150);
  textAlign(RIGHT, BOTTOM);
  textSize(16);
  text("Field of Flowering Particles | MausX = Flow | s = speichern | r = neue Blüten", width-20, height-15);
}

// Partikel-Klasse
class Particle {
  PVector pos;
  PVector vel;
  float life = 0;                       // für Aufblühen
  float hueBase;
  
  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D().mult(2);
    hueBase = random(360);
  }
  
  void update(float globalT) {
    // Noise-Flowfield für sanfte, organische Bewegung
    float angle = noise(pos.x * 0.005, pos.y * 0.005, globalT) * TWO_PI * 2;
    PVector force = new PVector(cos(angle), sin(angle));
    force.mult(0.8 + sin(globalT + pos.y * 0.01) * 0.5);  // variable Stärke
    
    vel.add(force).limit(3);
    pos.add(vel);
    
    // Wrap around edges
    if (pos.x < 0) pos.x = width;
    if (pos.x > width) pos.x = 0;
    if (pos.y < 0) pos.y = height;
    if (pos.y > height) pos.y = 0;
    
    // Life für Blüten-Aufblühen
    life = sin(globalT * 2 + pos.x * 0.01) * 0.5 + 0.5;  // 0–1 pulsierend
  }
  
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    
    // Farbe: Pastell zu Neon je nach Life
    float hue = (hueBase + life * 120) % 360;
    float sat = 40 + life * 60;           // von Pastell zu satt
    float bri = 70 + life * 30;
    float alpha = 60 + life * 40;
    
    // Aufblühen-Stufen
    float bloomSize = life * 25 + 5;      // von Punkt zu Blüte
    
    if (life < 0.3) {
      // Stufe 1: Punkt
      fill(hue, sat * 0.5, bri, alpha);
      ellipse(0, 0, bloomSize, bloomSize);
    } else if (life < 0.7) {
      // Stufe 2: Kreis
      fill(hue, sat, bri, alpha);
      ellipse(0, 0, bloomSize * 2, bloomSize * 2);
    } else {
      // Stufe 3: Blüte mit 5–8 Blättern
      int petals = 5 + (int)(life * 3);     // 5–8 Blätter
      float petalSize = bloomSize * 1.5;
      
      for (int p = 0; p < petals; p++) {
        pushMatrix();
        rotate(p * TWO_PI / petals + t * 0.5);  // leichte Rotation
        fill((hue + p * 30) % 360, sat, bri * (1 - p * 0.1), alpha);
        
        // Blütenblatt als Ellipse
        ellipse(petalSize * 0.6, 0, petalSize, petalSize * 0.6);
        popMatrix();
      }
      
      // Mittelpunkt
      fill(hue, sat * 0.8, bri * 1.2, alpha * 1.5);
      ellipse(0, 0, bloomSize * 0.8, bloomSize * 0.8);
    }
    
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String name = "flowering-field_" + year() + nf(month(),2) + nf(day(),2) + "_" + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
    saveFrame(name);
    println("Gespeichert: " + name);
  }
  if (key == 'r' || key == 'R') {
    for (int i = 0; i < numParticles; i++) {
      particles[i] = new Particle(random(width), random(height));  // neue Blüten
    }
    t = 0;
  }
}
