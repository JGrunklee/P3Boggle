Boggle_Dice dice;
String[] Letters;

PFont f;
PFont h;
int r, g, b;

int DieCount = 4; // Number of dice along one edge of the boggle grid

Boggle_Timer countDownTimer;
int timeLeft = 65;

Grid mainGrid; // Root graphical object
TextBox timeBox; // Textbox displaying the time left
TextBox DiePointers[][];
Button myButton;
int lastHeight;
int lastWidth;

void setup() 
{
  /*Determines size of graphics box, gets dice info from Boggle_Dice,
  creates the fonts, and randomly selects background color*/
  
  Window w = new Window();
  w.ConfigureResizeable(400, 400);
  size(400, 400);
  dice = new Boggle_Dice();
  DiePointers = new TextBox[DieCount][DieCount];
  Letters = dice.GetDice();
  f = createFont("Britannic", 40, true);
  h = createFont("Franklin Gothic Book", 20, true);
  r = int(random(256));
  g = int(random(256));
  b = int(random(256));
  fill(r,g,b);
  
  //1000 milliseconds = 1 second. This is the timer interval
  countDownTimer = new Boggle_Timer(1000);
  
  /// This grid contains all the other objects ///
  mainGrid = new Grid(3, 3).SetDimensions(0,0,width,height).SetBackground(color(64)).SetVisible(true);
  
  /// Set up boggle grid ///
  Grid boggleGrid = mainGrid.SetChild(new Box(20), 0, 0, 2, 2).SetBackground(color(r,g,b)).SetRadius(20)
    .SetChild(new Grid(DieCount, DieCount)).SetMargin(20);
  
  for(int row=0; row<DieCount; row++) {
    for(int col=0; col<DieCount; col++) {
      System.out.println("Filling bogglebox. row = " + row + " col = " + col);
      String text;
      if (col*DieCount + row < Letters.length) {
        text = Letters[col*DieCount + row];
      }
      else {
        text = "?";
      }
      TextBox temp = boggleGrid.SetChild(new TextBox(text, 10),row, col)
        .SetSize(0) // Auto-size
        .SetAlignment(CENTER,TOP)
        .SetRadius(20);
      DiePointers[row][col] = temp;
    }
  }
  
  /// Textbox explaining the scoring ///
  String pointString = 
     "Point System:\n" +
     "3-4 letters = 1 point\n" +
     "5 letters = 2 points\n" +
     "6 letters = 3 points\n" +
     "7 letters = 5 points\n" +
     "7+ letters = 11 points";
  mainGrid.SetChild(new TextBox(pointString,20),0,2)
    .SetSize(20)
    .SetAlignment(CENTER, CENTER)
    .SetRadius(20);
    
  /// Textbox containing the leaderboard ///
  mainGrid.SetChild(new TextBox("Leaderboard",20),2,0)
    .SetSize(20)
    .SetAlignment(CENTER,TOP)
    .SetRadius(20);
    
  /// Textbox containing the timer ///
  timeBox = mainGrid.SetChild(new TextBox("Time Left",20),2,1)
    .SetSize(20)
    .SetAlignment(CENTER,CENTER)
    .SetRadius(20);
    
  myButton = mainGrid.SetChild(new Button("New Board", 20),2,2)
    .SetPressedBackground(color(200))
    .SetClickCommand(new NewBoardCallback())
    .SetAlignment(CENTER,CENTER)
    .SetSize(20)
    .SetRadius(20);
    
  mainGrid.Update();
  
  lastHeight = height;
  lastWidth = width;
}

//Feature where the board and timer resets when mouse is pressed. 
//Leadership board would remain the same and shuffle in ranking order.

/*void startTimer() {
  
  if(mousePressed == true) {
      countDownTimer.start();
  }  
}*/

public class NewBoardCallback implements ClickableCallback {
  public void Callback(Object parameter) {
    dice.Generate();
    Letters = dice.GetDice();
    for(int row=0; row<DieCount; row++) {
      for(int col=0; col<DieCount; col++) {
        String text;
          if (col*DieCount + row < Letters.length) {
            text = Letters[col*DieCount + row];
          }
          else {
            text = "?";
          }
        DiePointers[row][col].SetText(text);
      }
    }
  }
}

void draw() {

  timeBox.SetText("Time left: " + timeLeft/60 + ":" + nf(timeLeft%60,2));
  
  //Runs timer
  if(countDownTimer.complete() == true) {
      if(timeLeft > 0) {
          timeLeft--;
          countDownTimer.start();
      }    
  }
  
  mainGrid.Draw();
  
  if(lastHeight != height || lastWidth != width) {
    mainGrid.SetDimensions(0,0,width,height).Update();
    lastHeight = height;
    lastWidth = width;
  }
}

void mousePressed() {
  myButton.MousePressedAction(null);
}

void mouseReleased() {
  myButton.MouseReleasedAction(null);
}
