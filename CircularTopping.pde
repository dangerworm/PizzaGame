class CircularTopping extends DraggableTopping {
  float radius;

  CircularTopping(float x, float y, float radius, color colour) {
    super(x, y, colour);
    this.radius = radius;
  }

  void alignToMouse(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  boolean contains(float x, float y) {
    return dist(x, y, this.x, this.y) < this.radius;
  }

  void render() {
    fill(colour);
    circle(x, y, radius);
  }
}
