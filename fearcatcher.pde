import io.socket.emitter.*;
import io.socket.client.*;

public static final String FEARCATCHER_ADDRESS = "http://127.0.0.1:3000/";



volatile int[] faceData = new int[8];

volatile int anger;
volatile int contempt;
volatile int disgust;
volatile int fear;
volatile int happiness;
volatile int neutral;
volatile int sadness;
volatile int surprise;
volatile int mm;
volatile int instant;

Socket socket;

void initFearCatcher() {
  try {
    socket = IO.socket(FEARCATCHER_ADDRESS);
    socket.on("face:analyzed", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
        org.json.JSONObject obj = (org.json.JSONObject)incoming[0];
        try {
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
          faceData[0] = (int)(255.0 * obj.getDouble("neutral"));
          faceData[1] = (int)(255.0 * obj.getDouble("anger"));
          faceData[2] = (int)(255.0 * obj.getDouble("fear"));
          faceData[3] = (int)(255.0 * obj.getDouble("sadness"));
          faceData[4] = (int)(255.0 * obj.getDouble("surprise"));
          faceData[5] = (int)(255.0 * obj.getDouble("disgust"));
          faceData[6] = (int)(255.0 * obj.getDouble("happiness"));
          faceData[7] = (int)(255.0 * obj.getDouble("contempt"));
          
          int highEmotion = getHighIndex();
          color emotionColor = color(random(255), random(255), random(255));
          int xPos = int(random(width - 200));
          int yPos = int(random(height));
          if(highEmotion == 0){
            messages.add(new Message("You seem neutral", emotionColor, xPos, yPos));
          } else if(highEmotion == 1) {
            messages.add(new Message("You seem angry", emotionColor, xPos, yPos));
          } else if(highEmotion == 2) {
            messages.add(new Message("You seem afraid", emotionColor, xPos, yPos));
          } else if(highEmotion == 3) {
            messages.add(new Message("You seem sad", emotionColor, xPos, yPos));
          } else if(highEmotion == 4) {
            messages.add(new Message("You seem surprised", emotionColor, xPos, yPos));
          } else if(highEmotion == 5) {
            messages.add(new Message("You seem disgusted", emotionColor, xPos, yPos));
          } else if(highEmotion == 6) {
            messages.add(new Message("You seem happy", emotionColor, xPos, yPos));
          } else if(highEmotion == 7) {
            messages.add(new Message("You seem contempt", emotionColor, xPos, yPos));
          }
          trys--;
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    });
    socket.on("moodmetric:data", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
      }
    });
    socket.on("moodmetric:ring:removed", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
      }
    });
    socket.on("moodmetric:ring:inserted", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
      }
    });
    socket.connect();
  } catch (Exception ex) {
    print("Couldn't initialize FearCatcher: ", ex.getMessage());
  }
}