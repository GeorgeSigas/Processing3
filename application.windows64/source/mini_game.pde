import processing.sound.*;

int ClickCounter=0;
boolean END = false; //Has the game ended or not
boolean WIN = false; //Win condition of the game
boolean START = true;
boolean playerChosen = false;

int speed = 4; //speed of running (4-5-6)
int lives = 3; //lives
int min_dist=300; //Minimum distance of obstacles (changes with level)
int max_dist=420; //Maximum distance of obstacles (changes with level)

Player p1;
int p_x = 140; //player's x-pos
int p_y = 460; //player's y-pos

String current_score;
String current_level;

//level one values
int currentCoins = 0;
int levelCoins = 25;
int currentLevel = 1;
int Skycolor1=107;
int Skycolor2=241;
int Skycolor3=255;

//BackGround
float x=0;

PFont f;

//Images
PImage obs1;
PImage obs2;
PImage obs3;
PImage obs4;

PImage bg_1;
PImage bg_2;
PImage bg_3;

PImage heart;
PImage current_bg;

PImage PButt;
PImage Pause;
PImage Play;
PImage Sound;
PImage Mute;
PImage SButt;
Boolean Sounds=true;



PImage profile_1;
PImage profile_2;
PImage profile_3;

//Sounds
SoundFile jump;
SoundFile crash;
SoundFile coins;
SoundFile loser;
SoundFile winner;
SoundFile lvlup;
SoundFile coin;
SoundFile music;
SoundFile noExtraLife;
SoundFile extraLife;
SoundFile click;

static Obstacle[] obstacle = new Obstacle[10]; 
static Coin[] Coins=new Coin[30];

void setup()
{
  
  size(1300, 557);
  
  //p1=new Player();
  
  profile_1 = loadImage("mario-profile.png");
  profile_2 = loadImage("thanos-profile.png");
  profile_3 = loadImage("george-profile.png");

  heart = loadImage("hrt.png");
  
  bg_1 = loadImage("cloud3.1.png");
  bg_2 = loadImage("cloud3.2.png");
  
  Play=loadImage("Play.png");
  Pause=loadImage("Pause.png");
  PButt=Pause;
  Sound=loadImage("sound.png");
  Mute=loadImage("mute.png");
  SButt=Sound;
  
  
    
  //loading sounds
  jump= new SoundFile(this, "jump.wav");
  coins= new SoundFile(this, "coin.wav");
  crash= new SoundFile(this, "crash.wav");
  loser = new SoundFile(this, "game-over.wav");
  winner = new SoundFile(this, "win.wav");
  lvlup = new SoundFile(this, "lvlup.wav");
  coin = new SoundFile(this, "coin.wav");
  music = new SoundFile(this, "theme-song.mp3"); 
  noExtraLife = new SoundFile(this, "noExtraLife.wav");
  extraLife = new SoundFile(this, "extra-life.wav");
  click = new SoundFile(this, "click.mp3");



  END=false;
  
  background(107,241,255);
  fill(0);
  //title
  textSize(40);
  text("SELECT PLAYER", 500, 100); 
  
  //player 1
  image(profile_1, 200, 250, 100, 100);
  textSize(20);
  text("Mario", 220, 230);
  textSize(20);
  text("1", 243, 390);
  
  //player 2
  image(profile_2, 600, 250, 100, 100);
  textSize(20);
  text("Thanos", 615, 230);
  textSize(20);
  text("2", 646, 390);
  
  //player 3
  image(profile_3, 1000, 250, 100, 100);
  textSize(20);
  text("George", 1010, 230);
  textSize(20);
  text("3", 1043, 390);
}

void draw()
{
  if(END)
  {
    // black background
    background(0);
    

    fill(255,255,255);
    
    text("You lost. Better luck next time!", width/2 - 160, height/2 - 20);
    text("Level "+ currentLevel+ " progress: "+ currentCoins+"/"+levelCoins+".",
    width/2 - 120, height/2 + 20);
    text("Press ENTER to play again!", width/2 - 125, height - 100);
    
    return;
  }
  if(WIN)
  {
    // black background 
    background(0);
    
 
    fill(255,255,255);
    
    text("You won. Congratulations!", width/2 - 125, height/2 - 20);
    text("Press ENTER to play again!", width/2 - 125, height - 100);
    
    return;
  }
  
  
  if(!START){
   
    
    background(Skycolor1,Skycolor2,Skycolor3);
    //background changes with level
    image(bg_1, x, 50);
    image(bg_1, x+2*bg_1.width, 50);
    image(bg_2, x+bg_1.width,50);
    image(PButt, 1150, 10, 50, 50);
    image(SButt, 1220, 11, 50, 50);
    x=x-0.5;
    movement();
      
    p1.P_draw(p_y); //draw player
    p_y = p1.move(); //player's y-position based on jumping or running
    
    display(); //Display score and lives
     
    check_collision(); //check for collision
  }
}

void movement()
{
  //find the obstacle with max x-position
  int max_h = 0;
  for(int i=0; i<obstacle.length; i++)
    if(obstacle[i].getPosition()>max_h) max_h = obstacle[i].getPosition();
  
  for(int i=0; i<obstacle.length; i++)
  {
    obstacle[i].drawOb();
    obstacle[i].setPosition(obstacle[i].getPosition()-speed);
    for(int j=i*3; j<(i*3+3);j++)
      {
        Coins[j].draw_coin();
        Coins[j].setPositionX(Coins[j].getPositionX()-speed);
      }
    
    //if an obstacle left the screen, generate a new one 
    //at the current farthest obstacle +some more distance
    //update score and change level
    if(obstacle[i].getPosition()<0)
    {
      obstacle[i].setPosition( max_h + int(random(min_dist, max_dist)) );
      //obstacle[i].resetCoinPos();
      int counter=200;
      for(int j=i*3; j<(i*3+3);j++)
      {     
        if(counter==0)
        {
          Coins[j].setPositionX(obstacle[i].getPosition()+10);
        }
        else{
              Coins[j].setPositionX(obstacle[i].getPosition()-counter);
        }
        counter-=100;
      
      }
    }
  }
     //level check
  if(currentCoins ==0) //level 1
  {
    WIN = false;
    //stay with initialized values
  }
  else if(currentCoins == 25 && speed==4) //level 2
  {
    currentLevel = 2;
    levelCoins = 60;
    x=0;
    
    if (Sounds)lvlup.play();
    speed ++; //increase speed
    lives = 3; //reset lives after progressing level
    Skycolor1=226;
    Skycolor2=151;
    Skycolor3=0;
    min_dist = 370; //change distance of obstacles
    max_dist = 460;
  }
  else if (currentCoins == 60 && speed==5) //level 3
  {
    currentLevel = 3;
    levelCoins = 100;
    x=0;
    if (Sounds)lvlup.play();
    speed ++;
    lives = 3;
    Skycolor1=102;
    Skycolor2=0;
    Skycolor3=0;
    min_dist = 400;
    max_dist = 510;
  }else if(currentCoins==100){
    WIN = true;
    music.stop();
    if (Sounds)winner.play();
  }
}//movementEND

void initializeObstacles()
{
  int counter;
   obstacle[0]=new monster();
   obstacle[0].setPosition(1300);
   for(int i=1; i<obstacle.length;i++)
    {
      float x =random(0.0,1.0);// number between 0 and 1, see Math.random()
      if (0 < x && x<= 0.30){
         obstacle[i]=new monster(); 
         
      }else if (0.30 < x && x<= 0.60){
         obstacle[i]=new turtle();  
         
      }else  if (0.60 < x && x<= 0.90){
         obstacle[i]=new flower();
         
      }else{
         obstacle[i]=new heart();
      }
      obstacle[i].setPosition( obstacle[i-1].getPosition()+int(random(min_dist, max_dist) ));
      
    }
    for(int i=0; i<obstacle.length;i++)
    {
      counter=200;
      for(int j=i*3; j<(i*3+3);j++)
      {
        Coins[j]=new Coin();
        if(counter==0)
        {
          Coins[j].setPositionY(Coins[j].getPositionY()-obstacle[i].OBS_H-40);
          Coins[j].setPositionX(obstacle[i].getPosition()+10);
        }
        else{
              Coins[j].setPositionX(obstacle[i].getPosition()-counter);
        }
        counter-=100;
      }
    }
    
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if( p1.isJumping() )
       {
        p1.setJumping(false);
        p1.setJumping2(true);
        
        if (Sounds)jump.play();
      }
      if( (!p1.isJumping())&&(!p1.isJumping2())&&(p1.isLanded()) )
      {
        p1.setJumping(true);
        if(Sounds)jump.play();
      }
    } 
  }
  
  /* double check for cross-platform purposes
  * ENTER is used on Windows, Linux
  * RETURN is used on MACoS
  */
  if(key == ENTER || key == RETURN || !START){
    //Case for when player clicks to play again
    if(END || WIN)
    {
      //reset everything 
      initializeObstacles();
      
      currentLevel = 1;
      levelCoins = 25;
      currentCoins = 0;
      Skycolor1=107;
      Skycolor2=241;
      Skycolor3=255;
      x=0;
      speed = 4;
      lives = 3;
      min_dist=240;
      max_dist=390;
     
      
      END=false;
      WIN = false;
      music.loop();
    }
  }
  
}
void mousePressed()
{
  if(ClickCounter==0)
  {
    if(objectOver(mouseX,mouseY,200, 250, 100, 100))//1st choice
    {
      p1 = new Player("mario.png", "mario-moving.png");
      playerChosen = true;
      START = false;
    }
    if(objectOver(mouseX,mouseY,600, 250, 100, 100))//2nd choice
    {
      p1 = new Player("thanos.png", "thanos-moving.png");
      playerChosen = true;
      START = false;
    }
    if(objectOver(mouseX,mouseY,1000, 250, 100, 100))//3rd choice
    {
      p1 = new Player("george.png", "george-moving.png");
      playerChosen = true;
      START = false;
    }
    if(!START){
      ClickCounter++;
      if (Sounds)click.play();
      initializeObstacles();
      music.loop();
    }
  }
  else{
    if(objectOver(mouseX,mouseY,1150, 10, 50, 50))
    {
     if(speed==0)
     {
       PButt=Pause;
       speed=currentLevel+3;
     }
     else
     {
       PButt=Play;
       speed=0;
     }
    }
    if(objectOver(mouseX,mouseY,1220, 11, 50, 50))
    {
      if(Sounds)
      {
        SButt=Mute;
        Sounds=false;
        music.stop();
      }
      else
      {
        SButt=Sound;
        Sounds=true;
        music.loop();
      }
    }
  }
 
}
boolean objectOver(int x1,int y1,int x, int y, int w, int h)
{
  if (x1 >= x && x1 <= x+w && 
      y1 >= y && y1 <= y+h) {
    return true;
  } else {
    return false;
  }
}


void display()
{
  //write score
  current_score = "Coins: "+ currentCoins + "/" + levelCoins;
  //display level
  current_level = "Level: " + currentLevel;
  //textFont(f,20);
  fill(0);
  text(current_score, 600,30);
  text(current_level, 300,30);
  
  //draw hearts
  int h_x = 593;
  for(int i=0; i<lives; i++)
  {
    image(heart, h_x, 45, 25, 25);
    h_x += 35;
  }
}

void check_collision()
{
  //check for obstacle
  for(int i=0; i<obstacle.length; i++)
  {
    if( obstacle[i].collision(p_x,p_y) )
    {
      //add live only if total lives are less than two
      if(obstacle[i].heartObstacle()){
        if(lives == 3){
          // do not add an extra life (max lives = 3)
          if (Sounds)noExtraLife.play();
        }else if(lives == 1 || lives==2){ //add an extra life
          if (Sounds)extraLife.play();
          lives++;
        }
      }else{
        if (Sounds)crash.play();
        lives--;
      }
      
      if(lives == 0)
      {
        END =true;
        music.stop();
        if(Sounds)loser.play();
      }
      
      break;
    }
   
  }
  //coin collision
  for(int i=0; i<Coins.length; i++)
  {
    if( Coins[i].collision(p_x,p_y) )
    {
      if (Sounds)coin.play();
      currentCoins ++;
    }
   
  }
}
