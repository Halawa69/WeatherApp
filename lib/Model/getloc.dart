class Getloc {
  final double latitude;
  final double longitude;

  String? cityName;
  double? temperature;
  String? description;
  String? icon;

  Getloc({
    required this.latitude,
    required this.longitude,
    this.cityName,
    this.temperature,
    this.icon,
    this.description,
  });


  factory Getloc.fromJson(Map<String, dynamic> json) {
    return Getloc(
      latitude: (json['coord']['lat'] as num).toDouble(),
      longitude: (json['coord']['lon'] as num).toDouble(),
      cityName: (json['name']),
      temperature: (json['main']['temp'].toDouble()),
      description: (json['weather'][0]['description']),
      icon: (json['weather'][0]['icon']),
    );  

  }
}
