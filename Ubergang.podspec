Pod::Spec.new do |s|
  s.name = 'Ubergang'
  s.version = '0.0.8'
  s.summary = 'A low level tweening engine.'
  s.homepage = 'https://github.com/RobinFalko/Ubergang'
  s.license = { type: 'Apache', file: 'LICENSE' }
  s.authors = { 'Robin Frielingsdorf' => 'mail@robinfalko.com' }

  s.source = { 	:git => 'https://github.com/RobinFalko/Ubergang.git', 
  				:tag => s.version.to_s }
  s.source_files = 'Ubergang/**/*.{h,swift}'
  
  s.requires_arc = true
  
  s.platform = :ios, '9.3'
end
