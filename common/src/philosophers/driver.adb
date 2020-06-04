with STM32.Board;       use STM32.Board;
with Ada.Real_Time;     use Ada.Real_Time;

package body Driver is

   protected body Fork is

      entry Pick_Up when On_Table is
      begin
         On_Table := False;
      end Pick_Up;

      procedure Put_Down is
      begin
         On_Table := True;
      end Put_Down;

   end Fork;

   task body Philosopher is
      LED : User_LED :=
        (if C = Red then Red_LED else (if C = Blue then Blue_LED else Green_LED));
   begin
      Initialize_LEDs;
      loop

         <<Thinking>>

         Turn_On (LED);
         Left.Pick_Up;
         Right.Pick_Up;
         Turn_Off (LED);

         <<Eating>>

         delay until Clock + Milliseconds (200);

         Left.Put_Down;
         Right.Put_Down;

      end loop;
   end Philosopher;

end Driver;
