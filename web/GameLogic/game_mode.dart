part of defense_is_magic;

class GameMode {
  final DivElement _hud;
  final ElementList<DivElement> _toggleButtons;
  final Map<PizzaType, DivElement> _pizzaTypeButtonMap = new Map<PizzaType, DivElement>();
  final Map<DivElement, PizzaType>_buttonPizzaTypeMap = new Map<DivElement, PizzaType>();
  
  
  final Map<String, PizzaType> _identifierModeMap = {
    'v': PizzaType.VEGETARISCH,
    'f': PizzaType.TUNFISCH,
    's': PizzaType.SALAMI
  };

  PizzaType _aktPizzaType;
    PizzaType get aktPizzaType => _aktPizzaType;
    set aktPizzaType(PizzaType value) {
      _aktPizzaType = value;
      updateToggleButtons();
    }
  
  static final GameMode _singletonInstance = new GameMode._internal();
  GameMode._internal()
      : _hud = querySelector(".hud"),
        _toggleButtons = querySelectorAll(".hud .togglebutton") {

    
    
    _initIdentifierButtonMap();
    _initKeyModeSelection();
    _initToogleButtonEvents();
    
    aktPizzaType = PizzaType.VEGETARISCH;
  }
  
  _initToogleButtonEvents() {
    _toggleButtons.onClick.listen(toogleButtonClickEvent);
  }

  void _initKeyModeSelection() {
    window.onKeyPress.listen(keyPressedModeSelection);
  }

  void _initIdentifierButtonMap() {
    for (DivElement toggleButton in _toggleButtons) {
      Element identifierSpan = toggleButton.querySelector(".identifier");
      String identifierText = identifierSpan.text;
      String identifier = identifierText.toLowerCase();
      PizzaType identifiersPizzaType = _identifierModeMap[identifier];

      _buttonPizzaTypeMap[toggleButton] = identifiersPizzaType;
      _pizzaTypeButtonMap[identifiersPizzaType] = toggleButton;
    }
  }

  

  DivElement get aktToggleButton => _pizzaTypeButtonMap[_aktPizzaType];


  void updateToggleButtons() {
    Element buttonToUntoggle = _hud.querySelector(".toggled");
    bool untoggleButtonAvailable = buttonToUntoggle != null;
    if (untoggleButtonAvailable) {
      buttonToUntoggle.classes.remove("toggled");
    }
    aktToggleButton.classes.add("toggled");
  }

  factory GameMode() {
    return _singletonInstance;
  }

  void keyPressedModeSelection(KeyboardEvent event) {
    String pressedKey = new String.fromCharCode(event.charCode);
    pressedKey = pressedKey.toLowerCase();

    bool mapContainsKey = _identifierModeMap.containsKey(pressedKey);
    
    if (mapContainsKey) {
      PizzaType pressedKeyMode = _identifierModeMap[pressedKey];
      
      aktPizzaType = pressedKeyMode;
    }
  }
  
  void toogleButtonClickEvent(MouseEvent event) {
    Element clickedButton = event.currentTarget;
    PizzaType clickedPizzaType = _buttonPizzaTypeMap[clickedButton];
    aktPizzaType = clickedPizzaType;

  }
}
