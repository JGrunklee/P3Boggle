/*
class Grid

Grid IS A Box, but instead of having 1 child, it has a 2-D array of children.
*/
public class Grid extends Box { //  
  protected int Rows = 0;
  protected int Columns = 0;
  protected int[] XCoords;
  protected int[] YCoords;
  protected Box[][] Children;
  
  /// Constructors ///
  
  public Grid(Box parent, int margin, int rows, int columns) {
    super(parent, margin); //<>//
    this.SetVisible(false);
    Rows = rows;
    Columns = columns;
    
    Children = new Box[Rows][Columns]; // i.e. [Y][X]
    Child = null;
    XCoords = new int[Columns + 1];
    YCoords = new int[Rows + 1];
    this.CalculateCells();
  }
  
  /// Methods ///
  
  public void Update() {
    System.out.println("Grid Update(Box)");
    super.Update();
    this.CalculateCells();
    
    for(int i=0; i<Rows; i++) { // Update children
      for(int j=0; j<Columns; j++) {
        if(Children[i][j] != null) {
          Children[i][j].Update(
            XCoords[j],
            YCoords[i],
            XCoords[j+1]-XCoords[j],
            YCoords[i+1]-YCoords[i]);
        }
      }
    }
  }
  
  public Box CreateChildBox(int margin, int row, int column) { 
    System.out.println("Grid CreateChildBox(int,int,int)");
    CheckExists(row,column);
    Children[row][column] = new Box(
      XCoords[column],
      YCoords[row],
      XCoords[column+1]-XCoords[column],
      YCoords[row+1]-YCoords[row],
      margin);
    return Children[row][column];
  }
  
  public Box CreateChildBox(int margin, int row, int column, int rowSpan, int columnSpan) { 
    System.out.println("Grid CreateChildBox(int,int,int)");
    CheckExists(row,column);
    Children[row][column] = new Box(
      XCoords[column],
      YCoords[row],
      XCoords[column+columnSpan]-XCoords[column],
      YCoords[row+rowSpan]-YCoords[row],
      margin);
    return Children[row][column];
  }
  
  protected void CalculateCells() {
    for(int i=0; i<Columns; i++) { // Calculate X coordinates
      XCoords[i] = X + (Width*i)/Columns;
    }
    XCoords[Columns] = X + Width;
    
    for(int i=0; i<Rows; i++) { // Calculate Y coordinates
      YCoords[i] = Y + (Height*i)/Rows;
    }
    YCoords[Rows] = Y + Height;
  }
  
  public void DrawChild() {
    for(int i=0; i<Rows; i++) { // Draw children
      for(int j=0; j<Columns; j++) {
        if(Children[i][j] != null) {
          Children[i][j].Draw();
        }
      }
    }
  }
  
  protected void CheckExists(int row, int column) {
    if(row < 0 || row >= Rows) {
      throw new IllegalArgumentException("Grid: Row " + row + " does not exist.");
    }
    if(column < 0 || column >= Columns) {
      throw new IllegalArgumentException("Grid: Column " + column + " does not exist.");
    }
  }
  
  /// Get/Set ///
  
  public Box GetChild(int row, int column) { // Zero-indexed!
    this.CheckExists(row, column);
    if( Children[row][column] == null) {
      return new Box(
        XCoords[column],
        YCoords[row],
        XCoords[column+1]-XCoords[column],
        YCoords[row+1]-YCoords[row]);
    }
    return Children[row][column];

  }
  public Box SetChild(Box child, int row, int column) {
    this.CheckExists(row,column);
    Children[row][column] = child;
    return Children[row][column];
  }
  public int GetRows() { return Rows; }
  public int GetColumns() { return Columns; }
}
