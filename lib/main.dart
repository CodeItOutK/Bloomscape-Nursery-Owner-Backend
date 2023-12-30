import 'package:bloomscape_backend/bloc/blocs.dart';
import 'package:bloomscape_backend/bloc/settings/settings_bloc.dart';
import 'package:bloomscape_backend/model/models.dart';
import 'package:bloomscape_backend/repositories/Nursery/nursery_repository.dart';
import 'package:bloomscape_backend/rough_work/menu_screen_possible_code1.dart';
import 'package:bloomscape_backend/screens/menu/menu_screen.dart';
import 'package:bloomscape_backend/screens/settings/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme.dart';
import 'firebase_options.dart';
import 'model/category_model.dart';
import 'model/product_model.dart';
import 'package:uuid/uuid.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);


  var uuid = Uuid();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: ( context) =>NurseryRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>CategoryBloc()..add(LoadCategories(categories:Category.categories),),),
          BlocProvider(create: (context)=>ProductBloc(
              categoryBloc: BlocProvider.of<CategoryBloc>(context),
              nurseryRepository: context.read<NurseryRepository>(),
            )..add(
            LoadProducts(products:Product.products
            ),)
            ,),
          BlocProvider(create: (context)=>SettingsBloc(
            nurseryRepository: context.read<NurseryRepository>()
            )..add(const LoadSettings()),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bloomscape Backend',
          theme:theme(),
          initialRoute: '/menu',
          routes: {
            // '/menuL':(context)=>const MenuScreenPossible(),
            '/menu':(context)=>const MenuScreen(),
            '/settings':(context)=>const SettingsScreen(),
          },
        ),
      ),
    );
  }
}




