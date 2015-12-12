public class Bullet
{
  private int flag;             //弾の状態（弾の有無、タイプ）
  private int x,y;              //弾の位置（マス）
  private float xp,yp;          //弾の位置（座標）
  private int direction;        //弾の向き（色塗り・攻撃判定用）
  private float vx,vy;          //弾の速度
  private int tx,ty;            //飛んでいく場所（マス）
  private float txp,typ;        //飛んで行く場所(座標)
  private float sxp,syp;        //発射した場所（大砲の弾の描画用）
  private int substance;        //攻撃判定の有無
  private int erase;            //削除予定
  private int blNo;             //弾の番号(誰の弾か)
  private int member;           //プレイヤーの人数
  private int field;            //ステージの広さ
  private float sizex,sizey;    //タイルの大きさ
  
  Bullet(){};
  Bullet(int n,int f,int m)
  {
    this.field=f;
    this.member=m;
    this.sizex=(width*4/5)/f;
    this.sizey=(height*4/5)/f;
    this.flag=0;
    this.x=0;          this.y=0;
    this.xp=0;         this.yp=0;
    this.direction=0;
    this.vx=0;         this.vy=0;
    this.tx=0;         this.ty=0;
    this.txp=0;        this.typ=0;
    this.substance=0;
    this.erase=0;
    this.blNo=n;
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
  public void setVx(float vx){
    this.vx=vx;
  }
  public void setVy(float vy){
    this.vy=vy;
  }
  public void setTx(int tx){
    this.tx=tx;
    this.txp=tx*this.sizex+this.sizex/2+width/10;
  }
  public void setTy(int ty){
    this.ty=ty;
    this.typ=ty*this.sizey+this.sizey/2+height/10;
  }
  public void setTxp(float txp){
    this.txp=txp;
  }
  public void setTyp(float typ){
    this.typ=typ;
  }
  public void setSxp(float txp){
    this.sxp=sxp;
  }
  public void setSyp(float typ){
    this.syp=syp;
  }
  public void setSubstance(int substance){
    this.substance=substance;
  }
  public void setErase(int erase){
    this.erase=erase;
  }
  public void setBullet(int x,int y,int direction,int speed,int tx,int ty){    //弾発射用セッター
    this.x=x;          this.y=y;
    this.xp=x*this.sizex+this.sizex/2+width/10;
    this.yp=y*this.sizey+this.sizey/2+height/10;
    this.direction=direction;
    this.vx=this.sizex/speed;
    this.vy=this.sizey/speed;
    this.tx=tx;        this.ty=ty;
    this.txp=tx*this.sizex+this.sizex/2+width/10;
    this.typ=ty*this.sizey+this.sizey/2+height/10;
    this.sxp=this.xp;  this.syp=this.yp;
    this.flag=1;
    this.substance=0;
    this.erase=0;
  }
  public void setBlNo(int bn){
    this.blNo=bn;
  }
  public void setMember(int member){
    this.member=member;
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
  public float getVx(){
    return this.vx;
  }
  public float getVy(){
    return this.vy;
  }
  public int getTx(){
    return this.tx;
  }
  public int getTy(){
    return this.ty;
  }
  public float getTxp(){
    return this.txp;
  }
  public float getTyp(){
    return this.typ;
  }
  public float getSxp(){
    return this.sxp;
  }
  public float getSyp(){
    return this.syp;
  }
  public int getSubstance(){
    return this.substance;
  }
  public int getErase(){
    return this.erase;
  }
  public int getBlNo(){
    return this.blNo;
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
  
  //弾の描画
  public void draw()
  {
    stroke(0);
    fill(pL[blNo].getColors());
    if(this.flag==1){          //普通の弾
      ellipse(this.xp,this.yp,this.sizex*3/4,this.sizey*3/4);
    }else if(this.flag>1){          //大砲の弾(位置によって大きさが変化)
      ellipse(this.xp,this.yp,
      this.sizex*3/4*((distance(this.sxp,this.syp,this.txp,this.typ)/2-abs(distance(this.xp,this.yp,this.txp,this.typ)-distance(this.sxp,this.syp,this.txp,this.typ)/2))*this.flag/distance(sxp,syp,txp,typ)+1),
      this.sizey*3/4*((distance(this.sxp,this.syp,this.txp,this.typ)/2-abs(distance(this.xp,this.yp,this.txp,this.typ)-distance(this.sxp,this.syp,this.txp,this.typ)/2))*this.flag/distance(sxp,syp,txp,typ)+1));
    }
  }
  
  //移動処理
  public void move(PlayCharacter[] pL,StageTile[][] sT)
  {
    this.xp+=this.vx*cos(this.angle(this.xp,this.yp,this.txp,this.typ));          //移動
    this.yp-=this.vy*sin(this.angle(this.xp,this.yp,this.txp,this.typ));
    if(this.xp<width/10||width*9/10<this.xp||this.yp<height/10||height*9/10<this.yp)    //狙った地点を越えたら消去
    {
      this.flag=0;
    }
    for(int i=0;i<this.member;i++)          //弾同士の衝突判定
    {
      for(int j=0;j<40;j++)                 //ウィンドウの縦横比が違う場合にも対応しているため無駄に長い
      {
        if(bL[i][j].getBlNo()!=this.blNo&&distance(this.xp,this.yp,bL[i][j].getXp(),bL[i][j].getYp())
        <=distance(0,0,sizex*3/8*cos(angle(this.xp,this.yp,bL[i][j].getXp(),bL[i][j].getYp())),sizey*3/8*sin(angle(this.xp,this.yp,bL[i][j].getXp(),bL[i][j].getYp()))))
        {
          if(this.flag==bL[i][j].getFlag())          //相殺
          {
            this.flag=0;
            bL[i][j].setErase(1);                    //即座に判定を消さないのは処理順による有利不利をなくすため
          }
          else if(this.flag==3&&bL[i][j].getFlag()==2)          //アトミックキャノンは通常の大砲の弾を一方的に相殺
          {
            bL[i][j].setErase(1);
          }
        }
      }
    }
    for(int i=0;i<this.member;i++)          //弾とキャラクターの衝突判定
    {
      if(this.flag==1&&this.substance==1&&pL[i].getFlag()==1&&pL[i].getInvincible()==0&&distance(this.xp,this.yp,pL[i].getXp(),pL[i].getYp())
      <=distance(0,0,sizex*3/8*cos(angle(this.xp,this.yp,pL[i].getXp(),pL[i].getYp())),sizey*3/8*sin(angle(this.xp,this.yp,pL[i].getXp(),pL[i].getYp()))))    //死亡設定
      {
        this.flag=0;
        pL[i].setFlag(0);
        pL[i].setDead(180);
      }
    }
    if(this.flag==1&&this.substance==1&&(sT[this.y][this.x].getLandMine()>0||sT[this.y][this.x].getStar()==1)          //地雷・スターとの衝突判定
    &&distance(this.xp,this.yp,sT[this.y][this.x].getXp()+this.sizex/2,sT[this.y][this.x].getYp()+this.sizey/2)
    <=distance(0,0,sizex*3/8*cos(angle(this.xp,this.yp,sT[this.y][this.x].getXp()+this.sizex/2,sT[this.y][this.x].getYp()+this.sizey/2)),
    sizey*3/8*sin(angle(this.xp,this.yp,sT[this.y][this.x].getXp()+this.sizex/2,sT[this.y][this.x].getYp()+this.sizey/2))))
    {
      this.flag=0;          //消去
      if(sT[this.y][this.x].getLandMine()<=this.member){
        sT[this.y][this.x].setRemove();
      }else{                //大型地雷なら起爆
        sT[this.y][this.x].setTime(0);
      }
    }
    for(int j=0;j<this.field;j++)                    //ショットガンは実際の弾の軌道と塗る・攻撃する場所が違う
    {
      for(int i=0;i<this.field;i++)
      {
        if(sT[j][i].getXp()<=this.xp&&this.xp<sT[j][i].getXp()+this.sizex&&sT[j][i].getYp()<=this.yp&&this.yp<sT[j][i].getYp()+this.sizey)
        {
          if(this.flag==1)
          {
            if((this.x!=i&&this.direction%2==1)||(this.y!=j&&this.direction%2==0))      //塗る・攻撃判定復活
            {
              sT[j][i].setPaint(this.blNo+1);
              this.substance=1;
            }
            else if((this.x!=i&&this.direction%2==0)||(this.y!=j&&this.direction%2==1))      //攻撃判定削除
            {
              this.substance=0;
            }
          }                    //弾の座標(マス)の変更
          this.x=i;
          this.y=j;
        }
      }
    }
    if((this.yp<=this.typ&&this.direction==0)||(this.xp>=this.txp&&this.direction==1)||(this.yp>=this.typ&&this.direction==2)||(this.xp<=this.txp&&this.direction==3))    //大砲の弾の着弾処理
    {
      if(this.flag==2)      //普通の大砲の弾
      {
        attack(this.x,this.y);          //着弾地点を攻撃・色塗り
        sT[this.y][this.x].setPaint(this.blNo+1);
        sT[this.y][this.x].setRemove();
        for(int j=0;j<3;j++)            //周囲8方向に弾を発射
        {
          for(int i=0;i<3;i++)
          {
            for(int k=0;k<40;k++)
            {
              if(bL[this.blNo][k].getFlag()==0&&(i!=1||j!=1))      //遊び心で1行にまとめたため、分かりにくくなった
              {
                bL[this.blNo][k].setBullet(this.x,this.y,((i+3)+(i*i*j))%4,30,this.x-1+i,this.y-1+j);
                break;
              }
            }
          }
        }
      }
      else if(this.flag==3)      //アトミックキャノン
      {
        attack(this.x,this.y);
        sT[this.y][this.x].setPaint(this.blNo+1);
        sT[this.y][this.x].setRemove();
        for(int j=0;j<5;j++)          //周囲16方向に弾を発射
        {
          for(int i=0;i<5;i++)
          {
            for(int k=0;k<40;k++)
            {
              if(bL[this.blNo][k].getFlag()==0)
              {
                if(i==0){
                  bL[this.blNo][k].setBullet(this.x,this.y,3,30,this.x-2,this.y-2+j);
                }else if(i==4){
                  bL[this.blNo][k].setBullet(this.x,this.y,1,30,this.x+2,this.y-2+j);
                }else if(j==0){
                  bL[this.blNo][k].setBullet(this.x,this.y,0,30,this.x-2+i,this.y-2);
                }else if(j==4){
                  bL[this.blNo][k].setBullet(this.x,this.y,2,30,this.x-2+i,this.y+2);
                }
                break;
              }
            }
          }
        }
      }
      this.flag=0;
    }
    if(this.erase==1)          //削除予定があれば弾を削除
    {
      this.flag=0;
      this.erase=0;
    }
  }
  
  //危険地帯の更新
  public void updateDanger(StageTile[][] sT)          //負荷軽減のため、弾の軌道予測の精度は完全ではない。ゲームにはほぼ支障なし。
  {
    if(this.flag==1){          //普通の弾
      int a=this.x;
      int b=this.y;
      if(this.direction==0){
        while(b>=this.ty&&0<=a&&a<this.field&&0<=b&&b<this.field){
          if(a!=this.x||b!=this.y||this.substance==1){          //攻撃判定が無いなら弾の現在地は安全
            sT[b][a].setDanger(1);
            if(sT[b][a].getLandMine()>0||sT[b][a].getStar()>0){
              break;
            }
          }
          if(abs(this.tx-a)==abs(this.ty-b)){
            if(this.tx-a<0){
              a--;
            }else if(this.tx-a>0){
              a++;
            }
          }
          b--;
        }
      }else if(this.direction==1){
        while(a<=this.tx&&0<=a&&a<this.field&&0<=b&&b<this.field){
          if(a!=this.x||b!=this.y||this.substance==1){
            sT[b][a].setDanger(1);
            if(sT[b][a].getLandMine()>0||sT[b][a].getStar()>0){
              break;
            }
          }
          if(abs(this.tx-a)==abs(this.ty-b)){
            if(this.ty-b<0){
              b--;
            }else if(this.ty-b>0){
              b++;
            }
          }
          a++;
        }
      }else if(this.direction==2){
        while(b<=this.ty&&0<=a&&a<this.field&&0<=b&&b<this.field){
          if(a!=this.x||b!=this.y||this.substance==1){
            sT[b][a].setDanger(1);
            if(sT[b][a].getLandMine()>0||sT[b][a].getStar()>0){
              break;
            }
          }
          if(abs(this.tx-a)==abs(this.ty-b)){
            if(this.tx-a<0){
              a--;
            }else if(this.tx-a>0){
              a++;
            }
          }
          b++;
        }
      }else if(this.direction==3){  
        while(a>=this.tx&&0<=a&&a<this.field&&0<=b&&b<this.field){
          if(a!=this.x||b!=this.y||this.substance==1){
            sT[b][a].setDanger(1);
            if(sT[b][a].getLandMine()>0||sT[b][a].getStar()>0){
              break;
            }
          }
          if(abs(this.tx-a)==abs(this.ty-b)){
            if(this.ty-b<0){
              b--;
            }else if(this.ty-b>0){
              b++;
            }
          }
          a--;
        }
      }
    }else if(this.flag==2){          //大砲の弾
      for(int j=0;j<3;j++){
        for(int i=0;i<3;i++){
          int a=this.tx-1+i;
          int b=this.ty-1+j;
          if(0<=this.tx&&this.tx<this.field&&0<=this.ty&&this.ty<this.field&&0<=a&&a<this.field&&0<=b&&b<this.field){          //枠外へ出る弾は除外、枠外指定回避
            sT[b][a].setDanger(1);
          }
        }
      }
    }else if(this.flag==3){          //アトミックキャノン
      for(int j=0;j<5;j++){
        for(int i=0;i<5;i++){
          int a=this.tx-2+i;
          int b=this.ty-2+j;
          if(0<=this.tx&&this.tx<this.field&&0<=this.ty&&this.ty<this.field&&0<=a&&a<this.field&&0<=b&&b<this.field){      //枠外へ出る弾は除外、枠外指定回避
            sT[b][a].setDanger(1);
          }
        }
      }
    }
  }
  
  //角度を求めるメソッド
  public float angle(float x1,float y1,float x2,float y2)
  {
    return atan2(y1-y2,x2-x1);
  }
  
  //距離を求めるメソッド
  public float distance(float x1,float y1,float x2,float y2)
  {
    return sqrt(sq(x2-x1)+sq(y2-y1));
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
  
  //弾関連の処理を全てまとめたもの
  public void defaultAction(PlayCharacter[] pL,StageTile[][] sT)
  {
    if(this.flag>0)
    {
       //Mitsugoro Changed　弾の描画は別関数に
      this.move(pL,sT);
      this.updateDanger(sT);
    }
  }
   //Mitsugoro Changed　弾の描画は別関数に
  public void drawMethod()
  {
     if(this.flag>0)
    {
      this.draw();
    }
  }
}
