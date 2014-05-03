part of defense_is_magic;


/**
 * Aufz&auml;hlung der Typen der Pizzen und Pizzerien
 * 
 * @author Alexander Johr m18927
 * 
 */
class PizzaType {
  static const VEGETARISCH = const PizzaType._(0);
  static const SALAMI = const PizzaType._(1);
  static const TUNFISCH = const PizzaType._(2);

  final int value;
  const PizzaType._(this.value);
}
