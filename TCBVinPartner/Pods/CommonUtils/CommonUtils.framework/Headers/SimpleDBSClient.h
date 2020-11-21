//
//  Created by Backbase R&D B.V. on 05/03/2018.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>

#ifndef SimpleDBSClient_h
#define SimpleDBSClient_h

typedef NSString *HTTPMethod;

FOUNDATION_EXPORT HTTPMethod const HTTPMethodGET;
FOUNDATION_EXPORT HTTPMethod const HTTPMethodPUT;
FOUNDATION_EXPORT HTTPMethod const HTTPMethodPOST;
FOUNDATION_EXPORT HTTPMethod const HTTPMethodDELETE;

/// A simple client that can be used to interact with the DBS back-end.
@interface SimpleDBSClient : NSObject <DBSClient>

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSObject<DBSDataProvider> *dataProvider;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) HTTPMethod method;

/// HTTP body data, assumed to be JSON - only sent as part of a PUT or POST request.
@property (nonatomic, strong) NSData *body;

/**
 * Constructs a SimpleDBSClient that aids in performing a request.
 *
 * @param url The url of the request.
 * @param method The http method type.
 * @param path The path of the endpoint.
 * @param dataProvider A dataprovider that is responsible for handling the request.
 */
+ (instancetype)clientWithBaseURL:(NSURL *)url
                           method:(HTTPMethod)method
                             path:(NSString *)path
                     dataProvider:(NSObject<DBSDataProvider> *)dataProvider;

/**
 * Constructs a SimpleDBSClient that aids in performing a request.
 *
 * @param url The url of the request.
 * @param method The http method type.
 * @param path The path of the endpoint.
 * @param bodyData The body of the request.
 * @param dataProvider A dataprovider that is responsible for handling the request.
 */
+ (instancetype)clientWithBaseURL:(NSURL *)url
                           method:(HTTPMethod)method
                             path:(NSString *)path
                             body:(NSData *)bodyData
                     dataProvider:(NSObject<DBSDataProvider> *)dataProvider;

- (void)execute:(NSDictionary<NSString *,NSString *> *)params
completionHandler:(void (^)(NSURLResponse *, NSData *, NSError *))completionHandler;

@end

#endif /* SimpleDBSClient_h */
