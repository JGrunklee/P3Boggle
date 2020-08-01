public class Button extends TextBox implements Clickable {
  private boolean IsPressed = false;
  private ClickableCallback ClickCommand;
  protected color PressedBackground;
  private color BackgroundColorHelper;
  
  /// Constructors ///
  
  public Button(String text, int x, int y, int w, int h) { // Fixed size
    super(text,x,y,w,h);
    PressedBackground = Background;
  }
  
  public Button(String text, int margin) { // automatic size
    super(text,margin);
    PressedBackground = Background;
  }
  
  /// Implement Clickable functions ///
  
  public boolean IsInside(int x, int y) {
    return (
      (x > GetX()) &&
      (x < GetX() + GetWidth()) &&
      (y > GetY()) &&
      (y < GetY() + GetHeight())
      );
  }
  
  public void MousePressedAction(Object parameter) {
    IsPressed = true;
    BackgroundColorHelper = Background;
    Background = PressedBackground;
  }
  public void MouseReleasedAction(Object parameter) {
    IsPressed = false;
    Background = BackgroundColorHelper;
    ClickCommand.Callback(parameter);
  }
  
  /// Draw methods ///
  
  // Button just uses the parent (TextBox) draw methods
  
  /// Get/Set ///
  
  public <T extends Button> T SetPressedBackground(color c) { PressedBackground = c; return (T)this; }
  public <T extends Button> T SetClickCommand(ClickableCallback ccb) { ClickCommand = ccb; return (T)this;}
}
