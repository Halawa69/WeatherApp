import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/view/bottomBar.dart';
import 'package:weather/viewmodel/weatherprovider.dart';
class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WeatherProvider>(context);
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3E2D8F), Color(0xFF8E78C8)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Consumer<WeatherProvider>(
                builder: (context, prov, child) {
                  return Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.length < 3) {
                        return const Iterable<String>.empty();
                      }
                      return prov.cities.where((city) => city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                    },
                    displayStringForOption: (option) => option,
                    fieldViewBuilder:
                        (context, controller, focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Enter City Name',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (value) async {
                          prov.searchCityDebounced(value);
                        },
                        onFieldSubmitted: (value) {
                          controller.clear();
                          if (value.isNotEmpty) {
                            prov.addWeather(value).then((_) {
                              prov.saveCacheWeather();
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $error')),
                              );
                            });
                          }
                        },
                      );
                    },
                    onSelected: (String value) {
                      prov.addWeather(value).then((_) {
                        prov.saveCacheWeather();
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $error')),
                        );
                      });
                    },
                  );
                }
              ),
              const SizedBox(height: 20),
              Expanded(
                child: prov.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: prov.weatherData.length,
                        itemBuilder: (context, index) {
                          final data = prov.weatherData[index];
                          return Card(
                            color: Colors.white.withOpacity(0.8),
                            child: ListTile(
                              title: Text(data.city ?? 'Unknown City',
                                  style: const TextStyle(color: Colors.black)),
                              subtitle: Text(
                                  '${data.temp?.toStringAsFixed(1)}°C - ${data.description ?? 'No description'}',
                                  style:
                                      const TextStyle(color: Colors.black54)),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  prov.removeWeather(index).then((_) {
                                    prov.saveCacheWeather();
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
              FloatingActionButton(
                onPressed: () {
                  prov.clearWeather().then((_) {
                    prov.saveCacheWeather();
                  });
                },
                backgroundColor: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
