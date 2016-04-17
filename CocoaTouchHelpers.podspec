Pod::Spec.new do |s|
  s.name = 'CocoaTouchHelpers'
  s.summary = 'Cocoa Touch Helpers'
  s.version = '1.0.2'
  s.license = 'MIT'
  s.authors = { 'Felipe Augusto' => '' }
  s.homepage = 'https://github.com/felipowsky/CocoaTouchHelpers'

  s.source = { :git => 'https://github.com/felipowsky/CocoaTouchHelpers.git', :tag => "#{s.version}" }
  s.source_files = 'CocoaTouchHelpers/CocoaTouchHelpers/*.{h,m,swift}'
  s.requires_arc = true

  s.platform = :ios, '7.0'

  s.dependency 'Reachability'
end
