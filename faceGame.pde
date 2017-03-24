import processing.sound.*;

ArrayList<PImage> faceImages = new ArrayList<PImage>();
ArrayList<Message> messages = new ArrayList<Message>();

volatile int trys = 5;

long failTimer = 10000;
int currentIndex = int(random(8));

SoundFile fail;
SoundFile success;

void setup() {
  //size(1024, 800, P2D);
  fullScreen();
  fail = new SoundFile(this, "fail.mp3");
  success = new SoundFile(this, "success.wav");
  
  faceImages.add(loadImage("data/neutral.jpg"));
  faceImages.add(loadImage("data/angry.jpg"));
  faceImages.add(loadImage("data/fear.jpg"));
  faceImages.add(loadImage("data/sad.jpg"));
  faceImages.add(loadImage("data/surprise.jpg"));
  faceImages.add(loadImage("data/disgust.jpg"));
  faceImages.add(loadImage("data/happy.jpg"));
  faceImages.add(loadImage("data/contempt.jpg"));
  
  initFearCatcher();
  /*
  0 -> neutral
  1 -> angry
  2 -> fear
  3 -> sad
  4 -> surprise
  5 -> disgust
  6 -> happy
  7 -> contempt
  */
}

public int getHighIndex(){
  int currentHighIndex = 0;
  int currentHighValue = 0;
  for(int i = 0; i < faceData.length;i++){
    if(faceData[i] > currentHighValue) {
      currentHighIndex = i;
      currentHighValue = faceData[i];
    }
  }
  return currentHighIndex;
}

void updateIndex(){
  int prevIndex = currentIndex;
  currentIndex = int(random(8));
  if(currentIndex == prevIndex) {
    currentIndex++;
    if(currentIndex > 7){
      currentIndex = 0;
    }
  }
}

void draw(){
  background(0);
  int highIndex = getHighIndex();
  if(currentIndex == highIndex) {
    success.play();
    trys = 5;
    updateIndex();
  } else if(trys <= 0) {
    fail.play();
    trys = 5;
    updateIndex();
  }
  image(faceImages.get(currentIndex), 0, 0, width, height);
  for (int i = messages.size() - 1; i >= 0; i--) {
    Message msg = messages.get(i);
    msg.draw();
    if (msg.y < 0) {
      messages.remove(i);
    }
  }
}