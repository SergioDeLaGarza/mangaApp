import 'package:flutter/material.dart';
import 'package:manga_app/models/modelo_serie.dart';
import 'package:manga_app/providers/series_provider.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  final Serie serie = new Serie();

  @override
  Widget build(BuildContext context) {
    final Serie data = ModalRoute.of(context).settings.arguments;
    //final Serie chapter = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Series Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0)),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<Serie>(
        future: SerieProvider().getDetails(data.url),
        initialData: Serie(),
        builder: (BuildContext context, AsyncSnapshot<Serie> snapshot) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: <Widget>[
                  FadeInImage(
                  image: NetworkImage(data.image),
                  placeholder:  NetworkImage('https://www.bluechipexterminating.com/wp-content/uploads/2020/02/loading-gif-png-5.gif'),
                  fadeInDuration: Duration(milliseconds: 150),
                  height: 200.0,
                  fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(data.title),
                        )
                      ],
                    )
                  ),
                   Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children:[
                        ListTile(
                          title: Text(snapshot.data.authors == null ? 'Author: ' : 'Author: ${snapshot.data.authors}'),
                        )
                      ]
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data.genre == null ? 'Genre: ' : 'Genre: ${snapshot.data.genre}'),
                          )
                      ]
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children:[
                        ListTile(
                          title: Text(snapshot.data.artist == null ? 'Artist: ' : 'Artist: ${snapshot.data.artist}'),
                        )
                      ]
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data.description == null ? ' ' : 'Description: ${snapshot.data.description}'),
                        )
                      ]
                    )
                  ),
                   Container(
                    child:Column(
                      children: <Widget>[
                        FutureBuilder<List<Serie>>(
                        future: SerieProvider().getChapters(data.url),
                         initialData: List<Serie>(),
                         builder: (BuildContext context, AsyncSnapshot<List<Serie>> snapshot1) { 
                           return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot1.data.length,
            itemBuilder: (BuildContext context, int index) {
            final gesture = Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot1.data[index].chapterTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                      
                    )
                  )
                ],
              )
            );
            return GestureDetector(
              child: gesture,
              onTap: (){
                Navigator.pushNamed(context, 'chapters', arguments: snapshot1.data[index]);
              },
            );
           },
          );
                            },                                      
                          ),
                        ]
                      )
                    )
                    
                ],
          )
            );
           },
          );
        },
      ),
    );
  }
}