part of defense_is_magic;



/**
 * GameObject ist die Superklasse von Turm, Pizza und Kunde. Sie enh&auml;lt die
 * Positions Vektoren von den Objekten.
 * 
 * @author Alexander Johr m18927
 */
abstract class SpielObjekt {
  Vektor2D position = new Vektor2D(0, 0);
  static final int RASTER_GROESSE = 40;

  num get x => position.x;
  set x(num nummer) => position.x = nummer;

  num get y => position.y;
  set y(num) => position.y = num;

  SpielObjekt(this.position);

  SpielObjekt.vonKoordinaten(num x, num y): this(new Vektor2D(x, y));

  void zeichne(CanvasRenderingContext2D context);
}
