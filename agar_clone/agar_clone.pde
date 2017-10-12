Player player1, player2;
Food[] food;
Poison[] poison;

void setup(){
  size(1366, 768);
  player1 = new Player(20,color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255)), 5, 10.0, 300, 1);
  player2 = new Player(20,color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255)), 5, 10.0, 300, 2);
  food = new Food[20];
  poison = new Poison[5];
  for(int i = 0; i < food.length; i++){
    food[i] = new Food(random(5, 10));
  }
   for(int i = 0; i < poison.length; i++){
    poison[i] = new Poison();
  }
}

void draw(){
  background(200);
  for(int i = 0; i < poison.length; i++){
    if(!poison[i].isValid()){
      poison[i] = new Poison();
    }
    poison[i].display();
    if(player1.distance(poison[i]) < player1.getSize() / 2 - food[i].getSize() / 2){
      player1.feed(poison[i]);
      poison[i] = new Poison();
    }
    if(player2.distance(poison[i]) < player2.getSize() / 2 - food[i].getSize() / 2){
      player2.feed(poison[i]);
      poison[i] = new Poison();
    }
  }
  for(int i = 0; i < food.length; i++){
    if(!food[i].isValid()){
      food[i] = new Food();
    }
    food[i].display();
    if(player1.distance(food[i]) < player1.getSize() / 2 - food[i].getSize() / 2){
      player1.feed(food[i]);
      food[i] = new Food();
    }
    if(player2.distance(food[i]) < player2.getSize() / 2 - food[i].getSize() / 2){
      player2.feed(food[i]);
      food[i] = new Food();
    }
  }
  player1.display();
  player2.display();
}