import 'package:test_app/Models/album.dart';
import 'package:test_app/apis/network.dart';

class AlbumBloc { 
  // Fetch album data
  Stream<List<Album>> get album$ => Stream<List<Album>>.fromFuture(Network.fetchAlbum());
}