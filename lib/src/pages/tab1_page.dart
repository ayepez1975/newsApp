import 'package:flutter/material.dart';
import 'package:newapps/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsServices>(context).headlines;

    //print(newService.headlines[0].description);

    return Scaffold(
      body: (headlines.length == 0)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListaNoticias(noticias: headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
