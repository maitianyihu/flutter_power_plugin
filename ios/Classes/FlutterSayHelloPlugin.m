#import "FlutterSayHelloPlugin.h"
#import "FlutterSayHelloPluginEvent.h"


@implementation FlutterSayHelloPlugin

FlutterSayHelloPluginEvent *sayHelloEvent;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
   
  //通道1
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_say_hello_plugin"
            binaryMessenger:[registrar messenger]];
    

  FlutterSayHelloPlugin* instance = [[FlutterSayHelloPlugin alloc] init];
   
    
  [registrar addMethodCallDelegate:instance channel:channel];
    
    
    
    //事件监听通道
    sayHelloEvent = [[FlutterSayHelloPluginEvent alloc]init];
    
    sayHelloEvent.eventChannel = [FlutterEventChannel eventChannelWithName:@"flutter_say_hello_plugin_event" binaryMessenger:[registrar messenger]];
    [sayHelloEvent.eventChannel setStreamHandler:sayHelloEvent];
    
    
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    
  } else if([@"sayHello" isEqualToString:call.method]){
      NSLog(@"ios：你好呀，马上告诉你电量");
      
      [UIDevice currentDevice].batteryMonitoringEnabled = YES;
      double deviceLevel = [UIDevice currentDevice].batteryLevel;
      
      NSString *message;
      if(deviceLevel<0){
          message = @"请用真机调试哦";
      }else{
          message = [NSString stringWithFormat:@"你手机电量是%f",deviceLevel];
      }
      
      //发送事件
      FlutterEventSink eventSink = sayHelloEvent.eventSink;
      if(eventSink){
          
          eventSink(@{
                   @"event":@"noPower",
                   @"value":message,
               });
      }
     
      
      
  }
  
  else {
    result(FlutterMethodNotImplemented);
  }
}



@end
