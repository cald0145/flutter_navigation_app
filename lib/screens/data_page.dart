import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  // future to store api call
  late Future<List<Map<String, dynamic>>> _pokemonFuture;

  @override
  void initState() {
    super.initState();
    _pokemonFuture = fetchPokemon();
  }

  // fetch pokemon data from api
  Future<List<Map<String, dynamic>>> fetchPokemon() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=15'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      // fetch detail for each pokemon
      List<Map<String, dynamic>> pokemonDetails = [];

      for (var pokemon in results) {
        final detailResponse = await http.get(Uri.parse(pokemon['url']));
        if (detailResponse.statusCode == 200) {
          final details = json.decode(detailResponse.body);
          pokemonDetails.add({
            'Name': details['name'],
            'Height': details['height'],
            'Weight': details['weight'],
            'Type': details['types'][0]['type']['name'],
          });
        }
      }

      return pokemonDetails;
    } else {
      throw Exception('Uh oh! Failed to load pokemon!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Data'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _pokemonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available!'));
          }

          // display data in a gridview
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final pokemon = snapshot.data![index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pokemon['name'].toString().toUpperCase(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Type: ${pokemon['type']}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Height: ${pokemon['height']}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
