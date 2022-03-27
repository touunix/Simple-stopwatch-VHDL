# ENG Simple stopwatch VHDL
###### Description
The system enables time measurement with an accuracy of hundredths of a second. The system uses a display control block and a frequency divider module. The system has two buttons:
- BTN0 - its successive presses trigger: START, STOP RESET
- BTN 3 - asynchronous reset

The time on the LED display is displayed in the form: SS.DD, and the overflow of 59.99 seconds is signalled by the display of a special overflow symbol "--.--". The system is protected against the vibration of the BTN0 button.

###### Simulation and Verification results
<img src="https://user-images.githubusercontent.com/79804729/160259482-022fefcb-b974-48aa-afba-fdd27710c90a.gif" width="100%"></img>

###### Overflow effect
<img src="https://user-images.githubusercontent.com/79804729/160259563-e95490ba-9eba-4e91-821c-d5df33b58053.gif" width="100%"></img>

###### Files description
- top_display.vhd - VHDL file with display control of individual display segments
- top_divider.vhd - VHDL file with frequency divider
- top_part.vhd - VHDL file with individual displayed symbols on the display
- top_stoper.vhd - main VHDL design file with the operation algorithm
- tb.vhd - testbench file
- iup7.xdc - file with constraints for the Nexys-A7 board (FPGA xc7a100tcsg324-1)

# PL Prosty stoper LED VHDL
###### Opis
Układ po zaprogramowaniu, umożliwia pomiar czasu z dokładnością do setnych części sekundy. W układzie został zastosowany blok sterowania wyświetlaczem oraz moduł dzielnika częstotliwości. Układ posiada dwa przyciski:
- BTN0 – kolejne jego naciśnięcia wywołują: START, STOP RESET
- BTN 3 – reset asynchroniczny

Czas na wyświetlaczu LED jest wyświetlany w postaci: SS.DD, a przekroczenie czasu 59.99 sekund jest sygnalizowane wyświetleniem specjalnego symbolu oznaczającego przepełnienie „--.--„. Układ został zabezpieczony przed drganiami przycisku BTN0.

###### Wyniki symulacji i weryfikacji
<img src="https://user-images.githubusercontent.com/79804729/160259482-022fefcb-b974-48aa-afba-fdd27710c90a.gif" width="100%"></img>

###### Efekt przepełnienia
<img src="https://user-images.githubusercontent.com/79804729/160259563-e95490ba-9eba-4e91-821c-d5df33b58053.gif" width="100%"></img>

###### Opis plików
- top_display.vhd - plik VHDL ze sterowaniem wyświetlania na poszczególnych segmentach wyświetlacza
- top_divider.vhd - plik VHDL z dzielnikiem częstotliwości
- top_part.vhd - plik VHDL z poszczególnymi wyświetlanymi symbolami na wyświetlaczu
- top_stoper.vhd - główny plik projektu VHDL z algorytmem działania
- tb.vhd - plik testbench
- iup7.xdc - plik z ograniczeniami projektowymi dla płytki Nexys-A7 (układ FPGA xc7a100tcsg324-1)
