package Engine is

   type Player_Type is (Player_White, Player_Black);

   type Index_Type is range 1..8;

   type Column_Type is new Index_Type;

   type Row_Type is new Index_Type;

   type Field_Type is (Empty,
                       White_Pawn, White_Rook, White_Knight, White_Bishop, White_Queen, White_King,
                       Black_Pawn, Black_Rook, Black_Knight, Black_Bishop, Black_Queen, Black_King);

   type Board_Type is array (Column_Type, Row_Type) of Field_Type;

   type Status_Type is (OK, Draw, Error);

   procedure Init (Board : out Board_Type);

   procedure Best_Move (Board : in Board_Type;
                        Player : in Player_Type;
                        From_Column : out Column_Type; From_Row : out Row_Type;
                        To_Column : out Column_Type; To_Row : out Row_Type;
                        Status : out Status_Type);

end Engine;
