class ball {

  PVector velocity;
  PVector position; 
  float radius = 45; // radius of the balls
  color fill; // what colour to fill them with
  float speedMultiplier = 3; // how much to multiply velocity by as it can be a bit slow without this
  PVector gravity = new PVector (0, 400); // for fun, we can have gravity going in any direction, useful for projectile motion
  float timeStep;

  ball(float vx, float vy, float x, float y)
  {
    velocity = new PVector(vx, vy);
    position = new PVector(x, y); 
    fill = color(random(255), random(255), random(255));
  }

  void go()
  {
    noStroke();
    fill(fill);
    circle(position.x, position.y, radius);
    timeStep = 1 / frameRate;
    //println(timeStep);
    velocity.add(PVector.mult(gravity, timeStep)); // add gravity to velocity every frame
    position.add(PVector.mult(PVector.mult(velocity, timeStep), speedMultiplier)); // add velocity to potiion every frame, but multiply it by the time step to have framerate independant motion...
  } // ..then multiply that velocity by the multiplier

  boolean isOutOfBounds() // check whether or not the ball has left the screen, except for the top, so that it  can be removed by the for loop
  {
    if (position.x > width + radius || position.x < 0 - radius || position.y > height + radius)
    {
      return true;
    } else
    {
      return false;
    }
  }
}
