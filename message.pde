class Message {
  private String content;
  private int x;
  private int y;
  private color textColor;
  
  public Message(String content, color textColor, int x, int y){
    this.content = content;
    this.textColor = textColor;
    this.x = x;
    this.y = y;
  }
  
  public void draw() {
    this.y = y - 20;
    textSize(32);
    fill(textColor);
    text(content, x, y); 
  }
}