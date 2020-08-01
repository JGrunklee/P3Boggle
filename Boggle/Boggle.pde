

Boggle_Dice dice;
String[] Letters;

PFont f;
PFont h;
int r, g, b;

int DieCount = 5; // Number of dice along one edge of the boggle grid

Boggle_Timer countDownTimer, jacob;
int timeLeft;

Grid mainGrid; 

void setup() 
{
  
  /*Determines size of graphics box, gets dice info from Boggle_Dice,
  creates the fonts, and randomly selects background color*/
  
  Window w = new Window();
  w.ConfigureResizeable(1600, 1600);
  size(1600, 1600);
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
  jacob = countDownTimer;
  timeLeft = 100;
  
  mainGrid = new Grid(new Box(0, 0, width, height), 0, 3, 3);
  Box boggleBox = mainGrid.CreateChildBox(20, 0, 0, 2, 2); // margin, row, col, rowSpan, colSpan
  boggleBox.SetBackground(color(r,g,b));
  boggleBox.SetRadius(20);
  Grid boggleGrid = new Grid(boggleBox, 5, DieCount, DieCount);
  boggleBox.SetChild(boggleGrid);
  
  for(int row=0; row<DieCount; row++) {
    for(int col=0; col<DieCount; col++) {
      System.out.println("Filling bogglebox. row = " + row + " col = " + col);
      Box current = boggleGrid.GetChild(row, col);
      System.out.println(current == null);
      TextBox temp = (TextBox) boggleGrid.SetChild(new TextBox("o",current, 20),row, col);
      temp.SetSize(100);
      temp.SetAlignment(CENTER,CENTER);
      temp.SetRadius(20);
      temp.Update();
    }
  }
  
  String pointString = 
     "Point System:\n" +
     "3-4 letters = 1 point\n" +
     "5 letters = 2 points\n" +
     "6 letters = 3 points\n" +
     "7 letters = 5 points\n" +
     "7+ letters = 11 points";
  TextBox points = (TextBox)mainGrid.SetChild(new TextBox(pointString,mainGrid.GetChild(0,2),20),0,2);
  points.SetSize(40);
  points.SetAlignment(CENTER, CENTER);
  points.SetRadius(20);
  points.Update();
}

//Feature where the board and timer resets when mouse is pressed. 
//Leadership board would remain the same and shuffle in ranking order.

/*void startTimer() {
  
  if(mousePressed == true) {
      countDownTimer.start();
  }  
}*/

void draw() {
  mainGrid.Draw();


//int col, lastWidth,lastHeight;

//Box b;
//Grid g;
//TextBox t;
 
//void setup() {
//  Window w = new Window();
//  w.ConfigureResizeable(500, 500);
//  size(500, 500);
  
//  int rows = 5;
//  int columns = 5;
  
//  // Look! Boxes!
//  b = new Box(0, 0, width, height);

//  Box innermost = b.CreateChild(20, color(255))
//    .CreateChild(30, color(128))
//      .CreateChild(40, color(64));
//  g = new Grid(innermost,20,rows,columns);
//  innermost.SetChild(g);
  
//  Box temp = b;
//  for(int i=0; i<rows; i++) {
//    for(int j=0; j<columns; j++) {
//      temp = g.CreateChildBox(0,i,j);
//      temp.SetBackground(color((int)random(255),(int)random(255),(int)random(255)));
//    }
//  }
//  t = (TextBox)temp.SetChild(new TextBox("Hi",temp,5));
//  t.SetAlignment(CENTER, CENTER);
//  t.SetSize(0);
//  t.SetBackground(temp.Background);
//  t.SetBorderVisible(false);
//  t.Update();
//  lastWidth = width;
//  lastHeight = height;
//}
 
//void draw() {
//  if (frameCount % 300 == 1) {
//    col = (int)random(0xff000000);
//    b.SetBackground(col);
//    t.SetText(str(col));
//  }
//  background(255,255,255);
//  if(lastWidth != width || lastHeight != height)
//  {
//    lastWidth = width;
//    lastHeight = height;
//    int smaller = min(width, height);
//    b.Update(0,0, smaller, smaller);
//  }
//  b.Draw();
  
//}
