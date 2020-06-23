class Carta {
  int id;
  String nombre;
  String pathImage;
  int coste;
  int fuerza;
  int raza;
  int edicion;
  int tipoCarta;
  int frecuencia;
  String habilidad;
  List<String> atributos;

  Carta(
    {
    this.id,
    this.nombre,
    this.pathImage,
    this.coste,
    this.fuerza,
    this.raza,
    this.edicion,
    this.tipoCarta,
    this.frecuencia,
    this.habilidad,
    this.atributos
    }
  );

  String getAttributesAsString() {
    String attributes = "";
    if (this.atributos.length > 0) {
      this.atributos.forEach((element) {
        attributes += (element + " ");
      });
    }
    return attributes;
  }

  String getAllText() {
    String allText = this.nombre + " " + getAttributesAsString() + " " + this.habilidad;
    return allText.toLowerCase();
  }
}