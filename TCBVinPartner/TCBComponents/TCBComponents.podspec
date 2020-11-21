Pod::Spec.new do |s|
  s.name = 'TCBComponents'
  s.version = '0.0.1'
  s.summary = 'TCBComponents'
  s.homepage = 'https://github.com'
  s.authors = { 'Techcombank' => 'info@techcombank.com.vn' }
  s.source = { :git => 'https://github.com', :tag => s.version }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'Source/**/*.swift'
  s.resource = 'Assets/*'

  s.dependency 'SnapKit', '5.0.0'
  s.dependency 'RxCocoa', '5'
end
