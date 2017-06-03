import java.util.Random;

static final boolean drawStepWise = true;
static final int dungeon_edge = 5;

static final int[] tiles = {50,50};
static final int zoominFactor = 13;

static int prntscr_count = 0;

static boolean mooreNeighborhood = false;

Random r;
PGraphics pg;

void setup(){
  size(tiles[0]*zoominFactor, tiles[1]*zoominFactor);
  frameRate(3);
  noSmooth();
  r = new Random();
  resetGraphics();
  setBlackWhiteNoise();
}

void setBlackWhiteNoise(){
  pg.beginDraw();
  for(int x=dungeon_edge;x<pg.width-dungeon_edge;x++){
    for(int y=dungeon_edge;y<pg.height-dungeon_edge;y++){
      int c = r.nextInt()>=0.5 ? 0 : 255;
      pg.set(x,y,color(c));
    }
  }
  pg.endDraw();
}

void applyCellularAutomata(){
  boolean[][] tempMap = new boolean[pg.width][pg.height];
  pg.beginDraw();
  for(int x=0;x<pg.width;x++){
    for(int y=0;y<pg.height;y++){
      int blackCount = 0;
      // MOORE
      if(mooreNeighborhood){
        for(int i=x-1;i<=x+1;i++){
          for(int j=y-1;j<=y+1;j++){
            if(i<0||i>=pg.width||j<0||j>=pg.height){ 
              blackCount++; 
            } else {
              if(pg.get(i,j)==color(0)){
                blackCount++;
              }
            }
          }
        }
        tempMap[x][y]=(blackCount<5);
      } else {
        int totalCount=0;
        for(int i=x-1;i<=x+1;i++){
          for(int j=y-1;j<=y+1;j++){
            if(i==x || j==y){
              totalCount++;
              if(i<0||i>=pg.width||j<0||j>=pg.height){ 
                blackCount++; 
              } else {
                if(pg.get(i,j)==color(0)){
                  blackCount++;
                }
              }
            }
          }
        }
        println(blackCount+"/"+totalCount);
        tempMap[x][y]=(blackCount<3);
      }
      //int c = (blackCount>=5) ? 0 : 255;
      //pg.set(x,y,color(c));
    }
  }
  for(int x=0;x<pg.width;x++){
    for(int y=0;y<pg.height;y++){
      int c = tempMap[x][y] ? 255 : 0;
      pg.set(x,y,color(c));
    }
  }
  pg.endDraw();
}

void keyTyped(){
  if(key=='s'){ 
    pg.save("screen"+prntscr_count+".png");
    prntscr_count++;
  } else if(key=='r'){ 
    resetGraphics();
    setBlackWhiteNoise();
  } else {
    if(drawStepWise){ applyCellularAutomata(); }
  } 
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

void setEmpty(int x,int y){ 
  pg.beginDraw();
  pg.set(x,y,color(0));
  pg.endDraw(); 
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
  pg.set(x,y,color(255,127,127)); 
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
  if(!drawStepWise){ applyCellularAutomata(); }
}

