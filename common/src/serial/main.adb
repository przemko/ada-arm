-- TO DO: poprawic bo nie dziala

--                stm32f446
------------------------------------------------------------------------
-- Tranceiver     USART_2
-- Tranceiver_AF  GPIO_AF_USART1_7
-- TX_Pin         PA2
-- Rx_Pin         PA3

with Ada.Real_Time; use Ada.Real_Time;
with STM32;         use STM32;
with STM32.Device;  use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;
with STM32.USARTs;  use STM32.USARTs;

procedure Main is

   Tranceiver    : not null access USART   := USART_2'Access;
   Tranceiver_AF : GPIO_Alternate_Function := GPIO_AF_USART2_7;
   Tx_Pin        : GPIO_Point              := PA2;
   Rx_Pin        : GPIO_Point              := PA3;

   Msg : String := "Hello World!" & ASCII.CR & ASCII.LF;

begin

   <<Initialize>>

   Enable_Clock (Tx_Pin & Rx_Pin);
   Enable_Clock (Tranceiver.all);

   Configure_IO (Tx_Pin & Rx_Pin,
                 (Mode           => Mode_AF,
                  AF             => Tranceiver_AF,
                  AF_Speed       => Speed_50MHz,
                  AF_Output_Type => Push_Pull,
                  Resistors      => Pull_Up));

   <<Configure>>

   Disable          (Tranceiver.all);
   Set_Baud_Rate    (Tranceiver.all, 9600);
   Set_Mode         (Tranceiver.all, Tx_Rx_Mode);
   Set_Stop_Bits    (Tranceiver.all, Stopbits_1);
   Set_Word_Length  (Tranceiver.all, Word_Length_8);
   Set_Parity       (Tranceiver.all, No_Parity);
   Set_Flow_Control (Tranceiver.all, No_Flow_Control);
   Enable           (Tranceiver.all);

   <<Transmission>>

   loop

      for Ch of Msg loop

         <<Await_Send_Ready>>

         loop
            exit when Tx_Ready (Tranceiver.all);
         end loop;

         << Transmit_One_Character>>

         Transmit (Tranceiver.all, Character'Pos (Ch));

      end loop;

      delay until Clock + Milliseconds (1000);

   end loop;

end Main;
