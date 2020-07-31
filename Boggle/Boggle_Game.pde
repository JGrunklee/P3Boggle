
Boggle_Dice dice;
String[] Letters;

PFont f;
PFont h;
int r, g, b;

Boggle_Timer countDownTimer;
int timeLeft;


void setup() 
{
  
  /*Determines size of graphics box, gets dice info from Boggle_Dice,
  creates the fonts, and randomly selects background color*/
  
  size(1000, 1600);
  dice = new Boggle_Dice();
  Letters = dice.GetDice();
  f = createFont("Britannic", 40, true);
  h = createFont("Franklin Gothic Book", 20, true);
  r = int(random(256));
  g = int(random(256));
  b = int(random(256));
  fill(r,g,b);
  
  //1000 milliseconds = 1 second. This is the timer interval
  countDownTimer = new Boggle_Timer(1000);
  timeLeft = 10;
}

//Feature where the board and timer resets when mouse is pressed. 
//Leadership board would remain the same and shuffle in ranking order.

/*void startTimer() {
  
  if(mousePressed == true) {
      countDownTimer.start();
  }  
}*/

void draw() 
{
  
  //Draws background  
  fill(r,g,b);
  rect(30, 30, width-60, width-60, 20, 20, 20, 20);
  
  //Draws dice
  fill(255, 255, 255);
  for(int i=0; i<4; i++)
  {
      for(int j=0; j<4; j++)
      {
          //Determines size of dice
          rect(i*((width-60)/4)+60, j*((width-60)/4)+60, (width-120)/4-60, (width-120)/4-60, 20, 20, 20, 20);
      }
  }
  
  //Draws point scale box
  fill(255, 255, 255);
  rect(30, 1000, 400, 370, 20, 20, 20, 20);
  fill(0, 0, 0);
  textFont(h, 40);
  text("Point System:", 40, 1050);
  text("3-4 letters = 1 point", 40, 1150);
  text("5 letters = 2 points", 40, 1200); 
  text("6 letters = 3 points", 40, 1250); 
  text("7 letters = 5 points", 40, 1300); 
  text("7+ letters = 11 points", 40, 1350);
  
  //Draws player leadership board
  fill(255, 255, 255);
  rect(450, 1000, 520, 370, 20, 20, 20, 20);
  fill(0, 0, 0);
  textFont(h, 40);
  text("Leadership Board:", 460, 1050);
  
  //Draws timer box
  fill(255, 255, 255); 
  rect(30, 1400, 400, 100, 20, 20, 20, 20);
  String timeText = "Time left: " + timeLeft;
  fill(255, 0, 0);
  textFont(h, 40);
  text(timeText, 40, 1460);
  
  //Runs timer
  if(countDownTimer.complete() == true) {
      if(timeLeft > 0) {
          timeLeft--;
          countDownTimer.start();
      }    
  }
  
  //Draws letters for each dice
  fill(0, 0, 0);
  textFont(f, 100);
  for(int i=0; i<4; i++)
  {
      for(int j=0; j<4; j++)
      {
          text(Letters[4*i+j], i*240+100, j*240+170);
      }      
  }
   
}
