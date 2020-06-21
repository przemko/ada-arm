with Last_Chance_Handler; pragma Unreferenced (Last_Chance_Handler);
with Board; use Board;

procedure Main is

begin
   Init;

   Draw_Piece (1, 1, White, Rook);    Draw_Piece (1, 2, White, Pawn);
   Draw_Piece (2, 1, White, Knight);  Draw_Piece (2, 2, White, Pawn);
   Draw_Piece (3, 1, White, Bishop);  Draw_Piece (3, 2, White, Pawn);
   Draw_Piece (4, 1, White, Queen);   Draw_Piece (4, 2, White, Pawn);
   Draw_Piece (5, 1, White, King);    Draw_Piece (5, 2, White, Pawn);
   Draw_Piece (6, 1, White, Bishop);  Draw_Piece (6, 2, White, Pawn);
   Draw_Piece (7, 1, White, Knight);  Draw_Piece (7, 2, White, Pawn);
   Draw_Piece (8, 1, White, Rook);    Draw_Piece (8, 2, White, Pawn);

   Draw_Piece (1, 8, Black, Rook);    Draw_Piece (1, 7, Black, Pawn);
   Draw_Piece (2, 8, Black, Knight);  Draw_Piece (2, 7, Black, Pawn);
   Draw_Piece (3, 8, Black, Bishop);  Draw_Piece (3, 7, Black, Pawn);
   Draw_Piece (4, 8, Black, Queen);   Draw_Piece (4, 7, Black, Pawn);
   Draw_Piece (5, 8, Black, King);    Draw_Piece (5, 7, Black, Pawn);
   Draw_Piece (6, 8, Black, Bishop);  Draw_Piece (6, 7, Black, Pawn);
   Draw_Piece (7, 8, Black, Knight);  Draw_Piece (7, 7, Black, Pawn);
   Draw_Piece (8, 8, Black, Rook);    Draw_Piece (8, 7, Black, Pawn);

   loop
      null;
   end loop;
end Main;

