Pod::Spec.new do |s|

  s.name         = "AnyMenu"
  s.version      = "1.0.0"
  s.summary      = "An easy to use menu framework for any styling use case."

  s.description  = <<-DESC
    Create your own menu from anywhere with any transition you like.
    Choose from existing animations or implement your own ones.
                   DESC

  s.homepage     = "https://github.com/Flinesoft/AnyMenu"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author             = { "Cihat Gündüz" => "CihatGuenduez@posteo.de" }
  s.social_media_url   = "https://twitter.com/Dschee"

  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.13"
  s.tvos.deployment_target = "11.0"

  s.source       = { :git => "https://github.com/Flinesoft/AnyMenu.git", :tag => "#{s.version}" }
  s.source_files = "Sources", "Sources/**/*.swift"
  s.framework    = "Foundation"

  # s.dependency "HandyUIKit", "~> 1.4"
  # s.dependency "HandySwift", "~> 2.3"

end
