import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'app_provider.dart';

List<SingleChildWidget> mainProviders = [
  ChangeNotifierProvider(create: (_) => AppProvider()),
];