with Ada.Unchecked_Deallocation;

package body Generic_Queue is

   function Is_Empty (Fst : Pointer) return Boolean
   is (Fst = null);

   procedure Enqueue (Fst : in out Pointer;
                      El : in Element_Type) is

      Temp : Pointer := new Queue_Element;

   begin
      Temp.Item := El;
      Temp.Next := Fst;
      Fst := Temp;
   end Enqueue;

   function Dequeue (Fst : in out Pointer) return Element_Type is
   begin
      if Fst = null then
         raise Queue_Underflow;
      else
         declare
            procedure Free is new
              Ada.Unchecked_Deallocation (Queue_Element, Pointer);
            El : Element_Type := Fst.Item;
            Temp : Pointer := Fst.Next;
         begin
            Free (Fst);
            Fst := Temp;
            return El;
         end ;
      end if;
   end Dequeue;

end Generic_Queue;
