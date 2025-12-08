import 'package:LongLaoshi/screens/home/language_selection_screen.dart';
import 'package:LongLaoshi/screens/auth/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:LongLaoshi/screens/auth/login_screen.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    PrefUtils().init()
  ]).then((value) {
    runApp(ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        final authService = FirebaseAuthService();
        return MaterialApp(
          theme: theme,
          title: 'LongLaoshi',
          navigatorKey: NavigatorService.navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizationDelegate(),
            //GlobalMaterialLocalizations.delegate,
            //GlobalWidgetsLocalizations.delegate,
            //GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            Locale(
              'en',
              '',
            )
          ],
          home: StreamBuilder<User?>(
            stream: authService.userStream,
            builder: (context, snapshot) {
              // return LanguageSelectionScreen();
              // Uncomment this if you are gonna use the loginScreen again
              // print("HOLA");
              // print(
              //     'SNAPSHOT: ${snapshot.connectionState} | DATA: ${snapshot.data}');

              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(child: Text("Cargando auth..."));
              // }
              return snapshot.hasData
                  ? LanguageSelectionScreen()
                  : LoginScreen();
            },
          ),
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
