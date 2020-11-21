//
//  Created by Backbase R&D B.V. on 01/10/2018.
//

#ifndef BBBaseClient_h
#define BBBaseClient_h

#import <Backbase/Backbase.h>
#import "BBBaseJSONParser.h"
#import "BBDbsClientPath.h"
NS_ASSUME_NONNULL_BEGIN

/// The class that is extended by the clients.
@interface BBBaseClient : NSObject <DBSClient>

/// This path property is not used anymore, its here to prevent some clients from breaking.
@property (nonatomic, strong, nonnull, class) NSString *path
__deprecated_msg("This property will be removed in favour of BBDbsClientPath.");

/// Path that is used as a base for creating the query. Defaults to "v2".
@property (nonatomic, strong, nonnull, readwrite) NSString *path
__deprecated_msg("This property will be removed in favour of BBDbsClientPath."
                 "Every client has a default configuration which are created from default raml specs.");

/// The parser object that is used to convert JSON responses to single items or an array of items of a specified class.
@property (nonatomic, strong, nonnull) NSObject<BBJSONParser> *parser;
 
/**
* Initilize the BBBaseClient object with the provided Network configuration.
* @param clientPath BBDbsClientPath object.
* If no parser is provided or the parser object does not conform to the BBJSONParser protocol the default one will be used. (BBBaseJSONParser).
*/
-(instancetype)initWithDBSClientPath:(BBDbsClientPath* )clientPath;

/**
 * Initialize the BBBaseClient object with the default JSON parser & default Client Path object (which is BBBaseJSONParser & BBDbsClientPath).
 */
- (instancetype)init;

/**
 * Initialize the BBBaseClient object with the provided JSON parser implementation.
 * @warning With this initializer, the defaul path of the client is set to "v2".
 * @param parser The NSObject that conforms to the BBJSONParser protocol.
 * If no parser is provided or the parser object does not conform to the BBJSONParser protocol the default one will be used. (BBBaseJSONParser).
 */
- (instancetype)initWithParser:(nullable NSObject<BBJSONParser> *)parser
__deprecated_msg("This method will be removed in favour of initWithParser:clientPath: method");

/**
 * Initialize the BBBaseClient object with the provided JSON parser implementation and network configuration object..
 * @param parser The NSObject that conforms to the BBJSONParser protocol.
 * If no parser is provided or the parser object does not conform to the BBJSONParser protocol the default one will be used. (BBBaseJSONParser).
 * @param clientPath BBDbsClientPath object.
 */
- (instancetype)initWithParser:(nullable NSObject<BBJSONParser> *)parser clientPath:(nonnull BBDbsClientPath *)clientPath;

/**
 * Initialize the BBBaseClient object with the provided JSON parser implementation.
 * @param parser The NSObject that conforms to the BBJSONParser protocol.
 * If no parser is provided or the parser object does not conform to the BBJSONParser protocol the default one will be used. (BBBaseJSONParser).
 * @param path An NSString that is the base path of all requests. Not to be confused with baseURL. This path is appended to the baseURL, but before the request specific paths.
 */
- (instancetype)initWithParser:(nullable NSObject<BBJSONParser> *)parser path:(nonnull NSString *)path
__deprecated_msg("This method will be removed in favour of initWithParser:clientPath: method");

#pragma mark - Request builder methods

/**
 * This method creates a mutable URL request based on the baseURL and path provided. The HTTP method is going to be set to "GET",
 * and if there are any parameters given in the params dictionary that will be turned into query parameters appended to the URL.
 * This method also adds the Backbase auth client tokens as headers to the request object.
 * @discussion This is more a convenience method that we use for creating the default Backbase clients and that is why we are appending
 * the auth tokens.
 * @param path NSString The path to append to the baseURL.
 * @param params NSDictionary An optional set of key-value pairs to append to the URL as query parameters.
 */
- (NSMutableURLRequest *)getRequestForPath:(NSString *)path params:(nullable NSDictionary *)params;

/**
 * This method creates a mutable URL request based on the baseURL and path provided. The HTTP method is going to be set to "POST",
 * and if there are any parameters given in the params dictionary that will be turned into query parameters appended to the URL
 * (which is technically possible but not recommended when working with POST requests).
 * This method also adds the Backbase auth client tokens as headers to the request object.
 * The "Content-Type" header is also going to be set to "application/json" by default.
 * @discussion This is more a convenience method that we use for creating the default Backbase clients and that is why we are setting the
 * "Content-Type" of the header, and appending the auth tokens.
 * @param path NSString The path to append to the baseURL.
 * @param params NSDictionary An optional set of key-value pairs to append to the URL as query parameters.
 */
- (NSMutableURLRequest *)postRequestForPath:(NSString *)path params:(nullable NSDictionary *)params;

/**
 * This method creates a mutable URL request based on the baseURL and path provided. The HTTP method is going to be set to "PUT",
 * and if there are any parameters given in the params dictionary that will be turned into query parameters appended to the URL
 * (which is technically possible but not recommended when working with PUT requests).
 * This method also adds the Backbase auth client tokens as headers to the request object.
 * The "Content-Type" header is also going to be set to "application/json" by default.
 * @discussion This is more a convenience method that we use for creating the default Backbase clients and that is why we are setting the
 * "Content-Type" of the header, and appending the auth tokens.
 * @param path NSString The path to append to the baseURL.
 * @param params NSDictionary An optional set of key-value pairs to append to the URL as query parameters.
 */
- (NSMutableURLRequest *)putRequestForPath:(NSString *)path params:(nullable NSDictionary *)params;

/**
 * This method creates a mutable URL request based on the baseURL and path provided. The HTTP method is going to be set to "PATCH",
 * and if there are any parameters given in the params dictionary that will be turned into query parameters appended to the URL
 * (which is technically possible but not recommended when working with PATCH requests).
 * This method also adds the Backbase auth client tokens as headers to the request object.
 * The "Content-Type" header is also going to be set to "application/json" by default.
 * @discussion This is more a convenience method that we use for creating the default Backbase clients and that is why we are setting the
 * "Content-Type" of the header, and appending the auth tokens.
 * @param path NSString The path to append to the baseURL.
 * @param params NSDictionary An optional set of key-value pairs to append to the URL as query parameters.
 */
- (NSMutableURLRequest *)patchRequestForPath:(NSString *)path params:(nullable NSDictionary *)params;

/**
 * This method creates a mutable URL request based on the baseURL and path provided. The HTTP method is going to be set to "DELETE",
 * and if there are any parameters given in the params dictionary that will be turned into query parameters appended to the URL.
 * This method also adds the Backbase auth client tokens as headers to the request object.
 * @discussion This is more a convenience method that we use for creating the default Backbase clients and that is why we are appending
 * the auth tokens.
 * @param path NSString The path to append to the baseURL.
 * @param params NSDictionary An optional set of key-value pairs to append to the URL as query parameters.
 */
- (NSMutableURLRequest *)deleteRequestForPath:(NSString *)path params:(nullable NSDictionary *)params;

#pragma mark - Generic request

/**
 * This method creates a mutable URL request based on the baseURL and path provided. The HTTP method is going to be set to the provided one,
 * and if there are any parameters given in the params dictionary that will be turned into query parameters appended to the URL.
 * @discussion If the convenience methods don't fit your need somehow (maybe you don't want to deal with extra headers) you can use this
 * method to quickly create a request object.
 * @param baseURL NSURL This is going to be the base of the request, the method appends the path string to this.
 * @param path NSString The path to append to the baseURL.
 * @param httpMethod NSString The method type for the http request.
 * @param params NSDictionary An optional set of key-value pairs to append to the URL as query parameters.
 */
- (NSMutableURLRequest *)requestFromBaseURL:(NSURL *)baseURL
                                       path:(NSString *)path
                                 httpMethod:(NSString *)httpMethod
                                     params:(nullable NSDictionary *)params;

#pragma mark - Parsing

/**
 * This method takes the payload from the provided request and tries to map the JSON into an item that matches the required class.
 * @param klass The class you would like to map from the request.
 * @param request The request object to grab the payload from if possible.
 * @param completion A completion handler that will either return an item of class 'klass', or an error object describing any failures
 * during the process.
 */
- (void)itemType:(Class)klass
     fromRequest:(NSURLRequest *)request
  withCompletion:(nullable void (^)(id _Nullable item, NSError * _Nullable error))completion;

/**
 * This method takes the payload from the provided request and tries to map the JSON into an array of items that match the required class.
 * @param klass The class of items you would like to map from the request.
 * @param request The request object to grab the payload from if possible.
 * @param completion A completion handler that will either return an array of items of class 'klass', or an error object describing
 * any failures during the process.
 */
- (void)arrayOfItemsOfType:(Class)klass
               fromRequest:(NSURLRequest *)request
            withCompletion:(nullable void (^)(NSArray * _Nullable items, NSError * _Nullable error))completion;

/**
 * This method takes the payload from the provided request and tries to map the JSON into an array of items that match the required class.
 * @param klass The class of items you would like to map from the request.
 * @param request The request object to grab the payload from if possible.
 * @param completion A completion handler that will either return an array of items of class 'klass' together with response
 * headers, or an error object describing any failures during the process.
 */
- (void)arrayResponseWithHeadersOfItemsOfType:(Class)klass
                                  fromRequest:(NSURLRequest *)request
                               withCompletion:(nullable void (^)(NSArray * _Nullable items,
                                                                 NSDictionary * _Nullable headers,
                                                                 NSError * _Nullable error))completion;

/**
 * This method takes the request object and an array of expected status codes.
 * If the request has one of the expected status codes it is considered a success. If there is no error object, but the status code does not
 * match one of the expected ones, we will try to parse the json in the response as an error message.
 * @param statusCodes The status codes to check for as a success.
 * @param request The request object to check.
 * @param completionHandler A completion handler that will either return success boolean, or an error object describing
 * any failures during the process.
 */
- (void)expectingStatusCodes:(nonnull NSArray<NSNumber *> *)statusCodes
                 fromRequest:(nonnull NSURLRequest *)request
           completionHandler:(nullable void (^)(BOOL success, NSError * _Nullable error))completionHandler;

/**
 * This method takes the request object and an array of expected status codes.
 * If the request has one of the expected status codes it is considered a success. If there is no error object, but the status code does not
 * match one of the expected ones, we will try to parse the json in the response as an error message.
 * @param statusCodes The status codes to check for as a success.
 * @param request The request object to check.
 * @param completionHandler A completion handler that will return an error object if there are any failures during the process.
 */
- (void)expectingStatusCodes:(nonnull NSArray<NSNumber *> *)statusCodes
                 fromRequest:(nonnull NSURLRequest *)request
       withCompletionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

#pragma mark - Helper methods

/**
 * Checks the response status code if its considered valid or not.
 * @return A BOOL indicating if the response is considered valid or not.
 */
- (BOOL)isValidResponse:(NSURLResponse *)response;

#pragma mark - Header helpers

/**
 * Adds the key-value pairs to an NSMutableRequest object as headers.
 * @param headers The NSDictionary that holds the headers as key-value pairs to add. The key should be the header field (ex. "Content-Type")
 * and the value the value of the header you want to set.
 * @param request The NSMutableURLRequest object to add the headers to.
 */
- (void)addHeaders:(NSDictionary<NSString *, NSString *> *)headers toRequest:(NSMutableURLRequest *)request;

#pragma mark - Payload / query helpers

/**
 * Adds the provided string payload in UTF8 encoding to the body of the mutable URL request.
 * @param payload The NSString payload to add to the request HTTPBody.
 */
- (void)addPayload:(NSString *)payload toRequest:(NSMutableURLRequest *)request;

/**
 * Create an NSURLQueryItem array from the provided dictionary. Values other than NSString and NSNumber are not converted.
 * @param dictionary An NSDictionary containing the required parameter values.
 * @return An NSArray object with all converted NSURLQueryItems.
 */
- (nullable NSArray <NSURLQueryItem *> *)queryItemsFromDictionary:(nullable NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

#endif
