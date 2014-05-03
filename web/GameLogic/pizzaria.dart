part of defense_is_magic;



/**
 * Der Turm bewuetft Kunden in seien Radius mit bestimmten Pizzatypen nach eien
 * wurf muss er eine zeitspanne warten bis zum naechsten wurf
 * 
 * @author Alexander Johr m18927
 * 
 */
class Pizzaria extends SpielObjekt {

  num reichweite;
  PizzaType pizzaTyp;
  Duration abklingzeit;
  List<Pizza> pizzen = new List<Pizza>();

  DateTime letzerWurf = new DateTime.now();

  Pizzaria(num x, num y, PizzaType pizzaTyp): super.vonKoordinaten(x * SpielObjekt.RASTER_GROESSE, y * SpielObjekt.RASTER_GROESSE) {


    this.pizzaTyp = pizzaTyp;

    switch (pizzaTyp) {
      case PizzaType.SALAMI:
        this.reichweite = 4 * SpielObjekt.RASTER_GROESSE;
        this.abklingzeit = new Duration(milliseconds: 2000);
        break;
      case PizzaType.TUNFISCH:
        this.reichweite = 6 * SpielObjekt.RASTER_GROESSE;
        this.abklingzeit = new Duration(milliseconds: 3000);
        break;
      case PizzaType.VEGETARISCH:
        this.reichweite = 8 * SpielObjekt.RASTER_GROESSE;
        this.abklingzeit = new Duration(milliseconds: 2500);
        break;
    }

  }

  bool istBereit() {
    DateTime aktSysZeit = new DateTime.now();

    if (aktSysZeit.difference(letzerWurf).compareTo(abklingzeit) >= 0) return true; else return false;
  }


  bool inReichweite(SpielObjekt objekt) {
    if (this.position.dist(objekt.position) < reichweite) return true; else return false;
  }


  void zeichne(CanvasRenderingContext2D context) {


    ImageElement img = Bilder.getPizzariaBild(pizzaTyp);


    context.drawImage(img, x + (SpielObjekt.RASTER_GROESSE >> 1) - (img.width >> 1), y + (SpielObjekt.RASTER_GROESSE >> 1) - (img.height >> 1));


  }

  void fuettern(List<Kunde> kunden) {
    kunden.forEach((Kunde kunde) {
      if (istBereit()) if (inReichweite(kunde)) {

        pizzen.add(new Pizza(position.x, position.y, this.pizzaTyp, kunde, this));
        letzerWurf = new DateTime.now();
      }
    });
  }
}
