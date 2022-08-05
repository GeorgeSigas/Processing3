//--------PLAYER CLASS-------//
class Player
{
  boolean jumping;
  boolean jumping2;
  boolean landed;
  
  final float jump = 3.5;
  final int PLAYER_SIZE = 100;
  final int JUMP_H = 360; //jump height
  final int JUMP_H2 = 250; //jump height
  final int Base_Y = 460; //Player's Y position on ground
  
  PImage player1;
  PImage player2;
  int nextimg;
  
  Player(String a, String b )
  {
    player1 = loadImage(a);
    player2 = loadImage(b);
    jumping = false;
    landed = true;
    p_y = Base_Y;
    nextimg = 1;
  }
  
  boolean isJumping(){
    return jumping;
  }
    boolean isJumping2(){
    return jumping2;
  }
  boolean isLanded(){
    return landed;
  }
  void setJumping(boolean j){
    jumping=j;
  }
  void setJumping2(boolean j2){
    jumping2=j2;
  }
    void setLanded(boolean L){
    landed=L;
  }
  
  int move()
  {
    if(jumping)
    {
      p_y -= jump; //lift player
      
      if(p_y <= JUMP_H) //height of jump
      {
        jumping = false;
        landed = false;
      }
    }
    if(jumping2)
    {
      
      p_y -= jump; //lift player
      
      if(p_y <= JUMP_H2) //height of jump
      {
        jumping2 = false;
        landed = false;
      }
    }
    if(!landed)
    {
      p_y += jump;//lower player
      if(p_y >= Base_Y) //back to ground
      {
        p_y = Base_Y;
        landed = true;
      }
    }
    return p_y;
  }//moveEND
  
  
  void P_draw(int p_y)
  {
     if(jumping) //dont animate while jumping
     {
       image(player1, p_x, p_y, PLAYER_SIZE, PLAYER_SIZE);
       return;
      }
  
      //animation
      //change player's image every 10 frames
      if(frameCount % 10 == 0)
      {
        //change next image
        if(nextimg == 1)
        {
          image(player1, p_x, p_y, PLAYER_SIZE, PLAYER_SIZE);
          nextimg = 2;
          return;
        }
        else
        {
          image(player2, p_x, p_y, PLAYER_SIZE, PLAYER_SIZE);
          nextimg = 1;
          return;
        }
      }
      else
      {
        //draw the current image
        if(nextimg == 1)
        {
          image(player1, p_x, p_y, PLAYER_SIZE, PLAYER_SIZE);
          return;
        }
        else
        {
          image(player2, p_x, p_y, PLAYER_SIZE, PLAYER_SIZE);
          return;
        }
      }
  }//playerDraw end
}//playerEND
