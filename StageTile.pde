public class StageTile
{
  private int x,y;            //タイルの位置（マス）
  private float xp,yp;        //タイルの左上の隅の座標
  private int paint;          //タイルの色
  private int landmine;       //地雷の有無・種類
  private int time;           //地雷の爆発までの時間
  private int target;         //地雷を踏みそうなプレイヤー
  private int star;           //ミラクルスターの有無
  private int theta;          //ミラクルスターの角度
  private int danger;         //攻撃が来そうかどうか
  private int member;         //プレイヤーの人数
  private int field;          //ステージの広さ
  private float sizex,sizey;  //タイルの大きさ
  
  //コンストラクタ
  StageTile(){};
  StageTile(int x,int y,int f,int m)
  {
    this.field=f;
    this.member=m;
    this.sizex=(width*4/5)/f;
    this.sizey=(height*4/5)/f;
    this.x=x;
    this.y=y;
    this.xp=x*sizex+width/10;
    this.yp=y*sizey+height/10;
    this.paint=0;
    this.landmine=0;
    this.time=0;
    this.target=0;
    this.star=0;
    this.theta=0;
    this.danger=0;
  }
  
  //セッター
  public void setPosition(int xp,int yp){
    this.xp=xp;
    this.yp=yp;
  }
  public void setX(int x){
    this.x=x;
  }
  public void setY(int y){
    this.y=y;
  }
  public void setXp(int xp){
    this.xp=xp;
  }
  public void setYp(int yp){
    this.yp=yp;
  }
  public void setPaint(int paint){
    this.paint=paint;
  }
  public void setLandMine(int landmine){
    this.landmine=landmine;
  }
  public void setTime(int time){
    this.time=time;
  }
  public void setTarget(int target){
    this.target=target;
  }
  public void setRemove(){          //地雷・スターの撤去用セッター
    this.landmine=0;
    this.time=0;
    this.target=0;
    this.star=0;
    this.theta=0;
  }
  public void setStar(int star){
    this.star=star;
  }
  public void setTheta(int theta){
    this.theta=theta;
  }
  public void setDanger(int danger){
    this.danger=danger;
  }
  public void setMember(int member){
    this.member=member;
  }
  public void setField(int field){
    this.field=field;
  }
  public void setSizeX(float sizex){
    this.sizex=sizex;
  }
  public void setSizeY(float sizey){
    this.sizey=sizey;
  }
  
  //ゲッター
  public int getX(){
    return this.x;
  }
  public int getY(){
    return this.y;
  }
  public float getXp(){
    return this.xp;
  }
  public float getYp(){
    return this.yp;
  }
  public int getPaint(){
    return this.paint;
  }
  public int getLandMine(){
    return this.landmine;
  }
  public int getTime(){
    return this.time;
  }
  public int getTarget(){
    return this.target;
  }
  public int getStar(){
    return this.star;
  }
  public int getTheta(){
    return this.theta;
  }
  public int getDanger(){
    return this.danger;
  }
  public int getMember(){
    return this.member;
  }
  public int getField(){
    return this.field;
  }
  public float getSizeX(){
    return this.sizex;
  }
  public float getSizeY(){
    return this.sizey;
  }
  
  //ステージの描画
  public void draw(PlayCharacter[] pL)
  {
    stroke(0);
    if(this.paint==0){          //塗られていればその色で描画
      fill(255);
    }else{
      fill(pL[this.paint-1].getColors());
    }
    rectMode(CORNER);
    rect(this.xp,this.yp,this.sizex,this.sizey);
    if(this.landmine>0)          //地雷の描画
    {
      if((80<this.time&&this.time%40==0)||(this.time<=80&&this.time%5==0)){          //爆発までの時間により点滅
        fill(0);
      }else{
        fill(pL[(this.landmine-1)%this.member].getColors());
      }
      if(this.landmine>this.member){          //大型地雷の描画
        quad(centerx(),centery()-this.sizey/4*sqrt(2),centerx()-this.sizex/4*sqrt(2),centery(),centerx(),centery()+this.sizey/4*sqrt(2),centerx()+this.sizex/4*sqrt(2),centery());
      }
      rect(this.xp+sizex/4,this.yp+sizey/4,this.sizex/2,this.sizey/2);
    }
    if(this.star>0)          //ミラクルスターの描画
    {
      stroke(0);
      colorMode(HSB,359);
      fill(this.theta,359,359);
      beginShape();
      for(int i=0;i<5;i++)          //虹色の5角星
      {
        vertex(centerx()+this.sizex/2*cos(radians(90+this.theta+72*i)),centery()-this.sizey/2*sin(radians(90+this.theta+72*i)));
        vertex(centerx()+this.sizex*1/5*cos(radians(126+this.theta+72*i)),centery()-this.sizey*1/5*sin(radians(126+this.theta+72*i)));
      }
      endShape(CLOSE);
      colorMode(RGB,255);
      for(int i=0;i<5;i++)          //白色の5角星(三角形に分けて描画)
      {
        fill(255);
        triangle(centerx(),centery(),centerx()+this.sizex*2/5*cos(radians(90+this.theta+i*72)),centery()-this.sizey*2/5*sin(radians(90+this.theta+i*72)),
        centerx()+this.sizex*4/25*cos(radians(126+this.theta+i*72)),centery()-this.sizey*4/25*sin(radians(126+this.theta+i*72)));
        fill(223);
        triangle(centerx(),centery(),centerx()+this.sizex*2/5*cos(radians(90+this.theta+i*72)),centery()-this.sizey*2/5*sin(radians(90+this.theta+i*72)),
        centerx()+this.sizex*4/25*cos(radians(54+this.theta+i*72)),centery()-this.sizey*4/25*sin(radians(54+this.theta+i*72)));
      }
    }
  }
  
  //地雷の処理
  public void landmine(PlayCharacter[] pL,Bullet[][] bL)
  {
    if(this.time>0)          //残り時間の減算
    {
      this.time--;
    }
    int check=0;             //起爆判定
    if(this.landmine>0&&this.target>0)          //誰かが踏んだ時
    {
      if((pL[this.target-1].getDirection()==0&&pL[this.target-1].getYp()<=this.yp+this.sizey*11/20)||(pL[this.target-1].getDirection()==1&&pL[this.target-1].getXp()>=this.xp+this.sizex*9/20)
      ||(pL[this.target-1].getDirection()==2&&pL[this.target-1].getYp()>=this.yp+this.sizey*9/20)||(pL[this.target-1].getDirection()==3&&pL[this.target-1].getXp()<=this.xp+this.sizex*11/20))
      {
        check=1;
      }
    }
    if(this.landmine>0&&this.time==0)           //時間が切れた時
    {
      check=1;
    }
    if(check==1)             //起爆処理
    {
      this.attack(this.x,this.y);          //起爆地点を攻撃・色塗り
      this.setPaint((this.landmine-1)%this.member+1);
      if(this.landmine<=this.member)          //通常の地雷
      {
        for(int j=0;j<5;j++)          //周囲16方向に弾を発射
        {
          for(int i=0;i<5;i++)
          {
            for(int k=0;k<40;k++)
            {
              if(bL[(this.landmine-1)%this.member][k].getFlag()==0&&2<=abs(2-i)+abs(2-j)&&abs(2-i)+abs(2-j)<=3)    //遊び心で1行にまとめたため、分かりにくくなった
              {
                bL[(this.landmine-1)%this.member][k].setBullet(this.x,this.y,(j+2)/3+(4-i)*2/3*((j+2)/3%2),30,this.x-2+i,this.y-2+j);
                break;
              }
            }
          }
        }
        this.setRemove();
      }
      else                    //大型地雷
      {
        for(int j=0;j<7;j++)          //周囲24方向に弾を発射
        {
          for(int i=0;i<7;i++)
          {
            for(int k=0;k<40;k++)
            {
              if(bL[(this.landmine-1)%this.member][k].getFlag()==0&&(abs(3-i)+abs(3-j)==4||(abs(3-i)+abs(3-j)==3&&abs(abs(3-i)-abs(3-j))==3)))
              {
                if(i<=1){
                  bL[(this.landmine-1)%this.member][k].setBullet(this.x,this.y,3,30,this.x-3+i,this.y-3+j);
                }else if(5<=i){
                  bL[(this.landmine-1)%this.member][k].setBullet(this.x,this.y,1,30,this.x-3+i,this.y-3+j);
                }else if(j==0){
                  bL[(this.landmine-1)%this.member][k].setBullet(this.x,this.y,0,30,this.x-3+i,this.y-3);
                }else if(j==6){
                  bL[(this.landmine-1)%this.member][k].setBullet(this.x,this.y,2,30,this.x-3+i,this.y+3);
                }
                break;
              }
            }
          }
        }
        this.setRemove();
      }
    }
  }
  
  //ミラクルスターの処理
  public void miraclestar()
  {
    if(this.star>0)          //回転
    {
      theta+=2;
      theta%=360;
    }
  }
  
  //危険地帯の更新
  public void updateDanger()
  {
    if(this.landmine>0)
    {
      if(this.landmine<=this.member)          //地雷の範囲内ならば危険
      {
        for(int j=0;j<5;j++)
        {
          for(int i=0;i<5;i++)
          {
            int a=this.x-2+i;
            int b=this.y-2+j;
            if(abs(2-i)+abs(2-j)<=3&&0<=a&&a<this.field&&0<=b&&b<this.field)          //枠外指定回避
            {
              sT[b][a].setDanger(1);
            }
          }
        }
      }
      else          //大型地雷の範囲内ならば危険
      {
        for(int j=0;j<7;j++)
        {
          for(int i=0;i<7;i++)
          {
            int a=this.x-3+i;
            int b=this.y-3+j;
            if(abs(3-i)+abs(3-j)<=4&&0<=a&&a<this.field&&0<=b&&b<this.field)
            {
              sT[b][a].setDanger(1);
            }
          }
        }
      }
    }
  }
  
  //マスの中心のx座標を求めるメソッド
  public float centerx()
  {
    return this.xp+this.sizex/2;
  }
  
  //マスの中心のy座標を求めるメソッド
  public float centery()
  {
    return this.yp+this.sizey/2;
  }
  
  //特定のマスを攻撃するメソッド
  public void attack(int x,int y)
  {
    for(int i=0;i<this.member;i++)
    {
      if(pL[i].getFlag()==1&&pL[i].getX()==x&&pL[i].getY()==y)
      {
        pL[i].setFlag(0);
        pL[i].setDead(180);
      }
    }
  }
  
  //ステージ関連の処理を全てまとめたもの
  public void defaultAction(PlayCharacter[] pL,Bullet[][] bL)
  {
    this.landmine(pL,bL);
    this.miraclestar();
    this.updateDanger();
  }
  
  // Mitsugoro Changed: 
  public void drawMethod (PlayCharacter[] pL)
  {
    this.draw(pL);
  }
}