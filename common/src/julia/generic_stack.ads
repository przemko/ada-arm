generic
   type Element_Type is private;
   
package Generic_Stack is
   
   Stack_Underflow : exception;
   
   type Pointer is private;
   
   function Is_Empty (Top : in Pointer) return Boolean;
   
   procedure Push (Top : in out Pointer; El : in Element_Type);
   
   function Pop (Top : in out Pointer) Return Element_Type;
   
private
   
   type Stack_Element;
   
   type Pointer is access Stack_Element;
   
   type Stack_Element is 
      record
	Item : Element_Type;
	 Next : Pointer;
     end record;

end Generic_Stack;
