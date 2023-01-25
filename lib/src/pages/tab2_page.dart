import 'package:flutter/material.dart';
import 'package:newapps/src/models/category_model.dart';
import 'package:newapps/src/services/news_service.dart';
import 'package:newapps/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsServices>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          _ListaCategorias(),
          Expanded(
              child: (newsServices.getArticulosCategoriaSeleccionada.length > 0)
                  ? ListaNoticias(
                      noticias: newsServices.getArticulosCategoriaSeleccionada)
                  : Center(
                      child: CircularProgressIndicator(),
                    ))
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsServices>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      //color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categoria: categories[index]),
                  const SizedBox(height: 5),
                  Text(categories[index].name)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton({required this.categoria});

  @override
  Widget build(BuildContext context) {
    final newsResponse = Provider.of<NewsServices>(context);
    return GestureDetector(
      onTap: () {
        final newsResponse = Provider.of<NewsServices>(context, listen: false);
        newsResponse.selectedCategory = categoria.name;
      },
      child: Container(
          width: 40,
          height: 40,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            categoria.icon,
            color: (newsResponse.selectedCategory == categoria.name)
                ? Colors.red
                : Colors.black,
          )),
    );
  }
}
