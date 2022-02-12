// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

//______________________________________________________________INSTANZ-VARIABLEN
  PVector position;        // Positionsvektor (x,y)
  PVector velocity;        // Geschwindigkeitsektor (xvel,yvel)
  PVector acceleration;    // Beschleunigungsvektor (xacc,yacc)
  float mass;              // Massenvektor

  float angle = 0;         // Winkel
  float aVelocity = 0;     // Winkel-Geschwindigkeit
  float aAcceleration = 0; // Winkel-Beschleunigung

//_______________________________________________________________KONSTRUKTOR
  Mover(float mass, float x, float y) {
    
    this.mass = mass;                                     // Masse (wird bei Initialisierung übergeben)
    position = new PVector(x,y);                          // Startposition (wird bei Initialisierung übergeben)
    velocity = new PVector(random(-1,1),random(-1,1));    // Startgeschwindigkeit (zuf. Zahl zw. -1 und 1 in beide Richtg.)
    acceleration = new PVector(0,0);                      // Startbeschleunigung
    
  } 

//_______________________________________________________________Methode: Appliziere Kraft
  void applyForce(PVector force) {                        // Kraftvektor 'force' wird übergeben
    
    PVector f = PVector.div(force,mass);                  // force wirkt in Abhängigkeit der Masse des Objektes (je größer m, umso kleiner f)
    acceleration.add(f);                                  // f ergibt sich somit aus force / mas und wird anschließend dem acc-Vektor hinzugef.
    
  }

//_______________________________________________________________Methode: Update-MoverStatus
  void update() {

    velocity.add(acceleration);        // Beschleunigung ist Änderung der Geschwindigkeit (new vel = vel + acc)
    position.add(velocity);            // Geschwindigkeit ist Änderung des Weges (new pos = pos + vel)

    aAcceleration = acceleration.x / 10.0;      // Winkelbeschleunigung richtet sich nach x-KO
    aVelocity += aAcceleration;                 // (neue) Winkelgeschw. = (alte) Winkelgeschw. + Winkelbeschleunigung
    aVelocity = constrain(aVelocity,-0.1,0.1);  // constrain zwingt aVelocity zu einem pot. Maximum von 0,1 und einem pot. Minimum von -0,1
    angle += aVelocity;                         // (neuer) Winkel = (alter) Winkel + Winkelgeschwindigkeit

    acceleration.mult(0);              // zurücksetzen der acceleration auf 0
  }

//________________________________________________________________Methode: Display
  void display() {
    
    stroke(0);
    strokeWeight(0);
    fill(175,200);
    rectMode(CENTER);
    
    pushMatrix();                      // pushMatrix 'speichert' den Zustand. Ab hier wird nur das KOS des Rechteck verschobe (translate)
    translate(position.x,position.y);  // KO-Ursprung ist nun der Positions-Vektor des Movers
    rotate(angle);                     // KO wird nun um den Winkel 'angle' gedreht (eigentliche Drehung)
    rect(0,0,mass*16,mass*16);         // das Rechteck wird im KO-Ursprung (wegen translate) mit der Größe Mass * Faktor (16) gezeichnet
    popMatrix();                       // popMatrix setzt das KOS usw. zurück zum pushMatrix-Zustand
  }

} // ende Mover-Class