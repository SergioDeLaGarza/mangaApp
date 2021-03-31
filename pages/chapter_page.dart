import 'package:flutter/material.dart';
import 'package:manga_app/models/modelo_serie.dart';
import 'package:manga_app/providers/series_provider.dart';

class ChapterPage extends StatefulWidget {
  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {

  final Serie serie = new Serie();
  int page = 1;

 @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Serie chapterContent = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Chapters Content', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0)),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.keyboard_arrow_left),
           onPressed:(){ setState(() { page --;});}
           ),
          IconButton(icon: Icon(Icons.keyboard_arrow_right),
           onPressed:(){ setState(() { page ++;});}
           )
        ],
      ),
      body: FutureBuilder<List<Serie>>(
       future: SerieProvider().getChaptersImg('${chapterContent.chapterSource}$page.html'),
        initialData: List<Serie>(),
        builder: (BuildContext context, AsyncSnapshot<List<Serie>> snapshot) {       
          return InkWell(
            onTap:(){
              setState(() {
                page ++;
              });
            },
            child: Container(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                //snapshot.data.chapterSource = ' ';
                return Container(
                  child:
                    Image.network(snapshot.data[index].chapterSource, 
                    fit: BoxFit.fitWidth, loadingBuilder: (context,child,loadindProgress){
                      if(loadindProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },)
                    
                    
                );
               },
              ),
            ),
          );
        }
      )
    );
  }
}