Pod::Spec.new do |s|
  s.name     = 'CocoaTouchHelpers'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = ''
  s.homepage = 'https://github.com/felipowsky/CocoaTouchHelpers'
  s.authors  = { 'Felipe Augusto' => '' }
  s.source   = { :git => 'https://github.com/felipowsky/CocoaTouchHelpers.git', :tag => "v#{s.version}" }
  s.source_files = 'CocoaTouchHelpers/CocoaTouchHelpers/*.{h,m}'
  s.requires_arc = true

  s.dependency 'Reachability'

  s.ios.deployment_target = '8.0'
end
