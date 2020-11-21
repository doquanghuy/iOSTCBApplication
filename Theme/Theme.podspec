Pod::Spec.new do |s|
  s.name = 'Theme'
  s.version = '0.0.1'
  s.summary = 'Theme'
  s.homepage = 'https://github.com'
  s.authors = { 'Techcombank' => 'info@techcombank.com.vn' }
  s.source = { :git => 'https://github.com', :tag => s.version }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'Source/**/*.swift'
  s.resource = 'Assets/*'
end
