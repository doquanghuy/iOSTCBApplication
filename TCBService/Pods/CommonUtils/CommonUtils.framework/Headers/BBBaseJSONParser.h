//
//  Created by Backbase R&D B.V. on 01/10/2018.
//

#ifndef BBBaseParser_h
#define BBBaseParser_h

#import <Foundation/Foundation.h>

/// JSON Parser protocol that the base client implements.
@protocol BBJSONParser <NSObject>

/**
 * Tries to grab the JSON encoded error dictionary from an NSURLResponse object.
 * @param response The NSURLResponse object to grab the error from.
 * @param data The NSData object that was passed along with the NSURLResponse object.
 * @return An NSError object with the appended error dictionary from the response object.
 */
- (nonnull NSError *)errorFromResponse:(nonnull NSURLResponse *)response data:(nullable NSData *)data;

/**
 * Converts an NSData object containing JSON to an NSArray.
 * @param data The NSData object to convert.
 * @param error An NSError containing a serialization failure if one occurs.
 * @return An NSArray object converted from the NSData object provided.
 */
- (nullable NSArray *)arrayFromJSONData:(nullable NSData *)data withError:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * Converts an NSData object containing JSON to an NSDictionary.
 * @param data The NSData object to convert.
 * @param error An NSError containing a serialization failure if one occurs.
 * @return An NSDictionary object converted from the NSData object provided.
 */
- (nullable NSDictionary *)dictionaryFromJSONData:(nullable NSData *)data withError:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * Converts an NSData object that contains JSON to an NSArray of the specified class.
 * @param klass The Class of items to return in the array.
 * @param data The NSData object to convert.
 * @param error An NSError containing a serialization failure if one occurs.
 * @return An NSArray object converted from the NSData object provided.
 */
- (nullable NSArray *)arrayOfClass:(nonnull Class)klass
                      fromJSONData:(nullable NSData *)data
                         withError:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * Converts an NSData object that contains JSON to an instance of the provided class if possible.
 * @param klass The Class to convert the NSData to.
 * @param data The NSData object to convert.
 * @param error An NSError containing a serialization failure if one occurs.
 * @return An NSDictionary object converted from the NSData object provided.
 */
- (nullable id)objectOfClass:(nonnull Class)klass
                fromJSONData:(nullable NSData *)data
                   withError:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end

#pragma mark - BBBaseJSONParser interface

@interface BBBaseJSONParser : NSObject <BBJSONParser>

@end

#endif
