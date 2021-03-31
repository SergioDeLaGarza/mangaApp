import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:manga_app/models/modelo_serie.dart';
import 'package:html/dom.dart';

class SerieProvider {
  
  Client _client;
  List<Serie> _serie = [];
  List<Serie> _chapterContent = [];
  List<Serie> _chapters = [];
 
 SerieProvider(){
   this._client = Client();
 }

  Future<List<Serie>> getLatest() async {

    if(_serie.length != 0) return _serie;

    final response = await _client.get('http://www.mangatown.com/latest/');
    final document = parse(response.body);
    
    final elements = document.getElementsByClassName('manga_cover');

    for(Element s in elements){
    final image = s.getElementsByTagName('img')[0].attributes['src'];
    final title = s.attributes['title'];
    final url = s.attributes['href'].replaceAll('/manga', 'http://www.mangatown.com/manga');

    var serie = Serie(image: image, title: title, url: url);
    _serie.add(serie);
    }
    return _serie;
  }

var detailsManga;

  Future<Serie> getDetails(String url) async{

     //if(_details.length != 0) return _details;
     //_details.clear();

    final response = await _client.get(url);
    final document = parse(response.body);

    final detailsElement = document.getElementsByClassName('detail_info clearfix');
    final descriptionElement = document.getElementById('show');

    for(Element s in detailsElement){
      final authors = s.getElementsByTagName('a')[10].innerHtml;
      final genre = s.getElementsByTagName('a')[06].innerHtml;
      
      try{
      var artist = s.getElementsByTagName('a')[11].innerHtml;
      var description = descriptionElement.text.replaceAll('&nbsp', '');
      var details = Serie(authors: authors, genre: genre,artist: artist, description: description.toString());
      detailsManga = details;
      } catch(e){
        print(e);
        var artist = ' ';
        var description = ' ';
        var details = Serie(authors: authors, genre: genre,artist: artist, description: description.toString());
        detailsManga = details;
      }
    }
    return detailsManga;

  }


  Future<List<Serie>> getChapters(String url) async{
     if(_chapters.length != 0) return _chapters;
     _chapters.clear();

    final response = await _client.get(url);
    final document = parse(response.body);

    final cElements = document.getElementsByClassName('chapter_list');

    for(Element s in cElements){
      for(Element e in s.children){
        final chapter = e.getElementsByTagName('a')[0];
        final chapterTitle = chapter.text.trim();
        final chapterSource = chapter.attributes['href'];

        final chapters = Serie(chapterTitle: chapterTitle, chapterSource: chapterSource);
        _chapters.add(chapters);
      }
    }
      return _chapters;
  }



  Future<List<Serie>> getChaptersImg(String url) async{
    if(_chapterContent.length != 0){
    _chapterContent.clear();
    }

    final response = await _client.get(url.replaceAll('/manga', 'http://www.mangatown.com/manga'));
    final document = parse(response.body);

    final pages = document.getElementsByClassName('page_select');
    final images = document.getElementsByClassName('read_img');
    final urlImg  = document.getElementById('url');
    final contentImg = images.first.getElementsByTagName('img')[0];
    final source = contentImg.attributes['src'];
    final content = urlImg.attributes['value'];
    
    final chapterContent = Serie(chapterSource: source.replaceAll('//', 'http://'), content: content);
    _chapterContent.add(chapterContent);
    return _chapterContent;
  }

  }
  