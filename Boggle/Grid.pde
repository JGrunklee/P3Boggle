/*
class Grid

Grid IS A Box, but instead of having 1 child, it has a 2-D array of children.
*/
public class Grid extends Box { //  
  private int Rows = 0;
  private int Columns = 0;
  private int[] XCoords;
  private int[] YCoords;
  private GridBox[][] Children;
  
  private class GridBox extends Box { // Encapsulate row span and 
    private int RowSpan, ColSpan;
    protected GridBox(int x, int y, int w, int h, int r, int c) {
      super(x,y,w,h);
      RowSpan = r;
      ColSpan = c;
    }
    public int GetRowSpan() { return RowSpan; }
    public int GetColSpan() { return ColSpan; }
  }
  
  /// Constructors ///
  
  public Grid(int rows, int columns) {
    super(0); //<>//
    this.SetVisible(false);
    Rows = rows;
    Columns = columns;
    
    Children = new GridBox[Rows][Columns]; // i.e. [Y][X]. All children are null at this point
    SetChild(null);
    XCoords = new int[Columns + 1];
    YCoords = new int[Rows + 1];
  }
  
  /// Methods ///
  
  protected void UpdateSelf() {
    super.UpdateSelf();
    CalculateCells();
  }
  
  protected void UpdateChild() {
    for(int i=0; i<Rows; i++) { // Update children
      for(int j=0; j<Columns; j++) {
        if(Children[i][j] != null) {
          GridBox temp = Children[i][j];
          temp.SetDimensions(
            XCoords[j],
            YCoords[i],
            XCoords[j+temp.GetColSpan()]-XCoords[j],
            YCoords[i+temp.GetRowSpan()]-YCoords[i]);
          temp.Update();
        }
      }
    }
  }
  
  protected void CalculateCells() {
    for(int i=0; i<Columns; i++) { // Calculate X coordinates
      XCoords[i] = GetX() + (GetWidth()*i)/Columns;
    }
    XCoords[Columns] = GetX() + GetWidth();
    
    for(int i=0; i<Rows; i++) { // Calculate Y coordinates
      YCoords[i] = GetY() + (GetHeight()*i)/Rows;
    }
    YCoords[Rows] = GetY() + GetHeight();
  }
  
  protected void DrawChild() {
    for(int i=0; i<Rows; i++) { // Draw children
      for(int j=0; j<Columns; j++) {
        if(Children[i][j] != null) {
          Children[i][j].GetChild().Draw();
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
  public <T extends Box> T SetDimensions(int x, int y, int w, int h) {
    T temp = super.SetDimensions(x,y,w,h);
    UpdateSelf();
    return temp;
  }
  public Box GetChild(int row, int column) { // Zero-indexed!
    this.CheckExists(row, column);
    if( Children[row][column] == null) {
      return null;
    }
    else {
      return Children[row][column].GetChild();
    }
  }
  public <T extends Box> T SetChild(T child, int row, int column) {
    return SetChild(child, row, column, 1, 1);
  }
  public <T extends Box> T SetChild(T child, int row, int column, int rowSpan, int colSpan) {
    this.CheckExists(row,column);
    this.CheckExists(row+rowSpan-1, column+colSpan-1);
    Children[row][column] = new GridBox(
        XCoords[column],
        YCoords[row],
        XCoords[column+colSpan]-XCoords[column],
        YCoords[row+rowSpan]-YCoords[row],
        rowSpan,
        colSpan);
    Children[row][column].SetChild(child).Update();
    return (T)Children[row][column].GetChild();
  }
  public int GetRows() { return Rows; }
  public int GetColumns() { return Columns; }
}
