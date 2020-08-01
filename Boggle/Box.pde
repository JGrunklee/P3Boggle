/*
class Box

Convenience base class for drawing nested rectangles 
*/
public class Box {
  
  /// Fields  ///
  
  protected int X, Y, Height, Width;       //Boxes have these dimensions
  protected int Margin = 0;                //Space around this Box
  protected Box Child = null;              //Boxes may have child (inner) boxes
  protected Box Parent = null;             //Most boxes may have a parent (containing) box
  protected Boolean IsVisible = true;      //Boxes may or may not be visible
  protected color Background = color(255); //Boxes have a color
  protected color Border = color(0);       //Border color
  protected Boolean DrawBorder = true;     //Boxes may or may not show their border
  protected int Radius = 0; 
  
  /// Constructors ///
  
  public Box() { // Use this to make a Box that takes up the whole window
    X = 0; Y = 0;
    Width = width; Height = height;
  }
  
  public Box(int x, int y, int w, int h) { // Basic constructor
    X = x; Y = y;
    Width = w; Height = h;
  }
  
  public Box(int x, int y, int w, int h, int m) { 
    Margin = m;
    CalculateDimensions(x,y,w,h);
  }
  
  public Box(int x, int y, int w, int h, int m, color c) {
    Margin = m;
    CalculateDimensions(x,y,w,h);
    Background = c;
  }
  
  public Box(Box parent, int margin) {
    System.out.println("Box(Box, int)");
    Parent = parent;
    Margin = margin;
    CalculateDimensions();
  }
  
  public Box(Box parent, int margin, color c) {
    Parent = parent;
    Margin = margin;
    Background = c;
    CalculateDimensions();
  }
  
  /// Methods ///

  public void Copy(Box model) { // Copy the properties of model into this
    X = model.GetX();
    Y = model.GetY();
    Width = model.GetWidth();
    Height = model.GetHeight();
  }
  
  public void Update() { // Set this box's properties according to its parent
    System.out.println("Box update(Box)");
    CalculateDimensions();
    if(Child != null)
    {
      Child.Update();
    }
  }
  
  public void Update(int parentX, int parentY, int parentW, int parentH) {
    System.out.println("Box update(int, int, int, int)");
    CalculateDimensions(parentX, parentY, parentW, parentH);
    if(Child != null)
    {
      Child.Update();
    }
  }
  
  public Box CreateChild(int margin) { // Initialize the child/inner box
    Child = new Box(this, margin);
    return Child;
  }
  
  public Box CreateChild(int margin, color c) { // Initialize the child/inner box
    System.out.println("Box CreateChild(int, color)");
    Child = new Box(this, margin, c);
    return Child;
  }
  
  protected void CalculateDimensions() {
    CalculateDimensions(Parent.X, Parent.Y, Parent.Width, Parent.Height);
  }
  
  protected void CalculateDimensions(int parentX, int parentY, int parentW, int parentH) {
    X = parentX + Margin;
    Y = parentY + Margin;
    Width = parentW - 2*Margin;
    Height = parentH - 2*Margin;
  }
  
  /// Draw Methods ///
  // IMPORTANT: Only these functions can have Processing drawing commands
  
  protected void DrawSelf() {
    if(IsVisible) {
      fill(Background);
      if(DrawBorder) {
        stroke(Border);
      }
      else {
        noStroke();
      }
      rect(X, Y, Width, Height, Radius);
    }
  }
  
  protected void DrawChild() {
    if(Child != null) {
      Child.Draw();
    }
  }
  
  public void Draw() { // Goal: Derived classes don't need to modify this
    DrawSelf();
    DrawChild();
  }
  
  /// Get/Set ///
  
  public int GetX() { return X; }
  public int GetY() { return Y; }
  public int GetWidth() { return Width; }
  public int GetHeight() { return Height; }
  public void SetVisible(Boolean visible) { IsVisible = visible; }
  public void SetBackground(color c) { Background = c; }
  public void SetMargin(int m) { Margin = m; }
  public void SetBorder(color c) {Border = c; }
  public void SetBorderVisible(Boolean visible) { DrawBorder = visible; }
  public void SetRadius(int radius) {Radius = radius; }
  
  public Box SetChild(Box child) {
    Child = child;
    Child.Parent = this;
    return child;
  }
  public Box GetChild() { return Child; }
  public Box GetParent() { return Parent; }
  
} //END class Box
