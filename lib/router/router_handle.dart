import 'package:base_bloc/data/model/category_model.dart';
import 'package:base_bloc/data/model/place.dart';
import 'package:fluro/fluro.dart';

import '../modules/home_page/home_page.dart';

var routeHome = Handler(handlerFunc: (c, p) => const HomePage());
