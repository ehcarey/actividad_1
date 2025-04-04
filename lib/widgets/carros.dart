  class Car {
  final String id;
  final String modelo;
  final String marca;

  Car({required this.id, required this.modelo, required this.marca});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      modelo: json['modelo'],
      marca: json['marca'],
    );
  }
}
