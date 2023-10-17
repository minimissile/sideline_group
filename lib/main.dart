import 'dart:io';
import 'config/color.dart';
import 'global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'provider/providers.dart';
import 'pages/index/index_page.dart';

void main() {
  // 在Flutter应用程序启动时确保Widgets框架的初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 禁止应用横屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    Global.init().then((v) => runApp(const MyApp()));
  });

  // 修改状态栏颜色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  // 安卓需要单独设置状态栏为透明，图标为黑色，实现沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 设置页面切换时的过渡效果
  // 可选的页面过渡效果： FadeUpwardsPageTransitionsBuilder, ZoomPageTransitionsBuilder, CupertinoPageTransitionsBuilder,
  static const Map<TargetPlatform, PageTransitionsBuilder> _defaultBuilders = <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: mainProviders,
      child: MaterialApp(
        title: '副业圈',
        debugShowCheckedModeBanner: false,
        home: const IndexPage(),
        theme: ThemeData(
          primarySwatch: customPrimaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          // 统一页面过渡效果
          pageTransitionsTheme: const PageTransitionsTheme(builders: _defaultBuilders),
        ),
      ),
    );
  }
}
