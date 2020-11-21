//
//  Created by Backbase R&D B.V. on 10/10/2018.
//

#import <Foundation/Foundation.h>

/**
 * This class is a collection of simple helper methods to make unit testing Backbase Widgets and Clients simpler.
 * The signature and behaviour of these methods *can* change outside of the regular breaking change cycle, so use at your own risk.
 */
@interface BBTestHelper: NSObject

/**
 * Returns the NSData contents of the given file path inside the BBTestHelper classes bundle.
 * @param file The name of the file to return the contents of in an NSData format.
 * @return NSData representation of the file contents or nil if it cannot be found or an error happened.
 */
+ (nullable NSData *)dataFromFile:(nullable NSString *)file;

/**
 * Returns the NSData contents of the given file path inside the BBTestHelper classes bundle.
 * @param file The name of the file to return the contents of in an NSData format.
 * @param bundle The NSBundle in which to look for the provided file.
 * @return NSData representation of the file contents or nil if it cannot be found or an error happened.
 */
+ (nullable NSData *)dataFromFile:(nullable NSString *)file inBundle:(nonnull NSBundle *)bundle;

/**
 * This is a helper method to create a successful NSHTTPURLResponse for testing purposes.
 * @return An NSHTTPURLResponse object that has http version 1.0 specified, with the status code of 200 and no headers.
 */
+ (nonnull NSHTTPURLResponse *)successfulResponse;

/**
 * This is a helper method to create an NSHTTPURLResponse for testing purposes.
 * @param statusCode The status code to return in the response object.
 * @return An NSHTTPURLResponse object that has http version 1.0 specified, with the status code provided and no headers.
 */
+ (nonnull NSHTTPURLResponse *)responseWithStatusCode:(NSInteger)statusCode;

/**
 * This is a helper method to create an NSHTTPURLResponse for testing purposes.
 * @param statusCode The status code to return in the response object.
 * @param headerFields The response headers that the response object should include
 * @return An NSHTTPURLResponse object that has http version 1.0 specified, with the status code provided and no headers.
 */
+ (nonnull NSHTTPURLResponse *)responseWithStatusCode:(NSInteger)statusCode withHeaderFields:(nullable NSDictionary*)headerFields;

/**
 * This is a helper method to get a JSON response in a dictionary for the given file.
 * @param file The name of the file to return the contents of in an NSData format.
 * @param bundle The NSBundle in which to look for the provided file.
 * @param error Returns value if there was a failure on parsing to dictionary.
 * @return a dictionary from the retrieved payload JSON
 */
+ (nullable NSDictionary*)payloadFromFile:(nonnull NSString*)file
                                 inBundle:(nonnull NSBundle *)bundle
                                withError:(NSError * _Nullable __autoreleasing *_Nullable)error;

@end
