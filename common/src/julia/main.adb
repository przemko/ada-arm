with Ada.Numerics.Generic_Complex_Types;
with Ada.Numerics.Generic_Complex_Elementary_Functions;
with Last_Chance_Handler; pragma Unreferenced (Last_Chance_Handler);
with Interfaces; use Interfaces;
with HAL; use HAL;
with STM32.Board; use STM32.Board;
with HAL.Bitmap; use HAL.Bitmap;
with HAL.Framebuffer; use HAL.Framebuffer;
with STM32.RNG.Polling; use STM32.RNG.Polling;

with LCD_Std_Out;

with Generic_Stack;

procedure Main is

   package Complex_Types is
     new Ada.Numerics.Generic_Complex_Types (Float);
   use Complex_Types;

   package Complex_Functions is
     new Ada.Numerics.Generic_Complex_Elementary_Functions (Complex_Types);
   use Complex_Functions;

   type Element is
      record
         Z : Complex_Types.Complex;
         Label : Natural;
         Deriv : Float;
      end record;

   package Stack is new Generic_Stack(Element);

   Top : Stack.Pointer;

   Format : constant HAL.Framebuffer.FB_Color_Mode := RGB_565;
   White_Color : constant UInt32 := 16#FFFF#;
   Blue_Color : constant UInt32 := 16#001F#;
   Black_Color : constant UInt32 := 16#0000#;

   LCD_W : constant := (if LCD_Natural_Width > LCD_Natural_Height
                        then LCD_Natural_Width else LCD_Natural_Height);
   LCD_H : constant := (if LCD_Natural_Width > LCD_Natural_Height
                        then LCD_Natural_Height else LCD_Natural_Width);

   procedure Clear is
   begin
      for Y in 0 .. LCD_H loop
         for X in 0 .. LCD_W loop
            Display.Hidden_Buffer (1).Set_Pixel ((X, Y), Blue_Color);
         end loop;
      end loop;
   end Clear;

   C : Complex_Types.Complex := (Re => -0.512511498387847167,
                                 Im =>  0.521295573094847167);

   Dbound : constant Float := 300.0;

   Maxdepth : Natural := 100;

   Counter : Natural := 0;

begin
   Initialize_RNG;
   Display.Initialize (Orientation => Landscape);
   Display.Initialize_Layer (1, Format);
   Clear;

   Stack.Push (Top, ((0.0, 0.0), 0, 1.0));

   LCD_Std_Out.Current_Background_Color := Blue;
   while not Stack.Is_Empty (Top) loop
      declare
         Current : Element := Stack.Pop (Top);
         X : Integer := Integer (Float (LCD_W) * (Current.Z.Re + 1.5) / 3.0);
         Y : Integer := Integer (Float (LCD_H) * (1.0 - Current.Z.Im) / 2.0);
      begin
         if X >= 0 and then X < LCD_W and then Y >= 0 and then Y < LCD_H then
            Counter := Counter + 1;
            if Counter mod 1000 = 0 then
               LCD_Std_Out.Put (X => 0, Y => LCD_H - 24, Msg => Counter'Image);
            end if;
            Display.Hidden_Buffer (1).Set_Pixel ((X, Y), Black_Color);
            Display.Update_Layer (1, Copy_Back => True);
         end if;
         if Current.Label < Maxdepth and then Current.Deriv < Dbound then
            Current.Z := Sqrt (Current.Z - C);
            Current.Label := Current.Label + 1;
            Current.Deriv := 2.0 * Current.Deriv*abs(Current.Z);
            Stack.Push (Top, Current);
            Current.Z := - Current.Z;
            Stack.Push (Top, Current);
         end if;
      end;
   end loop;

   LCD_Std_Out.Put (X => 0, Y => LCD_H - 24, Msg => Counter'Image);

   loop
      null;
   end loop;
end Main;

