class SaveUtils {

  // Details of converting to .gif found here:
  // https://sighack.com/post/make-animated-gifs-in-processing

  String projName = "processing";
  String outPutFolder = "frames/";
  String gifFolder = "gif/";
  String timeStamp;
  int saveCount = 0;
  boolean overrideGifFiles = true;
  int maxFrames = 9999;
  
  SaveUtils(int _maxFrames)
  {
    Setup();
    maxFrames = _maxFrames;
  }

  SaveUtils(String _projName)
  {
    Setup();
    projName = _projName;
  }

  SaveUtils()
  {
    Setup();
  }

  void Setup()
  {
    timeStamp = NowString();
  }

  void SaveFrameOnKeyPress()
  {
    if (keyPressed) {
      if (key == 's' || key == 'S') {
        String fileName = outPutFolder+projName+"-"+timeStamp+"-"+nf(saveCount++, 3)+".png";
        save(fileName);
        println("Saved frame: "+fileName);
      }
    }
  }

  void SaveFrame()
  {
    if (saveCount == 0)
      println("Starting to save frames");
    String fileName;
    if (overrideGifFiles)
    {
      fileName = outPutFolder+gifFolder+nf(saveCount++, 7)+".png";
    } else {
      fileName = outPutFolder+gifFolder+timeStamp+"/"+nf(saveCount++, 5)+".png";
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
};
