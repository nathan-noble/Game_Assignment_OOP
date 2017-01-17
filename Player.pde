class Player {
  PVector loc;
  PVector vel;
  PVector acc;
  PVector mouse;
  float speed;
  
  Player() {
    loc = new PVector(width/15, height/1.2);
    vel = new PVector(0, 0);
    mouse = new PVector(100, 100);
    acc = PVector.sub(mouse, loc);
    speed = 5;
  }
  
  void update() {
    
    //Set magnitute of acceleration
    acc.setMag(0.2);
    //Velocity changes according to acceleration
    vel.add(acc);
    //Limit the velocity by speed
    vel.limit(speed);
    //Location changes by velocity
    loc.add(vel);
  }
  
  void display() {
    stroke(random(20,45));
    fill(255, 500, 100);
    rect(loc.x, loc.y, 50, 50);
    
  }
}