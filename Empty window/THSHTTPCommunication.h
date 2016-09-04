//
//  THSHTTPCommunication.h
//  Empty window
//
//  Created by Никита on 29.08.16.
//  Copyright (c) 2016 Никита. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THSHTTPCommunication : NSObject<NSURLSessionDownloadDelegate>

- (void) retrieveURL:(NSURL *)url successBlock:(void(^)(NSData *))successBlock;
- (NSData *) get: (NSString *)getString url:(NSString*)urlString;
@end