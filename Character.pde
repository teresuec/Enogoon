public abstract class PlayCharacter
{
  private int flag;             //自分の状態（生死）
  private int x,y;              //自分の位置（マス）
  private float xp,yp;          //自分の位置（座標）
  private int direction;        //自分の向き
  private int move;             //移動中かどうか・移動する向き
  private int moving;           //移動する時間（距離）
  private int attacking;        //攻撃中かどうか（描画用）
  private int lag;              //攻撃不能時間（未使用）
  private int dead;             //復活までの時間
  private int invincible;       //無敵時間
  private int special;          //必殺技フラグ
  private color colors;         //自分の色
  private String aiName;        //自分の名前
  private PImage img;           //自分の画像
  private int plNo;             //自分の番号（何Ｐか）
  private int weapon;           //自分の武器
  private int speed;            //移動速度
  private int member;           //プレイヤーの人数
  private int mate;             //1チームあたりの人数
  private int field;            //ステージの広さ
  private float sizex,sizey;    //タイルの大きさ
  
  //コンストラクタ
  PlayCharacter(){};
  PlayCharacter(int x,int y,int d,color c,int f,int m,int a)
  {
    this.field=f;
    this.member=m;     this.mate=a;
    this.sizex=(width*4/5)/f;
    this.sizey=(height*4/5)/f;
    this.flag=1;
    this.x=x;          this.y=y;
    this.xp=x*this.sizex+this.sizex/2+width/10;
    this.yp=y*this.sizey+this.sizey/2+height/10;
    this.direction=d;
    this.move=0;       this.moving=0;
    this.attacking=0;  this.lag=0;
    this.dead=0;       this.invincible=0;
    this.special=0;
    this.colors=c;
    this.weapon=0;
    this.speed=1;
  }
  
  //セッター
  public void setFlag(int flag){
    this.flag=flag;
  }
  public void setX(int x){
    this.x=x;
    this.xp=x*this.sizex+this.sizex/2+width/10;
  }
  public void setY(int y){
    this.y=y;
    this.yp=y*this.sizey+this.sizey/2+height/10;
  }
  public void setXp(float xp){
    this.xp=xp;
  }
  public void setYp(float yp){
    this.yp=yp;
  }
  public void setDirection(int d){
    this.direction=d;
  }
  public void setPlace(int x,int y,int direction){      //初期配置用セッター
    this.x=x;
    this.y=y;
    this.direction=direction;
    this.xp=x*this.sizex+this.sizex/2+width/10;
    this.yp=y*this.sizey+this.sizey/2+height/10;
  }
  public void setMove(int move){
    this.move=move;
  }
  public void setMoving(int moving){
    this.moving=moving;
  }
  public void setAttacking(int attacking){
    this.attacking=attacking;
  }
  public void setLag(int lag){
    this.lag=lag;
  }
  public void setDead(int dead){
    this.dead=dead;
  }
  public void setInvincible(int invincible){
    this.invincible=invincible;
  }
  public void setSpecial(int special){
    this.special=special;
  }
  public void setColors(color colors){
    this.colors=colors;
  }
  public void setAiName(String name){
    this.aiName=name;
  }
  public void setImg(PImage img){
    this.img=img;
  }
  public void setPlNo(int pn){
    this.plNo=pn;
  }
  public void setWeapon(int weapon){
    this.weapon=weapon;
  }
  public void setSpeed(int speed){
    this.speed=speed;
  }
  public void setMember(int member){
    this.member=member;
  }
  public void setMate(int mate){
    this.mate=mate;
  }
  public void setField(int field){
    this.field=field;
    this.sizex=(width*4/5)/field;
    this.sizey=(height*4/5)/field;
  }
  public void setSizeX(float sizex){
    this.sizex=sizex;
  }
  public void setSizeY(float sizey){
    this.sizey=sizey;
  }
  
  //ゲッター
  public int getFlag(){
    return this.flag;
  }
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
  public int getDirection(){
    return this.direction;
  }
  public int getMove(){
    return this.move;
  }
  public int getMoving(){
    return this.moving;
  }
  public int getAttacking(){
    return this.attacking;
  }
  public int getLag(){
    return this.lag;
  }
  public int getDead(){
    return this.dead;
  }
  public int getInvincible(){
    return this.invincible;
  }
  public int getSpecial(){
    return this.special;
  }
  public color getColors(){
    return this.colors;
  }
  public String getAiName(){
    return this.aiName;
  }
  public PImage getImg(){
    return this.img;
  }
  public int getPlNo(){
    return this.plNo;
  }
  public int getWeapon(){
    return this.weapon;
  }
  public int getMember(){
    return this.member;
  }
  public int getMate(){
    return this.mate;
  }
  public int getField(){
    return this.field;
  }
  public int getSpeed(){
    return this.speed;
  }
  public float getSizeX(){
    return this.sizex;
  }
  public float getSizeY(){
    return this.sizey;
  }
  
  //動かないためのメソッド
  public void stop()
  {
    this.move=5;
    this.moving=30;
  }
  
  //移動系メソッド
  private void moveUp()
  {
    this.setDirection(0);
    this.move=1;
    this.moving=30;
  }
  private void moveRight()
  {
    this.setDirection(1);
    this.move=2;
    this.moving=30;
  }
  private void moveDown()
  {
    this.setDirection(2);
    this.move=3;
    this.moving=30;
  }
  private void moveLeft()
  {
    this.setDirection(3);
    this.move=4;
    this.moving=30;
  }
  
  //攻撃メソッド
  public void attack(Bullet[][] bL)
  {
    if(this.special==0)          //通常攻撃
    {
      if(this.weapon==1)          //ランチャー
      {
        for(int i=0;i<40;i++)
        {
          if(bL[this.plNo][i].getFlag()==0)
          {
            if(this.direction==0){
              bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x,this.y-10);
            }else if(this.direction==1){
              bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x+10,this.y);
            }else if(this.direction==2){
              bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x,this.y+10);
            }else if(this.direction==3){
              bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x-10,this.y);
            }
            break;
          }
        }
        this.move=5;
        this.moving=60;
        this.attacking=20;
        this.lag=60;
      }
      else if(this.weapon==2)          //ショットガン
      {
        for(int j=0;j<5;j++)           //5発発射
        {
          for(int i=0;i<40;i++)
          {
            if(bL[this.plNo][i].getFlag()==0)
            {
              if(this.direction==0){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x-2+j,this.y-3);
              }else if(this.direction==1){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x+3,this.y-2+j);
              }else if(this.direction==2){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x+2-j,this.y+3);
              }else if(this.direction==3){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x-3,this.y+2-j);
              }
              break;
            }
          }
        }
        this.move=5;
        this.moving=60;
        this.attacking=20;
        this.lag=60;
      }
      else if(this.weapon==3)          //キャノン
      {
        for(int l=0;l<40;l++)
        {
          if(bL[this.plNo][l].getFlag()==0)
          {
            int check=0;                    //視界内に敵がいるかどうか
            if(this.direction==0){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x-k+j&&pL[i].getY()==this.y-k-1&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,0,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(2);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)          //敵がいなければ2マス先を攻撃
              {
                bL[this.plNo][l].setBullet(this.x,this.y,0,30,this.x,this.y-2);
                bL[this.plNo][l].setFlag(2);
              }
            }else if(this.direction==1){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x+k+1&&pL[i].getY()==this.y-k+j&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,1,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(2);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)
              {
                bL[this.plNo][l].setBullet(this.x,this.y,1,30,this.x+2,this.y);
                bL[this.plNo][l].setFlag(2);
              }
            }else if(this.direction==2){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x+k-j&&pL[i].getY()==this.y+k+1&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,2,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(2);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)
              {
                bL[this.plNo][l].setBullet(this.x,this.y,2,30,this.x,this.y+2);
                bL[this.plNo][l].setFlag(2);
              }
            }else if(this.direction==3){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x-k-1&&pL[i].getY()==this.y+k-j&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,3,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(2);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)
              {
                bL[this.plNo][l].setBullet(this.x,this.y,3,30,this.x-2,this.y);
                bL[this.plNo][l].setFlag(2);
              }
            }
            break;
          }
        }
        this.move=5;
        this.moving=75;
        this.attacking=20;
        this.lag=75;
      }
      else if(this.weapon==4)          //地雷
      {
        if(sT[this.y][this.x].getLandMine()==0)
        {
          sT[this.y][this.x].setLandMine(this.plNo+1);
          sT[this.y][this.x].setTime(600);
        }
        this.move=5;
        this.moving=90;
        this.attacking=20;
        this.lag=90;
      }
    }
    else                    //必殺技
    {
      if(this.weapon==1)          //グランドクロス
      {
        for(int k=0;k<3;k++)      //3連弾
        {
          for(int j=0;j<4;j++)        //4方向に発射
          {
            for(int i=0;i<40;i++)
            {
              if(bL[this.plNo][i].getFlag()==0)
              {
                if(j==0){
                  bL[this.plNo][i].setBullet(this.x,this.y,j,60/(k+1),this.x,this.y-7);
                }else if(j==1){
                  bL[this.plNo][i].setBullet(this.x,this.y,j,60/(k+1),this.x+7,this.y);
                }else if(j==2){
                  bL[this.plNo][i].setBullet(this.x,this.y,j,60/(k+1),this.x,this.y+7);
                }else if(j==3){
                  bL[this.plNo][i].setBullet(this.x,this.y,j,60/(k+1),this.x-7,this.y);
                }
                break;
              }
            }
          }
        }
        this.move=5;
        this.moving=60;
        this.attacking=20;
        this.lag=60;
        this.invincible=20;
        this.special=0;
      }
      else if(this.weapon==2)          //タイダルウェーブ
      {
        for(int j=0;j<9;j++)           //9発発射
        {
          for(int i=0;i<40;i++)
          {
            if(bL[this.plNo][i].getFlag()==0)
            {
              if(this.direction==0){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x-4+j,this.y-5);
              }else if(this.direction==1){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x+5,this.y-4+j);
              }else if(this.direction==2){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x+4-j,this.y+5);
              }else if(this.direction==3){
                bL[this.plNo][i].setBullet(this.x,this.y,this.direction,30,this.x-5,this.y+4-j);
              }
              break;
            }
          }
        }
        this.move=5;
        this.moving=60;
        this.attacking=20;
        this.lag=60;
        this.special=0;
      }
      else if(this.weapon==3)          //アトミックキャノン
      {
        for(int l=0;l<40;l++)
        {
          if(bL[this.plNo][l].getFlag()==0)
          {
            int check=0;
            if(this.direction==0){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x-k+j&&pL[i].getY()==this.y-k-1&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,0,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(3);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)          //敵がいなければ3マス先を攻撃
              {
                bL[this.plNo][l].setBullet(this.x,this.y,0,30,this.x,this.y-3);
                bL[this.plNo][l].setFlag(3);
              }
            }else if(this.direction==1){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x+k+1&&pL[i].getY()==this.y-k+j&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,1,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(3);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)
              {
                bL[this.plNo][l].setBullet(this.x,this.y,1,30,this.x+3,this.y);
                bL[this.plNo][l].setFlag(3);
              }
            }else if(this.direction==2){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x+k-j&&pL[i].getY()==this.y+k+1&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,2,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(3);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)
              {
                bL[this.plNo][l].setBullet(this.x,this.y,2,30,this.x,this.y+3);
                bL[this.plNo][l].setFlag(3);
              }
            }else if(this.direction==3){
              for(int k=0;k<10;k++){
                for(int j=0;j<k*2+1;j++){
                  for(int i=0;i<this.member;i++){
                    if(pL[i].getFlag()==1&&pL[i].getX()==this.x-k-1&&pL[i].getY()==this.y+k-j&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){
                      bL[this.plNo][l].setBullet(this.x,this.y,3,30,pL[i].getX(),pL[i].getY());
                      bL[this.plNo][l].setFlag(3);
                      check=1;
                    }
                    if(check==1){break;}
                  }
                  if(check==1){break;}
                }
                if(check==1){break;}
              }
              if(check==0)
              {
                bL[this.plNo][l].setBullet(this.x,this.y,3,30,this.x-3,this.y);
                bL[this.plNo][l].setFlag(3);
              }
            }
            break;
          }
        }
        this.move=5;
        this.moving=75;
        this.attacking=20;
        this.lag=75;
        this.special=0;
      }
      else if(this.weapon==4)          //大型地雷
      {
        if(sT[this.y][this.x].getLandMine()==0)
        {
          sT[this.y][this.x].setLandMine(this.plNo+this.member+1);
          sT[this.y][this.x].setTime(600);
        }
        this.move=5;
        this.moving=90;
        this.attacking=20;
        this.lag=90;
        this.special=0;
      }
    }
  }
  
  //キャラクターの描画
  public void draw()
  {
    if((this.weapon!=5&&this.invincible%2==0)||(this.weapon==5&&this.invincible%4==0))    //無敵時間中は点滅
    {
      if(this.special>0&&(this.special>180*this.speed||this.special%5!=0))          //必殺状態ではオーラを描画
      {
        stroke(0);
        colorMode(HSB,359);
        fill(this.special%360,359,359);
        beginShape();
        for(int i=0;i<10;i++)          //10角星
        {
          vertex(this.xp+this.sizex/2*cos(radians(90+this.special/this.speed%360*3+36*i)),this.yp-this.sizey/2*sin(radians(90+this.special/this.speed%360*3+36*i)));
          vertex(this.xp+this.sizex/4*cos(radians(108+this.special/this.speed%360*3+36*i)),this.yp-this.sizey/4*sin(radians(108+this.special/this.speed%360*3+36*i)));
        }
        endShape(CLOSE);
        colorMode(RGB,255);
      }
      pushMatrix();
      translate(this.getXp(),this.getYp());
      if(this.getDirection()==0)          //向きに応じて画像を回転
      {
        rotate(0);
      }
      else if(this.getDirection()==1)
      {
        rotate(HALF_PI);
      }
      else if(this.getDirection()==2)
      {
        rotate(PI);
      }
      else if(this.getDirection()==3)
      {
        rotate(3*HALF_PI);
      }
      imageMode(CENTER);
      image(this.getImg(),0,0);
      popMatrix();
    }
  }
  
  //AIを入力するメソッド
  public abstract int ai(StageTile[][] sT);
  
  //AIの行動
  private void action(StageTile[][] sT,Bullet[][] bL)
  {
    int h=ai(sT);
    if(h==0){
      this.stop();
    }else if(h==1){
      this.moveUp();
    }else if(h==2){
      this.moveRight();
    }else if(h==3){
      this.moveDown();
    }else if(h==4){
      this.moveLeft();
    }else if(h==5){
      if(this.lag==0){
        this.attack(bL);
      }else{
        this.stop();
      }
    }
  }
  
  //移動処理
  private void moveCal(StageTile[][] sT)
  {
    if(this.move==1)          //向きに応じて移動
    {
      this.yp-=this.sizey/30;
    }
    else if(this.move==2)
    {
      this.xp+=this.sizex/30;
    }
    else if(this.move==3)
    {
      this.yp+=this.sizey/30;
    }
    else if(this.move==4)
    {
      this.xp-=this.sizex/30;
    }
    if(this.moving>0)          //移動時間を減算
    {
      this.moving--;
    }
    if(this.moving==0)         //移動終了時の処理
    {
      this.move=0;
    }
    if(0<this.attacking&&this.attacking<=20)          //攻撃モーションの描画
    {
      if(this.direction==0)
      {
        if(this.attacking<=5||15<this.attacking){      //左右に震動
          this.xp-=this.sizex/20;
        }else{
          this.xp+=this.sizex/20;
        }
      }
      else if(this.direction==1)
      {
        if(this.attacking<=5||15<this.attacking){
          this.yp-=this.sizey/20;
        }else{
          this.yp+=this.sizey/20;
        }
      }
      else if(this.direction==2)
      {
        if(this.attacking<=5||15<this.attacking){
          this.xp+=this.sizex/20;
        }else{
          this.xp-=this.sizex/20;
        }
      }
      else if(this.direction==3)
      {
        if(this.attacking<=5||15<this.attacking){
          this.yp+=this.sizey/20;
        }else{
          this.yp-=this.sizey/20;
        }
      }
      this.attacking--;
    }
    if(this.lag>0)          //攻撃不能時間の減算
    {
      this.lag--;
    }
    if(this.invincible>0)          //無敵時間の減算
    {
      this.invincible--;
    }
    if(this.special>0)             //必殺時間の減算
    {
      this.special--;
      if(this.special==0&&this.weapon==5)      //効果時間が切れた時、ローラースケートの移動速度を戻す
      {
        this.speed=2;
      }
    }
    if(this.xp<width/10)          //画面外に移動しようとすると跳ね返る
    {
      this.xp=width/10;
      this.move=2;
      this.moving=15;
    }
    else if(width-width/10<this.xp)
    {
      this.xp=width-width/10;
      this.move=4;
      this.moving=15;
    }
    if(this.yp<height/10)
    {
      this.yp=height/10;
      this.move=3;
      this.moving=15;
    }
    else if(height-height/10<this.yp)
    {
      this.yp=height-height/10;
      this.move=1;
      this.moving=15;
    }
    for(int j=0;j<this.field;j++)
    {
      for(int i=0;i<this.field;i++)
      {
        if(sT[j][i].getXp()<=this.xp&&this.xp<sT[j][i].getXp()+this.sizex&&sT[j][i].getYp()<=this.yp&&this.yp<sT[j][i].getYp()+this.sizey)
        {
          if(this.x!=i||this.y!=j)          //移動時にマスが変わると色を塗る
          {
            sT[j][i].setPaint(this.plNo+1);
            if(sT[j][i].getLandMine()>0&&sT[j][i].getTarget()==0)          //地雷を踏む前の処理
            {
              sT[j][i].setTarget(this.plNo+1);
            }
          }                    //自分の座標(マス)を変更
          this.x=i;
          this.y=j;
        }
      }
    }
    if(sT[this.y][this.x].getStar()==1)          //ミラクルスターがあるときの処理
    {
      if((this.direction==0&&this.yp<=sT[this.y][this.x].getYp()+this.sizey*11/20)||(this.direction==1&&this.xp>=sT[this.y][this.x].getXp()+this.sizex*9/20)
      ||(this.direction==2&&this.yp>=sT[this.y][this.x].getYp()+this.sizey*9/20)||(this.direction==3&&this.xp<=sT[this.y][this.x].getXp()+this.sizex*11/20))
      {
        if(this.weapon!=5){
          this.special=600;
        }else{                    //ローラースケートは行動速度(処理回数)が上がるため効果時間が長い
          this.special=1800;
          this.speed=3;
        }
        sT[this.y][this.x].setRemove();
      }
    }
  }
  
  //復活メソッド
  public void resurrection(StageTile[][] sT)
  {
    if(this.dead>0)          //復活までの時間を減算
    {
      this.dead--;
    }
    if(this.dead==0)         //復活
    {
      int randx=0,randy=0;          //基本はランダム
      for(int i=0;i<20;i++)         //無限ループ防止にwhile文でなくfor文
      {
        randx=int(random(this.field));
        randy=int(random(this.field));
        if(sT[randy][randx].getDanger()==1){          //安全な場所に復活
          continue;
        }
        int check=0;
        for(int k=0;k<5;k++){          //近くに人や地雷、スターが無い場所に復活
          for(int j=0;j<5;j++){
            if(abs(2-j)+abs(2-k)<=2){
              if(blank(sT,randx-2+j,randy-2+k)==0){
                check=1;
              }
            }
            if(check==1){break;}
          }
          if(check==1){break;}
        }
        if(check==1){continue;}
      }
      this.flag=1;
      this.setX(randx);
      this.setY(randy);
      this.direction=int(random(4));
      this.move=5;
      this.moving=30;
      this.attacking=0;
      this.lag=0;
      this.special=0;
      if(this.weapon!=5){
        this.invincible=180;
      }else{                    //ローラースケートは行動速度(処理回数)が多いため無敵時間が長い
        this.invincible=360;
        this.speed=2;
      }
    }
  }
  
  //特定のマスが何も無いかどうかを調べるメソッド(何も無ければ1)
  public int blank(StageTile[][] sT,int x,int y)
  {
    if(x<0||this.field<=x||y<0||this.field<=y)          //例外処理(枠外)
    {
      return 1;
    }
    for(int i=0;i<this.member;i++)
    {
      if(pL[i].flag==1&&pL[i].x==x&&pL[i].y==y)      //キャラクターの有無
      {
        return 0;
      }
    }
    if(sT[y][x].getLandMine()>0||sT[y][x].getStar()>0)      //地雷・スターの有無
    {
      return 0;
    }
    return 1;
  }
  
  //特定のマスが塗られているかどうかを調べるサーチメソッド
  public int paint(StageTile[][] sT,int x,int y)
  {
    if(x<0||this.field<=x||y<0||this.field<=y){         //枠外なら3
      return 3;
    }else if(sT[y][x].getPaint()==0){         //塗られていないなら0
      return 0;
    }else if((sT[y][x].getPaint()-1)/this.mate==this.plNo/this.mate){   //味方チームの色なら1
      return 1;
    }else{                                    //敵チームの色なら2
      return 2;
    }
  }
  
  //特定のマスが危険かどうかを調べるサーチメソッド
  public int danger(StageTile[][] sT,int x,int y)
  {
    if(x<0||this.field<=x||y<0||this.field<=y){         //枠外なら2
      return 2;
    }else{                              //危険なら1、安全なら0
      return sT[y][x].getDanger();
    }
  }
  
  //特定のマスの地雷の有無を調べるサーチメソッド
  public int landmine(StageTile[][] sT,int x,int y)
  {
    if(x<0||this.field<=x||y<0||this.field<=y||sT[y][x].getLandMine()==0){         //枠外か、地雷がなければ0
      return 0;
    }else if(sT[y][x].getLandMine()<=this.member){      //普通の地雷なら1
      return 1;
    }else{                                              //大型地雷なら2
      return 2;
    }
  }
  
  //特定のマスのスターの有無を調べるサーチメソッド
  public int star(StageTile[][] sT,int x,int y)
  {
    if(x<0||this.field<=x||y<0||this.field<=y||sT[y][x].getStar()==0){         //枠外か、スターが無ければ0
      return 0;
    }else{                    //スターがあるなら1
      return 1;
    }
  }
  
  //特定のマスにいる敵の向きを調べるサーチメソッド
  public int enemy(int x,int y)
  {
    for(int i=0;i<this.member;i++){
      if(pL[i].getFlag()==1&&pL[i].getX()==x&&pL[i].getY()==y&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){    //敵がいればその向きを1~4で返す
        return pL[i].getDirection()+1;
      }
    }
    return 0;                    //敵がいなければ0
  }
  
  //特定のマスにいる敵の武器を調べるサーチメソッド
  public int weapon(int x,int y)
  {
    for(int i=0;i<this.member;i++){
      if(pL[i].getFlag()==1&&pL[i].getX()==x&&pL[i].getY()==y&&pL[i].getPlNo()/this.mate!=this.plNo/this.mate){    //敵がいればその武器を1~5で返す
        return pL[i].getWeapon();
      }
    }
    return 0;                    //敵がいなければ0
  }
  
  //キャラクター関連の処理を全てまとめたもの
  public void defaultAction(StageTile[][] sT)
  {
    if(this.flag==1){
      // Mitsugoro changed: 高速再生に対応するために、描画関数を抜いた
      for(int i=0;i<this.speed;i++){
        this.moveCal(sT);
      }
    }else{
      this.resurrection(sT);
    }
  }
  
  // Mitsugoro changed: 高速再生に対応するために、キャラクターの描画関数を別にした
  public void drawMethod() {
     if(this.flag==1){
      this.draw();
    }
  }
}
