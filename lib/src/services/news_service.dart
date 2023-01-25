import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newapps/src/models/category_model.dart';
import 'package:newapps/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URLNews = "newsapi.org";
const _API_KEY = "db447d1e12d8419dbfd0c460225978dc";
final dio = Dio();

class NewsServices with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsServices() {
    dio.options = BaseOptions(responseType: ResponseType.plain);
    getTopHeadLinesDio();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory]!;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  getTopHeadlinesHttp() async {
    final url = Uri.https(
        _URLNews, "/v2/top-headlines", {'country': 'Mx', 'apiKey': _API_KEY});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final newResponse = NewsResponse.fromJson(response.body);
      headlines.addAll(newResponse.articles);
      notifyListeners();
    }
  }

  getTopHeadLinesDio() async {
    final url = Uri.https(
        _URLNews, "/v2/top-headlines", {'country': 'Mx', 'apiKey': _API_KEY});
    final response = await dio.getUri(
      url,
    );
    if (response.statusCode == 200) {
      final newResponse = NewsResponse.fromJson(response.data.toString());
      headlines.addAll(newResponse.articles);
      notifyListeners();
    }
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url = Uri.https(_URLNews, "/v2/top-headlines",
        {'country': 'Mx', 'apiKey': _API_KEY, 'category': category});

    final response = await dio.getUri(url);

    if (response.statusCode == 200) {
      final newResponse = NewsResponse.fromJson(response.data.toString());
      categoryArticles[category]!.addAll(newResponse.articles);
      notifyListeners();
    }
  }
}
