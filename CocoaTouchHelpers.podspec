Pod::Spec.new do |s|
  s.name         = 'CocoaTouchHelpers'
  s.version      = '0.0.1'
  s.platform 	 = :ios
  s.ios.deployment_target = '8.0'
  s.summary      = ''
  s.license      = ''
  s.homepage     = 'https://github.com/felipowsky/CocoaTouchHelpers'
  s.requires_arc = true
  s.author = {
    'Felipe Augusto' => ''
  }
  s.source = {
    :git => 'https://github.com/felipowsky/CocoaTouchHelpers.git',
    :tag => "v#{s.version}"
  }
  s.source_files = 'CocoaTouchHelpers/CocoaTouchHelpers/*.{h,m}'
end