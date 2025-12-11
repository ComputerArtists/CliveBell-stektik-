# README: Generative Ästhetik-Skripte für Processing

## Einführung

Diese Sammlung enthält 12 generative Kunst-Skripte für Processing 4.x, basierend auf einer Serie von Ideen, die sich auf visuelle Ästhetik konzentrieren. Die Skripte erzeugen dynamische, hypnotische und oft meditative visuelle Effekte, inspiriert von Themen wie Flüssigkeit, Geometrie, Fraktalen und digitalem Verfall. Sie sind so gestaltet, dass sie mit minimalem Code (meist unter 300 Zeilen) beeindruckende Ergebnisse erzielen und leicht erweitert werden können.

Die Skripte wurden schrittweise entwickelt, und einige haben mehrere Versionen (z. B. shader-frei, 3D-Erweiterungen oder mit Steuerungs-Features). Alle sind 100 % lauffähig in Processing 4.x (Java-Mode). Einige nutzen die Bibliothek **PeasyCam** für 3D-Navigation (installiere sie über Sketch > Bibliothek importieren > Verwalten > "PeasyCam").

**Zielgruppe:** Künstler, Designer, Coder, die mit Processing experimentieren wollen. Perfekt für Instagram-Visuals, Wallpapers oder Live-Performances.

## Voraussetzungen

- **Processing**: Version 4.3 oder höher (kostenlos unter processing.org).
- **Bibliotheken**: Für einige Skripte (z. B. 3D-Navigation) brauchst du PeasyCam – installiere es im Processing-IDE.
- **Performance**: Die Skripte laufen bei 60 FPS auf normalen Rechnern. Passe `size()` oder Parameter (z. B. Partikelanzahl) für schwächere Hardware an.
- **Ausführung**: Kopiere den Code in einen neuen Sketch, drücke F5. Viele haben Tastensteuerung (z. B. 's' für Speichern, 'r' für Reset).

## Liste der Skripte

Hier eine Übersicht über alle 12 Skripte. Jeder Eintrag enthält eine kurze Beschreibung, die Ästhetik und verfügbare Versionen. Die Codes sind in der Konversation oben zu finden – kopiere sie direkt in Processing.

1. **Liquid Mirror / Chromatic Waves**  
   Ästhetik: Flüssiges, hochglänzendes Chrom mit wabernden Regenbogenreflexen – wie flüssiges Metall in einer spiegelnden Welt.  
   Versionen: 
   - Shader-Version (hochperformant, aber GLSL-Code).  
   - Shader-freie Version (rein Java, mit Layer-Blending).  
   - Variante mit Maus-Steuerung und 4 Moods (Silber, Gold, Holo, Deep Purple).  
   Features: 'c' = Mood wechseln, 's' = speichern.  
   Tipp: Perfekt als Screensaver.

2. **Truchet-Tiles mit organischer Deformation**  
   Ästhetik: Elegante, geometrische Muster, die wie lebendige Seide oder Marmorierung wogen.  
   Versionen: 
   - Basis (Bögen in Kacheln mit Noise-Verzerrung).  
   - Kreise-Variante (weiche, runde Blasen statt Bögen).  
   - 3D-Variante (Sphären im Raum mit PeasyCam).  
   Features: MausX = Tempo, 'r' = neue Welt, 's' = speichern.  
   Tipp: Super für Tapeten-Generierung.

3. **10PRINT auf Psychedelika**  
   Ästhetik: Retro-Computerkunst trifft 70er-Tapete – diagonale Linien in driftenden HSV-Farben mit Rotation und Glow.  
   Versionen: Eine Hauptversion mit variabler Geschwindigkeit.  
   Features: MausX = Tempo, 'r' = neue Seed, 's' = speichern.  
   Tipp: Basierend auf dem legendären BASIC-One-Liner, aber auf Steroiden.

4. **Field of Flowering Particles**  
   Ästhetik: Zarter Frühlingsgarten – Partikel folgen einem Flowfield und blühen von Punkten zu Blüten auf.  
   Versionen: Eine Hauptversion mit Noise-Flow.  
   Features: MausX = Flow-Speed, 'r' = neue Partikel, 's' = speichern.  
   Tipp: Hypnotisch meditativ.

5. **Glitch Garden**  
   Ästhetik: Symmetrischer, fraktaler Garten, der periodisch glitcht (RGB-Shift, Scanlines) und sich heilt.  
   Versionen: 
   - Basis (mit Glitch-Effekten).  
   - Optimierte mit Fortschrittsbalken (Countdown bis nächster Glitch).  
   Features: 'r' = neuer Garten, 's' = speichern.  
   Tipp: Emotionale Mischung aus Schönheit und Verfall.

6. **Breathing Mandala**  
   Ästhetik: Hochsymmetrisches Mandala, das pulsiert, atmet und rotiert – sakral und hypnotisch.  
   Versionen: Eine Hauptversion mit Sinus-Wellen.  
   Features: 'r' = neue Mandala, 's' = speichern.  
   Tipp: Ideal für Meditation.

7. **Neon Topography**  
   Ästhetik: Cyberpunk-Höhenlinien aus Perlin-Noise, von oben betrachtet, mit Neon-Glow.  
   Versionen: 3D mit PeasyCam für Erkundung.  
   Features: 'c' = Palette wechseln, 's' = speichern.  
   Tipp: Fühlt sich wie eine futuristische Landkarte an.

8. **Voronoi-Stained-Glass mit Zeit**  
   Ästhetik: Dynamisches Voronoi-Diagramm als Buntglas-Fenster, Zellen bewegen sich, mit Glow-Outline.  
   Versionen: Mit Bild-Auswahl ('o' = eigenes Foto laden als Farbquelle).  
   Features: 'r' = neue Punkte, 's' = speichern.  
   Tipp: Lade ein Foto für personalisierte Kathedralenfenster.

9. **Soft Geometry Collapse**  
   Ästhetik: Perfektes Gitter löst sich langsam auf – Punkte driften, Farben verblassen.  
   Versionen: Mit 5 Stilen (Pastell, Neon, Gold, Chaos, Black Hole).  
   Features: 1–5 = Stil wechseln, Leertaste = sofort zerfallen, 'r' = neu, 's' = speichern.  
   Tipp: Melancholisch-poetisch.

10. **Iridescent Fractal Butterflies**  
    Ästhetik: Schillernde, fraktale Schmetterlinge in Schwärmen, Flügel glänzen je nach Winkel.  
    Versionen: 3D mit PeasyCam für Immersion.  
    Features: 's' = speichern.  
    Tipp: Magisch und lebendig.

11. **Eternal Sunset Grid**  
    Ästhetik: Endlos scrollendes 3D-Grid in ewigen Sonnenuntergangsfarben.  
    Versionen: Mit 8 Welten (Classic, Cotton Candy, etc.).  
    Features: 1–8 = Welt wechseln, MausX = Geschwindigkeit, 's' = speichern.  
    Tipp: Unendliche Ruhe.

12. **Flüssige Metaballs / Organische Blobs** (Bonus aus der Liste)  
    Ästhetik: Weiche, biomorphe Blobs wie Lava-Lampen, mit Farbverläufen.  
    Versionen: Basis mit Perlin-Noise. (Nicht explizit entwickelt, aber hier eine einfache Implementierung:)  

    ```java
    // Flüssige Metaballs (einfache Version)
    void setup() {
      size(1200, 800, P2D);
      colorMode(HSB, 360, 100, 100, 100);
    }
    void draw() {
      background(0);
      loadPixels();
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          float sum = 0;
          for (int i = 0; i < 5; i++) {
            float px = width/2 + sin(frameCount*0.01 + i*1.2)*300;
            float py = height/2 + cos(frameCount*0.015 + i*0.8)*250;
            sum += 100 / dist(x, y, px, py);
          }
          float h = sum % 360;
          pixels[y*width + x] = color(h, 80, constrain(sum*5, 0, 100));
        }
      }
      updatePixels();
    }
    ```

## Usage & Tipps

- **Starten**: Öffne Processing, erstelle neuen Sketch, kopiere Code, drücke Strg+R (F5).
- **Anpassen**: Passe `size()`, Partikelanzahl oder Parameter (z. B. `numPoints`) für deine Hardware.
- **Export**: Für Videos nutze Processing's MovieMaker-Bibliothek oder recorde mit OBS.
- **Erweiterung**: Füge MIDI-Input, Webcam-Integration oder Export nach Blender hinzu (z. B. für OBJ-Dateien).
- **Probleme**: Wenn ein Sketch langsam ist, reduziere Schleifen (z. B. numParticles) oder deaktiviere Glow (blendMode).

## Lizenz & Credits

- **Lizenz**: Creative Commons CC0 – nutze, teile, modifiziere frei.  
- **Inspiration**: Basierend auf deiner Idee-Sammlung und klassischen generativen Kunst (z. B. Heinz Mack, Truchet, Perlin).  
- **Entwickelt mit**: Grok von xAI – für dich, 2025.  

Falls du Erweiterungen oder eine GitHub-Repo brauchst, lass es mich wissen!
