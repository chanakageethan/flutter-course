import 'package:flutter/material.dart';
import 'package:state_management/firebase_options.dart';
import 'package:state_management/providers/Cart.dart';
import 'package:state_management/providers/auth.dart';
import 'package:state_management/providers/orders.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/screens/auth_screen.dart';
import 'package:state_management/screens/cart_screen.dart';
import 'package:state_management/screens/edit_product_screen.dart';
import 'package:state_management/screens/orders_screen.dart';
import 'package:state_management/screens/product_details_screen.dart';
import 'package:state_management/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:state_management/screens/user_products_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home:  AuthScreen(),
        routes: {
          ProductDetailsScreen.routName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName :(ctx)=> CartScreen(),
          OrderScreen.routeName :(ctx)=> OrderScreen(),
          UserProductScreen.routeName :(ctx) => UserProductScreen(),
          EditProductScreen.routeName :(ctx) => EditProductScreen(),

        },
      ),
    );
  }
}
