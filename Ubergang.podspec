Pod::Spec.new do |s|
  spec.name = "Ubergang"
  spec.version = "0.0.6"
  spec.summary = "A low level tweening engine."
  spec.homepage = "https://github.com/RobinFalko/Ubergang"
  spec.license = { type: 'Apache', file: 'LICENSE' }
  spec.authors = { "Your Name" => 'mail@robinfalko.com' }

  spec.platform = :ios, "9.3"
  spec.requires_arc = true
  spec.source = { :git => "https://github.com/RobinFalko/Ubergang.git", :branch => "master", :tag => s.version }
  spec.source_files = "Ubergang/Framework/**"
end