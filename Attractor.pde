// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Attraction : A class for a draggable attractive body in our world

//_______________________________________________________________INSTANZ-VARIABLEN
class Attractor {
  float mass;         // Masse (hängt am Ende vom Radius ab)
  PVector position;   // Positions-Vektor
  float g;

//_______________________________________________________________KONSTRUKTOR
  Attractor(float posx, float posy) {
    
    position = new PVector(posx, posy);             // neuer Attractor bekommt die Position 'center of the screen'
    mass = 50;                                      // seine Masse wird mit 50 versehen
    g = 0.4;                                        // seine Gravitationskonstante ist 0,04
  }

//________________________________________________________________Methode: Attract (bekommt ein Mover-Objekt 'm' und returnt die entspr. Kraft 'force')
  PVector attract(Mover m) {
    
    PVector force = PVector.sub(position, m.position);            // Kraft-Vektor = Pos.-Vektor(Attr.) - Pos.-Vektor(Mov.)
    float distance = force.mag();                                 // distance ist die Länge (magnitude) des force-Vektors
    distance = constrain(distance, 5.0, 30.0);                    // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;                                                 // gib force zurück
  }

  //______________________________________________________________Methode: Display
  void display() {
    
    stroke(100);                                     // Strichfarbe = schwarz
    strokeWeight(20);                                // Strichstärke = 2 px
    fill(127, 127, 127, 100);                        // Füllfarbe = dunkelgrau
    ellipse(position.x, position.y, 48, 48);         // zeichne Ellipse dort wo seine festgelegten x- & y-Koordinaten sind
  }

} // ende Attractor-class