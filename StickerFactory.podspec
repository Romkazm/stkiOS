
Pod::Spec.new do |s|

  s.name         = "StickerFactory"
  s.version      = "0.0.1"
  s.summary      = "Stickers Factory"

  s.description  = <<-DESC
                   A longer description of StickerFactory in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://908.dp.ua"


  s.license      = "'Apache License, Version 2.0'"


  s.author    = "908 Inc."
  # s.social_media_url   = "http://twitter.com/"

  s.platform     = :ios, "7.0"


  s.source       = "/"

  s.source_files  = "StickerFactory/SDK" 


  s.dependency  'SDWebImage', '~> 3.7'

end
