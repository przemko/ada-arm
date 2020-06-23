package body Engine is

   procedure Init (Board : out Board_Type) is
   begin
      Board :=
        (1    => ((White, Rook), (White, Knight), (White, Bishop), (White, Queen),
                  (White, King), (White, Bishop), (White, Knight), (White, Rook)),
         2    => (others => (White, Pawn)),
         3..6 => (others => (None, Empty)),
         7    => (others => (Black, Pawn)),
         8    => ((Black, Rook), (Black, Knight), (Black, Bishop), (Black, Queen),
                  (Black, King), (Black, Bishop), (Black, Knight), (Black, Rook)));
   end Init;

   function Is_Empty (Board : Board_Type; Column : Column_Type; Row : Row_Type) return Boolean
   is (Board (Column, Row).PC = Empty)
     with Inline;

   function Whose_Piece (Board : Board_Type; Column : Column_Type; Row : Row_Type) return Player_Type
   is (if Board(Column, Row).CL = White then Player_White else Player_Black)
     with Inline, Pre => not Is_Empty (Board, Column, Row);

   function Which_Piece (Board : Board_Type; Column : Column_Type; Row : Row_Type) return Piece_Type
   is (Board(Column, Row).PC);

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
