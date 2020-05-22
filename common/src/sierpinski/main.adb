with Last_Chance_Handler; pragma Unreferenced (Last_Chance_Handler);
with Interfaces; use Interfaces;
with HAL; use HAL;
with STM32.Board; use STM32.Board;
with HAL.Bitmap; use HAL.Bitmap;
with HAL.Framebuffer; use HAL.Framebuffer;
with STM32.RNG.Polling; use STM32.RNG.Polling;

procedure Main is

   Format : constant HAL.Framebuffer.FB_Color_Mode := RGB_565;
   White_Color : constant UInt32 := 16#FFFF#;
   Blue_Color : constant UInt32 := 16#001F#;
   LCD_W : constant := (if LCD_Natural_Width > LCD_Natural_Height
                        then LCD_Natural_Width else LCD_Natural_Height);
   LCD_H : constant := (if LCD_Natural_Width > LCD_Natural_Height
                        then LCD_Natural_Height else LCD_Natural_Width);

   procedure Clear;
   procedure Step;

   procedure Clear is
   begin
      for Y in 0 .. LCD_H loop
         for X in 0 .. LCD_W loop
            Display.Hidden_Buffer (1).Set_Pixel ((X, Y), Blue_Color);
         end loop;
      end loop;
   end Clear;

   Offset : constant Float := Float (LCD_W - LCD_H) / 2.0;
   X : Float := Offset;
   Y : Float := Float (LCD_H);
   Xs : constant array (0 .. 2) of Float := (Offset + Float (LCD_H) / 2.0, Offset, Offset + Float (LCD_H));
   Ys : constant array (0 .. 2) of Float := (0.0, Float (LCD_H), Float (LCD_H));

   procedure Step is
      I : Natural;
   begin
      Display.Hidden_Buffer (1).Set_Pixel ((Integer (X), Integer (Y)), White_Color);
      I := Natural (Random mod 3);
      X := (X + Xs (I)) * 0.5;
      Y := (Y + Ys (I)) * 0.5;
      Display.Update_Layer (1, Copy_Back => True);
   end Step;

begin
   Initialize_RNG;
   Display.Initialize (Orientation => Landscape);
   Display.Initialize_Layer (1, Format);
   Clear;
   loop
      Step;
   end loop;
end Main;

