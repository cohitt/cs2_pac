class Walls {
    // vertical walls.
    // This array is true for a given square if there is a wall to the right of that square
    private boolean[][] vertical;
    // horizontal - true if there is a wall below that square.
    private boolean[][] horizontal;

    // A new set of walls, for testing purposes
    // eventually, we'll want some particular levels
    Walls() {
        this.vertical = new boolean[boardHeight][boardWidth];
        this.horizontal = new boolean[boardHeight][boardWidth];
        for(int i=0; i<boardHeight; i++) {
            for (int j=0; j<boardWidth; j++) {
                if (i == j) {
                    vertical[i][j] = true;
                    horizontal[i][j] = true;
                } else {
                    vertical[i][j] = false;
                    horizontal[i][j] = false;
                }
            }
        }
    }


    // Make a new Walls object from two arrays:
    // Horizontal & Vertical walls.
    // WISH check that dimensions are correct.
    Walls(boolean[][] h, boolean[][] v) {
        this.horizontal = h;
        this.vertical = v;
    }

    // If there is a wall between the two given positions, return the point of collision.
    // Otherwise, return some value that can never be a collision.
    // Input & Output are in pixel coordinates 
    PVector collision(PVector fromPosition, PVector toPosition) {
      int positionCount = 0;
      int pixFromX = pixelToDot(fromPosition.x); 
      int pixToX = pixelToDot(toPosition.x);
      int pixFromY = pixelToDot(fromPosition.y);
      int pixToY = pixelToDot(toPosition.y);
      // Loop through for each direction and find if there is a wall at any given point within a range
      if (pixFromY > pixToY) { // North
        positionCount = pixFromY - pixToY;
        while (positionCount > 0) {
          if (horizontal[pixFromX][pixFromY] == true) {
            return new PVector(dotToPixel(pixFromX),dotToPixel(pixFromY));
          } else {
            positionCount = positionCount-1;
          }
        }
      } 
      if (pixFromX > pixToX) { // West
        positionCount = pixFromX - pixToX;
        while (positionCount > 0) {
          if (vertical[pixFromX][pixFromY] == true) {
            return new PVector(dotToPixel(pixFromX),dotToPixel(pixFromY));
          } else {
            positionCount = positionCount-1;
          }
        }
      } 
      if (pixFromX < pixToX) { // East
        positionCount = pixToX - pixFromX;
        while (positionCount > 0) {
          if (vertical[pixToX][pixToY] == true) {
            return new PVector(dotToPixel(pixToX),dotToPixel(pixToY));
          } else {
            positionCount = positionCount-1;
          }
        }
      }
      if (pixFromY < pixToY) { // South
        positionCount = pixToY - pixFromY;
        while (positionCount > 0) {
          if (vertical[pixToX][pixToY] == true) {
            return new PVector(dotToPixel(pixToX),dotToPixel(pixToY));
          } else {
            positionCount = positionCount-1;
          }
        }
      }
      return new PVector(0,0);
    }

    void render() {
      int col=0;
      int row=0;
      while (col+1 < boardWidth) {
        while (row+1 < boardHeight) {
          if (vertical[col][row]==true) {
            line(dotToPixel(col)+(dotSpacing/2), dotToPixel(row)-(dotSpacing/2), dotToPixel(col)+(dotSpacing/2), dotToPixel(row)+(dotSpacing/2));
          }  
          if (horizontal[col][row]==true) {
            line(dotToPixel(col)-(dotSpacing/2), dotToPixel(row)-(dotSpacing/2), dotToPixel(col)+(dotSpacing/2), dotToPixel(row)-(dotSpacing/2));
          }
          row++;
        }
      col++;
      row=0;
    }
  }
}