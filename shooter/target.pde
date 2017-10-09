class Target{
  final static float maxVelocity = 4;
  final static float maxSize = 50;
  final static float minSize = 20;
  final static float maxPoint = 200;
  PVector position, velocity;
  float size;
  int r, g, b;
  
  
  Target(){
    velocity = new PVector(random(-maxVelocity, maxVelocity), random(-maxVelocity, maxVelocity));
    float x, y;
    if(abs(velocity.x) > abs(velocity.y)){
      if(velocity.x > 0){
        x = 0;
      }
      else{
        x = width;
      }
      y = height * abs(velocity.y) / maxVelocity;
    }
    else{
      if(velocity.y > 0){
        y = 0;
      }
      else{
        y = height;
      }
      x = width * abs(velocity.y) / maxVelocity;
    }
    position = new PVector(x, y);
    size = random(minSize, maxSize);
    r = (int)random(0, 255);
    g = (int)random(0, 255);
    b = (int)random(0, 255);
  }
  
  void draw(){
    fill(r, g, b);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size, size);
    position.add(velocity);  
  }
  
  int points(){
    return (int)(maxPoint / size * velocity.mag());
  }
  
}