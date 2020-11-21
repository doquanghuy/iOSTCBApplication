//
//  ThemeRule.h
//  Rorshach
//
//  Created by Backbase B.V. on 11/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ThemeCondition;

#ifndef THEMERULE_CLASS
#define THEMERULE_CLASS

/**
 * Theme Rule data object
 * This class provides a generic representation of a rule with condition and consequent.
 * Conditions are represented as conditions, who behave in the way <i>does this view matches X?</i>
 * If a condition is matched, then the consequents are applied in the way of declarations. Each declaration is a pair
 * property-expression.
 */
@interface ThemeRule : NSObject

/**
 * Initializes the rule with the conditions and declarations that define this rule.
 * @param conditions Condition object that will be use to determine if a view matches and triggers the rule.
 * @param declarations Dictionary with pairs property-expression to be applied if the rule is triggered.
 * @return A rule object
 */
- (instancetype _Nonnull)initWithConditions:(NSArray<ThemeCondition*>* _Nonnull)conditions
                               declarations:(NSDictionary<NSString*, NSString*>* _Nonnull)declarations;

@end

#endif
