require 'chunky_png'
require 'kmeans-clusterer'
require 'pry'

# Creating an image from scratch, save as an interlaced PNG
png = ChunkyPNG::Image.from_file(ARGV[0])
dim = png.dimension
# puts dim.width
# puts dim.height

data = []

for y in 0..dim.height - 1 do
  for x in 0..dim.width - 1 do  
    color_value = png[x,y]
    data << [ChunkyPNG::Color.r(color_value), ChunkyPNG::Color.g(color_value), ChunkyPNG::Color.b(color_value)]
    # data << png[x,y]
  end
  puts (y.to_f / dim.height.to_f).round(2)
end

# png[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
# png[2,1] = ChunkyPNG::Color('black @ 0.5')
# png.save('filename.png', :interlace => true)

# # Compose images using alpha blending.
# avatar = ChunkyPNG::Image.from_file('avatar.png')
# badge  = ChunkyPNG::Image.from_file('no_ie_badge.png')



if ARGV[1]
  k = ARGV[1].to_i
else
  k = 3
end
kmeans = KMeansClusterer.run k, data, runs: 5, log: true


for y in 0..dim.height - 1 do
  for x in 0..dim.width - 1 do  
    color_value = png[x,y]
    # data << [ChunkyPNG::Color.r(color_value), ChunkyPNG::Color.g(color_value), ChunkyPNG::Color.b(color_value)]
    # data << png[x,y]
    predicted = kmeans.predict [[ChunkyPNG::Color.r(color_value), ChunkyPNG::Color.g(color_value), ChunkyPNG::Color.b(color_value)]]
    centroid_data = Array(kmeans.clusters[predicted[0]].centroid.data).map{ |d| d.round(0).to_i }
    png[x,y] = ChunkyPNG::Color.rgba(centroid_data[0], centroid_data[1],centroid_data[2], 255)
  end
  puts (y.to_f / dim.height.to_f).round(2)
end


png.save("#{ARGV[0].gsub('.png', '')}_processed.png", {fast_rgba: true, interlace: true})#, :interlace => true)

# png[x,y] = ChunkyPNG::Color.rgba(255, 255,255, 255)
