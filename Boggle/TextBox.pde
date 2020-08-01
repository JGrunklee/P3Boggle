public class TextBox extends Box {
  private String Text;
  private int TextX, TextY;
  protected color TextColor = color(0);
  protected Boolean Wrap = false;
  protected int Size = 12;
  protected int HorizontalAlignment = LEFT;
  protected int VerticalAlignment = TOP;
  
  /// Constructors ///
  
  public TextBox(String text, int x, int y, int w, int h) {
    super(x,y,w,h);
    Text = text;
  }
  
  public TextBox(String text, int margin) {
    super(margin);
    Text = text;
  }

  /// Methods ///
  
  protected void UpdateSelf() {
    System.out.println("TextBox UpdateSelf()"); //for debugging
    super.UpdateSelf();
    CalculateTextPosition();
  }
  
  protected void CalculateTextPosition()
  {
    switch(HorizontalAlignment) {
      case LEFT:
        TextX = GetX(); break;
      case CENTER:
        TextX = GetX() + GetWidth()/2; break;
      case RIGHT:
        TextX = GetX() + GetWidth(); break;
      default:
        TextX = GetX(); break;
    }
    switch(VerticalAlignment) {
      case TOP:
        TextY = GetY(); break;
      case BOTTOM:
        TextY = GetY() + GetHeight(); break;
      case CENTER:
        TextY = GetY() + GetHeight()/2; break;
      default:
        TextY = GetY(); break;
    }
  }
  
  public void DrawSelf() {
    super.DrawSelf();
    if(IsVisible) {
      fill(TextColor);
      textAlign(HorizontalAlignment, VerticalAlignment);
      textSize(Size);
      if(Wrap) {
        text(Text,TextX,TextY, X+GetWidth(), Y+GetWidth());
      }
      else {
        text(Text, TextX, TextY);
      }
    }
  }
  
  /// Get/Set ///
  
  public <T extends TextBox> T SetAlignment(int xAlign, int yAlign) {
    if(xAlign == LEFT || xAlign == CENTER || xAlign == RIGHT) {
      HorizontalAlignment = xAlign;
    }
    else {
      throw new IllegalArgumentException("TextBox SetAlignment(int,int): invalid horizontal alignment");
    }
    if(yAlign == TOP || yAlign == BOTTOM || yAlign == CENTER) {
      VerticalAlignment = yAlign;
    }
    else {
      throw new IllegalArgumentException("TextBox SetAlignment(int,int): invalid vertical alignment");
    }
    return (T)this;
  }
  public <T extends TextBox> T SetSize(int size) {
    if(size == 0) {
      Size = GetHeight();
    }
    else {
      Size = size;
    }
    return (T) this;
  }  
  public <T extends TextBox> T SetText(String text)  { Text = text;   return (T)this; }
  public String GetText() { return Text; }
  public <T extends TextBox> T SetWrap(Boolean wrap) { Wrap = wrap;   return (T)this; }
  public <T extends TextBox> T SetTextColor(color c) { TextColor = c; return (T)this; }
}
