part of defense_is_magic;




/**
 * Kunde bewegt sich und hat einen Pizzatyp den der isst
 * 
 * @author Alexander Johr m18927
 * 
 */
class Kunde extends SpielObjekt {

  Vorlieben vorliebe;
  num geschwindikeit;
  List<Vektor2D> wegpunkte;
  Vektor2D aktZiel;
  bool istGestartet = false;
  DateTime startZeit;

  int hunger = 100;

  Kunde(num x, num y, this.vorliebe, Duration startZeit, List<Vektor2D> wegpunkte): super.vonKoordinaten(x, y) {

    this.wegpunkte = new List.from(wegpunkte);

    this.startZeit = new DateTime.now().add(startZeit);
    this.aktZiel = wegpunkte.first;

    switch (vorliebe) {
      case Vorlieben.FLEISCH:
        this.geschwindikeit = 2.0;
        break;
      case Vorlieben.FISCH:
        this.geschwindikeit = 3.0;
        break;
      case Vorlieben.GEMUESE:
        this.geschwindikeit = 4.0;
        break;
    }
    this.geschwindikeit = geschwindikeit;
  }

  /**
   * Bewegt den Kunden zu den vorgegebenden Wegpunkten
   */
  void bewegen() {

    if (!istGestartet && this.startZeit.compareTo(new DateTime.now()) <= 0) istGestartet = true;
    if (istGestartet) {

      num dist = this.position.dist(aktZiel);

      if (this.position.dist(aktZiel) < geschwindikeit) {

        if (wegpunkte.length >= 1) {
          wegpunkte.removeAt(0);
          if (wegpunkte.length > 1) aktZiel = wegpunkte[0];
          if (wegpunkte.length == 0) print("Sie haben verloren!");
        }
      }

      Vektor2D differenzVektor = aktZiel - this.position;

      differenzVektor = differenzVektor.scaleTo(this.geschwindikeit);

      position += differenzVektor;
    }
  }

  void essen(PizzaType pizzaTyp) {

    switch (pizzaTyp) {

      case PizzaType.SALAMI:
        switch (vorliebe) {
          case Vorlieben.GEMUESE:
            hunger -= 10;
            break;
          case Vorlieben.FISCH:
            hunger -= 20;
            break;
          case Vorlieben.FLEISCH:
            hunger -= 50;
            break;
        }
        break;
      case PizzaType.TUNFISCH:
        switch (vorliebe) {
          case Vorlieben.GEMUESE:
            hunger -= 20;
            break;
          case Vorlieben.FISCH:
            hunger -= 50;
            break;
          case Vorlieben.FLEISCH:
            hunger -= 40;
            break;
        }
        break;
      case PizzaType.VEGETARISCH:
        switch (vorliebe) {
          case Vorlieben.GEMUESE:
            hunger -= 40;
            break;
          case Vorlieben.FISCH:
            hunger -= 20;
            break;
          case Vorlieben.FLEISCH:
            hunger -= 20;
            break;
        }
        break;
    }
    if (hunger <= 0) SpielCanvas.kunden.remove(this);
  }

  /**
   * Zeichnet den Kunden und ruft die Metode bewegen auf
   */
  void zeichne(CanvasRenderingContext2D context) {

    ImageElement img = Bilder.getKundeBild(vorliebe);

    context.drawImage(img, x + (SpielObjekt.RASTER_GROESSE >> 1) - (img.width >> 1), y + (SpielObjekt.RASTER_GROESSE >> 1) - (img.height >> 1));

    bewegen();

  }


  toString() => "x: $x; y: $y;";
}

