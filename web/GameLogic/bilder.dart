part of defense_is_magic;


/** 
 * Hat die Pfade der Bilder und f&uuml;gt sie in Variabeln ein
 * 
 * @author Alexander Johr m18927 
 */
class Bilder {
  static final String pfad = './content/';

  static final ImageElement bildSalamiPizza = new ImageElement(src: '${pfad}pizza salami.png');
  static final ImageElement bildGemuesePizza = new ImageElement(src: '${pfad}pizza vegetarisch.png');
  static final ImageElement bildFischPizza = new ImageElement(src: '${pfad}pizza fisch.png');

  static final ImageElement bildSalamiPizzaria = new ImageElement(src: '${pfad}Fleisch Pizzeria.png');
  static final ImageElement bildGemuesePizzaria = new ImageElement(src: '${pfad}Vegetarische Pizzeria.png');
  static final ImageElement bildFischPizzaria = new ImageElement(src: '${pfad}FischPizzeria.png');

  static final ImageElement bildKundeFisch = new ImageElement(src: '${pfad}kunden fleisch.png');
  static final ImageElement bildKundeFleisch = new ImageElement(src: '${pfad}kunden fisch.png');
  static final ImageElement bildKundeGemuese = new ImageElement(src: '${pfad}kunden vegetarier.png');

  static final ImageElement bildHintergrund = new ImageElement(src: '${pfad}hintergrund spiel1.png');


  /**
   * Bielder f&uuml;r die Pizzen
   * 
   * @param pizzaTyp von dem das Bild selektiert werden soll
   * @return Pizzabild des angegebenen Typs
   */
  static ImageElement getPizzaBild(PizzaType pizzaTyp) {
    switch (pizzaTyp) {
      case PizzaType.SALAMI:
        return bildSalamiPizza;
      case PizzaType.TUNFISCH:
        return bildFischPizza;
      default:
        return bildGemuesePizza;
    }
  }

  /**
   * Bielder fuer die Pizzaria
   * 
   * @param pizzaTyp von dem das Bild selektiert werden soll
   * @return Pizzariabild des angegebenen Typs
   */
  static ImageElement getPizzariaBild(PizzaType pizzaTyp) {

    switch (pizzaTyp) {
      case PizzaType.SALAMI:
        return bildSalamiPizzaria;
      case PizzaType.TUNFISCH:
        return bildFischPizzaria;
      default:
        return bildGemuesePizzaria;
    }
  }

  /**
   * Bielder f&uuml;r die Kunden
   * 
   * @param vorliebe des Kunden von dem das Bild selektiert werden soll
   * @return Kundenbild des angegebenen Typs
   */
  static ImageElement getKundeBild(Vorlieben vorliebe) {
    switch (vorliebe) {
      case Vorlieben.FISCH:
        return bildKundeFisch;
      case Vorlieben.FLEISCH:
        return bildKundeFleisch;
      default:
        return bildKundeGemuese;
    }
  }

  /**
   * Gibt Hintergrundbild zur&uuml;ck
   * 
   * @return Das Hintergrundbild der Processing Ausgabe
   */
  static ImageElement getBildhintergrund() {
    return bildHintergrund;
  }
}
