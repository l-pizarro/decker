class Mazo {
  int id;
  String nombre;
  String formato;
  List<Map<String, int>> main;
  List<Map<String, int>> side;
  int monument;
  int date; // Just for sort pourposes

  Mazo({
    this.id,
    this.nombre,
    this.formato,
    this.main,
    this.side,
    this.monument,
    this.date
  });
}