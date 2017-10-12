class GameObject{
  float size;
  color c;
  int border;
  PVector position;
  PVector velocity;
  
  GameObject(float size, PVector position, PVector velocity, color c, int border){
    this.size = size;
    this.position = position;
    this.velocity = velocity;
    this.c = c;
    this.border = border;
  }
  
  PVector getPosition(){
    return position;
  }
  
  float getSize(){
    return size;
  }
  
  void setVelocity(PVector velocity){
    this.velocity = velocity;
  }
  
  void display(){
    ellipseMode(CENTER);
    strokeWeight(border);
    stroke(0);
    fill(c);
    ellipse(position.x, position.y, size, size);
    move();
  }
  
  void move(){
    position.add(velocity);
  }
  
  float distance(GameObject other){
    PVector dist = new PVector(position.x, position.y);
    return dist.sub(other.getPosition()).mag();
    
  }
}

class Food extends GameObject{
  int timeout;
  
  Food(){
    super(random(10, 30), new PVector(random(3, width - 3), random(3, height - 3)), 
      new PVector(0, 0), color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255)), 2);
    timeout = (int)random(frameRate * 20, frameRate * 40);
  }
  
  Food(float size){
     super(size, new PVector(random(3, width - 3), random(3, height - 3)), 
      new PVector(0, 0), color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255)), 2);
     timeout = (int)random(frameRate * 20, frameRate * 40);
  }
  
  void display(){
    super.display();
    timeout--;
  }
  
  boolean isValid(){
    return timeout > 0;
  }
}

class Poison extends GameObject{
  int timeout;
  Poison(){
    super(random(10, 30), new PVector(random(3, width - 3), random(3, height - 3)), 
      new PVector(0, 0), color(255, 0, 0), 0);
    timeout = (int)random(frameRate * 100, frameRate * 300);
  }
  
  void display(){
    super.display(); 
    timeout--;
  }
  
   boolean isValid(){
    return timeout > 0;
  }
  
  float getSize(){
    return -size;
  }
}

class Player extends GameObject{
  float maxSpeed;
  float maxSize;
  int playerNum;
  Player(float size, color c, int border, float maxSpeed, float maxSize, int playerNum){
    super(size, new PVector(width/3 * playerNum, height/2), new PVector(0, 0), c, border);
    this.playerNum = playerNum;
    this.maxSpeed = maxSpeed;
    this.maxSize = maxSize;
  }
  
  void move(){
    if(playerNum == 1){
      velocity = (new PVector(mouseX, mouseY).sub(position)).limit(maxSpeed / (size / 20));
    }
    else{
      float x = 0, y = 0;
      if(keyPressed){
        
        if(key == CODED){
          if(keyCode == UP){
            y = -100;
          }
          else if(keyCode == DOWN){
            y = 100;
          }
          
          if(keyCode == LEFT){
            x = -100;
          }
          else if(keyCode == RIGHT){
            x = 100;
          }
        }
      }
      velocity = new PVector(x, y).limit(maxSpeed / (size / 20));
    }
    
    super.move();
  }
  
  void feed(GameObject other){
    float ownArea = size * size / 2 * PI;
    float foodArea = other.getSize() * other.getSize() / 4 * PI;
    if(other.getSize() < 0){
      ownArea -= foodArea * 3;
    }
    else{
      ownArea += foodArea * 0.75;
    }
    size = sqrt(ownArea / PI * 2);
    if(size > maxSize){
      size = maxSize;
    }
  }
}