with STM32.Board;       use STM32.Board;
with Ada.Real_Time;     use Ada.Real_Time;

package body Driver is

   task body Controller is
      LED : User_LED :=
        (if C = Red then Red_LED else (if C = Green then Green_LED else Blue_LED));
      Period : Time_Span := Milliseconds (P);
      Next_Release : Time := Clock;
   begin
      Initialize_LEDs;
      loop
         Toggle (LED);
         Next_Release := Next_Release + Period;
         delay until Next_Release;
      end loop;
   end Controller;

end Driver;
