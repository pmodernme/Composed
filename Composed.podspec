Pod::Spec.new do |spec|
  spec.name         = "Composed"
  spec.version      = "0.1.0"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.homepage     = "https://github.com/pmodernme/Composed"
  spec.author       = { "Zoe Van Brunt" => "pmodernme@gmail.com" }
  spec.summary      = "Composed makes designing views in `layoutSubviews()` simpler with extensions to `CoreGraphics` structs such as `CGRect`, `CGSize`, and `CGPoint`."
  spec.source       = { :git => "https://github.com/pmodernme/Composed.git", :tag => 'v0.1.0b' }
  spec.source_files  = "Composed/*"
  spec.requires_arc = true
end
