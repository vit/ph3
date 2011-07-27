
$:.unshift File.expand_path('../../../../', __FILE__)

require 'ph_model/app'

Physcon::App.init( File.expand_path('../../ph_model_conf.yaml', __FILE__) )

puts Physcon::App.config
puts Physcon::App.model



