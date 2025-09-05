import 'package:bot_toast/bot_toast.dart';
import 'package:evently_app/core/routes/app_routes.dart';
import 'package:evently_app/core/services/loading_service.dart';
import 'package:evently_app/core/theme/app_theme_manager.dart';
import 'package:evently_app/modules/settings_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:evently_app/modules/manager/app_manager.dart';
import 'core/routes/page_route_name.dart';
import 'core/services/local_storage_services.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform
  );
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageServices.init();
  var isFirstTime = await LocalStorageServices.getBool("firstTime") ?? true;
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider())
        ],
        child: ChangeNotifierProvider(
            create: (context) => SettingsProvider(),
            child: MyApp(isFirstTime: isFirstTime,)),
      ),
      );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstTime});
  final bool isFirstTime;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      themeMode: provider.currentTheme,
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      initialRoute: isFirstTime? PageRouteName.onBoarding: PageRouteName.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(
        builder: BotToastInit()
      ),
    );
  }
}
