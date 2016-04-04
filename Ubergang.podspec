Pod::Spec.new do |spec|
  spec.name = "Ubergang"
  spec.version = "0.0.6"
  spec.summary = "A low level tweening engine."
  spec.homepage = "https://github.com/RobinFalko/Ubergang"
  spec.license = { type: 'Apache', file: 'LICENSE' }
  spec.authors = { "Robin Frielingsdorf" => 'mail@robinfalko.com' }

  spec.platform = :ios, "9.3"
  spec.requires_arc = true
  spec.source = { :git => "https://github.com/RobinFalko/Ubergang.git", :branch => "master", :tag => "0.0.6" }
  spec.source_files = "Ubergang/Framework/Ubergang.framework"
  spec.framework = 'Ubergang'
end