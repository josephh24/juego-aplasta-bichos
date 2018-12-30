Bichos[] myBichosArray = new Bichos[30];
PImage inicio;
PImage fondo;
PImage insecto;
int score = 0;  
int highScore = 0;
boolean introScreen = true;
int savedTime;
int totalTime = 15000;

void setup() {
  size(600, 600);
  smooth();
  inicio = loadImage("inicio.jpg");
  fondo = loadImage ("fondo.jpg");
  insecto = loadImage ("chinche.png");
  textSize(20);  
  savedTime = millis();
  
  for(int i=0; i<myBichosArray.length; i++) {
    myBichosArray[i] = new Bichos(300,300,35);  
  }
  
}

void draw() { 
  background(fondo);
   
   if (keyPressed) {
    if (key == 'i' || key == 'I') {
       introScreen = false;
    }
  }
 
  if (introScreen==true)
  {
    image(inicio, 0, 0);
    fill(#000000);
    text("PUNTAJE MAXIMO: "+highScore,220,440); 
  }
  else {
    for(int i=0; i<myBichosArray.length; i++) {  
     myBichosArray[i].speed();
     myBichosArray[i].colision();
     myBichosArray[i].display(); 
     myBichosArray[i].aplasta(); 
     myBichosArray[i].score(); 
     myBichosArray[i].gameover(); 
    }
  } 
   
}

class Bichos {
 
  float x;
  float y;
  float d;
  float xSpeed;
  float ySpeed; 
  
  Bichos(float posX, float posY, float diametro) {
    x = posX;
    y = posY;
    d = diametro;
    
    xSpeed = random(-5, 5);
    ySpeed = random(-5, 5);
     
  }
 
  void speed() {
    x += xSpeed;
    y += ySpeed; 
  }
   
  void colision() {
    
    if ((x<0) || (x>width-d)){
      xSpeed = -xSpeed;
    } 
     
    if((y<0) || (y>height-d)) {
      ySpeed = -ySpeed; 
    }
     
  }
   
  void display() { 
    image(insecto, x, y);
  }
  
  void aplasta() { 
     if (mousePressed) { 
      float distance = dist(mouseX, mouseY, x, y);
      if (distance<d) {
          xSpeed = 0;
          ySpeed = 0;
          x = -1000;
          score++;
          highScore = max(score, highScore);
       }
     } 
  }
  
   void score() { 
    fill(#000000);
    text("PUNTAJE: "+score,10,20);  
  }
  
   void gameover() { 
   int passedTime = millis() - savedTime;
   
     if (passedTime > totalTime){
         introScreen = true;
         savedTime = millis();
         score = 0;
         for(int i=0; i<myBichosArray.length; i++) {
         myBichosArray[i] = new Bichos(300,300,35);  
         }
     }
   }
   
}