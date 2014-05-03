import 'dart:html';
import 'GameLogic/pizza_defence.dart';

void main(){
  Element pizzaDefenceDontainer = querySelector("#pizza_defence_container");
  SpielCanvas spiel = new SpielCanvas(pizzaDefenceDontainer);
  
  spiel.run();
}