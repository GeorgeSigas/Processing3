//--------OBJECT CLASS-------//
abstract class Obstacle
{
  PImage image;
  int OBS_H = 90;//default 
  int OBS_W = 60; //default
  int y_pos; // obstacle's y position

  int x_pos; //obstacle's x position
  
  public Obstacle(PImage image, int y, int h,int w)
  {
    this.y_pos = y;
    this.OBS_H=h;
    this.OBS_W=w;
    this.image=image;
  }
  
  public int getPosition()
  {
    return x_pos;
  }
  
  public void setPosition(int pos)
  {
    x_pos=pos;
  }
  
  public void drawOb()
  {
    image(image, x_pos, y_pos, OBS_W, OBS_H);
  }
  
  //obstacle collision
  public boolean collision(int px,int py)
  {
    if(objectOver(px+20,py+20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+p1.PLAYER_SIZE-20,py+p1.PLAYER_SIZE-20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+p1.PLAYER_SIZE-20,py+20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+20,py+p1.PLAYER_SIZE-20,x_pos,y_pos,OBS_W , OBS_H)
     || objectOver(px+p1.PLAYER_SIZE/2,py+p1.PLAYER_SIZE/2,x_pos,y_pos,OBS_W , OBS_H))
          {
            if(py + p1.PLAYER_SIZE > height - OBS_H + 50 )
            {
              x_pos=-100;
              return true;
            }
          }
    return false;
  }
  public abstract boolean heartObstacle();

  
}
