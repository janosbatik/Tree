class SaveSketch {

  // Details of converting to .gif found here:
  // https://sighack.com/post/make-animated-gifs-in-processing

  String projName = "processing";
  String outPutFolder = "frames/";
  String contOutPutFolder = "animate/";
  String outputFileType = ".png";
  boolean saving = false;
  String timeStamp;

  boolean PRINT_PROGRESS = true;

  int saveCount = 0;
  boolean overrideGifFiles = true;
  int maxFrames = 9999;

  SaveSketch(int _maxFrames)
  {
    this();
    maxFrames = _maxFrames;
  }

  SaveSketch(String _projName)
  {
    this();
    projName = _projName;
  }

  SaveSketch()
  {
    timeStamp = NowString();
  }

  void SaveFrameOnKeyPress()
  {
    if (keyPressed) {
      if (key == 's' || key == 'S') {
        SaveStaticFrame();
      }
    }
  }

  void SaveStaticFrame()
  {
    String fileName = outPutFolder+projName+"-"+timeStamp+"-"+nf(saveCount++, 3)+outputFileType;
    save(fileName);
    PrintLn("Saved frame: "+fileName);
  }

  void SaveFramesOnKeyPress()
  {
    if (keyPressed) {
      if (key == 's' || key == 'S') {
        saving = true;
      }
      if (key == 'x' || key == 'X') {
        saving = false;
        PrintLn("Stoped saving frames");
      }
    }
    if (saving)
      SaveFrameForAnimation();
  }

  void SaveFrameForAnimation()
  {
    if (saveCount == 0)
      PrintLn("Starting to save frames");
    String fileName;
    if (overrideGifFiles)
    {
      fileName = outPutFolder+contOutPutFolder+nf(saveCount++, 5)+outputFileType;
    } else {
      fileName = outPutFolder+contOutPutFolder+timeStamp+"/"+nf(saveCount++, 5)+outputFileType;
    }
    if (saveCount <= maxFrames ) 
      save(fileName);
  }

  String NowString() {
    return 
      nf(year(), 4)
      +nf(month(), 2)
      +nf(day(), 2) 
      +"-"
      +nf(hour(), 2)+"h"
      +nf(minute(), 2)+"m"
      +nf(second(), 2);
  }

  void  PrintLn(String str)
  {
    if (PRINT_PROGRESS)
      println(str);
  }
}
