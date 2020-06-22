with Last_Chance_Handler; pragma Unreferenced (Last_Chance_Handler);
with Board;
with Engine;

procedure Main is

   Current_Board : Engine.Board_Type;
   From_Column, To_Column : Engine.Column_Type;
   From_Row, To_Row : Engine.Row_Type;
   Status : Engine.Status_Type;

begin
   Board.Init;
   Engine.Init (Current_Board);

   loop
      Engine.Best_Move (Current_Board, Engine.Player_White,
                        From_Column, From_Row, To_Column, To_Row, Status);
      Engine.Best_Move (Current_Board, Engine.Player_Black,
                        From_Column, From_Row, To_Column, To_Row, Status);
   end loop;
end Main;

