import 'package:flutter/material.dart';
import 'package:manga_app/models/modelo_serie.dart';
import 'package:manga_app/providers/series_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Serie serie = new Serie();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Series Manga', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0)),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Serie>>(
        future: SerieProvider().getLatest(),
        initialData: List<Serie>(),
        builder: (BuildContext context, AsyncSnapshot<List<Serie>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
            final gesture = Container(
              child: Column(
                children: <Widget>[
                  FadeInImage(
                  image: NetworkImage(snapshot.data[index].image),
                  placeholder: NetworkImage('https://www.bluechipexterminating.com/wp-content/uploads/2020/02/loading-gif-png-5.gif'),
                  fadeInDuration: Duration(milliseconds: 200),
                  height: 200.0,
                  fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
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
                Navigator.pushNamed(context, 'details', arguments: snapshot.data[index]);
              },
            );
           },
          );
        },
      ),
    );
  }
}