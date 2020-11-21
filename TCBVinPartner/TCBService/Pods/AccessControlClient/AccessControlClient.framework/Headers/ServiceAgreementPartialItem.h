//
//  Created by Backbase R&D B.V. on 04/07/2018.
//

#import <CommonUtils/CommonUtils.h>

#ifndef AccessControlClient_ServiceAgreementPartialItem_h
#define AccessControlClient_ServiceAgreementPartialItem_h

@interface ServiceAgreementPartialItem : Additions

@property (strong, nonatomic, nonnull, readonly) NSString *identifier;

@property (strong, nonatomic, nullable, readonly) NSString *externalId;

@property (strong, nonatomic, nonnull, readonly) NSString *desc;

@property (strong, nonatomic, nonnull, readonly) NSString *name;

@property (assign, nonatomic, readonly) BOOL isMaster;

+ (NSArray<ServiceAgreementPartialItem *> * _Nullable)agreementsFromJSONArray:(NSArray <NSDictionary*> * _Nonnull)array;

@end

#endif
