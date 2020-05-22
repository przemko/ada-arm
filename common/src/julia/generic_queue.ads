generic
   type Element_Type is private;

package Generic_Queue is

   Queue_Underflow : exception;

   type Pointer is private;

   function Is_Empty (Fst : in Pointer) return Boolean;

   procedure Enqueue (Fst : in out Pointer;
                      El : in Element_Type);

   function Dequeue (Fst : in out Pointer) return Element_Type;

private

   type Queue_Element;

   type Pointer is access Queue_Element;

   type Queue_Element is
      record
         Item : Element_Type;
         Next : Pointer;
      end record;

end Generic_Queue;
