
Pod::Spec.new do |s|

  s.name            = 'StickerFactory'
  s.version         = '0.0.5'
  s.platform        = :ios, '6.0'
  s.summary         = 'Stickers Factory lib'
  s.description     = 'Sticker Factory for iOS'
  s.homepage        = "https://github.com/908Inc/stkiOS"
  s.license         = "Apache License, Version 2.0"
  s.author          = "908 Inc."
  s.source          = { :git => 'https://github.com/908Inc/stkiOS.git', :tag => s.version }
  s.source_files    = "StickerFactory/SDK/Core/*"
  s.framework       = 'CoreData'
  s.requires_arc    = true 
  s.dependency       'SDWebImage', '~> 3.0'
  s.dependency       'AFNetworking', '~> 2.0'
  s.dependency        'GoogleAnalytics', '~> 3.0'
  s.resources       = 'StickerFactory/SDK/Core/Media.xcassets'

end
