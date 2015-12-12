class RandomAi5 extends PlayCharacter
{
  RandomAi5()
  {
    this.setAiName("イカAI5");
    this.setImg(loadImage("ika5.png"));
    this.setWeapon(5);
  }
  
  public int ai(StageTile[][] sT)
  {
    int q=int(random(5));
    return q;
  }
}
