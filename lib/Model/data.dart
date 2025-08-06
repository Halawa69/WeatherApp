class Data{
  String? city;
  double? temp;
  String? description;

  Data({this.city, this.temp, this.description});
  
  factory Data.fromJson(Map<String,dynamic> json){
    return Data(
      city: json['name'],
      temp: (json['main']['temp']as num).toDouble(),
      description: json['weather'][0]['description'],
    );
  }
  Map<String,dynamic> toJson(){
    return{
      'name':city,
      'main':{
        'temp':temp,
      },
      'weather':[
        {'description':description}
      ]
    };
  }
  
}

