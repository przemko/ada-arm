with Ada.Real_Time; use Ada.Real_Time;
with STM32.Board; use STM32.Board;

package Driver is

   protected type Fork is
      entry Pick_Up;
      procedure Put_Down;
   private
      On_Table : Boolean := True;
   end Fork;

   F0, F1, F2 : aliased Fork;

   type Colour is (Red, Blue, Green);

   type AFork is access all Fork;

   task type Philosopher (C : Colour; Left, Right : AFork) with
     Storage_Size => (4 * 1024);

   Ph1 : Philosopher (  Red, F1'Access, F0'Access);
   Ph2 : Philosopher ( Blue, F2'Access, F1'Access);
   Ph3 : Philosopher (Green, F0'Access, F2'Access);

end Driver;
