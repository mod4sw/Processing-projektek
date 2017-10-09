Target target;
int points = 0;
int time;

void setup(){
  size(1366, 768);
  noCursor();
  target = new Target();
  time = 30 * 60;
}

void draw(){
  background(200);
  target.draw();
  crosshair();
  points();
  if(target.position.x - target.size/2 > width ||
     target.position.x + target.size/2 < 0 ||
     target.position.y - target.size/2 > height ||
     target.position.y + target.size/2 < 0){
       target = new Target();
     }
  time--;
  if(time <= 0){
    noLoop();
    background(200);
    textSize(50);
    fill(100, 0, 0);
    textAlign(CENTER, CENTER);
    text("Processing Shooter\n\nGame Over!\nPoints: " + points + 
    "\nClick to restart\n\nYouTube.com/mod4\nDownload from: GitHub.com/mod4sw", width/2, height/2);
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
    target = new Target();
    textAlign(LEFT);
    loop();
  }
  else{
    PVector mousePos = new PVector(mouseX, mouseY);
    println("Különbség: " + target.position.dist(mousePos));
    if(target.position.dist(mousePos) <= target.size/2){
      points += target.points();
      time += target.velocity.mag() * 10;
      target = new Target(); 
    }
  }
}