package body Engine is

   procedure Init (Board : out Board_Type) is
   begin
      Board :=
        (1    => (White_Rook, White_Knight, White_Bishop, White_Queen, White_King, White_Bishop, White_Knight, White_Rook),
         2    => (others => White_Pawn),
         3..6 => (others => Empty),
         7    => (others => Black_Pawn),
         8    => (Black_Rook, Black_Knight, Black_Bishop, Black_Queen, Black_King, Black_Bishop, Black_Knight, Black_Rook));
   end Init;

   function Is_Empty (Board : Board_Type; Column : Column_Type; Row : Row_Type) return Boolean
   is (Board (Column, Row) = Empty)
     with Inline;

   function Whose_Piece (Board : Board_Type; Column : Column_Type; Row : Row_Type) return Player_Type
   is (Player_White)
     with Inline, Pre => not Is_Empty (Board, Column, Row);

   procedure Best_Move (Board : in Board_Type;
                        Player : in Player_Type;
                        From_Column : out Column_Type; From_Row : out Row_Type;
                        To_Column : out Column_Type; To_Row : out Row_Type;
                        Status : out Status_Type) is
   begin
      From_Column := 1; From_Row := 1;
      To_Column   := 1;   To_Row := 1;
      Status := Error;
   end Best_Move;


end Engine;
