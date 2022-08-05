
//--------HEART----------//
class heart extends Obstacle
{
  public heart()
  {
    super(loadImage("obs4.png"),490,80,65);
  }
  
  public PImage getImage()
  {
    return loadImage("obs4.png");
  }
  
  public boolean heartObstacle(){return true;}
}//heartEND

//--------MONSTER----------//
class monster extends Obstacle
{
  public monster()
  {
    super(loadImage("obs1.png"),490,75,65);
  }
  
  public PImage getImage()
  {
    return loadImage("obs1.png");
  }
  
  public boolean heartObstacle(){return false;}
}//monsterEND

//--------TURTLE----------//
class turtle extends Obstacle
{  
  public turtle()
  {
    super( loadImage("obs2.png"), 480,80,65 );
  }
  
  public PImage getImage()
  {
    return loadImage("obs2.png");
  }
  public boolean heartObstacle(){return false;}//turtleEND
  
}


//--------FLOWER----------//
class flower extends Obstacle
{
  public flower()
  {
    super(loadImage("obs3.png"), 490,70,70);
  }
  public PImage getImage()
  {
    return loadImage("obs3.png");
  }
  
  public boolean heartObstacle(){return false;}
}//flowerEND
