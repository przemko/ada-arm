with STM32.Board;       use STM32.Board;
with Ada.Real_Time;     use Ada.Real_Time;

package body Driver is

   task body Controller_1 is
      Period       : constant Time_Span := Milliseconds (75);  -- arbitrary
      Next_Release : Time := Clock;

   begin
      Initialize_LEDs;

      loop
         Toggle (Red_LED);

         Next_Release := Next_Release + Period;
         delay until Next_Release;
      end loop;
   end Controller_1;

   task body Controller_2 is
      Period       : constant Time_Span := Milliseconds (150);  -- arbitrary
      Next_Release : Time := Clock;

   begin
      Initialize_LEDs;

      loop
         Toggle (Blue_LED);

         Next_Release := Next_Release + Period;
         delay until Next_Release;
      end loop;
   end Controller_2;


   task body Controller_3 is
      Period       : constant Time_Span := Milliseconds (300);  -- arbitrary
      Next_Release : Time := Clock;

   begin
      Initialize_LEDs;

      loop
         Toggle (Green_LED);

         Next_Release := Next_Release + Period;
         delay until Next_Release;
      end loop;
   end Controller_3;

end Driver;
