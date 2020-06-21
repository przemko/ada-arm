with Ada.Real_Time; use Ada.Real_Time;
with Last_Chance_Handler; pragma Unreferenced (Last_Chance_Handler);
with Interfaces; use Interfaces;
with HAL; use HAL;
with STM32.Board; use STM32.Board;
with HAL.Bitmap; use HAL.Bitmap;
with HAL.Framebuffer; use HAL.Framebuffer;
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
      Display.Initialize (Orientation => Landscape);
      Display.Initialize_Layer (1, RGB_565);
      Digits_And_Letters;
      Clear;
   end Init;

   procedure Draw_Piece (Column : Column_Type; Row : Row_Type; Color : Color_Type; Piece : Piece_Type) is

      X : Integer := 32*Integer(Column);
      Y : Integer := 256 - 32*Integer(Row);
      PixCol : Bitmap_Color := (if Color = White then HAL.Bitmap.White else HAL.Bitmap.Black);

   begin
      Clear (Column, Row);
      case Piece is
      when Pawn =>
         for I in 0..31 loop
            for J in 0..31 loop
               if (Pawn_Bitmap(J) and 2**I) /= 0 then
                  Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
               end if;
            end loop;
         end loop;

         when Rook =>
            for I in 0..31 loop
               for J in 0..31 loop
                  if (Rook_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
                  end if;
               end loop;
            end loop;

         when Knight =>
            for I in 0..31 loop
               for J in 0..31 loop
                  if (Knight_Bitmap(J) and 2**I) /= 0 then
                     Display.Hidden_Buffer (1).Set_Pixel ((X+I, Y+J), PixCol);
                  end if;
               end loop;
            end loop;
         when others =>
            null;
      end case;
      Display.Update_Layer (1, Copy_Back => True);

end Draw_Piece;

end Board;
