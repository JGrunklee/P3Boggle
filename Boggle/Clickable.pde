
public interface Clickable {
  public boolean IsInside(int x, int y);
  public void MousePressedAction(Object parameter);
  public void MouseReleasedAction(Object parameter);
}

public interface ClickableCallback {
  public void Callback(Object parameter);
}
