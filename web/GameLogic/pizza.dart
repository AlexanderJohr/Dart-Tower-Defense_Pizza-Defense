part of defense_is_magic;


/**
 * Das Pizza Object zeichnet die Pizza und verfolgt den Kunden
 * 
 * @author Alexander Johr m18927
 * 
 */
class Pizza extends SpielObjekt {

  PizzaType pizzaTyp;
  num geschwindikeit;
  Kunde verfolgter;
  static final int iRadius = 10;
  Pizzaria pizzaria;

  Pizza(num x, num y, this.pizzaTyp, this.verfolgter, this.pizzaria): super.vonKoordinaten(x, y) {

    switch (pizzaTyp) {
      case PizzaType.SALAMI:
        this.geschwindikeit = 20;
        break;
      case PizzaType.TUNFISCH:
        this.geschwindikeit = 15;
        break;
      case PizzaType.VEGETARISCH:
        this.geschwindikeit = 10;
        break;
    }
  }

  void zeichne(CanvasRenderingContext2D context) {

    context.drawImage(Bilder.getPizzaBild(pizzaTyp), x + (SpielObjekt.RASTER_GROESSE >> 1), y + (SpielObjekt.RASTER_GROESSE >> 1));

    this.bewege();
  }

  void bewege() {
    if (this.position.dist(verfolgter.position) < geschwindikeit) {
      pizzaria.pizzen.remove(this);
      verfolgter.essen(this.pizzaTyp);
    } else {

      Vektor2D differenzVektor = verfolgter.position - this.position;

      differenzVektor = differenzVektor.scaleTo(this.geschwindikeit);

      position += differenzVektor;
    }
  }
}
