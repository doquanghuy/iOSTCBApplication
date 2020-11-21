//
//  Backbase.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 19/02/15.
//

#import <UIKit/UIKit.h>

//! Project version number for Backbase.
FOUNDATION_EXPORT double BackbaseVersionNumber;

//! Project version string for Backbase.
FOUNDATION_EXPORT const unsigned char BackbaseVersionString[];

// exposed interfaces.

// global public constants
#import <Backbase/BBConstants.h>
#import <Backbase/BBErrors.h>

// configuration package
#import <Backbase/BBExperimentalConfiguration.h>
#import <Backbase/BBDevelopmentConfiguration.h>
#import <Backbase/BBAuthenticationFieldNamesConfiguration.h>
#import <Backbase/BBAuthenticationConfiguration.h>
#import <Backbase/BBIdentityConfiguration.h>
#import <Backbase/BBOAuth2Configuration.h>
#import <Backbase/BBBackbaseConfiguration.h>
#import <Backbase/BBSSLPinningConfiguration.h>
#import <Backbase/BBSecurityConfiguration.h>
#import <Backbase/BBTemplateConfiguration.h>
#import <Backbase/BBHSDKConfiguration.h>
#import <Backbase/BBConfiguration.h>

// rendering package
#import <Backbase/Renderable.h>
#import <Backbase/Renderer.h>
#import <Backbase/WebRenderer.h>
#import <Backbase/RendererDelegate.h>
#import <Backbase/BBRendererFactory.h>
#import <Backbase/NativeView.h>
#import <Backbase/NativeContract.h>
#import <Backbase/NativeRenderer.h>
#import <Backbase/PageRenderer.h>
#import <Backbase/UniformPageRenderer.h>
#import <Backbase/PageRendererView.h>
#import <Backbase/TargetingRenderer.h>
#import <Backbase/TargetingRendererContract.h>
#import <Backbase/TargetingRendererView.h>

// model package
#import <Backbase/SiteMapItemChild.h>
#import <Backbase/Model.h>
#import <Backbase/ModelDelegate.h>
#import <Backbase/StatusCheckerDelegate.h>

// plugins package
#import <Backbase/Plugin.h>
#import <Backbase/BBStorage.h>
#import <Backbase/StorageComponent.h>
#import <Backbase/AbstractStorageComponent.h>
#import <Backbase/PersistentStorage.h>
#import <Backbase/PersistentStorageComponent.h>
#import <Backbase/InMemoryStorage.h>
#import <Backbase/InMemoryStorageComponent.h>
#import <Backbase/EncryptedStorage.h>
#import <Backbase/EncryptedStorageComponent.h>
#import <Backbase/BiometricStorage.h>
#import <Backbase/BiometricStorageComponent.h>
#import <Backbase/DeviceInfo.h>
#import <Backbase/DeviceInfoComponent.h>

// security package
#import <Backbase/SecurityViolationDelegate.h>
#import <Backbase/LoginDelegate.h>
#import <Backbase/SessionDelegate.h>
#import <Backbase/SecurityCertificateValidator.h>
#import <Backbase/BBPublicKeyValidator.h>
#import <Backbase/BBPKIUtils.h>

// networking package
#import <Backbase/ErrorResponseResolver.h>
#import <Backbase/BBChainErrorResponseResolver.h>

// content package
#import <Backbase/BBContentItem.h>

// targeting package
#import <Backbase/BBTargetingCallback.h>

// auth clients
#import <Backbase/BBCookieUtils.h>
#import <Backbase/AuthClientDelegate.h>
#import <Backbase/AuthClient.h>
#import <Backbase/PasswordAuthClientDelegate.h>
#import <Backbase/PasswordAuthClient.h>
#import <Backbase/BBAuthClient.h>
#import <Backbase/OAuth2AuthClientDelegate.h>
#import <Backbase/OAuth2ROPCGrant.h>
#import <Backbase/OAuth2AuthClient.h>
#import <Backbase/BBOAuth2AuthClient.h>
#import <Backbase/BBOAuth2InvalidAccessTokenResolver.h>
#import <Backbase/BBOAuth2InvalidRefreshTokenResolver.h>
#import <Backbase/DeviceAuthClient.h>
#import <Backbase/BBIdentityAuthClient.h>
#import <Backbase/BBIdentityAuthClientDelegate.h>
#import <Backbase/BBIdentityChallengeResolver.h>
#import <Backbase/FIDORegistrationDelegate.h>
#import <Backbase/BBIdentityAuthenticatorsProvider.h>

// Identity Authenticators
#import <Backbase/BBAuthenticator.h>
#import <Backbase/BBAuthenticatorPresenter.h>
#import <Backbase/BBAuthenticatorDataSource.h>
#import <Backbase/BBAuthenticatorDelegate.h>
#import <Backbase/BBAuthenticatorContract.h>
#import <Backbase/BBAuthenticatorView.h>
#import <Backbase/BBDismissableAuthenticator.h>
#import <Backbase/BBShowableAuthenticator.h>
#import <Backbase/BBSilentAuthenticator.h>

// OTP Authenticator
#import <Backbase/BBOTPAuthenticator.h>
#import <Backbase/BBOTPAuthenticatorDataSource.h>
#import <Backbase/BBOTPAuthenticatorDelegate.h>
#import <Backbase/BBOTPAuthenticatorContract.h>
#import <Backbase/BBOTPAuthenticatorView.h>
#import <Backbase/DefaultBBOTPAuthenticatorView.h>
#import <Backbase/BBOTPChallenge.h>

// DeviceKey Authenticator
#import <Backbase/BBDeviceAuthenticator.h>
#import <Backbase/BBDeviceAuthenticatorContract.h>
#import <Backbase/BBDeviceAuthenticatorDataSource.h>
#import <Backbase/BBDeviceAuthenticatorDelegate.h>
#import <Backbase/BBDeviceKeyChallenge.h>

// TermsAndConditions Authenticator
#import <Backbase/BBTermsAndConditionsAuthenticator.h>
#import <Backbase/BBTermsAndConditionsAuthenticatorContract.h>
#import <Backbase/BBTermsAndConditionsAuthenticatorDataSource.h>
#import <Backbase/BBTermsAndConditionsAuthenticatorDelegate.h>
#import <Backbase/BBTermsAndConditionsAuthenticatorView.h>
#import <Backbase/DefaultBBTermsAndConditionsAuthenticatorView.h>
#import <Backbase/BBTermsAndConditionsChallenge.h>

// Input Required Authenticator
#import <Backbase/BBInputRequiredAuthenticator.h>
#import <Backbase/BBInputRequiredAuthenticatorContract.h>
#import <Backbase/BBInputRequiredAuthenticatorDataSource.h>
#import <Backbase/BBInputRequiredAuthenticatorDelegate.h>
#import <Backbase/BBInputRequiredAuthenticatorView.h>
#import <Backbase/DefaultBBInputRequiredAuthenticatorView.h>
#import <Backbase/BBInputRequiredChallenge.h>
#import <Backbase/BBForgottenCredentialsManager.h>
#import <Backbase/BBForgottenCredentialsDelegate.h>

// FIDO Authenticators
#import <Backbase/BBFIDOAuthenticator.h>
#import <Backbase/BBFIDOAuthenticatorDelegate.h>
#import <Backbase/BBFIDOAuthenticatorDataSource.h>
#import <Backbase/BBFIDOAuthenticatorContract.h>

// FIDO Biometric Authenticator
#import <Backbase/BBBiometricAuthenticator.h>
#import <Backbase/BBBiometricAuthenticatorContract.h>
#import <Backbase/BBBiometricAuthenticatorView.h>
#import <Backbase/DefaultBBBiometricAuthenticatorView.h>

// FIDO Passcode Authenticator
#import <Backbase/BBPasscodeAuthenticator.h>
#import <Backbase/BBPasscodeAuthenticatorContract.h>
#import <Backbase/BBPasscodeAuthenticatorView.h>
#import <Backbase/DefaultBBPasscodeAuthenticatorView.h>
#import <Backbase/BBPasscodeChangeDelegate.h>
#import <Backbase/BBPasscodeManager.h>

// DBS clients
#import <Backbase/DBSClient.h>
#import <Backbase/DBSDataProvider.h>

// main module
#import <Backbase/Facade.h>
