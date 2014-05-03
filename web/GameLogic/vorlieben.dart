part of defense_is_magic;

/**
 * Aufz&auml;hlung der Vorlieben der Kunden
 * 
 * @author Alexander Johr m18927
 * 
 */
class Vorlieben {
  static const FLEISCH = const Vorlieben._(0);
  static const FISCH = const Vorlieben._(1);
  static const GEMUESE = const Vorlieben._(2);

  final int value;
  const Vorlieben._(this.value);
}
