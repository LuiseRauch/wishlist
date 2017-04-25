require 'embedly'
require 'json'

module EmbedlyHelper
  def display(url)
    embedly_api = Embedly::API.new :key => ENV['embedly_api_key'],
    :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    # url = 'http://www.india.com'
    # obj = embedly_api.extract :url => url
    # @object = obj[0].marshal_dump[:images].first['url']
    # @embedly = JSON.pretty_generate(obj[0].marshal_dump)
    # url = @bookmark.url
    # objs = embedly_api.extract :url => url
    # json_obj = JSON.pretty_generate(objs.collect{|o| o.marshal_dump})
    # puts json_obj
    obj = embedly_api.oembed :url => url
    obj[0].marshal_dump
  end
end
