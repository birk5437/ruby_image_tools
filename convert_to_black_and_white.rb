require 'chunky_png'

# Creating an image from scratch, save as an interlaced PNG
png = ChunkyPNG::Image.from_file(ARGV[0])
dim = png.dimension
# puts dim.width
# puts dim.height

for y in 0..dim.height - 1 do
  for x in 0..dim.width - 1 do  
    color_value = png[x,y]
    black_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:black])
    white_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:white])

    next if ChunkyPNG::Color.a(color_value) < 10
    if black_distance < white_distance
      # png[x,y] = ChunkyPNG::Color::PREDEFINED_COLORS[:cyan]
      png[x,y] = ChunkyPNG::Color.rgba(0,0,0,255)
    else
      png[x,y] = ChunkyPNG::Color.rgba(255, 255,255, 255)
    end
    # puts png[x,y]
    # puts "#{black_distance} | #{white_distance}"
  end
  puts y
end
png.save(ARGV[0], {fast_rgba: true, interlace: true})#, :interlace => true)
# png[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
# png[2,1] = ChunkyPNG::Color('black @ 0.5')
# png.save('filename.png', :interlace => true)

# # Compose images using alpha blending.
# avatar = ChunkyPNG::Image.from_file('avatar.png')
# badge  = ChunkyPNG::Image.from_file('no_ie_badge.png')
