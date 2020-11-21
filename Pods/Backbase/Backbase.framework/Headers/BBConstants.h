//
//  BBConstants.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 20/05/15.
//

#ifndef PUBLIC_CONSTANTS
#define PUBLIC_CONSTANTS

#define BACKBASE_VERSION @"7.1.0"

#pragma mark - Logging

/// Defines logLevels for logging the SDK activity.
typedef NS_ENUM(NSUInteger, BBLogLevel) {
    /// Suppress all internal logs
    BBLogLevelNone = 0,
    /// Only display internal error messages
    BBLogLevelError,
    /// Only display internal error and warnings messages
    BBLogLevelWarn,
    /// Only display internal information, warning and errors messages
    BBLogLevelInfo,
    /// Only display internal debug, information, warning and errors messages
    BBLogLevelDebug,
    /// Logs everything, this is the default value.
    BBLogLevelEverything
};

#pragma mark - Renderable

/// Possible types of item that can be rendered.
typedef NS_ENUM(NSUInteger, BBItemType) {
    /// Renderable item is link reference
    BBItemTypeLink,
    /// Renderable item is Page
    BBItemTypePage,
    /// Renderable item is a Widget
    BBItemTypeWidget,
    /// Renderable item is a Container / Layout
    BBItemTypeLayout,
    /// Renderable item is an App
    BBItemTypeApp,
    /// Renderable item is a divider
    BBItemTypeDivider,
    /// Item is a Header
    BBItemTypeHeader,
    /// Item is an Alias
    BBItemTypeAlias
};

#pragma mark - Model

/// Preload preference key
extern NSString* const kModelPreferencePreload;

/// Retain preference key
extern NSString* const kModelPreferenceRetain;

#pragma mark - Model Sources

/// ModelSource types available
typedef NSString* ModelSource NS_TYPED_ENUM;

/// Use to load the model from a server especified in the configurations
extern ModelSource const kModelSourceServer;

/// Use to load the model form a local file especified in the configurations
extern ModelSource const kModelSourceFile;

/// Type of cache to be applied when the model is retrieved from the server.
typedef NS_ENUM(NSInteger, ModelCacheType) {
    /// Cache the model as a non-authenticated model
    ModelCacheTypeNonAuthenticated = -1,
    /// Don't apply any caching
    ModelCacheTypeNone,
    /// Cache the model as an authenticated model
    ModelCacheTypeAuthenticated,
};

#pragma mark - BBNavigationFlowInformer

/// Navigation Flow relationship types
typedef NSString* BBNavigationFlowRelationship NS_TYPED_ENUM;

/// Navigation flow informer self relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipSelf;

/// Navigation flow informer child relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipChild;

/// Navigation flow informer parent relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipParent;

/// Navigation flow informer root ancestor relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipRootAncestor;

/// Navigation flow informer root relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipRoot;

/// Navigation flow informer sibling relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipSibling;

/// Navigation flow informer other relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipOther;

/// Navigation flow informer external relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipExternal;

/// Navigation flow informer none relationship
extern BBNavigationFlowRelationship const kBBNavigationFlowRelationshipNone;

#pragma mark - Site map section names

/// Site Map section types.
typedef NSString* SiteMapSection NS_TYPED_EXTENSIBLE_ENUM;

/// Convenient constant name for the Main Navigation site map section
extern SiteMapSection const kSiteMapSectionMainNavigation;

/// Convenient constant name for the Not in Main Navigation site map section
extern SiteMapSection const kSiteMapSectionNotInMainNavigation;
#endif
