Pod::Spec.new do |s|
	s.name            = "Composed"
	s.version         = "0.1.0"
	s.license         = { :type => "MIT", :file => "LICENSE" }
	s.homepage        = "https://github.com/pmodernme/Composed"
	s.author          = { "Zoe Van Brunt" => "pmodernme@gmail.com" }
	s.summary         = "Extensions to `CoreGraphics` structs for simple manual layout."

	s.source          = { :git => "https://github.com/pmodernme/Composed.git", :tag => s.version }

	s.description     = %{
		Composed makes designing views in `layoutSubviews()` simpler with extensions to `CoreGraphics` 
		structs such as `CGRect`, `CGSize`, and `CGPoint`.
	}

	s.source_files    = "Composed/*.swift"

    s.swift_version   = '5.0'
	s.ios.deployment_target = '13.1'
	s.ios.frameworks 	= 'Foundation', 'UIKit', 'CoreGraphics'
	s.requires_arc    = true
end
