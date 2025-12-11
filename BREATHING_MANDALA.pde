// BREATHING MANDALA – sakral & hypnotisch
// Processing 4.x – kopieren → loslassen → atmen

float t = 0;
int symmetry = 60;           // 60-fach = fast kreisrund, 12–120 möglich
float baseHue = 0;

void setup() {
  size(1200, 1200, P2D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
}

void draw() {
  t += 0.0008;   // ultra-langsam
  
  background(0, 0, 8);
  translate(width/2, height/2);
  
  // Globales Atmen
  float breatheScale = 0.9 + 0.15 * sin(t * 0.8);           // 0.9–1.05
  float breatheSat   = 20 + 80 * sin(t * 0.6 + HALF_PI);   // 20–100
  float breatheRot   = sin(t * 0.4) * 0.04;
  
  scale(breatheScale);
  rotate(t * 0.07 + breatheRot);
  
  for (int i = 0; i < symmetry; i++) {
    pushMatrix();
    rotate(i * TWO_PI / symmetry);
    
    // Farbe pro Segment + globaler Drift
    float hue = (baseHue + i*360/symmetry + t*15) % 360;
    float sat = constrain(breatheSat + sin(t + i*0.3)*30, 0, 100);
    float bri = 90 + sin(t*1.2 + i*0.2)*10;
    
    // —— Innere Kreise ——
    for (int r = 0; r < 7; r++) {
      float radius = 40 + r*55 + sin(t + i*0.5 + r)*30;
      float alpha = 15 + sin(t + r + i*0.1)*10;
      
      noFill();
      stroke(hue, sat, bri, alpha);
      strokeWeight(3 + sin(t + r*1.3)*2);
      ellipse(0, 0, radius*2, radius*2);
      
      // kleine Akzent-Kreise
      stroke((hue + 180)%360, sat*0.8, bri*1.2, alpha*1.5);
      strokeWeight(1.5);
      ellipse(0, radius*0.8, 12 + sin(t + i + r)*8, 12 + sin(t + i + r)*8);
    }
    
    // —— Blütenblätter / Strahlen ——
    int petals = 8;
    for (int p = 0; p < petals; p++) {
      pushMatrix();
      rotate(p * TWO_PI / petals + sin(t + i)*0.2);
      float len = 180 + sin(t*1.5 + i + p)*70;
      
      stroke(hue, sat*0.9, bri, 25);
      strokeWeight(6 + sin(t + p + i*0.4)*3);
      line(80, 0, 80 + len, 0);
      
      // Spitzen
      noStroke();
      fill((hue + 120)%360, sat, bri*1.1, 40);
      ellipse(80 + len, 0, 28 + sin(t + p)*12, 28 + sin(t + p)*12);
      
      popMatrix();
    }
    
    popMatrix();
  }
  
  // Extra Glow-Layer (ADD blend)
  blendMode(ADD);
  tint(255, 40);
  image(get(), -12, -10);
  tint(255, 25);
  image(get(), 14, 12);
  blendMode(BLEND);
  noTint();
  
  // UI
  fill(255, 180);
  textAlign(RIGHT, BOTTOM);
  textSize(18);
  text("Breathing Mandala | s = speichern | r = neue Welt | atme einfach mit", width-30, height-20);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String name = "breathing-mandala_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png";
    saveFrame(name);
    println("Gespeichert: "+name);
  }
  if (key == 'r' || key == 'R') {
    baseHue = random(360);
    t = 0;
    noiseSeed((long)random(999999));
  }
}
