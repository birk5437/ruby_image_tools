require 'chunky_png'
# puts ARGF[0]
# raise ARGV[0].inspect
# Creating an image from scratch, save as an interlaced PNG
# puts ARGV[0]
file_name = ARGV[0].split("/").last
directory = ARGV[0].gsub(file_name, "")
new_file_name = "#{file_name.gsub('.png', '')}_transparent.png"

white_cutoff = if ARGV.length > 1
  ARGV[1].to_i
else
  240
end

png = ChunkyPNG::Image.from_file(ARGV[0])
# png = ChunkyPNG::Image.from_blob(ARGF)
dim = png.dimension
# puts dim.width
# puts dim.height

for y in 0..dim.height - 1 do
  for x in 0..dim.width - 1 do  
    color_value = png[x,y]
    black_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:black])
    white_distance = ChunkyPNG::Color.euclidean_distance_rgba(color_value, ChunkyPNG::Color::PREDEFINED_COLORS[:white])

    if png[x,y] >= ChunkyPNG::Color.rgb(white_cutoff, white_cutoff,white_cutoff)
      # png[x,y] = ChunkyPNG::Color::PREDEFINED_COLORS[:cyan]
      # png[x,y] = ChunkyPNG::Color.rgba(231, 212,129, 255)
      png[x,y] = ChunkyPNG::Color.rgba(0, 0,0,0)
    else
      
    end
    # puts png[x,y]
    # puts "#{black_distance} | #{white_distance}"
  end
  # puts y
end
png.save("#{directory}#{file_name}", {fast_rgba: true, interlace: true})

# puts "#{directory}#{new_file_name}"

# new_file_with_directory = "#{directory}#{new_file_name}"#.gsub(" ", "\\ ")

# system("qlmanage -p \"#{new_file_with_directory}\"")




# png[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
# png[2,1] = ChunkyPNG::Color('black @ 0.5')
# png.save('filename.png', :interlace => true)

# # Compose images using alpha blending.
# avatar = ChunkyPNG::Image.from_file('avatar.png')
# badge  = ChunkyPNG::Image.from_file('no_ie_badge.png')
