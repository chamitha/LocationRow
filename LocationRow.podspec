Pod::Spec.new do |s|
  s.name         = "LocationRow"
  s.version      = "1.0.0"
  s.summary      = "LocationRow is a Eureka custom row that allows you to search and select an address or location of interest."
  s.homepage     = "https://github.com/chamitha/LocationRow"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Chamitha Wijesekera" => "chamitha@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/chamitha/LocationRow.git", :tag => "#{s.version}" }
  s.source_files  = "LocationRow/**/*.{swift}"
  s.resource_bundles = { "LocationRow" => ["LocationRow/**/*.{xib,xcassets,json,imageset,png}"] }
  s.swift_version = "4.2"
  s.requires_arc = true
  s.dependency "Eureka", "~> 4.3"
end
