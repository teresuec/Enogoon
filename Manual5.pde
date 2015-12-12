class Manual5 extends PlayCharacter
{
  Manual5()
  {
    this.setAiName("手動");
    this.setImg(loadImage("ika10.png"));
    this.setWeapon(5);
  }
  
  public void stop(){
    this.setMove(0);
    this.setMoving(0);
  }
  
  public int ai(StageTile[][] sT)
  {
    if(keyPressed)
    {
      if(key=='w'){
        return 1;
      }else if(key=='d'){
        return 2;
      }else if(key=='s'){
        return 3;
      }else if(key=='a'){
        return 4;
      }else if(key==' '){
        return 5;
      }else{
        return 0;
      }
    }else{
      return 0;
    }
  }
}
