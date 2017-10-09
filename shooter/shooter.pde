final int targetCount = 20;
Target[] targets;
int points = 0;
int time;

void setup(){
  size(1366, 768);
  noCursor();
  targets = new Target[targetCount];
  for(int i = 0; i < targetCount; i++){
    targets[i] = new Target();
  }
  time = 30;
}

void draw(){
  background(200);
  for(int i = 0; i < targetCount; i++){
    targets[i].draw();
    if(targets[i].position.x - targets[i].size/2 > width ||
       targets[i].position.x + targets[i].size/2 < 0 ||
       targets[i].position.y - targets[i].size/2 > height ||
       targets[i].position.y + targets[i].size/2 < 0){
         targets[i] = new Target();
     }
  }
  
  crosshair();
  points();
  
  time--;
  if(time <= 0){
    noLoop();
    background(200);
    textSize(50);
    fill(100, 0, 0);
    textAlign(CENTER, CENTER);
    text("Processing Shooter\n\nGame Over!\nPontszám: " + points + 
    "\nKattints az újrakezdéshez!\n\nYouTube.com/mod4\nLetölthető: GitHub.com/mod4sw", width/2, height/2);
    delay(1000);
  }
}

void crosshair(){
  crosshair(4, 3, 5);
}

void crosshair(int size, int thickness, int offset){
  strokeWeight(thickness);
  line(mouseX - offset, mouseY, mouseX - offset - size, mouseY);
  line(mouseX + offset, mouseY, mouseX + offset + size, mouseY);
  line(mouseX, mouseY - offset, mouseX, mouseY - offset - size);
  line(mouseX, mouseY + offset, mouseX, mouseY + offset + size);
  
}

void points(){
  textSize(32);
  if(time / 60 <= 10){
    fill(255, 0, 0);
  }
  else{
    fill(25);
  }
  text("Time: " + (time / 60), 10, 30);
  fill(25);
  text("Points: " + points, 10, 70);
}

void setGameTime(){
   time = (int)(30 * frameRate);
}

void mousePressed(){
  if(time <= 0){
    setGameTime();
    for(int i = 0; i < targetCount; i++){
      targets[i] = new Target();
    } 
    points = 0;
    textAlign(LEFT);
    loop();
  }
  else{
    PVector mousePos = new PVector(mouseX, mouseY);
    for(int i = 0; i < targetCount; i++){
      if(targets[i].position.dist(mousePos) <= targets[i].size/2){
        points += targets[i].points();
        time += targets[i].velocity.mag() * 5;
        targets[i] = new Target(); 
      }
    }
  }
}