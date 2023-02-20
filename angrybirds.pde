/*
by Adam Dia - 7/11/2022

wanted to recreate the throwing mechanic from angry birds, had the idea of subtracting the position of release from the position of press to give the ball its initial velocity and then it went from there
*/


PVector mousePress = new PVector(0, 0); // the location of where you started dragging the mouse
PVector mouseUnpress = new PVector(0, 0); // the location of where you stopped dragging the mouse
boolean pressing = false; // storing whether or not left click is being held down
PVector velocity = new PVector(0, 0); // the velocity to give the balls
ArrayList<ball> balls = new ArrayList<ball>(); // array list used to hold the balls, array list is preferable as it is dynamically resizable and we will be deleting and adding balls in quick succession

ball currentBall; // the current ball we are working on during the for loop

void setup()
{
  size(640, 480);
}

void draw()
{
  background(200);
  stroke(255);
  if (pressing) // if we are holding down the mouse...
  {
    stroke(255);
    strokeWeight(20);
    line(mouseX, mouseY, mousePress.x, mousePress.y); // ... draw a line between the mouse's current position and where we started holding it down
  }

  for (int i = balls.size() - 1; i >= 0; i--) // loop through all the balls backwards because we need to remove balls if they go out of bounds... 
    { // ...if go through it normally, we will end up deleting the ball that we are trying to render
    currentBall = balls.get(i); //<>//
    currentBall.go(); //<>//
    if (currentBall.isOutOfBounds()) // check if the currentball is out of bounds, as measured by the ball classes internal function
    {
      balls.remove(i);
    }
  }
  
  println(balls.size());
}

void mousePressed()
{
  mousePress.set(mouseX, mouseY); // when the mouse has been pressed down, note its position at this instant
  pressing = true; 
}

void mouseReleased()
{
  pressing = false;
  mouseUnpress.set(mouseX, mouseY); // when the mouse is released, note its position at this instant
  if(PVector.sub(mouseUnpress, mousePress).mag() != 0) // dont create  a ball if there wont be any velocity
  {
    velocity.set(PVector.sub(mousePress, mouseUnpress)); // make velocity the difference between the press and release, so we will get a vector poiting from the release to the press
    balls.add(new ball(velocity.x, velocity.y, mouseUnpress.x, mouseUnpress.y)); // create a new ball with that velocity, and make its inital position where the mouse was released //<>//
  }
}
