with Driver; pragma Unreferenced (Driver);
with Last_Chance_Handler;  pragma Unreferenced (Last_Chance_Handler);
with System;

procedure Main is
   pragma Priority (System.Priority'First);
begin
   loop
      null;
   end loop;
end Main;

