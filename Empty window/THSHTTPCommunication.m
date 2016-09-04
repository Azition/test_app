# import "THSHTTPCommunication.h"

@interface THSHTTPCommunication ()

@property (nonatomic, copy) void(^successBlock)(NSData *);

@end

@implementation THSHTTPCommunication

- (void) URLSession:(NSURLSession *)session
       downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSData *data = [NSData dataWithContentsOfURL:location];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.successBlock(data);
    });
}

- (void) retrieveURL:(NSURL *) url successBlock:(void(^)(NSData *))successBlock{
    self.successBlock = successBlock;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf
                                                          delegate:self
                                                     delegateQueue:nil];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    [task resume];
}

- (NSData *) get: (NSString *)getString url:(NSString*)urlString{
    NSData *returnData = [[NSData alloc] init];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[getString length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:[getString dataUsingEncoding:NSUTF8StringEncoding]];
    
    returnData = [NSURLConnection sendSynchronousRequest:request
                                       returningResponse:nil
                                                   error:nil];
    
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes]
                                                  length:[returnData length]
                                                encoding:NSUTF8StringEncoding];
    NSLog(@"Response >>>>>> %@", response);
    return returnData;
}

@end