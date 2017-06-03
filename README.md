# Constructive Generation Methods for Dungeons and Levels

This repository contains algorithms for digger agents and cellular automata which create dungeons and caves. The algorithms included are presented in detail in the Constructive Generation Methods for Dungeons and Levels chapter of the <A href="http://pcgbook.com/">PCG book</A>.

All the included .pde files can be run as-is. In order to open and compile the algorithms, Processing 1.5.1 must be installed; while the programs <b>may</b> run with Processing 2.2.1, it will not run with Processing 3.3 unless modifications are made (I will probably add Processing 3 versions within the year). Processing is built on Java and should be straightforward for any user with knowlede of object oriented programming. Some important variables in the code will also be highlighted below.

# General parameters

All .pde files visualize a dungeon or cave system made up of impassable tiles (e.g. walls) in black and passable tiles in white. In order to customize the size of the dungeon, you can edit the <b>tiles</b> tuple (width and height in tiles, in that order). In order to decrease or increase the size of each tile (for instance, for larger or smaller screens and resolutions), you can edit the <b>zoominFactor</b>. Every dungeon has a border of impassable tiles around it that can not be changed by any generator: the width of this border can be changed via the <b>dungeon_edge</b> parameter.

Finally, all algorithms in this repository can be run one step at a time, performing one step only when the user presses any key except <b>R</b>. Otherwise, the algorithms can run automatically, taking one generative step per frame update. To toggle between the two, change the boolean flag <b>drawStepWise</b> (default false).

# Digger agents

Three digger agents are included in this repository. All agents are shown in red, and start at the middle of the dungeon. 

The simplest digger agent is the <b><i>AgentBasedDungeon_random</i></b>, which moves randomly from the center of the dungeon. Movement can be completely random or biased towards avoiding the opposite direction: this is controlled by the <b>directionMode</b> parameter. 

A variation of the random digger agent which moves without changing direction as often is the <b><i>AgentBasedDungeon_corridor</i></b>. The only variable that can affect this algorithm is the <b>changeDirInc</b> which determines how often the digger will change direction and thus how long its corridors tend to be.

Expanding on the corridor agent, the <b><i>AgentBasedDungeon_room</i></b> agent adds rooms; both the <b>changeDirInc</b> and the <b>addRoomInc</b> parameters can be tweaked to affect how often the digger changes direction or adds a room respectively.
