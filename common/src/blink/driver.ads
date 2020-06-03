with Ada.Real_Time; use Ada.Real_Time;
with STM32.Board; use STM32.Board;

package Driver is

   type Colour is (Red, Green, Blue);

   task type Controller (P  : Positive := 100; C : Colour := Red) with
     Storage_Size => (4 * 1024);

   C1 : Controller ( 75, Red  );
   C2 : Controller (150, Blue );
   C3 : Controller (300, Green);

end Driver;
