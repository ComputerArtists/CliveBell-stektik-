// NEON TOPOGRAPHY – korrigiert für Processing 4.x
import peasy.PeasyCam;

PeasyCam cam;
float t = 0;
int palette = 0;

void setup() {
  size(1400, 900, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);

  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(300);
  cam.setMaximumDistance(3000);
}

void draw() {
  t += 0.008;
  background(0, 0, 8);

  directionalLight(180, 60, 100, -0.5, 0.8, -1);
  ambientLight(20, 20, 40);

  rotateX(PI/3.2);
  translate(-width*0.8, -height*0.8, -300);

  int steps = 60;
  float zStep = 12;

  color[][] palettes = {
    {color(180,100,100), color(200,90,100), color(320,100,100)}, // Cyan-Magenta
    {color(15,100,100),  color(330,90,100), color(300,100,90)},  // Orange-Pink
    {color(90,100,100),  color(140,90,100), color(60,100,100)}   // Lime-Purple
  };
  color[] pal = palettes[palette];

  for (int z = 0; z < steps; z++) {
    float n = noise(z * 0.04, t * 0.5) * 1.8;
    float level = z * zStep + sin(t + z*0.1)*60;
    float thickness = map(z, 0, steps, 8, 1.5);

    // korrigierte Zeile – kein "color c =" mehr!
    color lineColor = lerpColor(lerpColor(pal[0], pal[1], n), pal[2], n);
    lineColor = lerpColor(lineColor, color(200,0,100), 0.3);  // leichter Magenta-Schimmer

    stroke(lineColor);
    strokeWeight(thickness + sin(t*2 + z*0.2)*1.5);
    noFill();

    beginShape(QUAD_STRIP);
    for (float x = 0; x <= width*1.8; x += 20) {
      float y1 = noise((x + t*80)*0.003, z*0.08) * 400;
      float y2 = noise((x + width + t*80)*0.003, z*0.08) * 400;

      vertex(x, y1, level);
      vertex(x, y2, level + zStep*0.6);
    }
    endShape();
  }

  // Neon-Glow Overlay
  cam.beginHUD();
  blendMode(ADD);
  tint(255, 60);
  image(get(), -14, -10);
  tint(255, 30);
  image(get(), 18, 14);
  blendMode(BLEND);
  noTint();

  fill(255, 220);
  textAlign(RIGHT, BOTTOM);
  textSize(18);
  text("Neon Topography | Linksziehen = drehen | Rad = zoom | c = Palette | s = speichern", width-30, height-20);
  cam.endHUD();
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String[] names = {"cyan-magenta", "orange-pink", "lime-purple"};
    saveFrame("neon-topography_"+names[palette]+"_"+year()+nf(month(),2)+nf(day(),2)+"_"+nf(hour(),2)+nf(minute(),2)+nf(second(),2)+".png");
  }
  if (key == 'c' || key == 'C') palette = (palette + 1) % 3;
}
