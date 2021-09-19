import 'package:test_app/Models/news.dart';
import 'package:test_app/apis/network.dart';

class NewsBloc{

  // get the list data to be displayed on the news page
  Stream<Map<String,List<News>>> get news$ => Stream<Map<String,List<News>>>.fromFuture(Network.fetchNews());

}