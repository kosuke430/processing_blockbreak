int s_width=400;
int s_height=400;
int block_len=200;
int block_thin=30;
int block_line=1;
int block_row=s_width/block_len;
int bar_y=300;
int bar_len=100;
int bar_thin=20;
int x_dir=1;
int y_dir=1;
int check_block_num=block_line*block_row;
boolean [][] block_exist=new boolean [block_line][block_row];
int [][][] arr=new int [block_line][block_row][2];
float x_vec=1.0;
float y_vec=1.0;
float ball_size=10;
float ball_x_position=200;
float ball_y_position=200;
float speed=3.0;
float bar_x_position;
boolean collsion_x=false;
boolean gamestate=true;

void gameinit()
{
  s_width=400;
  s_height=400;
  block_len=200;
  block_thin=30;
  block_line=1;
  block_row=s_width/block_len;
  bar_y=300;
  bar_len=100;
  bar_thin=20;
  x_dir=1;
  y_dir=1;
  check_block_num=block_line*block_row;
  boolean [][] block_exist=new boolean [block_line][block_row];
  int [][][] arr=new int [block_line][block_row][2];
  x_vec=1.0;
  y_vec=1.0;
  ball_size=10;
  ball_x_position=200;
  ball_y_position=200;
  speed=3.0;
  collsion_x=false;
  gamestate=true;
}

void setup()
{
  size(400,400);
  background(0,255,255);
  gameinit();
  for (int i=0;i<block_line;++i)
  {
    for (int t=0;t<block_row;++t)
    {
      fill(255,255,0);
      rect(block_len*t,i*block_thin,block_len,block_thin);
      arr[i][t][0]=block_len*t;
      arr[i][t][1]=block_thin*i;
      block_exist[i][t]=true;
    }
  }
}

void draw()
{
  if (gamestate)
  {
    background(0,255,255);
    Road_block();
    Check_bar_collsion();
    Check_wall_collsion();
    Check_block_collsion();
    Movebar();
    Ballmove(); 
    Check_clear(); 
    Check_gameover();
  }
  else
  {
    Check_retry();
  }
}

void Movebar()
{
  fill(0,255,0);
  rect(mouseX,bar_y,bar_len,bar_thin);
  bar_x_position=mouseX;
}

void Ballmove()
{
  ball_x_position+=x_dir*x_vec*speed;
  ball_y_position+=y_dir*y_vec*speed;
  circle(ball_x_position,ball_y_position,ball_size);
  
}

void Collsion()
{
  if (collsion_x)
  {
    x_dir*=-1;
  }
  else
  {
    y_dir*=-1;
  }
}

void Check_bar_collsion()
{
  
  if ((ball_y_position<=bar_y+bar_thin)&&(bar_y<=ball_y_position))
  {
      if ((ball_x_position<=bar_x_position+bar_len)&&(bar_x_position<=ball_x_position))
    {
      collsion_x=false;
      Collsion();
    }
  }
}

void Check_wall_collsion()
{
  if ((ball_x_position>390)||(ball_x_position<0))
  {
    collsion_x=true;
    Collsion();
  }
  else if(ball_y_position<0)
  {
    collsion_x=false;
    Collsion();
  }
}

void Road_block()
{
  for (int i=0;i<block_line;++i)
  {
    for (int t=0;t<block_row;++t)
    {
      if (block_exist[i][t])
      {
        fill(255,255,0);
        rect( arr[i][t][0], arr[i][t][1],block_len,block_thin);
      }
    }
  }
}
void Check_block_collsion()
{
  int block_anchor_row=0;
  int  block_anchor_line=0;
  if (ball_y_position<block_thin*block_line)
  {
    
    while(ball_y_position>=block_thin* block_anchor_line)
    {
      ++ block_anchor_line;
    }
    
    while(ball_x_position>=block_len* block_anchor_row)
    {
      ++ block_anchor_row;
    }
    System.out.print(block_anchor_line);
    
    if ( block_anchor_line>0)
    {
      -- block_anchor_line;
    }
    if ( block_anchor_row>0)
    {
      -- block_anchor_row;
    }
    
    if (block_exist[block_anchor_line][block_anchor_row])
    {
      collsion_x=false;
      Collsion();
      block_exist[block_anchor_line][block_anchor_row]=false;
      --check_block_num;
    }
  }  
}

void Check_clear()
{
  if (check_block_num==0)
  {
    Clear();
  }
}

void Check_gameover()
{
  if (ball_y_position>s_height)
  {
    GameOver();
  }
}

void Clear()
{ 
   background(0,255,255);
   gamestate=false;
   //noLoop();
   fill(255,255,0);
   rect(0,s_height/4,s_width,s_height/2);
   fill(0);
   textAlign(CENTER);
   textSize(50);
   text("GameClear",0,s_height/4,s_width,s_height);
   //
   fill(255,255,255);
   rect(0,s_height/2,s_width,s_height/8);
   
   fill(0);
   textAlign(CENTER);
   textSize(30);
   text("one more challenge?",0,s_height/2,s_width,s_height);
}
void GameOver()
{ 
   background(0,255,255);
   gamestate=false;
   //noLoop();
   fill(255,0,0);
   rect(0,s_height/4,s_width,s_height/2);
   fill(0);
   textAlign(CENTER);
   textSize(50);
   text("GameOver",0,s_height/4,s_width,s_height);
   //
   fill(255,255,255);
   rect(0,s_height/2,s_width,s_height/8);
   
   fill(0);
   textAlign(CENTER);
   textSize(30);
   text("one more challenge?",0,s_height/2,s_width,s_height);
}
void Check_retry()
{
  if (mousePressed&&((s_height/2<=mouseY)&&(mouseY<=s_height*5/8)))
  {
    setup();
  }
}
  



      
