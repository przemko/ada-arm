package Board is

   type Color_Type is (White, Black);

   type Piece_Type is (King, Queen, Rook, Bishop, Knight, Pawn);

   type Index_Type is range 1 .. 8;

   type Column_Type is new Index_Type;

   type Row_Type is new Index_Type;

   procedure Init;

   procedure Clear;

   procedure Clear (Column : Column_Type; Row : Row_Type);

   procedure Draw_Piece (Column : Column_Type; Row : Row_Type; Color : Color_Type; Piece : Piece_Type);

end Board;
