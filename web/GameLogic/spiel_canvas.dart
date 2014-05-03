part of defense_is_magic;

class SpielCanvas {

  CanvasElement canvasElement;
  CanvasRenderingContext2D context;
  Timer updater;
  GameMode _gameMode = new GameMode();


  Element containerToDropCanvasIn;

  SpielCanvas(this.containerToDropCanvasIn) {
    
  }

  void run() {
    setup();
    canvasElement = new CanvasElement();
    canvasElement
        ..width = 800
        ..height = 600;
    context = canvasElement.context2D;

    canvasElement.onClick.listen(mousePressed);

    containerToDropCanvasIn.append(canvasElement);
  }

  List<Pizzaria> tuerme = new List<Pizzaria>();
  static List<Kunde> kunden = new List<Kunde>();
  List<Vektor2D> wegpunkte;
  bool start = false;
  int budget;
  List<List<bool>> belegt;
  



  /**
   * Startet die Welle von den gew&auml;hlten Kunden
   */
  void startWelle() {
    if (!start) {
      for (int i = 0; i < 20; i++) kunden.add(new Kunde(1, -1, Vorlieben.FLEISCH, new Duration(milliseconds: i * 2000), wegpunkte));
      for (int i = 0; i < 20; i++) kunden.add(new Kunde(1, -1, Vorlieben.FISCH, new Duration(milliseconds: i * 2000), wegpunkte));
      for (int i = 0; i < 20; i++) kunden.add(new Kunde(1, -1, Vorlieben.GEMUESE, new Duration(milliseconds: i * 2000), wegpunkte));
      start = true;



      

      var dauer = new Duration(milliseconds: 10);
      updater = new Timer.periodic(dauer, update);

    }
  }

  void update(Timer timer) {
    zeichne();
  }


  void setup() {

    belegt = new List<List<bool>>(20);
    for (int i = 0; i < belegt.length; i++) {
      belegt[i] = new List<bool>(15);
      for (int j = 0; j < belegt[i].length; j++) belegt[i][j] = false;
    }

    wegpunkte = new List<Vektor2D>();

    ladeWegpunkteAusXML("./content/OriginalWegpunkte.xml");



    budget = 20000;

    // Auswirkung der Parameter der Zeichenoperationen werden gesetzt
    //imageMode(CENTER);
    //ellipseMode(CENTER);
    //rectMode(CORNER);
  }


  void ladeWegpunkteAusXML(String pfad) {



    var httpRequest = HttpRequest.getString(pfad).then((String request) {

      var parser = new DomParser();
      Document doc = parser.parseFromString(request, 'application/xml');

      doc.querySelectorAll('wegpunkt').forEach((Element e) {

        wegpunkte.add(new Vektor2D(int.parse(e.querySelector('x').text), int.parse(e.querySelector('y').text)));

      });

      // Belegt alle Felder zwischen den Wegpunkten, damit sie f&uuml;r die
      // Kunden frei bleiben
      for (int i = 0; i < wegpunkte.length - 1; i++) {
        int x = wegpunkte[i].x;
        int y = wegpunkte[i].y;

        for (x = wegpunkte[i].x; x <= wegpunkte[i + 1].x; x++) belegt[x][y] = true;
        for (x = wegpunkte[i + 1].x; x <= wegpunkte[i].x; x++) belegt[x][y] = true;
        x = wegpunkte[i].x;
        for (y = wegpunkte[i].y; y <= wegpunkte[i + 1].y; y++) belegt[x][y] = true;
        for (y = wegpunkte[i + 1].y; y <= wegpunkte[i].y; y++) belegt[x][y] = true;
      }

      // Scaliert raster um die fixe Rastergr&ouml;sse.
      wegpunkte.forEach((Vektor2D punkt) {
        punkt.x *= SpielObjekt.RASTER_GROESSE;
        punkt.y *= SpielObjekt.RASTER_GROESSE;
      });

      startWelle();
    });
  }

  /**
   * Zeichnen-Methode zum zeichnen der SpielObjekte
   */
  void zeichne() {


    // Hintergrundbild zeichnen
    //imageMode(CORNER);
    context.drawImage(Bilder.getBildhintergrund(), 0, 0);
    //imageMode(CENTER);

    context.strokeStyle = '#8800ff';
    for (int i = 0; i < belegt.length; i++) for (int j = 0; j < belegt[i].length; j++) if (!belegt[i][j]) {

      context.strokeRect(i * SpielObjekt.RASTER_GROESSE, j * SpielObjekt.RASTER_GROESSE, SpielObjekt.RASTER_GROESSE, SpielObjekt.RASTER_GROESSE);
    }


    // Zeichne alle T&uuml;rme
    for (int i = 0; i < tuerme.length; i++) tuerme[i].zeichne(context);

    // Zeichne alle Kunden
    for (int i = 0; i < kunden.length; i++) kunden[i].zeichne(context);

    // F&uuml;ttere Kunden, zeichnen der Pizzen wird Dabei aufgerufen
    for (int i = 0; i < tuerme.length; i++) {
      tuerme[i].fuettern(kunden);
      for (int j = 0; j < tuerme[i].pizzen.length; j++) tuerme[i].pizzen[j].zeichne(context);
    }
    // Wenn Welle gestartet wurde un die Kunden alle ges&auml;ttigt werden hat der Spieler gewonnen
    if (start && kunden.length == 0) {
      print("Sie haben gewonnen!");
      start = false;
    }
  }

  void mousePressed(MouseEvent e) {
    // Beim Klick wird der Turm gesetzt, wenn der Platz frei ist und das Budget reicht
    num x = e.offset.x ~/ (SpielObjekt.RASTER_GROESSE / 800 * canvasElement.offsetWidth);
    num y = e.offset.y ~/ (SpielObjekt.RASTER_GROESSE / 600 * canvasElement.offsetHeight);

    if (!belegt[x][y] && budget >= 1000) {
      tuerme.add(new Pizzaria(x, y, _gameMode.aktPizzaType));
      budget -= 1000;
      belegt[x][y] = true;
    }
  }





  void keyPressed(KeyboardEvent e) {


    
  }

}
