class PizzaBase {
  float x, y, w, h;
  ArrayList<DraggableTopping> toppings;

  PizzaBase(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.toppings = new ArrayList<DraggableTopping>();
  }

  boolean contains(float x, float y) {
    boolean leftOfEnd = x < this.x + this.w;
    boolean rightOfStart = x > this.x;
    boolean aboveBottom = y < this.y + this.h;
    boolean belowTop = y > this.y;
    
    return leftOfEnd && rightOfStart && aboveBottom && belowTop;
  }
  
  void render() {
    fill(color(255));
    rect(x, y, w, h);
  }
}
