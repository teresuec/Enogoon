class RandomAi1 extends PlayCharacter
{
  RandomAi1()
  {
    this.setAiName("イカAI1");
    this.setImg(loadImage("ika1.png"));
    this.setWeapon(1);
  }
  
  public int ai(StageTile[][] sT)
  {
    int q=int(random(6));
    return q;
  }
}
