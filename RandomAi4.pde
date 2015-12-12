class RandomAi4 extends PlayCharacter
{
  RandomAi4()
  {
    this.setAiName("イカAI4");
    this.setImg(loadImage("ika4.png"));
    this.setWeapon(4);
  }
  
  public int ai(StageTile[][] sT)
  {
    int q=int(random(6));
    return q;
  }
}
