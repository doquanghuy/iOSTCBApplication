Pod::Spec.new do |s|
  s.name = 'TCBService'
  s.version = '0.0.1'
  s.summary = 'TCBService'
  s.homepage = 'https://github.com'
  s.authors = { 'Techcombank' => 'info@techcombank.com.vn' }
  s.source = { :git => 'https://github.com', :tag => s.version }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'Source/**/*.swift'
  s.resource = 'Assets/assets'

  s.dependency 'Backbase', '7.1'
  s.dependency 'CommonUtils', '7.0.0'
  s.dependency 'ProductsClient', '7.0.0'
  s.dependency 'PaymentOrderClient', '7.0.0'
  s.dependency 'TransactionsClient', '7.0.0'
  s.dependency 'NotificationsClient', '7.0.0'
  s.dependency 'Domain'
  s.dependency 'AccessControlClient', '7.0.0'
  s.dependency 'UserProfileClient', '7.0.0'
  s.dependency 'ContactsClient', '7.0.0'
end
