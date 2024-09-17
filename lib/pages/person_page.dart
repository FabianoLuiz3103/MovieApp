import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/components/progress.dart';
import 'package:movie_app/models/person_detail.dart';
import 'package:movie_app/services/api_services.dart';

class PersonDetailPage extends StatefulWidget {
  final int id;

  const PersonDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<PersonDetailPage> createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<Person>? person;

   @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  fetchInitialData() {
    person = apiServices.getDetailsPerson(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<Person>(
  future: person, 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            progressSkin(20), 
            const SizedBox(height: 20), 
   
          ],
        ),
      );
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData) {
      return const Center(child: Text('No data available'));
    } else {
      final person = snapshot.data!;
      return Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      "https://image.tmdb.org/t/p/w500${person.profilePath}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Born: ${person.birthday}",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                if (person.deathday != null)
                  Text(
                    "Died: ${person.deathday}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(height: 10),
                Text(
                  "Place of Birth: ${person.placeOfBirth}",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  person.biography,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
               
              ],
            ),
          ),
        ],
      );
    }
  },
)
      ),
    );
  }
}

