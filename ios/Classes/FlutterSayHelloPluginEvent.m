//
//  FlutterSayHelloPluginEvent.m
//  flutter_say_hello_plugin
//
//  Created by 王帅宇 on 2020/6/20.
//

#import <Foundation/Foundation.h>
#import "FlutterSayHelloPluginEvent.h"
#import <objc/runtime.h>


@implementation FlutterSayHelloPluginEvent


@dynamic eventSink;

- (FlutterEventSink)eventSink{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEventSink:(FlutterEventSink)eventSink{
    objc_setAssociatedObject(self, @selector(eventSink), eventSink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FlutterEventChannel *)eventChannel{
     return objc_getAssociatedObject(self, _cmd);
}

-(void)setEventChannel:(FlutterEventChannel *)eventChannel{
    objc_setAssociatedObject(self, @selector(eventChannel), eventChannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - FlutterStreamHandler
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events{
    self.eventSink = events;
    return nil;
}
 

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink = nil;
    return nil;

}

@end
