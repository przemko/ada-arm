with Ada.Unchecked_Deallocation;

package body Generic_Stack is
   
   function Is_Empty (Top : in Pointer) return Boolean
   is (Top = null);
   
   procedure Push (Top : in out Pointer; El : Element_Type) is
      Temp : Pointer := Top;
   begin
      Top := new Stack_Element;
      Top.Item := El;
      Top.Next := Temp;
   end Push;
   
   function Pop (Top : in out Pointer) return Element_Type is
   begin
      if Top = null then
	 raise Stack_Underflow;
      else
	 declare
	    procedure Free is new 
	      Ada.Unchecked_Deallocation (Stack_Element, Pointer);
	    El : Element_Type := Top.Item;
	    Temp : Pointer := Top.Next;
	 begin
	    Free (Top);
	    Top := Temp;
	    return El;
	 end;
      end if;
   end Pop;
   
end Generic_Stack;
