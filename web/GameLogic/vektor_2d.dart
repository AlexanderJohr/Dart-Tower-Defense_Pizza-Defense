part of defense_is_magic;



class Vektor2D {
  num x, y;

  Vektor2D(this.x, this.y);

  Vektor2D operator +(Vektor2D anderer) => new Vektor2D(this.x + anderer.x, this.y + anderer.y);
  Vektor2D operator -(Vektor2D anderer) => new Vektor2D(this.x - anderer.x, this.y - anderer.y);

  Vektor2D mult(num n) => new Vektor2D(this.x * n, this.y * n);
  Vektor2D multVektor(Vektor2D anderer) => new Vektor2D(this.x * anderer.x, this.y * anderer.y);

  Vektor2D operator *(num n) => new Vektor2D(this.x * n, this.y = n);
  //Vektor2D operator *(Vektor2D anderer) => new Vektor2D(this.x * anderer.x, this.y * anderer.y);

  Vektor2D div(num n) => new Vektor2D(this.x / n, this.y / n);
  Vektor2D divVektor(Vektor2D anderer) => new Vektor2D(this.x / anderer.x, this.y / anderer.y);

  //Vektor2D operator ~/(num n) => new Vektor2D(this.x ~/ n, this.y ~/ n);
  //Vektor2D operator ~/(Vektor2D anderer) => new Vektor2D(this.x ~/ anderer.x, this.y ~/ anderer.y);

  num dist(Vektor2D anderer) => Math.sqrt(Math.pow(this.x - anderer.x, 2) + Math.pow(this.y - anderer.y, 2));

  num mag() => Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));

  Vektor2D scaleTo(num n) => this.div(this.mag()).mult(n);

  toString() => "x: $x; y: $y;";

  operator ==(Vektor2D v) => v.x == this.x && v.y == this.y;
}
