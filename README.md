gameproject
===========

This is a game project to create a Might and Magic (the old ones, not the heroes series) type game where the game world, town, dungeons and NPCs would all be randomly generated on each new game. World of different size could be generated.

Feel free to submit comments, code reviews, ideas and pull requests.

This project uses

RSpec, Rake, Gosu, Texplay along with other source code. See attrib file for more details.

Getting started
---------------

From the root dir you can call map_explorer to explore map.

From the City dir you can call city_map_output to generate a sample city and see it represented as an image.

From the MapGenerator dir you can call map_output to generate a random world map and see it represented as an image.

From the RandomNameGeneration dir you can call either random_name_generator_test, establishment_name_generator_test or place_name_generator_test to see some random names.

Finally from the Rules dir you can call battle_coordinator to test out the rules engine.