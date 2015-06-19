public class ideuj{

  public static native void mainproc();

  public static void main(String[] args)

  {
  System.loadLibrary("ideuj");
  mainproc();
  }
}
