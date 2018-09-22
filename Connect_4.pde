/*  Name : Conor Power
    Student Number: 20075871
    Programme Name: Connect 4

    Description of the animation achieved:
    I have made the popular game Connect 4 using Processing IDE.
    I have made it functional as a 2 player game.
    I have also designed the game in the way that it will tell you who
    the winner is and then restart the game upon you pressing the space button.

    Known bugs/problems:
    The game does not register all possible winning outcomes.
    Game says player 1 wins if game is tied.
*/


int w = 7, h = 6, bs = 100, player = 1;     //width, height and box size
int [][] board = new int[h][w];             //create board


void setup()
{
  size (700, 600);
  ellipseMode(CORNER);                      //registers first two parmeters of ellipse as upper-left corner of the shape, last two parameters are its width and height
}

int piece(int y, int x)                                    //position of piece be it red or green
{
  return (y<0 || x<0 || y>=h || x>=w) ?0: board [y][x];    //return 0 if off board, otherwise return board [y][x] position
}

int getWinner()  //checking for winners in different rows, columns and diagonals and ties
{
  for(int y=0; y<h; y++) for(int x=0;x<w;x++)
    if(piece(y,x) != - 0 && piece(y,x) == piece(y,x+1) && piece(y,x) == piece(y,x+2) && piece(y,x) == piece(y,x+3)) return piece(y,x);           //Rows
  for(int y=0; y<h; y++) for(int x=0;x<w;x++)
    if(piece(x,y) != 0 && piece(y,x) == piece(y+1,x) && piece(y,x) == piece(y+2,x) && piece(y,x) == piece(y+3,x)) return piece(y,x);             //Columns
  for(int y=0; y<h; y++) for(int x=0;x<w;x++) for(int d=-1;d<=1;d+=2)
    if(piece(y,x) !=0 && piece(y,x) == piece(y+1*d,x+1) && piece(y,x) == piece(y+2*d,x+2) && piece(y,x) == piece(y+3*d,x+3)) return piece(y,x);  //Diagonals
  for (int y=0; y<h; y++) for(int x=0;x<w;x++) if (piece(y,x) ==0) return 0;
  return -1; //tie
}

int nextSpace(int x)                        //calculate where the next empty space is to drop coin
{
  for (int y=h-1;y>=0;y--) 
  if(board[y][x]==0) return y;              //if no empty slot is found 
  return -1;                                //remove that slot and restart to find available spot
}

void mousePressed()                         //calculate the position you clicked
{
  int x = (mouseX/bs), y = nextSpace(x);
  if(y>=0)                                  //if slot is available
  {
    board[y][x] = player;                   //put player into that spot
    player = player==1?2:1;                 //switch player to next player
  }
}

void draw()
{
  if(getWinner()==0)                                          //if true you can play game
  {
    for(int j=0; j<h; j++) for (int i=0; i<w; i++)            //draws board
    {
      fill(255);
      rect(i*bs, j*bs,bs,bs);
      if(board[j][i]>0)
      {
        fill(board[j][i]==1?255:0, board[j][i]==2?255:0,0);   //if player1 draw red ellipse, if player2 draw green token
        ellipse(i*bs,j*bs,bs,bs);
      }
    }
  }
  else
  {
    background(0);
    fill(255);
    text("Winner: "+getWinner()+". Press space to restart the game" , width/2, height/2);       //prints winner
    if(keyPressed&&key==' ')                                                                    //if you press space game restarts
    {
      player=1; for(int y=0; y<h; y++) for(int x=0;x<w;x++) board[y][x]=0;                      //restart game
    }
  }
}