import 'package:exam2_movie/data/first_api.dart';
import 'package:exam2_movie/data/movie_api.dart';
import 'package:exam2_movie/model/movie1.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Results> _movies = [];

  final _api = MovieApi();
  final _firstApi = FirstApi();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future<void> _show(String query) async {
      List<Results> movies = await _firstApi.firstMovies(query);
      setState(() {
        _movies = movies;
      });
    }

    _show('');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query1) async {
    List<Results> movies = await _api.fetchMovies(query1);
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영화 정보 검색기'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _showResult(_textEditingController.text);
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 1,
                    children: _movies
                        .map((e) => Image.network(e.posterPath))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
