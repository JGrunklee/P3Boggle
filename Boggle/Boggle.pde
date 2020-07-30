
int col, lastWidth,lastHeight;

Box b;
Grid g;
TextBox t;
 
void setup() {
  Window w = new Window();
  w.ConfigureResizeable(500, 500);
  size(500, 500);
  
  int rows = 5;
  int columns = 5;
  
  // Look! Boxes!
  b = new Box(0, 0, width, height);

  Box innermost = b.CreateChild(20, color(255))
    .CreateChild(30, color(128))
      .CreateChild(40, color(64));
  g = new Grid(innermost,20,rows,columns);
  innermost.SetChild(g);
  
  Box temp = b;
  for(int i=0; i<rows; i++) {
    for(int j=0; j<columns; j++) {
      temp = g.CreateChildBox(0,i,j);
      temp.SetBackground(color((int)random(255),(int)random(255),(int)random(255)));
    }
  }
  t = (TextBox)temp.SetChild(new TextBox("Hi",temp,5));
  t.SetAlignment(CENTER, CENTER);
  t.SetSize(0);
  t.SetBackground(temp.Background);
  t.SetBorderVisible(false);
  t.Update();
  lastWidth = width;
  lastHeight = height;
}
 
void draw() {
  if (frameCount % 300 == 1) {
    col = (int)random(0xff000000);
    b.SetBackground(col);
    t.SetText(str(col));
  }
  background(255,255,255);
  if(lastWidth != width || lastHeight != height)
  {
    lastWidth = width;
    lastHeight = height;
    int smaller = min(width, height);
    b.Update(0,0, smaller, smaller);
  }
  b.Draw();
  
}
