# Some common UI constants
module UiConstants
  MINI_TILE_SIZE = 10

  INFO_BOX_X_PLACEMENT = 650
  INFO_BOX_Y_PLACEMENT = 5
  INFO_BOX_FONT_SIZE = 20

  WIDTH = 640
  HEIGHT = 480

  Sky_Line = HEIGHT / 2

  First_Row_Height = HEIGHT - Sky_Line * 0.4
  Second_Row_Height = First_Row_Height - Sky_Line * 0.3
  Third_Row_Height = Second_Row_Height - Sky_Line * 0.15
  Fourth_Row_Height = Third_Row_Height - Sky_Line * 0.1
  Fifth_Row_Height = Fourth_Row_Height - Sky_Line * 0.05

  First_Row_Width = 0.198 * WIDTH
  Second_Row_Width = 0.3484 * WIDTH
  Third_Row_Width = 0.4234 * WIDTH
  Fourth_Row_Width = 0.4734 * WIDTH

  Fourth_Row_Second_Width = 0.2438 * WIDTH
  Fifth_Row_Second_Width = 0.4188 * WIDTH
end