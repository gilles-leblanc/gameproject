require_relative 'map_output'

ARGV[0].nil? ? path_to_media = '.' : path_to_media = ARGV[0]

window = MapOutput.new(path_to_media)
window.show
