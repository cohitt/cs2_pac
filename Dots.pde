class Dots {
   private boolean[][] dots;
   private int count;

   // Create an initial board with every dot present
   Dots() {
     dots = new boolean[boardWidth][boardHeight];
     count = 900;
     int col=0;
     int row=0;
     while (col < boardWidth) {
       while (row < boardHeight) {
         dots[row][col] = true;
         row++;
       }  
     col++;
     row=0;
     }
   }
   
   // remove any dots between the two positions
   // return the number of dots removed
  // Normally the input vectors will either be in the same row
   // or the same column.  It's fine to only handle these cases.
   // Write a comment explaining what your version does
   // if the inputs are not in the same row or column.
   //From position
   int remove(PVector fromPosition, PVector toPosition) {
     int returnCount = 0;
     int positionCount = 0;
     int pixFromX = pixelToDot(fromPosition.x); 
     int pixToX = pixelToDot(toPosition.x);
     int pixFromY = pixelToDot(fromPosition.y);
     int pixToY = pixelToDot(toPosition.y);
     if (pixFromY > pixToY) { // North     
       positionCount = pixFromY - pixToY;
       while (positionCount > 0) {
         dots[pixFromX][pixFromY-positionCount] = false;
         positionCount = positionCount-1;
         returnCount++;
       }
     }
     if (pixFromX > pixToX) { // West
       positionCount = pixFromX - pixToX;
       while (positionCount > 0) {
         dots[pixFromX-positionCount][pixFromY] = false;
         positionCount = positionCount-1;
         returnCount++;
       }
     }
     if (pixFromX < pixToX) { // East
       positionCount = pixToX - pixFromX;
       while (positionCount > 0) {
         dots[pixToX-positionCount][pixToY] = false;
         positionCount = positionCount-1;
         returnCount++;
       }
     }
     if (pixFromY < pixToY) { // South
       positionCount = pixToY - pixFromY;
       while (positionCount > 0) {
         dots[pixToX][pixToY-positionCount] = false;
         positionCount = positionCount-1;
         returnCount++;
       }
     }
     count = count-returnCount;
     return returnCount;
   } 

      // return the number of dots remaining
/*   boolean remaining() {
       return count;
   }*/

   // Draw the dots.  Use `dotToPixel`
   void render() {
     int col=0;
     int row=0;
     while (col < boardWidth) {
       while (row < boardHeight) {
         if (dots[col][row] == true) {
         ellipse(dotToPixel(col), dotToPixel(row), dotRadius, dotRadius);
         }
       row++;
       }  
     col++;
     row=0; 
     }
     textSize(18);
     text(900-count, 2, 20);
   }
}