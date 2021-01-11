import 'dart:async';
import 'dart:convert';
import 'package:crypto_template/api_client.dart';
import 'package:crypto_template/screen/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:crypto_template/screen/intro/login.dart';
import 'package:crypto_template/screen/intro/on_Boarding.dart';
import 'package:crypto_template/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:crypto_template/screen/setting/setting.dart';
import 'package:provider/provider.dart';
import 'package:crypto_template/pmodel/profileChangeNotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:crypto_template/app_global.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crypto_template/lang/index.dart'
    show AppLocalizations, AppLocalizationsDelegate;
import 'package:crypto_template/lang/config.dart' show ConfigLanguage;

/// Run first apps open
void main() {
  runApp(myApp());
}

GlobalKey<_ChangeLocalizationsState> changeLocalizationsStateKey =
    new GlobalKey<_ChangeLocalizationsState>();

class myApp extends StatefulWidget {
  final Widget child;

  myApp({Key key, this.child}) : super(key: key);

  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  /// Create _themeBloc for double theme (Dark and White theme)
  ThemeBloc _themeBloc;
  int _tabIndex = 0;
  bool isLoaded = false;
  String Token;
  Map showData = {};
  PackageInfo packageInfo; //  获取当前app的信息
  ApiClient client;
  String _newVersion; // 网络请求的版本号/名。
  String _notVersion; // 当前app的版本号/名。
  String _upgradeNewVersion; // 处理过的版本号,使用这个
  String _upgradeNotVersion; // 处理过的版本号,使用这个
  String _installUrl; // 下载apk的地址。
  BuildContext _context;
  // 定义全局 语言代理
  AppLocalizationsDelegate _delegate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _themeBloc = ThemeBloc();
    _delegate = AppLocalizationsDelegate();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _getData() async {
    // Map<String, dynamic> res = null;
    var result = client.getBanben();
    result.then((value) {
      _newVersion = value.data['versionShort']; // 赋值网络请求的版本号。
      _installUrl = value.data['installUrl']; // 赋值网络请请的下载apk地址。

      final data = _newVersion.split('.');
      _upgradeNewVersion = data.join('');
      // print(_notVersion + ' == ' + _upgradeNotVersion);
      // print(_newVersion + " == " + _upgradeNewVersion);
      // 判断当前网络请求的版本号是否大于当前版本号
      if (int.parse(_upgradeNotVersion) < int.parse(_upgradeNewVersion)) {
        // 判断需要更新，则去请求更新接口，获取接口api，获取更新内容。
        // 创建 一个同步执行的 Future
        // 上面说到本来想判断更新，然后请求更新接口的，发现行不通。则更新接口需要写死在里面。getBanben()
        // 如需请求更新接口，则需改写上面的方法。
        Future.sync(() {
          client.getBanbenData().then((value) {
            Map<String, dynamic> res = json.decode(value.toString());
            // print(res);
            if (res['err'] != true && res['msg'] == "success") {
              setState(() {
                showData['title'] = res['title'];
                showData['data'] = res['data'].split(' ');
              });
              _show();
            }
          });
        });
      }
    });
  }

  // 初始化页面后的下一个生命周期状态
  void didChangeDependencies() async {
    super.didChangeDependencies();
    client = new ApiClient();
    packageInfo = await PackageInfo.fromPlatform();
    _notVersion = packageInfo.version; // 赋值当前的版本号
    final data = _notVersion.split('.');
    _upgradeNotVersion = data.join('');
    // print('当前版本信息 11 222 33 44 55 66 77 ');
//    await _getData();
  }

  void _show() {
    showDialog(
        context: _context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Container(
              height: 30.0,
              child: Text(
                showData['title'],
                style: TextStyle(fontSize: 14),
              ),
            ),
            content: Column(
              children: <Widget>[
                ...List.generate(showData['data'].length, (index) {
                  return Container(
                    alignment: Alignment.topLeft,
                    // margin: EdgeInsets.fromLTRB( 0.0 , 5.0, 0.0, 5.0),
                    child: Text(
                      showData['data'][index],
                      textAlign: TextAlign.left,
                      style: TextStyle(height: 2),
                    ),
                  );
                })
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('以后再说'),
                onPressed: () {
                  Navigator.of(context).pop('no');
                },
              ),
              Container(
                color: Colors.red,
                child: FlatButton(
                  child: Text('前往下载'),
                  onPressed: () {
                    Navigator.of(context).pop('ok');
                    //  print(_installUrl);
                    _launchURL(_installUrl);
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<String> _checkLogin() async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('Token');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// StreamBuilder for themeBloc
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: WalletModel()),
        ChangeNotifierProvider.value(value: PromoteModel()),
        ChangeNotifierProvider.value(value: LangModel()),
        Provider<GlobalKey<_ChangeLocalizationsState>>.value(
            value: changeLocalizationsStateKey)
      ],
      child: StreamBuilder<ThemeData>(
        initialData: _themeBloc.initialTheme().data,
        stream: _themeBloc.themeDataStream,
        builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
          return MaterialApp(
            localeResolutionCallback: (deviceLocale, supportedLocal) {
              print(
                  '当前设备语种 deviceLocale: $deviceLocale, 支持语种 supportedLocale: $supportedLocal}');
              Locale _locale = supportedLocal.contains(deviceLocale)
                  ? deviceLocale
                  : Locale('en', 'US');
              return _locale;
            },
            onGenerateTitle: (context) {
              // 设置多语言代理
              // AppLocalizations.setProxy(setState, _delegate);
              return AppLocalizations.t('title_page');
            },
            // localizationsDelegates 列表中的元素时生成本地化集合的工厂
            localizationsDelegates: [
              GlobalMaterialLocalizations
                  .delegate, // 为Material Components库提供本地化的字符串和其他值
              GlobalWidgetsLocalizations.delegate, // 定义widget默认的文本方向，从左往右或从右往左
              _delegate
            ],
            supportedLocales: ConfigLanguage.supportedLocales,
            title: 'AUFI',
            theme: snapshot.data,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(
              themeBloc: _themeBloc,
            ),

            /// Move splash screen to onBoarding Layout
            /// Routes
            ///
            routes: <String, WidgetBuilder>{
              "onBoarding": (context) =>
                  // Home()
                  Builder(builder: (context) {
                    return ChangeLocalizations(
                        key: changeLocalizationsStateKey, child: login());
                  })
            },
          );
        },
      ),
    );
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {
  ThemeBloc themeBloc;
  SplashScreen({this.themeBloc});
  @override
  _SplashScreenState createState() => _SplashScreenState(themeBloc);
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  ThemeBloc themeBloc;
  _SplashScreenState(this.themeBloc);
  @override

  /// Setting duration in splash screen
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), NavigatorPage);
  }

  /// To navigate layout change
  void NavigatorPage() {
    Navigator.of(context).pushReplacementNamed("onBoarding");
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    startTime();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/splash_screen.png'),
                fit: BoxFit.cover)),
        child: Container(
          /// Set gradient black in image splash screen (Click to open code)
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromRGBO(0, 0, 0, 0.1),
                Color.fromRGBO(0, 0, 0, 0.1)
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
//          child: Center(
//            child: Container(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Image.asset("assets/image/logo.png", height: 35.0),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 17.0, top: 7.0),
//                        child: Text(
//                          "Crypto",
//                          style: TextStyle(
//                              fontFamily: "Sans",
//                              color: Colors.white,
//                              fontSize: 32.0,
//                              fontWeight: FontWeight.w300,
//                              letterSpacing: 3.9),
//                        ),
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ),
        ),
      ),
    );
  }
}

class ChangeLocalizations extends StatefulWidget {
  final Widget child;
  ChangeLocalizations({Key key, this.child}) : super(key: key);
  @override
  _ChangeLocalizationsState createState() => _ChangeLocalizationsState();
}

class _ChangeLocalizationsState extends State<ChangeLocalizations> {
  Locale _locale;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // 获取当前设备的语言
    _locale = Localizations.localeOf(context);
    print('设备语言: $_locale');
  }

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}
