/* Module 4.13 More Fun with Exam Stress
    Question 1 
    Title: Poor Coping Skills
    Description: As exams approach, Josie is drowning her stress in beer. 
    Open the window to slap her with some fresh air. 
    Oh no! It's a buggy summer night...  */
    
//colors used
//environment 
final color wallColor = color(145,240,188); 
final color carpetColor = color(227,209,183); 
final color sunColor = color(242,242,49); 
final color curtainColor = color(252,0,0);
final color deskColor = color(116,71,12);
//character
final color dressColor = color(227,153,242); 
final color skinColor = color(247,237,197); 
final color mouthColor = color(227,82,102); 
int mouthAlpha; //alpha value for character's mouth
final color eyeColor = color(0,183,247); 
final color hairColor = color(240,233,36); 
 

//room settings (baseboard, windows, and curtain)
int baseboardY;
int baseboardHeight;
int windowX, windowY, windowWidth, windowHeight;
int curtainHeight;

//character size and position declaration
int charX,charY,charWidth,charHeight;
//character eyebrow arc and mouth arc declaration (changes in program to show emotion)
int browArc;
float mouthArc1, mouthArc2;

//desk size and position declaration
int deskX,deskY,deskWidth,deskHeight;

//declare value for # sips & beer height(each time user clicks on beer glass = +1 sips)
int sips, beerCount;
float beerY;

//declare global values for beer glass coordinates
float glassX1, glassX2, glassY1, glassY2; 

//declare boolean for window open flag
boolean windowOpen;


//initialize room settings and character
void setup()
{
   size(800,800);
   
   //room setting assignment
   baseboardY = height*2/3;
   baseboardHeight = height/25;
   windowX = width*2/3;
   windowY = height/3;
   windowWidth = width/5;
   windowHeight = windowWidth;
   curtainHeight = windowHeight-20;
   
  //character size and position assignment
  charX = width/3;
  charY = height/2;
  charWidth = width/8;
  charHeight = charWidth*3/2;
  
  //desk assignment
  deskX = charX;
  deskY = charY+charHeight;
  deskWidth = width/2;
  deskHeight = deskWidth/6;
  
  //initialize beer count
  beerCount = 0;
  
  //initialize frame rate
  frameRate(10);
  
}

void draw()
{
  drawRoom(); //draws background and window
  
  drawPerson();
  
  drawDesk(); //draws desk and static objects (i.e. computer)
  
  drawBeer();
  
  //display instructions
  fill(0);
  text("Click on the beer to have a sip!", width/10, height/20);
  text("Open the window for some fresh air!", width/10, height/20+20);
  text("Press the space bar to sober up.", width/10, height/20+40);
  //display number of beers
  fill(0);
  text("Beers down: "+ beerCount,width/10,height/20+60);
  
  //vision is getting blurry!
  filter(BLUR,beerCount);
  
  //it gets buggy if you open the window!
  windowOpen();

}

//draws room and static obects (background, window, desk, and macbook)
void drawRoom()
{
  //draw room (wall, floor, baseboard)
  stroke(0);
  fill(wallColor);
  rectMode(CORNER);
  rect(0,0,width,baseboardY);
  fill(255);
  rect(0,baseboardY,width,baseboardHeight);
  fill(carpetColor);
  rect(0,baseboardY+baseboardHeight,width,height);
  
  //draw window
  stroke(255);
  strokeWeight(15);
  fill(49,242,231);
  rectMode(CENTER);
  rect(windowX,windowY,windowWidth,windowHeight);
  stroke(0);
  strokeWeight(1);
  //draw sun
  fill(sunColor);
  ellipse(windowX-windowWidth/4,windowY-windowHeight/5,windowWidth/4,windowHeight/4); 
  //draw curtain
  fill(curtainColor);
  rectMode(CORNER);
  rect(windowX-windowWidth/2, windowY-windowHeight/2,windowWidth,curtainHeight);
  //draw curtain ring
  fill(sunColor);
  ellipse(windowX,windowY-windowHeight/2+curtainHeight,10,10);
  
}

//draws character (behind desk)
void drawPerson()
{
  //local variables
  int headWidth=charWidth;
  int headHeight=charWidth;
  int headX=charX;
  int headY=charY-headHeight/2;
    
  //draw hair
  fill(hairColor);
  arc(charX,headY+headHeight/12,headWidth*6/5,headHeight*4/3,PI-PI/3,PI*2+(PI/3));
  
  //draw neck
  fill(skinColor);
  rectMode(CENTER);
  rect(charX,charY,headWidth/6,headWidth/2);
  
  //draw body
  fill(dressColor);
  rect(charX,charY+charHeight/2+headWidth/4,charWidth,charHeight,30);
  
  //draw arms
  int shoulderY = charY+headWidth/4;
  int shoulderWidth = charWidth/4;
  int shoulderX = charX-charWidth*5/8;
  
  stroke(0);
  fill(dressColor);
  rectMode(CORNER);
  rect(shoulderX,shoulderY,shoulderWidth,charHeight/2,30);
  rect(shoulderX+charWidth,shoulderY,shoulderWidth,charHeight/2,30);

  //draw head
  fill(skinColor);
  ellipseMode(CENTER);
  ellipse(headX,headY,headWidth, headHeight); 
  
  //draw bangs
  fill(hairColor);
  arc(headX,headY-headHeight/2,headWidth,headHeight/3,PI/5,PI-PI/5);
          
  //draw eyes
  int eyeXL = charX-headWidth/4;
  int eyeXR = charX+headWidth/4;
  int eyeY = headY-headHeight/6;
  int eyeWidth = headWidth/4;
  int eyeHeight = headWidth/5;
  fill(255);
  ellipse(eyeXL,eyeY,eyeWidth,eyeHeight);
  ellipse(eyeXR,eyeY,eyeWidth,eyeHeight);
  //iris
  fill(eyeColor);
  ellipse(eyeXL,eyeY,eyeWidth/2,eyeHeight/2);
  ellipse(eyeXR,eyeY,eyeWidth/2,eyeHeight/2);
  //pupil
  fill(0);
  ellipse(eyeXL,eyeY,eyeWidth/6,eyeHeight/6);
  ellipse(eyeXR,eyeY,eyeWidth/6,eyeHeight/6);  
  //eyebrows (change shape by changing arc values when bugs swarm)
  strokeWeight(2);
  noFill();
  arc(eyeXL+eyeWidth/6,eyeY-eyeHeight/3, eyeWidth*3/2,eyeHeight, PI+radians(browArc), radians(320)+radians(browArc));
  arc(eyeXR-eyeWidth/6,eyeY-eyeHeight/3, eyeWidth*3/2,eyeHeight, radians(220)-radians(browArc), (PI*2)-radians(browArc));
  
  //eyelids
  //eyes close as beer count increases, resets when space bar pressed (see switch)
  float eyeDroopInner = (PI+PI/4)-((PI/8)*(beerCount+(sips*0.05)));
  float eyeDroopOuter = (PI+PI*3/4)+((PI/8)*(beerCount+(sips*0.05)));
  strokeWeight(1);
  fill(skinColor);
  arc(eyeXL, eyeY, eyeWidth, eyeHeight, eyeDroopInner, eyeDroopOuter, CHORD);
  arc(eyeXR, eyeY, eyeWidth, eyeHeight, eyeDroopInner, eyeDroopOuter, CHORD);
  
  //draw nose
  noFill();
  arc(charX,headY,eyeWidth*3/4,eyeHeight,0,PI+PI/2);
  
  //draw mouth
  //mouth arc and alpha value change if windowOpen = true (character gets angry)
  fill(mouthColor,mouthAlpha); 
  arc(charX,headY+headHeight/4,eyeWidth,eyeHeight,mouthArc1,mouthArc2);

}

//draws desk and laptop
void drawDesk()
{
    //draw desktop
  rectMode(CENTER);
  fill(deskColor);
  rect(deskX,deskY,deskWidth,deskHeight);
  //draw desk stand
  rectMode(CORNER);
  rect(deskX-(deskWidth*3/4)/2,deskY+deskHeight/2,deskWidth*3/4,deskHeight*2);
  
  //draw macbook
  //declare mac variables
  int macX = deskX;
  int macY = deskY-deskHeight/2;
  int macWidth = deskWidth*2/5;
  int macHeight = charHeight*2/3;
  
  //draw computer
  fill(234,232,230);
  rectMode(CENTER);
  rect(macX,macY,macWidth,macHeight,5);
  triangle(macX-macWidth/2,macY+macHeight/2,macX-macWidth/2,macY,macX-macWidth*5/8,macY);
  fill(255);
  ellipse(macX,macY,macWidth/6,macWidth/6);
}

//draw beer using sips counter to determine beer level
void drawBeer()
{
  float glassWidth = charWidth*0.3; //local (only used here)
  float glassHeight = glassWidth*3/2; //local
  glassX1 = deskX + deskWidth/3; //global (used with mousePressed())
  glassY1 = deskY - deskHeight/2 - glassHeight/2;
  glassX2 = glassX1 + glassWidth; //global
  glassY2 = glassY1 + glassHeight; //global
  //beer height increments with # sips (# mouse clicks on glass)
  float beerHeight = glassHeight/6 + sips*2; //local
  beerY = glassY1 + beerHeight; //global
  
  
  //draw beer
  rectMode(CORNERS);
  fill(211,181,4);
  rect(glassX1, beerY, glassX2, glassY2,5);
  
  //draw glass
  fill(255,150);
  rect(glassX1, glassY1, glassX2, glassY2,5);
  
  //more beer notification when empty
  if (beerY >= glassY2-2)
  {
    fill(0);
    text("More beer!", glassX1, glassY1 - 20);
  }
}

//function to determine if window is open, and animates bugs
void windowOpen()
{
  //if the window is open, bugs fly around head, and character gets mad
  //text prompts user to close the window!
  
  if (windowOpen == true)
  {
    curtainHeight = 2;
    //draws 6 bugs at random positions
    for (int i=0; i<5; i++)
    {
      float x = random(deskX-charWidth,deskX+charWidth);
      float y = random(charY-charHeight, charY+charHeight/2);
      float bugWidth = charWidth*.08;
      float bugHeight = bugWidth*0.75;
      fill(0);
      ellipse(x,y,bugWidth,bugHeight);
      arc(x+bugWidth/8,y-bugHeight/2,bugWidth/2,bugHeight*0.7,(PI+PI/2),(PI*2));
      arc(x-bugWidth/8,y-bugHeight/2,bugWidth/2,bugHeight*0.7,(PI),(PI+PI/2));
    }
    //change character's expression
    browArc = 40;
    mouthAlpha = 200;
    mouthArc1= PI;
    mouthArc2= PI*2;
    //prompt user to close the window
    text("CLOSE THE WINDOW!!", windowX, windowY);
  }
  else
  //character appears as normal if window is not open
  {
    browArc = 0;
    mouthAlpha = 0;
    mouthArc1= 0;
    mouthArc2= PI;
    curtainHeight=windowHeight-20;
  }
}

//add interaction values
void mousePressed()
{
  //if (click within beer glass) -> increment sips/beer count
  //# sips feeds into beer height and character's eyelids (character becomes more relaxed)
  //beer count feeds into eyelids, as well as text on the screen.
  //beer count increases = blurring increases
  if ((mouseX > glassX1) && (mouseX < glassX2) && (mouseY > glassY1) && (mouseY < glassY2) && (beerY >= glassY2-2))
  {
    sips = 0;
    beerCount += 1;
  }
  else if ((mouseX > glassX1) && (mouseX < glassX2) && (mouseY > glassY1) && (mouseY < glassY2) && (beerY < glassY2))
  {
    sips += 1;
  }
  
  //if (click within window) -> blinds go up, bugs swarm, char gets angry
  if ((mouseX > windowX-windowWidth/2) && (mouseX < windowX+windowWidth/2) && (mouseY > windowY-windowHeight/2) && (mouseY < windowY+windowHeight/2))
  {
    if (windowOpen == false)
    {
      windowOpen = true;
    }
    else
    {
      windowOpen = false;
    }
  }
}

//allow the user to reset the blur by sobering the character up
void keyPressed()
{
  if (key == ' ')
  {
    sips = 0;
    beerCount = 0;
  }
}