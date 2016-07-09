Pod::Spec.new do |s|
  s.name = 'Ubergang'
  s.version = '0.5.2'
  s.summary = 'A tweening engine written in Swift.'
  s.homepage = 'https://github.com/RobinFalko/Ubergang'
  s.license = { type: 'Apache', file: 'LICENSE' }
  s.authors = { 'Robin Frielingsdorf' => 'mail@robinfalko.com' }

  s.source = { 	:git => 'https://github.com/RobinFalko/Ubergang.git', 
  				:tag => s.version.to_s }
  s.source_files = 'Ubergang/**/*.{h,swift}'
  
  s.requires_arc = true
  
  s.platform = :ios, '8.0'
  
  s.framework    = 'Ubergang'
  
  s.dependency 'XCGLogger'
end
