Pod::Spec.new do |s|
  s.name = "Ubergang"
  s.version = "0.0.6"
  s.summary = "A low level tweening engine."
  s.homepage = "https://github.com/RobinFalko/Ubergang"
  s.license = { type: 'Apache', file: 'LICENSE' }
  s.authors = { "Robin Frielingsdorf" => 'mail@robinfalko.com' }

  s.platform = :ios, "9.3"
  s.requires_arc = true
  s.source = { :git => "https://github.com/RobinFalko/Ubergang.git", :branch => "master", :tag => "#{s.version}" }
  s.source_files = "Ubergang/**/*.{h,swift}"
end