module UiConstants
  Mini_Tile_Size = 10

  Info_Box_x_Placement = 650
  Info_Box_y_Placement = 5

  Width = 640
  Height = 480

  Sky_Line = Height / 2

  First_Row_Height = Height - Sky_Line * 0.4
  Second_Row_Height = First_Row_Height - Sky_Line * 0.3
  Third_Row_Height = Second_Row_Height - Sky_Line * 0.15
  Fourth_Row_Height = Third_Row_Height - Sky_Line * 0.1
  Fifth_Row_Height = Fourth_Row_Height - Sky_Line * 0.05

  First_Row_Width = 0.198 * Width
  Second_Row_Width = 0.3484 * Width
  Third_Row_Width = 0.4234 * Width
  Fourth_Row_Width = 0.4734 * Width
end