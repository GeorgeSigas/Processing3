class Coin
{
  PImage image;
  int OBS_H = 90;//default 
  int OBS_W = 60; //default
  int y_pos; // coin's y position
  int x_pos; //coin's x position
  
  //coin animation
  int nextimg=1;
  int coin_h;
  PImage coin1;
  PImage coin2;
  PImage coin3;
  
  public Coin()
  {
    coin1 = loadImage("Coin1.1.png");
    coin2 = loadImage("Coin2.1.png");
    coin3 = loadImage("Coin3.1.png");
    this.OBS_H=40;
    this.OBS_W=40;
    this.y_pos=500;
  }
  
  public int getPositionX()
  {
    return x_pos;
  }
  
  public void setPositionX(int pos)
  {
    x_pos=pos;
  }
  public int getPositionY()
  {
    return y_pos;
  }
  
  public void setPositionY(int pos)
  {
    y_pos=pos;
  }

  //coin collision
  public boolean collision(int px,int py)
  {
     if(objectOver(px+20,py+20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+p1.PLAYER_SIZE-20,py+p1.PLAYER_SIZE-20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+p1.PLAYER_SIZE-20,py+20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+20,py+p1.PLAYER_SIZE-20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+p1.PLAYER_SIZE/2,py+p1.PLAYER_SIZE/2,x_pos,y_pos,OBS_W , OBS_H))
          {
              x_pos=-100;
              return true;
          }
    return false;
  }

  //coin animation 
  void draw_coin()
  {
      if(frameCount % 10 == 0)
      {
        changeCoin(x_pos, y_pos);
      }
      else
      {
        drawCurrentCoin(x_pos, y_pos);
      }
  }//drawcoinEND
  
  public void changeCoin(float x, float y){
    //change next image
      if(nextimg == 1)
      {
        image(coin1, x, y, 40, 40);
        nextimg = 2;
        return;
       }
       else if(nextimg == 2 )
       {
         image(coin2, x, y, 40, 40);
         nextimg = 3;
         return;
       }
       else
       {
         image(coin3, x, y, 40, 40);
         nextimg = 1;
         return;
       }
   }
   
   public void drawCurrentCoin(float x, float y){
     //draw the current image
       if(nextimg == 1)
       {
         image(coin1, x, y, 40, 40);
         return;
       }
       else if(nextimg == 2)
       {
         image(coin2, x, y, 40, 40);
         return;
       }
       else
       {
         image(coin3, x, y, 40, 40);
         return;
       }
   }
 
}
