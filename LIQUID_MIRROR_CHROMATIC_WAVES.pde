// LIQUID MIRROR / CHROMATIC WAVES – 100% fehlerfrei
// Processing 4.x

PGraphics a, b, c;
float t = 0;
int mood = 0;  // 0=silber, 1=gold, 2=holo, 3=deep purple
String[] names = {"Silber-Chrom", "Gold", "Holographic", "Deep Purple"};  // jetzt definiert!

void setup() {
  size(1200, 800, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  smooth(8);
  
  a = createGraphics(width, height, P2D);
  b = createGraphics(width, height, P2D);
  c = createGraphics(width, height, P2D);
  a.colorMode(HSB,360,100,100,100);
  b.colorMode(HSB,360,100,100,100);
  c.colorMode(HSB,360,100,100,100);
}

void draw() {
  t += 0.00035 * map(mouseX, 0, width, 0.2, 3.5);
  
  float[][] moods = {
    {0,70,90,22,  160,70,90,20,  240,80,95,24},    // Silber-Chrom
    {25,95,98,24,  45,95,94,22,  15,70,90,18},     // Gold
    {270,90,90,26, 170,90,92,22,  80,90,98,24},    // Holo
    {280,85,75,20, 320,90,85,22,  200,90,90,26}    // Deep Purple
  };
  float[] m = moods[mood];

  // Layer A
  a.beginDraw(); a.background(0);
  a.translate(width/2, height/2);
  for(int i=0; i<16; i++){
    float ph = t*1.4 + i*0.8;
    float amp = 100 + sin(ph*1.8)*70;
    a.stroke(m[0], m[1], m[2], m[3]);
    a.strokeWeight(6 + sin(ph)*3);
    a.noFill();
    a.beginShape();
    for(float j=0; j<TWO_PI; j+=0.06){
      float r = 140 + sin(j*12 + ph*5)*amp;
      a.vertex(cos(j)*r, sin(j)*r);
    }
    a.endShape();
  }
  a.endDraw();

  // Layer B
  b.beginDraw(); b.background(0);
  b.translate(width/2, height/2);
  for(int i=0; i<18; i++){
    float ph = t*0.9 - i*0.6;
    float amp = 110 + cos(ph*2)*80;
    b.stroke(m[4], m[5], m[6], m[7]);
    b.strokeWeight(5);
    b.noFill();
    b.ellipse(0,0, 320 + sin(ph*4)*amp, 320 + cos(ph*4)*amp);
  }
  b.endDraw();

  // Layer C
  c.beginDraw(); c.background(0);
  c.translate(width/2, height/2);
  for(int i=0; i<14; i++){
    float ph = -t*1.2 + i*0.9;
    float amp = 90 + sin(ph*2.3)*75;
    c.stroke(m[8], m[9], m[10], m[11]);
    c.strokeWeight(7);
    c.noFill();
    c.beginShape();
    for(float j=0; j<TWO_PI; j+=0.07){
      float r = 160 + cos(j*10 + ph*4)*amp;
      c.vertex(cos(j)*r, sin(j)*r);
    }
    c.endShape();
  }
  c.endDraw();

  // Zusammenbau
  background(5, 5, 20);
  blendMode(ADD);
  tint(255, mouseY < height/2 ? 70 : 130); image(a, -11, -7);
  tint(255, 190);                         image(b, 0, 0);
  tint(255, mouseY < height/2 ? 130 : 70); image(c, 11, 7);
  blendMode(BLEND);
  noTint();

  // UI
  fill(255, 180);
  textAlign(RIGHT, BOTTOM);
  textSize(16);
  text("Liquid Mirror – "+names[mood]+" | MausX = Tempo | MausY = Helligkeit | c = Mood | s = speichern", 
       width-20, height-15);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String filename = "liquid-mirror_"+names[mood].toLowerCase().replace(" ", "-")+
                      "_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png";
    saveFrame(filename);
    println("Gespeichert: "+filename);
  }
  if (key == 'c' || key == 'C') mood = (mood+1)%4;
}
