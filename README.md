# ENG Simple stopwatch VHDL
###### Description


###### Simulation and Verification results
<img src="https://user-images.githubusercontent.com/79804729/160259482-022fefcb-b974-48aa-afba-fdd27710c90a.gif" width="90%"></img> 

###### Files description


# PL Prosty stoper LED VHDL
###### Opis
Układ po zaprogramowaniu, umożliwia pomiar czasu z dokładnością do setnych części sekundy. W układzie został zastosowany blok sterowania wyświetlaczem oraz moduł dzielnika częstotliwości. Układ posiada dwa przyciski:
- BTN0 – kolejne jego naciśnięcia wywołują: START, STOP RESET
- BTN 3 – reset asynchroniczny

Czas na wyświetlaczu LED jest wyświetlany w postaci: SS.DD, a przekroczenie czasu 59.99 sekund jest sygnalizowane wyświetleniem specjalnego symbolu oznaczającego przepełnienie „--.--„. Układ został zabezpieczony przed drganiami przycisku BTN0.

###### Wyniki symulacji i weryfikacji
<img src="https://user-images.githubusercontent.com/79804729/160259482-022fefcb-b974-48aa-afba-fdd27710c90a.gif" width="90%"></img>

###### Efekt przepełnienia
<img src="https://user-images.githubusercontent.com/79804729/160259563-e95490ba-9eba-4e91-821c-d5df33b58053.gif" width="90%"></img> 

###### Opis plików
