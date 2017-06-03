import java.util.Random;

static final boolean drawStepWise = false;
static final int dungeon_edge = 5;

static final int[] tiles = {50,50};
static final int zoominFactor = 20;

final int directionMode = 0; 
// 0: all are possible
// 1: not same dir
// 2: not same dir or backwards

Random r;
PGraphics pg;

int agent_x;
int agent_y;
int agent_dir;

 
public static final int UP = 0;
public static final int RIGHT = 1;
public static final int DOWN = 2;
public static final int LEFT = 3;


void setup(){
  size(tiles[0]*zoominFactor, tiles[1]*zoominFactor);
  frameRate(10);
  noSmooth();
  r = new Random();
  resetGraphics();
  randomizeAgentPos();
  setAgent(agent_x,agent_y);
}

void keyTyped(){
  if(key=='r'){ 
    resetGraphics();
    randomizeAgentPos();
    setAgent(agent_x,agent_y);
  } else {
    if(drawStepWise){ update(); }
  } 
}

void update(){
  randomizeAgentDir();
  setAgentTrail(agent_x,agent_y);
  moveAgent();
  setAgent(agent_x,agent_y);
}

void resetGraphics(){
  pg = createGraphics(tiles[0],tiles[1]);
  pg.beginDraw();
  for(int x=0;x<pg.width;x++){
    for(int y=0;y<pg.height;y++){
      pg.set(x,y,color(0));
    }
  }
  pg.endDraw();
}

void randomizeAgentPos(){
 agent_x = getRandomInt(dungeon_edge,pg.width-dungeon_edge);
 agent_y = getRandomInt(dungeon_edge,pg.height-dungeon_edge);
}

void randomizeAgentDir(){
  if(directionMode==0){ 
    agent_dir = getRandomInt(0,4);
  } else if(directionMode==1){ 
    int prev_dir = agent_dir;
    do{
      agent_dir = getRandomInt(0,4);
    } while(prev_dir==agent_dir);
  } else if(directionMode==2){ 
    int prev_dir = agent_dir;
    int opposite_dir = (agent_dir+2)%4;
    do{
      agent_dir = getRandomInt(0,4);
    } while(prev_dir==agent_dir || prev_dir==opposite_dir);
  }
}

void moveAgent(){ moveAgent(agent_dir); }
void moveAgent(int dir){
  if(dir==0 && agent_y>dungeon_edge){ agent_y--; } 
  if(dir==1 && agent_x<pg.width-dungeon_edge){ agent_x++; }
  if(dir==2 && agent_y<pg.height-dungeon_edge){ agent_y++; }
  if(dir==3 && agent_x>dungeon_edge){ agent_x--; }
}

void setCorridor(int x,int y){ 
  pg.beginDraw();
  pg.set(x,y,color(255));
  pg.endDraw(); 
}
void setRoom(int centerx,int centery, int width, int height){ 
  pg.beginDraw();
  for(int x=centerx-width/2;x<=centerx+width/2;x++){
    for(int y=centery-height/2;x<=centery+height/2;y++){
      pg.set(x,y,color(255)); 
    }
  }
  pg.endDraw(); 
}
void setAgent(int x,int y){ 
  pg.beginDraw();
  pg.set(x,y,color(255,0,0));
  pg.endDraw(); 
}
void setAgentTrail(int x,int y){ 
  pg.beginDraw();
  //pg.set(x,y,color(255,127,127)); 
  pg.set(x,y,color(255)); 
  pg.endDraw(); 
}

int getRandomInt(int minvalue, int maxvalue){
  return minvalue + r.nextInt(maxvalue-minvalue);
}

void draw(){
  if(pg!=null){
    scale(zoominFactor);
    image(pg, 0, 0); 
  }
  if(!drawStepWise){ update(); }
}

