// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers = new Mover[50];

Attractor a, b;

void setup() {
  
  size(800,600);
  background(255);
  
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1,2),random(width),random(height)); 
  }
  
  a = new Attractor(width/4, height/2);
  b = new Attractor(width*0.75, height/2);
  
}

void draw() {
  background(255);

  a.display();
  b.display();

  for (int i = 0; i < movers.length; i++) {
    PVector force = PVector.add(a.attract(movers[i]), b.attract(movers[i]));
    
    movers[i].applyForce(force);
    movers[i].update();
    movers[i].display();
  }

}