Pod::Spec.new do |spec|
  spec.name         = 'JABSwiftCore'
  spec.version      = '4.4.0'
  spec.license      = { :type => 'MIT', :file => 'LICENSE'}
  spec.homepage     = 'https://github.com/jeremyabannister/JABSwiftCore'
  spec.authors      = { 'Jeremy Bannister' => 'jeremy.a.bannister@gmail.com' }
  spec.summary      = 'Core classes for Swift iOS apps.'
  spec.source       = { :git => 'https://github.com/jeremyabannister/JABSwiftCore.git'}
  spec.source_files = 'JABSwiftCore/**/*.{swift}'
  spec.framework    = 'SystemConfiguration'
  spec.ios.deployment_target = '10.0'
  spec.requires_arc = true
end
