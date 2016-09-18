Pod::Spec.new do |s|
  s.name = 'Ubergang'
  s.version = '0.9.0'
  s.summary = 'A tweening engine written in Swift.'
  s.homepage = 'https://github.com/RobinFalko/Ubergang'
  s.license = { type: 'Apache', file: 'LICENSE' }
  s.authors = { 'Robin Frielingsdorf' => 'mail@robinfalko.com' }

  s.source = { 	:git => 'https://github.com/RobinFalko/Ubergang.git', 
  				:tag => s.version.to_s }
  s.source_files = 'Ubergang/**/*.{h,m,swift}'
  
  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  
  s.framework  = "Foundation"
  s.requires_arc = true
end
