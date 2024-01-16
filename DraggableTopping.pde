abstract class DraggableTopping {
  float x, y;
  color colour;
  boolean isBeingDragged;

  DraggableTopping(float x, float y, color colour) {
    this.x = x;
    this.y = y;
    this.colour = colour;
    this.isBeingDragged = false;
  }

  abstract void alignToMouse(float x, float y);
  abstract boolean contains(float x, float y);
  abstract void render();
}
