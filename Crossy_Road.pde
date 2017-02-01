//  Author Name:  Jonathan Noble
//  Program Name: OOP 2nd Assignment - Game: Crossy_Road 2.0
//  Due Date:     08/02/2017
//  Description:  A game WHERE PLAYER avoids the OBSTACLES and the Footsloggers 
//                BUT the gearbox is incontrollably broken, thus giving away random change of gears 
//  Features:     1) A menu with: 
//                    a) Leaderboard
//                    b) Character and Lvl selection
//                2) A game interface with: 
//                    a) A TIMER SO EACH SCORE IS RECORDED IN THE LEADERBOARD
//                    b) Gas and gear is shown


Player pl1;
Finisher gem;
ArrayList<Road> road = new ArrayList<Road>();
ArrayList<Footslogger> FS = new ArrayList<Footslogger>();
ArrayList<Obstacle> obst = new ArrayList<Obstacle>();
ArrayList<Reward> scoreUp = new ArrayList<Reward>();
boolean game_over = false;

void setup() {
  //commit 7
  size(1100, 700);
  colorMode(HSB);
  smooth();

  //Initialize Player class
  pl1 = new Player();

  //Initialize Finisher class
  gem = new Finisher(pl1);

  //Initialize road class
  for (int i = 0; i < 100; i++) {
    road.add(new Road());
  }

  //Initialize Footslogger - pedestrian object
  //HERE
  Footslogger ped = new Footslogger();
  FS.add(ped);

  //for (int i = 0; i < FS.length; i++) {
  //  FS[i] = new Footslogger();
  //}

  //Initialize Obstacle - tree object
  for (int i = 0; i < 2; i++) {
    obst.add(new Obstacle());
  }
  //for (int i = 0; i < obst.length; i++) {
  //  obst[i] = new Obstacle();
  //}

  //Initialize reward - scoreUP
  for (int i = 0; i < 3; i++) {
    scoreUp.add(new Reward());
  }
}

void draw() {
  background(#FF05EF);
  resetUpdate();

  gem.levelUp();
  gem.display();


  for (Road roads : road) {
    roads.run();
  }

  //OR HERE
  //Footslogger ped = new Footslogger();
  //FS.add(ped);

  for (int i = 0; i < FS.size(); i++) {
    Footslogger footS = (Footslogger) FS.get(i);
    footS.run();
  }

  //for (Footslogger ped : FS) {
  //  ped.run();
  //}

  // JUST TO REMOVE ELEMENTS FROM THE ARRAY - FREES UP MEMORY
  //for(int i = 0; i < FS.size(); i++) {
  //FS.get(i);
  //if (FS.size() > 15) { 
  //  FS.remove(0);
  //}
  // }

  for (Obstacle obs : obst) {
    obs.update();
    obs.display();
  }

  for (Reward sU : scoreUp) {
    sU.display();
  }

  pl1.run();
}


void resetUpdate() {

  for (Footslogger ped : FS) {
    for (Obstacle obs : obst) {
      float pedX = ped.loc.x;
      float pedY = ped.loc.y;
      float FSSize = ped.size;

      float obsX = obs.loc.x;
      float obsY = obs.loc.y;
      float obstize = obs.size;

      // It only executes after Footslogger has passed by width??
      if ( overFS(pedX, pedY, FSSize, FSSize) ) {
        game_over = true;
        println("Game Over!");
      } else if (overObst(obsX, obsY, obstize, obstize)) {
        game_over = true;
        println("Game Over!");
      } else {
        game_over = false;
      }

      while (game_over == true)
      {
        noLoop();
      }
    }
  }
}

//THIS BOOLEAN FUNCTION ONLY DETECTS THE X AND Y COORDINATE OF THE OBJECT
//NOT ITS LINES IN THE EDGES!!! MEANING ONLY BOTTOM OF RECT IS DETECTED
boolean overFS(float x, float y, float width, float height) {

  float plyrX = pl1.loc.x;
  float plyrY = pl1.loc.y;

  if (plyrX >= x && plyrX <= x + width && 
    plyrY >= y && plyrY <= y + height) {
    return true;
  } else {
    return false;
  }
}

boolean overObst(float x, float y, float width, float height) {

  float plyrX = pl1.loc.x;
  float plyrY = pl1.loc.y;

  if (plyrX >= x && plyrX <= x + width && 
    plyrY >= y && plyrY <= y + height) {
    return true;
  } else {
    return false;
  }
}

void levelUpCheck() {
  int lvl = gem.level;

  if (lvl == 2) { 

    for (Footslogger ped : FS) {
      ped.size += 10;
    }

    //OR

        //ArrayList <Footslogger> footie = new ArrayList<Footslogger>(FS.size()*2);
        //for (int i = 0; i<FS.size(); i++) {
        //  footie[i] = FS[i];
        //}
  }
  //  //Obstacle obst[] = new Obstacle[3];

  //if (lvl == 3) {
  //}
}

//error-check if keys are pressed correctly by user
boolean[] keys = new boolean[1000];

void keyPressed()
{ 
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];
  }
  return false;
}