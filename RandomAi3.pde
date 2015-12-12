class RandomAi3 extends PlayCharacter
{
  RandomAi3()
  {
    this.setAiName("イカAI3");
    this.setImg(loadImage("ika3.png"));
    this.setWeapon(3);
  }
    
  public int ai(StageTile[][] sT)
  {
    int q=int(random(6));
    return q;
  }
}
