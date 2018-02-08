# Constructive Generation Methods for Dungeons and Levels

This repository contains algorithms for digger agents and cellular automata which create dungeons and caves. The algorithms included are presented in detail in the Constructive Generation Methods for Dungeons and Levels chapter of the <A href="http://pcgbook.com/">PCG book</A>. A version of this chapter is also available in HTML format <a href="http://antoniosliapis.com/articles/pcgbook_dungeons.php">here</a>. If you use this code it would be nice to refer to the original publication which is <a href="http://antoniosliapis.com/publications.php?bib=shaker2016constructive#shaker2016constructive">this</a> (along with the bibtex format).

All the included .pde files can be run as-is. In order to open and compile the algorithms, <b>Processing 1.5.1</b> (scroll through <a href="https://processing.org/download/">processsing.org</a>) must be 'installed'; while the programs <b>may</b> run with Processing 2.2.1, it will not run with Processing 3.3 unless modifications are made (I will probably add Processing 3 versions within the year). Processing is built on Java and should be straightforward for anyone with object oriented programming experience. Some important variables in the code will also be highlighted below.

# General parameters

All .pde files visualize a dungeon or cave system made up of impassable tiles (e.g. walls) in black and passable tiles in white. In order to customize the size of the dungeon, you can edit the <b>tiles</b> tuple (width and height in tiles, in that order). In order to decrease or increase the size of each tile (for instance, for larger or smaller screens and resolutions), you can edit the <b>zoominFactor</b>. Every dungeon has a border of impassable tiles around it that can not be changed by any generator: the width of this border can be changed via the <b>dungeon_edge</b> parameter.

Finally, all algorithms in this repository can be run one step at a time, performing one step only when the user presses any key except <b>R</b> (pressing R resets all processes and clears the dungeon, starting generation from scratch). Otherwise, the algorithms can run automatically, taking one generative step per frame update. To toggle between the two, change the boolean flag <b>drawStepWise</b> (default false).

# Digger agents

Three digger agents are included in this repository. All agents are shown in red, and start at the middle of the dungeon. 

<img width = 400 height = 400 src="/images/random.png"/>

The simplest digger agent is the <b><i>AgentBasedDungeon_random</i></b>, which moves randomly from the center of the dungeon. Movement can be completely random or biased towards avoiding the opposite direction: this is controlled by the <b>directionMode</b> parameter. 

<img width = 400 height = 400 src="/images/corridor.png"/>

A variation of the random digger agent which moves without changing direction as often is the <b><i>AgentBasedDungeon_corridor</i></b>. The only variable that can affect this algorithm is the <b>changeDirInc</b> which determines how often the digger will change direction and thus how long its corridors tend to be.

<img width = 400 height = 400 src="/images/room.png"/>

Expanding on the corridor agent, the <b><i>AgentBasedDungeon_room</i></b> agent adds rooms; both the <b>changeDirInc</b> and the <b>addRoomInc</b> parameters can be tweaked to affect how often the digger changes direction or adds a room respectively. The size of the rooms can be edited through the <b>minRoomSize</b> and <b>maxRoomSize</b> tuples, which randomize room width (first) and room height (second) independently.

# Cellular automata

Cellular automata start from a random binary map and recolor each tile based on the majority of the neighboring tiles. Two ways in which neighboring tiles can be determined is included in this algorithm: the Moore neighborhood (all 8 adjacent tiles) and the von Neumann neighborhood (only 4 adjacent tiles along the cardinal directions). More information can be gathered from the PCG book chapter linked above.

<img width = 400 height = 400 src="/images/cellular.png"/>

The cellular automata are found in <b><i>CellularAutomata_caves</i></b>. Apart from the general variables described above, the only variable that can be changed is the <b>mooreNeighborhood</b> boolean flag, which if true uses the Moore neighborhood and if false uses the von Neumann neighborhood for determining how each tile changes. For the purposes of demonstrating how cellular automata work, it is recommended to set <b>drawStepWise</b> to true, and also to reset the map using the <b>R</b> key.

# Notes

The code above is aimed to act as a tutorial for simple constructive methods for creating (simple) dungeons and caves. Many quick and easy fixes could be applied to the algorithms to improve the generated outcomes. Simplicity and readability was prioritized here as the code is provided as a backdrop of an educational curriculum using the PCG book. I would heartily recommend digging deeper into the code and editing it to improve e.g. how steps are counted in the digger agent for the purposes of changing direction, or to remove disconnected smaller caves in the cellular automata.
