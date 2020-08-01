/*
class Box
@author JGrunklee
@date July 2020

Represents a Processing 3 rectangle (drawn with rect() function).
Supports nesting (inner shape(s) with fixed margin), as well as auto-resizing. 
*/
public class Box {
  
  /// Fields  ///
  
  private int X, Y, Height, Width;         //Boxes have these dimensions (assume default rectMode)
  private int Margin = 0;                  //Space surrounding this box, separating it from its parent
  private Box Child = null;                //Boxes may have zero or one child (inner) boxes
  private Box Parent = null;               //Most boxes may have zero or one parent (containing) boxes
  private boolean ResizeWithParent;        //False to turn off auto-resizing
  protected boolean IsVisible = true;      //Boxes may or may not be drawn
  protected color Background = color(255); //Fill color
  protected color Border = color(0);       //Stroke color
  protected Boolean DrawBorder = true;     //Sets noStroke() for this instance only 
  protected int Radius = 0;                //Boxes can have rounded corners
  
  /// Constructors ///
  
  /**
   * Use this to make a Box that takes up the whole window (i.e. a root box).
   */
  public Box() {
    System.out.println("Box()");
    X = 0; Y = 0;
    Width = width; Height = height;
    ResizeWithParent = false;
  }
  
  /**
   * Manually create a box. You must manually resize it as well if you use this constructor.
   * This holds true even if this box has a parent.
   */
  public Box(int x, int y, int w, int h) {
    System.out.println("Box(int x, int y, int w, int h)");
    X = x; Y = y;
    Width = w; Height = h;
    ResizeWithParent = false;
  }
  
  /**
   * Create a box with a fixed margin separating it from its parent.
   * Use <parentObject>.SetChild(<childObject>,...) to establish child/parent relationships.
   * This box will automatically resize with its parent.
   */
  public Box(int margin) {
    System.out.println("Box(int margin)");
    Margin = margin;
    ResizeWithParent = true;
  }
  
  /// Methods ///

  public void Copy(Box model) { // Copy the properties of model into this
    X = model.GetX();
    Y = model.GetY();
    Width = model.GetWidth();
    Height = model.GetHeight();
  }
  
  /**
   * Calculate the box's dimensions based on parent's dimensions and margin.
   * Does nothing for boxes with manually-set dimensions or no parent.
   */
  protected void UpdateSelf() {
    System.out.println("Box UpdateSelf()");
    if(Parent != null && ResizeWithParent) {
      X = Parent.GetX() + Margin;
      Y = Parent.GetY() + Margin;
      Width = Parent.GetWidth() - 2*Margin;
      Height = Parent.GetHeight() - 2*Margin;
    }
  }
  
  protected void UpdateChild() {
    if(Child != null)
    {
      Child.Update();
    }
  }
  
  /**
   * Automatically resize this box and all child object(s)
   */
  public final void Update() { 
    UpdateSelf();
    UpdateChild();
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
  
  /**
   * Call from Processing 3 draw() to render this object and all child object(s)
   */
  public final void Draw() {
    DrawSelf();
    DrawChild();
  }
  
  /// Get/Set ///
  
  // Public setter methods implement a fluent interface (i.e. encourages method chaining)
  // by returning an instance to the calling object. This object might be a derived type, hence the use of generics.
  // Continue the use of this pattern in derived classes as well.
  
  public int GetX() { return X; }
  public int GetY() { return Y; }
  public int GetWidth() { return Width; }
  public int GetHeight() { return Height; }
  public int GetMargin() { return Margin; }
  public <T extends Box> T SetDimensions(int x, int y, int w, int h) {
    X = x; Y = y;
    Width = w; Height = h;
    ResizeWithParent = false;
    return (T)this;
  }
  public <T extends Box> T SetVisible(Boolean visible)       { IsVisible = visible;   return (T)this; }
  public <T extends Box> T SetBackground(color c)            { Background = c;        return (T)this; }
  public <T extends Box> T SetMargin(int m)                  { Margin = m;            return (T)this; }
  public <T extends Box> T SetBorder(color c)                { Border = c;            return (T)this; }
  public <T extends Box> T SetBorderVisible(Boolean visible) { DrawBorder = visible;  return (T)this; }
  public <T extends Box> T SetRadius(int radius)             { Radius = radius;       return (T)this; }
  
  public <T extends Box> T SetChild(T child) {
    Child = child;
    if(Child != null) {
      Child.SetParent(this);
      Child.Update();
    }
    return child;
  }
  public Box GetChild() { return Child; }
  public Box GetParent() { return Parent; }
  private void SetParent(Box parent) {Parent = parent;}  
} //END class Box
