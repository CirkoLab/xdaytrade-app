import 'dart:async';

import 'package:crypto_template/api_client.dart';
import 'package:crypto_template/component/style.dart';
import 'package:crypto_template/screen/setting/themes.dart';
import 'package:flutter/material.dart';

// 更改手机号页面
class ChangePhone extends StatefulWidget {
  ThemeBloc themeBloc;
  ChangePhone({this.themeBloc});
  @override
  _ChangePhoneState createState() => _ChangePhoneState(themeBloc);
}

class _ChangePhoneState extends State<ChangePhone> {
  ThemeBloc _themeBloc;
  _ChangePhoneState(this._themeBloc);
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool isSend = false;
  var _timer;
  var _count = 60;
  String phone_num = " ", confirm_phone = " ", code = " "; // 验证码

  // 计时器
  void SetInterval() {
    if (isSend) {
      _timer = new Timer(new Duration(seconds: 1), () {
        _timer.cancel();
        if (_count < 1) {
          isSend = false;
          _timer.cancel();
        }
        setState(() {
          --_count;
        });
      });
    } else {
      return;
    }
  }

  // 修改原来密码
  _changePasswd(context) async {
    RegExp mobile = new RegExp(r"1[0-9]\d{9}$");
    bool isPhone = mobile.hasMatch(phone_num);
    // TODO 提交修改手机号逻辑
    //        showDialog(
//            context: context,
//            barrierDismissible: false,
//            builder: (BuildContext context){
//              return new LoadingDialog(text: "两次输入密码不一致！",onBack : (){
//                Navigator.pop(context);
//              });
//            }
//        );
  }

  Widget build(BuildContext context) {
    SetInterval();
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(color: colorStyle.background),
        child: Stack(
          children: <Widget>[
            ///
            /// Set image in top
            ///

            Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /// Animation text marketplace to choose Login with Hero Animation (Click to open code)
                    Padding(
                      padding:
                          EdgeInsets.only(top: mediaQuery.padding.top + 90.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/image/logo.png", height: 35.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 17.0, top: 7.0),
                            child: Text(
                              "AUFI",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  color: Colors.white,
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 3.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 40.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 53.5,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                color: colorStyle.primaryColor,
                                width: 0.15,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 10.0),
                              child: Theme(
                                data: ThemeData(hintColor: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return '请输入手机号/邮箱';
                                      }
                                    },
                                    onChanged: (input) {
                                      setState(() {
                                        phone_num = input;
                                      });
                                    },
                                    style: new TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    controller: _phoneController,
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Icon(
                                            Icons.account_circle,
                                            color: colorStyle.primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: '手机号/邮箱',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 53.5,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              //              color: Color(0xFF282E41),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                color: colorStyle.primaryColor,
                                width: 0.15,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 10.0),
                              child: Theme(
                                data: ThemeData(hintColor: Colors.transparent),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return '请输入新手机号';
                                      }
                                    },
                                    onChanged: (input) {
                                      setState(() {
                                        confirm_phone = input;
                                      });
                                    },
                                    style: new TextStyle(color: Colors.white),
                                    textAlign: TextAlign.start,
                                    controller: _confirmController,
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    obscureText: true,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Icon(
                                            Icons.vpn_key,
                                            size: 20,
                                            color: colorStyle.primaryColor,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(0.0),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        labelText: '新手机号',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 40.0),
                      child: Container(
                        height: 53.5,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(
                            color: colorStyle.primaryColor,
                            width: 0.15,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 10.0),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.transparent),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return '请输入验证码';
                                        }
                                      },
                                      onChanged: (input) {
                                        setState(() {
                                          code = input;
                                        });
                                      },
                                      style: new TextStyle(color: Colors.white),
                                      textAlign: TextAlign.start,
                                      controller: _codeController,
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.adjust,
                                              color: colorStyle.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          labelText: '验证码',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    child: Row(children: <Widget>[
                                      isSend
                                          ? Container(
                                              constraints: BoxConstraints(
                                                minWidth: 60,
                                              ),
                                              height: 32,
                                              padding: EdgeInsets.only(
                                                  top: 0, left: 8),
                                              alignment: Alignment.center,
                                              color: Colors.transparent,
                                              child: Text(
                                                "$_count\s 后重新发送！",
                                                style: new TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red),
                                              ),
                                            )
                                          : Container(
                                              constraints: BoxConstraints(
                                                minWidth: 60,
                                              ),
                                              height: 32,
                                              color: Colors.transparent,
                                              child: FlatButton(
                                                onPressed: () {
                                                  SetInterval();
                                                  setState(() {
                                                    _count = 60;
                                                    isSend = true;
                                                  });
                                                  // 发送验证码 Api调用
                                                  Send(context, phone_num);
                                                },
                                                child: Text(
                                                  "发送验证码",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 40.0),
                      child: GestureDetector(
                        onTap: () {
                          _changePasswd(context);
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            color: colorStyle.primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              "重置手机号",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  letterSpacing: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
//                  Padding(
//                    padding: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 15.0),
//                    child: Container(width: double.infinity,height: 0.15,color: colorStyle.primaryColor,),
//                  ),
//                  Text("Register",style: TextStyle(color: colorStyle.primaryColor,fontSize: 17.0,fontWeight: FontWeight.w800),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 发送验证码
  Send(context, phone) {
    if (phone.length == 11) {
      ApiClient apiClient = ApiClient();
      apiClient
          .sendSms(phone, '0')
          .then((value) => {print(value), print("发送验证码")});
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new LoadingDialog(text: "手机号/邮箱有误！");
          });
    }
  }

  Widget _buildTextFeild({
    String hint,
    TextEditingController controller,
    TextInputType keyboardType,
    bool obscure,
    String icon,
    TextAlign textAlign,
    Widget widgetIcon,
  }) {
    return Column(
      children: <Widget>[
        Container(
          height: 53.5,
          decoration: BoxDecoration(
            color: Colors.black26,
//              color: Color(0xFF282E41),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
              color: colorStyle.primaryColor,
              width: 0.15,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  style: new TextStyle(color: Colors.white),
                  textAlign: textAlign,
                  obscureText: obscure,
                  controller: controller,
                  keyboardType: keyboardType,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: widgetIcon,
                      ),
                      contentPadding: EdgeInsets.all(0.0),
                      filled: true,
                      fillColor: Colors.transparent,
                      labelText: hint,
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white70,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingDialog extends Dialog {
  String text;
  Function onBack;
  LoadingDialog({Key key, @required this.text, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer _timer;
    _timer = new Timer(new Duration(seconds: 2), () {
      onBack();
      _timer.cancel();
    });
    //  创建透明层
    return new Material(
      // 透明层类型
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
            // width : 120.0,
            height: 60.0,
            child: new Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ))),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                        // top: 20.0,
                        ),
                    child: new Text(
                      text,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
