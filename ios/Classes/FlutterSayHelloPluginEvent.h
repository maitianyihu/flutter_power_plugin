//
//  FlutterSayHelloPluginEvent.h
//  flutter_say_hello_plugin
//
//  Created by 王帅宇 on 2020/6/20.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
NS_ASSUME_NONNULL_BEGIN

@interface FlutterSayHelloPluginEvent : NSObject<FlutterStreamHandler>
@property(nonatomic,strong)FlutterEventSink eventSink;
@property(nonatomic,strong)FlutterEventChannel *eventChannel;
@end

NS_ASSUME_NONNULL_END
