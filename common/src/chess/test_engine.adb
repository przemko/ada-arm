with Ada.Text_IO; use Ada.Text_IO;
with Engine; use Engine;

procedure Test_Engine is

   Board : Board_Type;
   Player : Player_Type := Player_White;
   From_Column, To_Column : Column_Type;
   From_Row, To_Row : Row_Type;
   Status : Status_Type;

begin
   Init (Board);
   loop
      Best_Move (Board, Player, From_Column, From_Row, To_Column, To_Row, Status);
      Put_Line("Status: " & Status_Type'Image (Status));
      exit when Status = Error;
      Put_Line("  Move: " & Column_Type'Image (From_Column) & Row_Type'Image (From_Row) &
                 " --> " & Column_Type'Image (To_Column) & Row_Type'Image (To_Row));
      exit when Status = Draw or Status = Checkmate;
      if Player = Player_White then
         Player := Player_Black;
      else
         Player := Player_White;
      end if;
   end loop;

end Test_Engine;
