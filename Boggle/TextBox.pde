public class TextBox extends Box {
  private String Text;
  private int TextX, TextY;
  private color TextColor = color(0);
  private Boolean Wrap = false;
  private int Size = 12;
  private int HorizontalAlignment = LEFT;
  private int VerticalAlignment = TOP;
  
  /// Constructors ///
  
  public TextBox(String text, int x, int y, int w, int h, int m) {
    super(x,y,w,h,m);
    Text = text; TextX = X; TextY = Y;
    CalculateTextPosition();
  }
  
  public TextBox(String text, int x, int y, int w, int h, int m, color c) {
    super(x,y,w,h,m,c);
    Text = text; TextX = X; TextY = Y;
    CalculateTextPosition();
  }
  
  public TextBox(String text, Box parent, int margin) {
    super(parent, margin);
    Text = text; TextX = X; TextY = Y;
    CalculateTextPosition();
  }
  
  public TextBox(String text, Box parent, int margin, color c) {
    super(parent, margin, c);
    Text = text; TextX = X; TextY = Y;
    CalculateTextPosition();
  }

  /// Methods ///
  
  public void Update() {
    System.out.println("TextBox Update()"); //for debugging
    CalculateDimensions();
    CalculateTextPosition();
    if(Child != null)
    {
      Child.Update();
    }
  }
  
  protected void CalculateTextPosition()
  {
    switch(HorizontalAlignment) {
      case LEFT:
        TextX = X; break;
      case CENTER:
        TextX = X + Width/2; break;
      case RIGHT:
        TextX = X + Width; break;
      default:
        TextX = X; break;
    }
    switch(VerticalAlignment) {
      case TOP:
        TextY = Y; break;
      case BOTTOM:
        TextY = Y + Height; break;
      case CENTER:
        TextY = Y + Height/2; break;
      default:
        TextY = Y; break;
    }
  }
  
  public void DrawSelf() {
    super.DrawSelf();
    if(IsVisible) {
      fill(TextColor);
      textAlign(HorizontalAlignment, VerticalAlignment);
      textSize(Size);
      if(Wrap) {
        text(Text,TextX,TextY, X+Width, Y+Width);
      }
      else {
        text(Text, TextX, TextY);
      }
    }
  }
  
  /// Get/Set ///
  
  public void SetAlignment(int xAlign, int yAlign) {
    if(xAlign == LEFT || xAlign == CENTER || xAlign == RIGHT) {
      HorizontalAlignment = xAlign;
    }
    else {
      System.out.println("TextBox SetAlignment(int,int): invalid horizontal alignment");
    }
    if(yAlign == TOP || yAlign == BOTTOM || yAlign == CENTER) {
      VerticalAlignment = yAlign;
    }
    else {
      System.out.println("TextBox SetAlignment(int,int): invalid vertical alignment");
    }
  }
  public void SetText(String text) { Text = text; }
  public void SetSize(int size) {
    if(size == 0) {
      Size = Height;
    }
    else {
      Size = size;
    }
      
  }
  public String GetText() { return Text; }
  public void SetWrap(Boolean wrap) { Wrap = wrap; }
  public void SetTextColor(color c) {TextColor = c; }
}
