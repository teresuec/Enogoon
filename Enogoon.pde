StageTile[][] sT;            //ステージのインスタンス
PlayCharacter[] sC;          //セレクト画面のキャラインスタンス
PlayCharacter[] pL;          //ゲーム画面のキャラインスタンス
Bullet[][] bL;               //攻撃（弾）のインスタンス
int scene=0;                 //キャラクターセレクト、ゲームなどの切り替えフラグ
int select=0;                //キャラクターセレクトで選んだ人数
int time=0;                  //ゲームの制限時間(処理用)
int frame=0;                 //制限時間管理用の変数
int member=4;                //プレイヤーの人数
int field=12;                //ステージの広さ
int team=4;                  //チームの数
int mate=1;                  //1チームあたりの人数
int limit=180;               //ゲームの制限時間(初期設定)
int press=0;                 //mousePressedを1フレームに2回以上起動させないための変数
color[] c;                   //プレイヤーごとの色
PImage title;                //タイトルロゴ
PFont font;                  //フォント

int playRate = 1;            // Mitsugoro Changed: 再生速度。1フレーム中に2回以上移動処理、描画は1フレーム1回だけにすることで、高速なAI対戦ができる。

void setup()
{
  size(600,600);
  smooth();
  frameRate(60);
  c=new color[8];
  c[0]=color(255,0,0);       //プレイヤーごとの色を設定
  c[1]=color(0,255,0);
  c[2]=color(0,0,255);
  c[3]=color(255,255,0);
  c[4]=color(0,255,255);
  c[5]=color(255,0,255);
  c[6]=color(255,127,0);
  c[7]=color(127,0,255);
  title=loadImage("Enogoon.png");    //ロゴの設定、拡大縮小
  title.resize(title.width*width/600,title.height*height/600);
  font=createFont("MS-Gothic",height/20);    //日本語を表示するためのフォント設定
  sT=new StageTile[20][20];          //ステージタイルの設定
  sC=new PlayCharacter[40];          //セレクト画面のキャラクター設定
  pL=new PlayCharacter[8];           //ゲーム画面のキャラクター設定
  bL=new Bullet[8][40];              //攻撃（弾）の設定
  for(int i=0;i<40;i++)
  {
    sC[i]=null;
  }
}

void draw()
{
  background(255);          //画面の初期化（白紙に戻す）
  stroke(0);
  fill(255);
  if(scene==0)
  {
    background(239);        //背景の描画
    imageMode(CENTER);      //タイトルの表示
    image(title,width/2,height/4);
    for(int i=0;i<2;i++)    //ボタンの表示(枠)
    {
      for(int j=0;j<3;j++)
      {
        rectMode(CENTER);
        fill(255);
        rect(width*3/10+width*2/5*i,height*11/20+height/6*j,width*7/24+width/12*i,height/12);
      }
    }
    fill(0);
    textAlign(CENTER);      //ボタンの表示(文字)
    textFont(font);
    text("２人対戦",width*3/10,height*273/480);
    text("４人対戦",width*3/10,height*353/480);
    text("８人対戦",width*3/10,height*433/480);
    text("２vs２チーム戦",width*7/10,height*273/480);
    text("２×４チーム戦",width*7/10,height*353/480);
    text("４vs４チーム戦",width*7/10,height*433/480);
  }
  else if(scene==1)              //キャラクターセレクト
  {
    background(247);             //背景の描画
    sC[0]=new RandomAi1();             //キャラクターを登録する場所
    sC[1]=new RandomAi2();
    sC[2]=new RandomAi3();
    sC[3]=new RandomAi4();
    sC[4]=new RandomAi5();
    /* To Do */
    
     // Mitsugoro Changed: ランダムキャラ選択を追加しました。そのため手動AIは32番以降に移動しました。
    sC[32]=new Manual1();
    sC[33]=new Manual2();
    sC[34]=new Manual3();
    sC[35]=new Manual4();
    sC[36]=new Manual5();
    for(int i=0;i<40;i++)              //画面サイズに合わせて画像を拡大縮小
    {
      if(sC[i]!=null)
      {
        sC[i].img.resize(width/12,height/12);
      }
    }
    if(member==2)                      //決定されたキャラクターの枠を描画
    {
      for(int i=0;i<2;i++)
      {
        rectMode(CENTER);
        stroke(c[i/mate*abs(6-team)/2]);
        rect((i+1)*width/3,height*7/40,width*7/40,height*7/40);
      }
    }
    else if(member==4)
    {
      for(int i=0;i<4;i++)
      {
        rectMode(CENTER);
        stroke(c[i/mate*abs(6-team)/2]);
        rect((i+1)*width/5,height*7/40,width*3/20,height*3/20);
      }
    }
    else if(member==8)
    {
      for(int i=0;i<8;i++)
      {
        rectMode(CENTER);
        stroke(c[i/mate*abs(6-team)/2]);
        rect((i%4+1)*width/5,height/10+(i/4)*height*3/20,width/8,height/8);
      }
    }
    stroke(0);
    for(int j=0;j<5;j++)          //選択できるキャラクターの枠を描画
    {
      for(int i=0;i<8;i++)
      {
        rectMode(CORNER);
        rect((i+1)*(width/10),height*7/20+j*height/10,width/10,height/10);
      }
    }
    for(int i=0;i<40;i++)          //選択枠にキャラクターの画像を表示
    {
      if(sC[i]!=null)
      {
        imageMode(CENTER);
        image(sC[i].getImg(),((i%8)+1)*(width/10)+width/20,height*7/20+(i/8)*height/10+height/20);
      }
       // Mitsugoro Changed: ランダムキャラ選択を追加しました。手動AIは32番以降に移動しました。
       if (i == 39) {
        textFont(font);
        textSize(20);
        fill(0,0,0);
        textAlign(CENTER);
        text("Rand",((i%8)+1)*(width/10)+width/20,height*7/20+(i/8)*height/10+height/20 + 10);
      }
    }
    if(member==2)                    //決定されたキャラクターの画像の表示
    {
      for(int i=0;i<select;i++)
      {
        imageMode(CENTER);
        image(pL[i].getImg(),(i+1)*width/3,height*7/40,width/12,height/12);
      }
    }
    else if(member==4)
    {
      for(int i=0;i<select;i++)
      {
        imageMode(CENTER);
        image(pL[i].getImg(),(i+1)*width/5,height*7/40,width/12,height/12);
      }
    }
    else if(member==8)
    {
      for(int i=0;i<select;i++)
      {
        imageMode(CENTER);
        image(pL[i].getImg(),(i%4+1)*width/5,height/10+(i/4)*height*3/20,width/12,height/12);
      }
    }
    //戻るボタンの表示
    rectMode(CENTER);
    fill(255);
    rect(width*11/60,height-height*3/40,width/6,height/12);
    fill(0);
    textAlign(CENTER);
    textFont(font);
    text("戻る",width*11/60,height-height*3/40+height/50);
    if(select==member)                  //決定ボタンの表示
    {
      rectMode(CENTER);
      fill(255);
      rect(width-width*11/60,height-height*3/40,width/6,height/12);
      fill(0);
      textAlign(CENTER);
      textFont(font);
      text("決定",width-width*11/60,height-height*3/40+height/50);
    }
    
    
    //Mitsugoro Changed: 速度変更ボタンの表示
    rectMode(CENTER);
    fill(255);
    rect(width*20/60,height-height*4/40,width/12,height/24);
    rect(width*20/60,height-height*2/40,width/12,height/24);
    fill(255, 0, 0);
    textAlign(CENTER);
    textFont(font);
    text("＋",width*20/60,height-height*4/40+height/50);
    fill(0, 0, 255);
    text("－",width*20/60,height-height*2/40+height/50);
    fill(0);
    text(playRate + "倍速プレイ",width*33/60,height-height*3/40+height/50);
  }
  else if(scene==2)               //ゲーム画面
  {
    // playRate: 何倍速で再生するか(2倍速以上だと、手動操作がうまくできなくなるので注意)
    for (int n = 0; n < playRate; n++)   // Mitsugoro Changed: 高速再生に対応するための繰り返し。1フレーム中に画像描画以外を何度も行う。
      {
      background(191);              //背景の描画
      for(int i=0;i<member;i++)          //AIの行動
      {
        if(pL[i].flag==1&&pL[i].moving==0)
        {
          pL[i].action(sT,bL);
        }
      }
      for(int j=0;j<field;j++)          //危険地帯の初期化
      {
        for(int i=0;i<field;i++)
        {
          sT[j][i].setDanger(0);
        }
      }
    }
    
    for(int j=0;j<field;j++)          //ステージの処理
    {
      for(int i=0;i<field;i++)
      {
        sT[j][i].drawMethod(pL);
      }
    }
    for (int n = 0; n < playRate; n++)   // Mitsugoro Changed: 高速再生に対応するための繰り返し。1フレーム中に画像描画以外を何度も行う。
      {
      for(int j=0;j<field;j++)          //ステージの処理
      {
        for(int i=0;i<field;i++)
        {
          sT[j][i].defaultAction(pL,bL);
        }
      }
    }
    for(int i=0;i<member;i++)          //キャラクターの処理
    {
      pL[i].drawMethod();        // Mitsugoro Changed: 高速再生に対応するために、画像描画だけを別にした。ここだけ繰り返しの外
    }
    for (int n = 0; n < playRate; n++) // Mitsugoro Changed: 高速再生に対応するための繰り返し。
    {
      for(int i=0;i<member;i++) 
      {         //キャラクターの処理
        pL[i].defaultAction(sT);
      }
    }
    for(int i=0;i<member;i++)          //弾の処理
    {
      for(int j=0;j<40;j++)
      {
        bL[i][j].drawMethod();  // Mitsugoro Changed: 高速再生に対応するために、画像描画だけを別にした。ここだけ繰り返しの外
      }
    }
    for (int n = 0; n < playRate; n++) // Mitsugoro Changed: 高速再生に対応するための繰り返し。
     {
       for(int i=0;i<member;i++)          //弾の処理
      {
        for(int j=0;j<40;j++)
        {
          bL[i][j].defaultAction(pL,sT);
        }
      }
      if(time%30==0&&frame==0&&time!=limit)    //ミラクルスターの設置
      {
        this.setMiracleStar();
      }
      frame++;                      //制限時間の処理
      if(frame>=60)
      {
        frame=0;
        time--;
      }
      if(time<=0)
      {
        scene=3;
      }
      // Mitsugoro Changed: バックスペースキーで強制終了。待ってられないときに使って
      if(keyPressed && key==BACKSPACE)
      {
        scene=1; 
      }
    }
  this.indicate();              //AIの名前や残り時間の表示
  
  // Mitsugoro Changed: 何倍速かを表示
  fill(0);
  textAlign(CENTER);
  text(playRate + "倍速プレイ",width*30/60,height-height*3/40+height/50);
  }
  else if(scene==3)               //終了画面
  {
    background(191);              //背景の描画
    for(int j=0;j<field;j++)          //ステージの描画
    {
      for(int i=0;i<field;i++)
      {
        sT[j][i].draw(pL);
      }
    }
    for(int i=0;i<member;i++)          //キャラクターの描画
    {
      pL[i].draw();
    }
    for(int i=0;i<member;i++)          //弾の描画
    {
      for(int j=0;j<40;j++)
      {
        bL[i][j].draw();
      }
    }
    this.indicate();              //AIの名前や残り時間の表示
    fill(0);
    textSize(height/10);
    textAlign(CENTER);
    text("TIME UP",width/2,height*11/20);
  }
  else if(scene==4)               //結果発表
  {
    background(255);             //背景の描画
    int[] rank;          //順位を保存する変数
    int[] area;          //塗ったマス数を保存する変数
    rank=new int[8];
    area=new int[8];
    for(int i=0;i<team;i++)
    {
      rank[i]=i;
      area[i]=0;
    }
    for(int j=0;j<field;j++)          //塗ったマスを集計
    {
      for(int i=0;i<field;i++)
      {
        if(sT[i][j].getPaint()>0)
        {
          area[(sT[i][j].getPaint()-1)/mate]+=1;
        }
      }
    }
    for(int j=0;j<team-1;j++)         //順位ごとに並び替え
    {
      for(int i=0;i<team-1;i++)
      {
        if(area[rank[i]]<area[rank[i+1]])
        {
          int box=rank[i];
          rank[i]=rank[i+1];
          rank[i+1]=box;
        }
      }
    }
    textFont(font);                    //表示
    textSize(height/15);
    for(int i=0;i<team;i++)
    {
      fill(pL[rank[i]*mate].getColors());
      textAlign(LEFT);
      text(i+1+"位:",width/10,(i+1)*height/(team+1)+height/30);
      textAlign(CENTER);
      for(int j=0;j<mate;j++)
      {
        text(pL[rank[i]*mate+j].getAiName(),width/2,(i+1)*height/(team+1)-height/30*(mate-2)+height/15*j);
      }
      textAlign(RIGHT);
      text("…"+area[rank[i]],width*9/10,(i+1)*height/(team+1)+height/30);
    }
  }
  press=0;                   //mousePressedを有効に戻す
}

void mousePressed()          //マウスがクリックされた時の処理
{
  if(press==0)            //そのフレーム中にまだmousePressedが起動されていないなら
  {
    if(scene==0)          //タイトル画面
    {
      if(width*37/240<mouseX&&mouseX<width*107/240&&height*61/120<mouseY&&mouseY<height*71/120){    //2人対戦
        member=2;
        field=8;
        team=2;
        mate=1;
        scene=1;
      }else if(width*37/240<mouseX&&mouseX<width*107/240&&height*81/120<mouseY&&mouseY<height*91/120){    //4人対戦
        member=4;
        field=12;
        team=4;
        mate=1;
        scene=1;
      }else if(width*37/240<mouseX&&mouseX<width*107/240&&height*101/120<mouseY&&mouseY<height*111/120){    //8人対戦
        member=8;
        field=20;
        team=8;
        mate=1;
        scene=1;
      }else if(width*123/240<mouseX&&mouseX<width*213/240&&height*61/120<mouseY&&mouseY<height*71/120){    //2vs2チーム戦
        member=4;
        field=12;
        team=2;
        mate=2;
        scene=1;
      }else if(width*123/240<mouseX&&mouseX<width*213/240&&height*81/120<mouseY&&mouseY<height*91/120){    //2×4チーム戦
        member=8;
        field=20;
        team=4;
        mate=2;
        scene=1;
      }else if(width*123/240<mouseX&&mouseX<width*213/240&&height*101/120<mouseY&&mouseY<height*111/120){    //4vs4チーム戦
        member=8;
        field=20;
        team=2;
        mate=4;
        scene=1;
      }
    }
    else if(scene==1)          //キャラクターセレクト
    {
      if(select<member)          //キャラクターセレクトの処理
      {
        for(int j=0;j<5;j++)
        {
          for(int i=0;i<8;i++)
          {
            if(((i+1)*(width/10)<mouseX&&mouseX<(i+2)*(width/10))&&(height*7/20+j*height/10<mouseY&&mouseY<height*7/20+(j+1)*height/10))
            {
              if(sC[8*j+i]!=null)
              {
                pL[select]=sC[8*j+i];
                select++;
              }
              // Mitsugoro Changed: ランダムキャラ選択を追加しました。手動AIは32番以降に移動しました。
              else if (8*j+i == 39) {
                int r = (int)(random(31));
                while (sC[r] == null) {
                 r = (int)(random(31));
                }
                pL[select]=sC[r];
               
                select++;
              }
            }
          }
        }
      }
      if((width/10<mouseX&&mouseX<width*4/15)&&(height-height*7/60<mouseY&&mouseY<height-height/30))
      {
        if(0<select)          //戻るボタンの処理
        {
          select--;
        }
        else
        {
          scene=0;
        } 
      }
      // Mitsugoro Changed: プレイ速度変更ボタン
      
      if(width*20/60-width/24<mouseX&&mouseX<width*20/60+width/24&&height-height*4/40-height/48<mouseY&&mouseY<height-height*4/40+height/48)
      {
        if (playRate == 1) playRate = 2;
        else if (playRate == 2) playRate = 3;
        else if (playRate == 3) playRate = 4;
        else if (playRate == 4) playRate = 6;
        else if (playRate == 6) playRate = 8;
        else playRate = 10;
      }
      
       if(width*20/60-width/24<mouseX&&mouseX<width*20/60+width/24&&height-height*2/40-height/48<mouseY&&mouseY<height-height*2/40+height/48)
      {
        if (playRate == 10) playRate = 8;
        else if (playRate == 8) playRate = 6;
        else if (playRate == 6) playRate = 4;
        else if (playRate == 4) playRate = 3;
        else if (playRate == 3) playRate = 2;
        else playRate = 1;
      }
      
      if(select==member)         //開始処理
      {
        if((width-width/10>mouseX&&mouseX>width-width*4/15)&&(height-height*7/60<mouseY&&mouseY<height-height/30))
        {
          firstSet();
          scene=2;
          select=0;
        }
      }
    }
    else if(scene==3)          //終了画面
    {
      scene=4;          //結果発表へ移行
    }
    else if(scene==4)          //結果発表
    {
      scene=1;          //キャラクターセレクトへ戻る
    }
    press=1;            //mousePressedをそのフレーム間無効にする
  }
}

//特定のマスに何も無いかどうかを調べるメソッド(何も無ければ1)
private int blank(int x,int y)
{
  if(x<0||this.field<=x||y<0||this.field<=y)          //例外処理(枠外)
  {
    return 1;
  }
  for(int i=0;i<member;i++)
  {
    if(pL[i].getFlag()==1&&pL[i].getX()==x&&pL[i].getY()==y)          //キャラクターの有無
    {
      return 0;
    }
  }
  if(sT[y][x].getLandMine()>0||sT[y][x].getStar()>0)          //地雷・スターの有無
  {
    return 0;
  }
  return 1;
}

//ミラクルスターの設置メソッド
private void setMiracleStar()
{
  int randx=0,randy=0;          //基本はランダム
  for(int i=0;i<20;i++)         //無限ループ防止にwhile文でなくfor文
  {
    randx=int(random(this.field));
    randy=int(random(this.field));
    if(sT[randy][randx].getDanger()==1){          //安全な場所に設置
      continue;
    }
    int check=0;
    for(int k=0;k<5;k++){          //近くに人や地雷、スターが無い場所に設置
      for(int j=0;j<5;j++){
        if(abs(2-j)+abs(2-k)<=2){
          if(blank(randx-2+j,randy-2+k)==0){
            check=1;
          }
        }
        if(check==1){break;}
      }
      if(check==1){break;}
    }
    if(check==0){break;}
  }
  sT[randy][randx].setStar(1);
  sT[randy][randx].setTheta(int(random(360)));
}

//AIの名前や残り時間の表示
private void indicate()
{
  textFont(font);
  textSize(height/20);
  textAlign(CENTER);
  fill(0);
  text("TIME:"+time,width/2,height/20);
  if(member==2)
  {
    textAlign(LEFT);
    fill(pL[0].getColors());
    text(pL[0].getAiName(),width/60,height/20);
    textAlign(RIGHT);
    fill(pL[1].getColors());
    text(pL[1].getAiName(),width*59/60,height/20);
  }
  else if(member==4)
  {
    if(mate==1)
    {
      textAlign(LEFT);
      fill(pL[0].getColors());
      text(pL[0].getAiName(),width/60,height/20);
      fill(pL[3].getColors());
      text(pL[3].getAiName(),width/60,height*59/60);
      textAlign(RIGHT);
      fill(pL[1].getColors());
      text(pL[1].getAiName(),width*59/60,height/20);
      fill(pL[2].getColors());
      text(pL[2].getAiName(),width*59/60,height*59/60);
    }
    else if(mate==2)
    {
      textAlign(LEFT);
      fill(pL[0].getColors());
      text(pL[0].getAiName(),width/60,height/20);
      fill(pL[1].getColors());
      text(pL[1].getAiName(),width/60,height*59/60);
      textAlign(RIGHT);
      fill(pL[2].getColors());
      text(pL[2].getAiName(),width*59/60,height/20);
      fill(pL[3].getColors());
      text(pL[3].getAiName(),width*59/60,height*59/60);
    }
  }
  else if(member==8)
  {
    if(mate==1)
    {
      textAlign(LEFT);
      fill(pL[4].getColors());
      text(pL[4].getAiName(),width/60,height*11/240);
      fill(pL[0].getColors());
      text(pL[0].getAiName(),width/60,height*3/32);
      fill(pL[7].getColors());
      text(pL[7].getAiName(),width/60,height*227/240);
      fill(pL[3].getColors());
      text(pL[3].getAiName(),width/60,height*119/120);
      textAlign(RIGHT);
      fill(pL[1].getColors());
      text(pL[1].getAiName(),width*59/60,height*11/240);
      fill(pL[5].getColors());
      text(pL[5].getAiName(),width*59/60,height*3/32);
      fill(pL[2].getColors());
      text(pL[2].getAiName(),width*59/60,height*227/240);
      fill(pL[6].getColors());
      text(pL[6].getAiName(),width*59/60,height*119/120);
    }
    else if(mate==2)
    {
      textAlign(LEFT);
      fill(pL[0].getColors());
      text(pL[0].getAiName(),width/60,height*11/240);
      fill(pL[1].getColors());
      text(pL[1].getAiName(),width/60,height*3/32);
      fill(pL[6].getColors());
      text(pL[6].getAiName(),width/60,height*227/240);
      fill(pL[7].getColors());
      text(pL[7].getAiName(),width/60,height*119/120);
      textAlign(RIGHT);
      fill(pL[2].getColors());
      text(pL[2].getAiName(),width*59/60,height*11/240);
      fill(pL[3].getColors());
      text(pL[3].getAiName(),width*59/60,height*3/32);
      fill(pL[4].getColors());
      text(pL[4].getAiName(),width*59/60,height*227/240);
      fill(pL[5].getColors());
      text(pL[5].getAiName(),width*59/60,height*119/120);
    }
    else if(mate==4)
    {
      textAlign(LEFT);
      fill(pL[0].getColors());
      text(pL[0].getAiName(),width/60,height*11/240);
      fill(pL[1].getColors());
      text(pL[1].getAiName(),width/60,height*3/32);
      fill(pL[2].getColors());
      text(pL[2].getAiName(),width/60,height*227/240);
      fill(pL[3].getColors());
      text(pL[3].getAiName(),width/60,height*119/120);
      textAlign(RIGHT);
      fill(pL[4].getColors());
      text(pL[4].getAiName(),width*59/60,height*11/240);
      fill(pL[5].getColors());
      text(pL[5].getAiName(),width*59/60,height*3/32);
      fill(pL[6].getColors());
      text(pL[6].getAiName(),width*59/60,height*227/240);
      fill(pL[7].getColors());
      text(pL[7].getAiName(),width*59/60,height*119/120);
    }
  }
}

//ゲーム開始時の初期設定
private void firstSet()
{
  time=limit;
  for(int i=0;i<member;i++)          //プレイヤーの初期設定
  {
    pL[i].setPlNo(i);
    pL[i].setFlag(1);
    pL[i].setMove(5);
    pL[i].setMoving(30);
    pL[i].setAttacking(0);
    pL[i].setDead(0);
    pL[i].setInvincible(0);
    pL[i].setSpecial(0);
    pL[i].setColors(c[i/mate*abs(6-team)/2]);
    pL[i].setField(field);
    pL[i].setMember(member);
    pL[i].setMate(mate);
    pL[i].img.resize(pL[i].img.width*8/field,pL[i].img.height*8/field);  //画面サイズに合わせて画像を拡大縮小
    if(pL[i].getWeapon()!=5){
      pL[i].setSpeed(1);
    }else{
      pL[i].setSpeed(2);
    }
  }
  if(member==2)          //初期配置
  {
    pL[0].setPlace(1,1,1);
    pL[1].setPlace(field-2,field-2,3);
  }
  else if(member==4)
  {
    if(mate==1)
    {
      pL[0].setPlace(1,1,1);
      pL[1].setPlace(field-2,1,2);
      pL[2].setPlace(field-2,field-2,3);
      pL[3].setPlace(1,field-2,0);
    }
    else if(mate==2)
    {
      pL[0].setPlace(1,1,1);
      pL[1].setPlace(1,field-2,1);
      pL[2].setPlace(field-2,1,3);
      pL[3].setPlace(field-2,field-2,3);
    }
  }
  else if(member==8)
  {
    if(mate==1)
    {
      pL[0].setPlace(1,4,1);
      pL[1].setPlace(field-5,1,2);
      pL[2].setPlace(field-2,field-5,3);
      pL[3].setPlace(4,field-2,0);
      pL[4].setPlace(4,1,2);
      pL[5].setPlace(field-2,4,3);
      pL[6].setPlace(field-5,field-2,0);
      pL[7].setPlace(1,field-5,1);
    }
    else if(mate==2)
    {
      pL[0].setPlace(1,4,1);
      pL[1].setPlace(4,1,1);
      pL[2].setPlace(field-5,1,2);
      pL[3].setPlace(field-2,4,2);
      pL[4].setPlace(field-2,field-5,3);
      pL[5].setPlace(field-5,field-2,3);
      pL[6].setPlace(4,field-2,0);
      pL[7].setPlace(1,field-5,0);
    }
    else if(mate==4)
    {
      pL[0].setPlace(4,1,1);
      pL[1].setPlace(1,4,1);
      pL[2].setPlace(1,field-5,1);
      pL[3].setPlace(4,field-2,1);
      pL[4].setPlace(field-5,1,3);
      pL[5].setPlace(field-2,4,3);
      pL[6].setPlace(field-2,field-5,3);
      pL[7].setPlace(field-5,field-2,3);
    }
  }
  for(int i=0;i<member;i++)          //弾の初期設定
  {
    for(int j=0;j<40;j++)
    {
      bL[i][j]=new Bullet(i,field,member);
    }
  }
  for(int j=0;j<field;j++)          //ステージの初期設定
  {
    for(int i=0;i<field;i++)
    {
      sT[j][i]=new StageTile(i,j,field,member);
    }
  }
}