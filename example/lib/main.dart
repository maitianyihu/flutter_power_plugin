import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_say_hello_plugin/flutter_say_hello_plugin.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  //监听原生事件对象
  StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    //初始化
    _streamSubscription = FlutterSayHelloPlugin.eventStreamSubscription(onData, error);
  }

  //收到原生层的事件
  void onData(dynamic event){
    Map<dynamic,dynamic> map = event;
    if(map['event'] == "noPower"){

      if(mounted){
        setState(() {
          _platformVersion =  map['value'];
        });
      }
    }
  }

  void error(Object error){
    PlatformException e = error;
    throw(e);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterSayHelloPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = '你手机系统版本是:'+platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('检查手机电量'),
        ),
        body:Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_platformVersion,style: TextStyle(fontSize: 22,color: Colors.redAccent),),
              RaisedButton(
                onPressed: (){
                  FlutterSayHelloPlugin.sayHello();
                },
                child: Text('点我告诉你系统电量哦~'),
              )
            ],
          ),
        )

      ),
    );
  }
}
