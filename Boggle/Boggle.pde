BoggleDice dice;
String[] Letters;

PFont f, h;

// Game settings
final int DieCount = 5; // Number of dice along one edge of the boggle grid
final int GameDuration = 10; //number of seconds the games should last
final int Radius = 30; //Global box radius

// Variables that will get moved into a BoggleGame object later
int timeLeft;
Boggle_Timer countDownTimer;
Grid mainGrid; // Root graphical object
Grid boggleGrid; // The grid with all the boggle letters
TextBox timeBox; // Textbox displaying the time left
TextBox DiePointers[][]; // Textboxes for each boggle die letter
Button myButton, timesUpButton;

// Variables for detecting screen resizing
int lastHeight;
int lastWidth;

void setup() 
{
  /*Determines size of graphics box, gets dice info from Boggle_Dice,
  creates the fonts, and randomly selects background color*/
  
  // Configure window
  Window w = new Window();
  w.ConfigureResizeable(600, 600); // Minimum screen size
  size(1000, 1000); // Screen size on startup
  
  // Colors and fonts
  f = createFont("Britannic", 40, true);
  h = createFont("Franklin Gothic Book", 20, true);
  
  // Set up game backend elments  
  dice = new BoggleDice(BoggleDiceType.BIG);
  DiePointers = new TextBox[DieCount][DieCount];
  Letters = dice.GetDice();
  countDownTimer = new Boggle_Timer(1000); //1000 milliseconds = 1 second. This is the timer interval
  timeLeft = GameDuration;
  
  /// This grid contains all the other objects ///
  mainGrid = new Grid(3, 3).SetDimensions(0,0,width,height).SetBackground(color(64)).SetVisible(true);
  
  /// Set up boggle grid ///
  boggleGrid = mainGrid.SetChild(new Box(20), 0, 0, 2, 2).SetBackground(randomColor()).SetRadius(Radius)
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
        .SetRadius(Radius);
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
    .SetRadius(Radius);
    
  /// Textbox containing the leaderboard ///
  mainGrid.SetChild(new TextBox("Leaderboard",20),2,0)
    .SetSize(20)
    .SetAlignment(CENTER,TOP)
    .SetRadius(Radius);
    
  /// Textbox containing the timer ///
  timeBox = mainGrid.SetChild(new TextBox("Time Left",20),2,1)
    .SetTextColor(color(255,0,0))
    .SetSize(20)
    .SetAlignment(CENTER,CENTER)
    .SetRadius(Radius);
    
  myButton = mainGrid.SetChild(new Button("New Board", 20),2,2)
    .SetPressedBackground(color(200))
    .SetClickCommand(new NewBoardCallback())
    .SetAlignment(CENTER,CENTER)
    .SetSize(20)
    .SetRadius(Radius);
    
  timesUpButton = new Button("Time's Up!", 0)
    .SetPressedBackground(color(200))
    .SetClickCommand(new TimeUpCallback())
    .SetTextColor(randomColor())
    .SetAlignment(CENTER,CENTER)
    .SetSize(40)
    .SetRadius(Radius/2)
    .SetBorder(color(255,0,0));
    
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

/// The code inside of Callback() happens every time you click the button ///
public class NewBoardCallback implements ClickableCallback {
  public void Callback(Object parameter) {
    dice.Generate();
    Letters = dice.GetDice();
    mainGrid.GetChild(0,0).SetBackground(randomColor());
    myButton.SetPressedBackground(randomColor());
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
    timeLeft = GameDuration;
  }
}

public class TimeUpCallback implements ClickableCallback {
  public void Callback(Object parameter) {
    mainGrid.SetChild(null,1,1);
  }
}

void draw() {

  timeBox.SetText("Time left: " + timeLeft/60 + ":" + nf(timeLeft%60,2));
  
  //Runs timer
  if(countDownTimer.complete() == true) {
      if(timeLeft > 0) {
          timeLeft--;
          countDownTimer.start();
          if (timeLeft == 0) {
            mainGrid.SetChild(timesUpButton,1,1);
          }
      }
  }
  
  // Draw everything
  mainGrid.Draw();
  
  // Handle resize
  if(lastHeight != height || lastWidth != width) {
    mainGrid.SetDimensions(0,0,width,height).Update();
    lastHeight = height;
    lastWidth = width;
  }
}

void mousePressed() {
  if(myButton.IsInside(mouseX, mouseY)) {
    myButton.MousePressedAction(null);
  }
  if(timesUpButton.IsInside(mouseX, mouseY)) {
    timesUpButton.MousePressedAction(null);
  }
}

void mouseReleased() {
  if(myButton.GetIsPressed()) {
    myButton.MouseReleasedAction(null);
  }
  if(timesUpButton.IsInside(mouseX, mouseY)) {
    timesUpButton.MouseReleasedAction(null);
  }
}

color randomColor() {
  int r, g, b;
  r = int(random(256));
  g = int(random(256));
  b = int(random(256));
  return color(r,g,b);
}
