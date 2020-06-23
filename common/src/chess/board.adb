with Ada.Real_Time; use Ada.Real_Time;
with Last_Chance_Handler; pragma Unreferenced (Last_Chance_Handler);
with Interfaces; use Interfaces;
with HAL; use HAL;
with STM32.Board; use STM32.Board;
with HAL.Bitmap; use HAL.Bitmap;
with HAL.Framebuffer; use HAL.Framebuffer;
--with HAL.Touch_Panel; use HAL.Touch_Panel;
with STM32.RNG.Polling; use STM32.RNG.Polling;
with BMP_Fonts; use BMP_Fonts;

with LCD_Std_Out;

package body Board is

   type Piece_Bitmap is array (0 .. 31) of UInt32;

   Pawn_Bitmap : Piece_Bitmap :=
     (16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#,
      16#00000000#, 16#00000000#, 16#00000000#, 16#00018000#,
      16#0003c000#, 16#0007e000#, 16#0007e000#, 16#0003c000#,
      16#0007e000#, 16#000ff000#, 16#000ff000#, 16#000ff000#,
      16#0007e000#, 16#0007e000#, 16#000ff000#, 16#001ff800#,
      16#003ffc00#, 16#007ffe00#, 16#007ffe00#, 16#007ffe00#,
      16#00ffff00#, 16#00ffff00#, 16#00ffff00#, 16#00ffff00#,
      16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#);

   Rook_Bitmap : Piece_Bitmap :=
     (16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#,
      16#00000000#, 16#00e3c700#, 16#00f3cf00#, 16#00ffff00#,
      16#00ffff00#, 16#00000000#, 16#006a5600#, 16#00000000#,
      16#003ffc00#, 16#003ffc00#, 16#003ffc00#, 16#003ffc00#,
      16#003ffc00#, 16#003ffc00#, 16#003ffc00#, 16#003ffc00#,
      16#003ffc00#, 16#00000000#, 16#00d5ab00#, 16#00ffff00#,
      16#00000000#, 16#03ffffc0#, 16#03ffffc0#, 16#01ffff80#,
      16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#);

   Knight_Bitmap : Piece_Bitmap :=
     (16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#,
      16#00000000#, 16#00042000#, 16#000c6000#, 16#001ee000#,
      16#007fe000#, 16#00ffe000#, 16#01fff000#, 16#03ff3800#,
      16#03ff1c00#, 16#07ff9e00#, 16#07ffff00#, 16#0fffff80#,
      16#0fffffc0#, 16#0fffffc0#, 16#0ffffcc0#, 16#1ffe7cc0#,
      16#1ffe3f80#, 16#1fff1f80#, 16#1fff8f00#, 16#1fffc000#,
      16#1fffe000#, 16#1ffff000#, 16#1ffff000#, 16#1ffff000#,
      16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#);

   Bishop_Bitmap : Piece_Bitmap :=
     (16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#,
      16#00000000#, 16#00018000#, 16#0003c000#, 16#0007e000#,
      16#0007e000#, 16#0003c000#, 16#000ff000#, 16#001ff800#,
      16#003ffc00#, 16#007e7e00#, 16#00fc3f00#, 16#01fc3f80#,
      16#01fe7f80#, 16#01ffff80#, 16#00ffff00#, 16#007ffe00#,
      16#003ffc00#, 16#003ffc00#, 16#007ffe00#, 16#00d5ab00#,
      16#007ffe00#, 16#003ffc00#, 16#0ffffff0#, 16#1ffc3ff8#,
      16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#);

   Queen_Bitmap : Piece_Bitmap :=
     (16#00000000#, 16#00000000#, 16#00018000#, 16#00c18300#,
      16#00c3c300#, 16#01e3c780#, 16#31e1878c#, 16#30c1830c#,
      16#78c1831e#, 16#78c3c31e#, 16#30e3c70c#, 16#30e3c70c#,
      16#38f3cf1c#, 16#3cfbdf3c#, 16#3e7ffe7c#, 16#1ffffff8#,
      16#1ffffff8#, 16#0ffffff0#, 16#07ffffe0#, 16#07ffffe0#,
      16#03ffffc0#, 16#03fc3fc0#, 16#03e3c7c0#, 16#078ff1e0#,
      16#0f3ffcf0#, 16#1f7ffef8#, 16#1ffffff8#, 16#0ffffff0#,
      16#03ffffc0#, 16#00000000#, 16#00000000#, 16#00000000#);

   King_Bitmap : Piece_Bitmap :=
     (16#00000000#, 16#00000000#, 16#00018000#, 16#00018000#,
      16#00018000#, 16#0007e000#, 16#0007e000#, 16#00018000#,
      16#0e018070#, 16#1f03c0f8#, 16#3f87e3fc#, 16#7fcff3fe#,
      16#7fc7e3fe#, 16#7fe3c7fe#, 16#7ff3cffe#, 16#7ffffffe#,
      16#7ffffffe#, 16#7ffffffe#, 16#3ffffffc#, 16#1ffffff8#,
      16#0ffffff0#, 16#0ffffff0#, 16#07ffffe0#, 16#07ffffe0#,
      16#06aa5560#, 16#0ffffff0#, 16#1ffffff8#, 16#1ffffff8#,
      16#00000000#, 16#00000000#, 16#00000000#, 16#00000000#);

   procedure Clear (Column : Column_Type; Row : Row_Type) is
   begin
      Display.Hidden_Buffer (1).Set_Source
        (if (Integer(Column) + Integer(Row)) mod 2 = 0
         then HAL.Bitmap.Brown else HAL.Bitmap.Orange);
      Display.Hidden_Buffer (1).Fill_Rect (((32*Integer(Column), 256-32*Integer(Row)), 32, 32));
   end Clear;

   procedure Clear is
   begin
      for Column in Column_Type loop
         for Row in Row_Type loop
            Clear (Column, Row);
         end loop;
      end loop;
      Display.Update_Layer (1, Copy_Back => True);
   end Clear;

   procedure Digits_And_Letters is
   begin
      LCD_Std_Out.Set_Font (Font12x12);
      LCD_Std_Out.Current_Text_Color := HAL.Bitmap.White;
      for I in 1 .. 8 loop
         LCD_Std_Out.Put (X => 4, Y => 256-32*I+10, Msg => I'Image);
         LCD_Std_Out.Put (X => 32*I+10, Y => 256+4, Msg => Character'Val (64+I));
      end loop;
   end Digits_And_Letters;

   procedure Init is
   begin
      Initialize_RNG;
      --Touch_Panel.Initialize;
      Display.Initialize (Orientation => Landscape);
      Display.Initialize_Layer (1, RGB_565);
      Digits_And_Letters;
      Clear;
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
   end Init;

   procedure Draw_Piece (Column : Column_Type; Row : Row_Type; Color : Color_Type; Piece : Piece_Type) is

      X : Integer := 32*Integer(Column);
      Y : Integer := 256 - 32*Integer(Row);
      PixCol : Bitmap_Color := (if Color = White then HAL.Bitmap.White else HAL.Bitmap.Dark_Grey);

   begin
      Clear (Column, Row);
      case Piece is
      when Pawn =>
         for I in 0..30 loop
            for J in 0..30 loop
               if (Pawn_Bitmap(J) and 2**I) /= 0 then
                  Display.Hidden_Buffer (1).Set_Pixel ((X+I+1, Y+J+1), HAL.Bitmap.Black);
               end if;
            end loop;
         end loop;

         for I in 0..31 loop
            for J in 0..31 loop
               if (Pawn_Bitmap(J) and 2**I) /= 0 then
                  Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
               end if;
            end loop;
         end loop;

         when Rook =>
            for I in 0..30 loop
               for J in 0..30 loop
                  if (Rook_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I+1, Y+J+1), HAL.Bitmap.Black);
                  end if;
               end loop;
            end loop;

            for I in 0..31 loop
               for J in 0..31 loop
                  if (Rook_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
                  end if;
               end loop;
            end loop;

         when Knight =>
            for I in 0..30 loop
               for J in 0..30 loop
                  if (Knight_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I+1, Y+J+1), HAL.Bitmap.Black);
                  end if;
               end loop;
            end loop;

            for I in 0..31 loop
               for J in 0..31 loop
                  if (Knight_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
                  end if;
               end loop;
            end loop;

         when Bishop =>
            for I in 0..30 loop
               for J in 0..30 loop
                  if (Bishop_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I+1, Y+J+1), HAL.Bitmap.Black);
                  end if;
               end loop;
            end loop;

            for I in 0..31 loop
               for J in 0..31 loop
                  if (Bishop_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
                  end if;
               end loop;
            end loop;

         when Queen =>
            for I in 0..30 loop
               for J in 0..30 loop
                  if (Queen_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I+1, Y+J+1), HAL.Bitmap.Black);
                  end if;
               end loop;
            end loop;

            for I in 0..31 loop
               for J in 0..31 loop
                  if (Queen_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
                  end if;
               end loop;
            end loop;

         when King =>
            for I in 0..30 loop
               for J in 0..30 loop
                  if (King_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I+1, Y+J+1), HAL.Bitmap.Black);
                  end if;
               end loop;
            end loop;

            for I in 0..31 loop
               for J in 0..31 loop
                  if (King_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
                  end if;
               end loop;
            end loop;
      end case;

      Display.Update_Layer (1, Copy_Back => True);

   end Draw_Piece;

   procedure Get_Position (Column : out Column_Type; Row : out Row_Type) is
--     State : TP_State := Touch_Panel.Get_All_Touch_Points;
--      X : Integer;
--      Y : Integer;
   begin
   --     while State'Length > 0 loop
   --        State := Touch_Panel.Get_All_Touch_Points;
   --     end loop;
   --
   --     loop
   --        loop
   --           State := Touch_Panel.Get_All_Touch_Points;
   --           exit when State'Length > 0;
   --        end loop;
   --        X := State (State'First).X;
   --        Y := State (State'First).Y;
   --        exit when X in 32..288 and then Y in 0..256;
   --     end loop;
   --
   --     Column := Column_Type (X / 32);
   --     Row := Row_Type ((Y+32) / 32);
      null;
   end Get_Position;

end Board;
