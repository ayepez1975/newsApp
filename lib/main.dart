import 'package:flutter/material.dart';
import 'package:newapps/src/pages/tabs_page.dart';
import 'package:newapps/src/services/news_service.dart';
import 'package:newapps/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsServices(),
        ),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: miTema,
        home: TabsPage());
  }
}
