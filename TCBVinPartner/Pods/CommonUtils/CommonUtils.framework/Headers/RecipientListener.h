//
//  Created by Backbase R&D B.V. on 27/03/2018.
//

#import <Foundation/Foundation.h>
#import <CommonUtils/RecipientModel.h>

#ifndef RecipientListener_h
#define RecipientListener_h

/// RecipientContract listener. The conforming object will be notified about events after the Recipient model convertion.
@protocol RecipientListener <NSObject>

/**
 * Notifies the conforming object that the recipient list have been loaded successfully.
 *
 * @param response list of selector model
 */
- (void)onSuccess:(NSArray<RecipientModel *> * _Nullable)response;

/**
 * Notifies the conforming object that the transactions could not be loaded successfully.
 *
 * @param error Error object with the underlying reason of the failure.
 */
- (void)onError:(NSError *_Nullable)error;

@end

#endif /* RecipientListener_h */
