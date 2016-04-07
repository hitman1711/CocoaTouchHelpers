Pod::Spec.new do |s|
  s.name = 'CocoaTouchHelpers'
  s.summary = 'Cocoa Touch Helpers'
  s.version = '0.0.0'
  s.license = 'MIT'
  s.authors = { 'Felipe Augusto' => '' }
  s.homepage = 'https://github.com/felipowsky/CocoaTouchHelpers'

  s.source = { :git => 'https://github.com/felipowsky/CocoaTouchHelpers.git', :tag => "#{s.version}" }
  s.source_files = 'CocoaTouchHelpers/CocoaTouchHelpers/*.{h,m,swift}'
  s.requires_arc = true

  s.platform = :ios, '8.0'

  s.dependency 'Reachability'
end
