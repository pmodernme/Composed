Pod::Spec.new do |s|
  s.name            = "Composed"
  s.version         = "0.1.0"
  s.license         = { :type => "MIT", :file => "LICENSE" }
  s.homepage        = "https://github.com/pmodernme/Composed"
  s.author          = { "Zoe Van Brunt" => "pmodernme@gmail.com" }
  s.summary         = "Extensions to `CoreGraphics` structs for simple manual layout."
  s.description     = "Composed makes designing views in `layoutSubviews()` simpler with extensions to `CoreGraphics` structs such as `CGRect`, `CGSize`, and `CGPoint`."
  
  s.platform        = :ios, '8.0'
  s.requires_arc    = true
  
  s.source          = { :git => "https://github.com/pmodernme/Composed.git", :tag => s.version }
  s.source_files    = "Composed/*"
end
