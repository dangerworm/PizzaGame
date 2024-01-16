class RectangularTopping extends DraggableTopping {
  float w, h;
  
  RectangularTopping(float x, float y, float w, float h, color colour) {
    super(x, y, colour);
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void alignToMouse(float x, float y) {
    this.x = x - (this.w / 2);
    this.y = y - (this.h / 2);
  }
  
  boolean contains(float x, float y) {
    boolean leftOfEnd = x < this.x + this.w;
    boolean rightOfStart = x > this.x;
    boolean aboveBottom = y < this.y + this.h;
    boolean belowTop = y > this.y;
    
    return leftOfEnd && rightOfStart && aboveBottom && belowTop;
  }

  void render() {
    fill(colour);
    rect(x, y, w, h);
  }
}
