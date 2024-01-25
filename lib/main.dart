import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/color.dart';
import 'global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'navigator/tab_navigator.dart';
import 'provider/providers.dart';
import 'pages/index/index_page.dart';
import 'router/routers.dart';
import 'widgets/toast/custom_toast.dart';

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
    // UI适配初始化
    ScreenUtil.init(
      context,
      designSize: const Size(390, 855), // 传入设计稿尺寸
      minTextAdapt: true, // 最小文本适应
      splitScreenMode: true, // 分屏模式
    );

    return MultiProvider(
      providers: mainProviders,
      child: MaterialApp(
        title: '副业圈',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        builder: CustomToast.init(),
        routes: staticRoutes,
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
