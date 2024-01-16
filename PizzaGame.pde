int cheeseInitialX = 100;
int cheeseInitialY = 30;
int cheeseWidth = 40;
int cheeseHeight = 80;

int tomatoInitialX = 200;
int tomatoInitialY = 400;
int tomatoRadius = 40;

int veganInitialX = 300;
int veganInitialY = 50;
int veganRadius = 30;

int pizzaBaseInitialX = 800;

float speed = 0.5;

boolean isGameOver = false;
int score = 0;

color red = color(255, 0, 0);
color yellow = color(255, 255, 0);
color green = color(0, 255, 0);

PizzaBase pizzaBase = new PizzaBase(pizzaBaseInitialX, 600, 100, 20);
ArrayList<DraggableTopping> toppings = new ArrayList<DraggableTopping>();

void setup() {
  size(800, 800);
}

void draw() {
  background(240);
  fill(0);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Score: " + score, 700, 50);

  if (isGameOver) {
    displayEndScreen();
  } else {
    createObjects();
    checkCollisions();
    moveObjects();
    checkWinLoseCriteria();
  }
}

void displayEndScreen() {
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Game Over", 400, 400);
}

boolean hasTopping(ArrayList<DraggableTopping> toppings, color colour) {
  for (DraggableTopping topping : toppings) {
    if (topping.colour == colour) {
      return true;
    }
  }
  return false;
}

void createObjects() {
  if (toppings.size() < 3) {
    if (!hasTopping(toppings, yellow)) {
      DraggableTopping cheese = new RectangularTopping(cheeseInitialX, cheeseInitialY, cheeseWidth, cheeseHeight, yellow);
      toppings.add(cheese);
    }

    if (!hasTopping(toppings, red)) {
      DraggableTopping tomato = new CircularTopping(tomatoInitialX, tomatoInitialY, tomatoRadius, red);
      toppings.add(tomato);
    }

    if (!hasTopping(toppings, green)) {
      DraggableTopping vegan = new CircularTopping(veganInitialX, veganInitialY, veganRadius, green);
      toppings.add(vegan);
    }
  }
}

void checkCollisions() {
  for (int i = 0; i < toppings.size(); i++) {
    DraggableTopping topping = toppings.get(i);
    if (!topping.isBeingDragged) {
      continue;
    }

    boolean overPizzaBase = pizzaBase.contains(mouseX, mouseY);
    if (overPizzaBase && !mousePressed) {
      toppings.remove(topping);
      pizzaBase.toppings.add(topping);
    }
  }
}

void moveObjects() {
  pizzaBase.render();
  pizzaBase.x -= speed;
  for (DraggableTopping pizzaTopping : pizzaBase.toppings) {
    pizzaTopping.x -= speed;
    pizzaTopping.render();
  }

  DraggableTopping activeTopping = null;
  for (DraggableTopping topping : toppings) {
    if (topping.isBeingDragged) {
      activeTopping = topping;
      break;
    }
  }

  if (activeTopping != null) {
    if (mousePressed) {
      activeTopping.alignToMouse(mouseX, mouseY);
    } else {
      activeTopping.isBeingDragged = false;
    }
  }

  for (DraggableTopping topping : toppings) {
    boolean mouseOver = topping.contains(mouseX, mouseY);
    if ((activeTopping == null || !activeTopping.isBeingDragged) && mouseOver && mousePressed) {
      topping.isBeingDragged = true;
    }

    topping.render();
  }
}

void checkWinLoseCriteria() {
  if (pizzaBase.x > -(pizzaBase.w / 2)) {
    return;
  }
  
  boolean hasCheese = hasTopping(pizzaBase.toppings, yellow);
  boolean hasTomato = hasTopping(pizzaBase.toppings, red);
  boolean hasVegan = hasTopping(pizzaBase.toppings, green);

  if (!hasCheese || !hasTomato || !hasVegan) {
    isGameOver = true;
    return;
  }
  
  score += pizzaBase.toppings.size() - 2;
  speed += 0.5;
  
  pizzaBase.toppings = new ArrayList<DraggableTopping>();
  pizzaBase.x = pizzaBaseInitialX;
}
