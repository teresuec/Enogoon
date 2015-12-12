class RandomAi2 extends PlayCharacter
{
  RandomAi2()
  {
    this.setAiName("イカAI2");
    this.setImg(loadImage("ika2.png"));
    this.setWeapon(2);
  }
    
  public int ai(StageTile[][] sT)
  {
    int q=int(random(6));
    return q;
  }
}
