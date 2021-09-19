import 'package:flutter/material.dart';
import 'package:test_app/Models/album.dart';
import 'package:test_app/exceptions/errors.dart';
import 'package:test_app/ui/album/album_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({ Key? key }) : super(key: key);
  final AlbumBloc bloc = AlbumBloc();

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<List<Album>>(
      stream: bloc.album$,
      builder: (context, snapshot) {
        if(snapshot.data != null && snapshot.hasData){
          List<Album> album = snapshot.data!;
          return GridView.builder(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
            ),
            itemCount: album.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: CachedNetworkImage(
                    imageUrl: album[index].image!,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                
                // Image(
                //   image: NetworkImage(album[index].image!)
                // ),
              );
            }
          );
        }
        if(snapshot.hasError){
          return Center(
            child: Text(ErrorMessage.error),
          );
        }

        return Center(
          child: LinearProgressIndicator(),
        );
      }
    );
  }
}