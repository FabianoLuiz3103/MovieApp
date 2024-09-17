import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/progress.dart';
import 'package:movie_app/models/media_model.dart';
import 'package:movie_app/pages/search/widgets/movie_search.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  late Future<Result> result;
  bool isMovie = true;

  void search(String query) {
    setState(() {
      if (query.isEmpty) {
        setState(() {
          result = _loadCombinedResults();
        });
      } else if (query.length > 4) {
        setState(() {
          result = _loadCombinedSearch(query);
        });
      }
    });
  }

  Future<Result> _loadCombinedResults() async {
    try {
      final results = await Future.wait([
        apiServices.getPopularMovies(),  
        apiServices.getPopularSeries()   
      ]);
      final movies = results[0].movies;   
      final series = results[1].movies;   
      final combinedMediaList = [...movies, ...series]; 
      combinedMediaList.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
      return Result(movies:  combinedMediaList, page: 0, totalPages: 0, totalResults: 0); 
    } catch (error) {
      throw Exception('Erro ao carregar filmes e séries: $error');
    }
  }

  Future<Result> _loadCombinedSearch(String query) async {
    try {
      final results = await Future.wait([
        apiServices.getSearchedMovie(query),  
        apiServices.getSearchedSeries(query)   
      ]);
      final movies = results[0].movies;   
      final series = results[1].movies;   
      final combinedMediaList = [...movies, ...series]; 
      combinedMediaList.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
      return Result(movies:  combinedMediaList, page: 0, totalPages: 0, totalResults: 0);
    } catch (error) {
      throw Exception('Erro ao carregar filmes e séries: $error');
    }
  }

  @override
  void initState() {
    result = _loadCombinedResults();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchTitle = searchController.text.isEmpty
        ? 'Top Searchs'
        : 'Search Result for ${searchController.text}';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoSearchTextField(
                  controller: searchController,
                  padding: const EdgeInsets.all(10.0),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    search(searchController.text);
                  },
                ),
              ),
              FutureBuilder<Result>(
                future: result,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data?.movies;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            searchTitle,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              isMovie = data[index].firstAirDate == null;
                              if (data[index].backdropPath.isEmpty) {
                                return const SizedBox();
                              }
                              return MovieSearch(movie: data[index], isMovie: isMovie,);
                            },
                          )
                        ]);
                  } else {
                    return  Center(
                      child: progressSkin(20),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
