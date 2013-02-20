 _______  __   __  _______  __   __  ___   _______  _______  ______    __   __ 
|       ||  | |  ||       ||  |_|  ||   | |       ||       ||    _ |  |  | |  |
|       ||  |_|  ||    ___||       ||   | |  _____||_     _||   | ||  |  |_|  |
|       ||       ||   |___ |       ||   | | |_____   |   |  |   |_||_ |       |
|      _||       ||    ___||       ||   | |_____  |  |   |  |    __  ||_     _|
|     |_ |   _   ||   |___ | ||_|| ||   |  _____| |  |   |  |   |  | |  |   |  
|_______||__| |__||_______||_|   |_||___| |_______|  |___|  |___|  |_|  |___|  

BY:             bas080
DESCRIPTION:    Get to know the world of matter
VERSION:        0.3
LICENSE:        WTFPL
FORUM:          http://forum.minetest.net/viewtopic.php?pid=69829

How to use
1. Get extractor (/giveme chemistry:extractor)
2. Place the extractor
3. Place node behind the arrow
4  Punch the extractor
5. Mine the atoms

6. Get reactor (/giveme chemistry:extractor)
7. Place the reactor
8. Build the reaction behind the arrow
9. Punch reactor to create block(molecules)

Features
Extract atoms from world with extractor /giveme chemistry:extractor
React atoms to create blocks /giveme chemistry:reactor

API
That enables mod to implement chemistry crafts
example of water_source:
chemistry:register_reaction({"default:water_source",
  {"chemistry:O", "chemistry:O"},
  {"chemistry:and"},
  {"chemistry:H", "chemistry:H"},
  {"chemistry:H", "chemistry:H"},
})

Changelog
ToDo
* Craft for extractor and reactor
* Fussion reactor to create rare elements

0.3
* Extractor changes nodes into atoms

0.2
* Reactor function enables players to compose a molecule and react it to molecule(node)

0.1
* Elements nodes with textures
