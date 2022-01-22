import 'package:flutter/material.dart';
import 'package:movie/utils/description.dart';

import 'package:tmdb_api/tmdb_api.dart';



class Grid2 extends StatefulWidget {
  Grid2({Key key}) : super(key: key);

  @override
  _Grid2State createState() => _Grid2State();
}

class _Grid2State extends State<Grid2> {
  List popularmovie = [];
  List topratedmovie = [];
  List upcomingmovie = [];
  final String apikey = '94129e99473cda1e44116ac3b1f16c6a';

  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NDEyOWU5OTQ3M2NkYTFlNDQxMTZhYzNiMWYxNmM2YSIsInN1YiI6IjYxZWE4MGNjYjUxM2E4MDA5MWEyYTNkYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7TNmdXdt7Ra_b4N2-tJCXTrTk0DHRvt8wElp6BUQaq8';

  @override
  void initState() {
    movies();
    super.initState();
  }

  movies() async {
    TMDB tmdb = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map popularresult = await tmdb.v3.movies.getPouplar();
    Map topratedresult = await tmdb.v3.movies.getTopRated();
    Map upcomingresult = await tmdb.v3.movies.getUpcoming();

    setState(() {
      popularmovie = popularresult['results'];
      topratedmovie = topratedresult['results'];
      upcomingmovie = upcomingresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
          shrinkWrap: true,
          itemCount: topratedmovie.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2 / 3),
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      
                        child: InkWell(
                           onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: popularmovie[index]['title'],
                                      bannerurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                            popularmovie[index]['backdrop_path'],
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              popularmovie[index]['poster_path'],
                                      description: popularmovie[index]['overview'],
                                      vote: popularmovie[index]['vote_average']
                                          .toString(),
                                      launch_on: popularmovie[index]
                                          ['release_date'],
                                    )));},
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            topratedmovie[index]['poster_path']))),
                          ),
                        ),
                      ),
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                      child: Text(
                        topratedmovie[index]['title'] != null
                            ? topratedmovie[index]['title']
                            : 'Loading',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                    
                  ],
                ));
          }),
    );
  }
}         