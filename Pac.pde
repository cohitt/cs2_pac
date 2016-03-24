class Pac {
    private PVector position;
    final float speed = 0.1 * dotSpacing;
    private Dir travelDirection = Dir.EAST;

    // for testing purposes, don't start in the corner
    Pac() {
        position = new PVector(dotToPixel(20), dotToPixel(15));
    }

    // return a copy of the current position
    PVector getPosition() {
      return position.copy();
    }

    // set a new movement direction
    void setDirection(Dir d) {
      travelDirection = d;
    }

    // Draw the Pac, as a circle
    void render() {
      fill(115, 115, 0);
      ellipse(getPosition().x, getPosition().y, 30, 30);
    }

    // If the given vector is off the screen, wrap it around to the other side
    // Modify the given vector.
    // If this were public, we probably woudn't modify the vector in place like this.
    private void wrapPosition(PVector vec) {
      if (vec.x >= width) {
        vec.x = 1;
      } 
      if (vec.x <= 0) {
        vec.x = width-1;
      }
      if (vec.y >= height) {
        vec.y = 1;
      }
      if (vec.y <= 0) {
        vec.y = height-1;
      }
    }

    // reverse the movement direction
    private void reverseDirection() {
      if (travelDirection == Dir.NORTH) {
        travelDirection = Dir.SOUTH;
      } else if (travelDirection == Dir.WEST) {
        travelDirection = Dir.EAST;
      } else if (travelDirection == Dir.EAST) {
        travelDirection = Dir.WEST;
      } else if (travelDirection == Dir.SOUTH) {
        travelDirection = Dir.NORTH;
      }
    }

    // Update the position, using the current speed & travel direction
    // If normal movement would hit a wall, find the position after bouncing off the wall.
    // The total distance travelled (before + after hitting the wall) should be the same.
    void updatePosition() {
      PVector oldPosition = getPosition();
      if (travelDirection == Dir.NORTH) {
        position.y = position.y - speed;
      } else if (travelDirection == Dir.WEST) {
        position.x = position.x - speed;
      } else if (travelDirection == Dir.EAST) {
        position.x = position.x + speed;
      } else if (travelDirection == Dir.SOUTH) {
        position.y = position.y + speed;
      }
      PVector wallPosition = walls.collision(oldPosition, getPosition());
      println(wallPosition);
      if (wallPosition.x != 0 && wallPosition.y != 0) {
        position = oldPosition;
      }
      wrapPosition(position);
    }
    
    void keyPressed() {
      if (key == CODED) {
        if (keyCode == UP) {
          setDirection(Dir.NORTH);
          } else if (keyCode == LEFT) {
          setDirection(Dir.WEST);
          } else if (keyCode == RIGHT) {
          setDirection(Dir.EAST); 
          } else if (keyCode == DOWN) {
          setDirection(Dir.SOUTH);
        }
      }
    }

}