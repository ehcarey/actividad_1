  class Car {
  final String matricula;
  final String modelo;
  final String marca;

  Car({required this.matricula, required this.modelo, required this.marca});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      matricula: json['matricula'],
      modelo: json['modelo'],
      marca: json['marca'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
      'modelo': modelo,
      'marca': marca,
    };
  }
}