import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import java.awt.Dimension;

public class Window {
  public static final int WINDOW_DEFAULT_HEIGHT_MIN = 300;
  public static final int WINDOW_DEFAULT_WIDTH_MIN = 400;
  
  public void ConfigureResizeable() {
    ConfigureResizeable(WINDOW_DEFAULT_WIDTH_MIN, WINDOW_DEFAULT_HEIGHT_MIN);
  }
  
  public void ConfigureResizeable(int minWidth, int minHeight) {
    Dimension d = new Dimension(minWidth, minHeight);
    ConfigureResizeable(d);
  }
  
  public void ConfigureResizeable(Dimension dim) {
    SmoothCanvas sc = (SmoothCanvas) getSurface().getNative();
    JFrame jf = (JFrame) sc.getFrame();
    jf.setMinimumSize(dim);
    println(jf.getMinimumSize());
    getSurface().setResizable(true);
  }
}
