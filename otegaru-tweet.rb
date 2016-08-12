# usage:
# otegaru-tweet.rb --auth auth.json --status status.json

require 'optparse'
require 'json'
require 'twitter'

class Tweet

  def status_update(auth, status)
    client = Twitter::REST::Client.new(auth)
    client.update(status[:status], status)
  end

  def get_option(argv)
    result = {}
    opt = OptionParser.new()
    opt.on('--auth FILE_PATH')   {|v| result[:auth] = v}
    opt.on('--status FILE_PATH') {|v| result[:status] = v}
    opt.parse(argv)
    return result
  end

  def get_json_file(path)
    data = open(path) do |io|
      json = io.read()
      JSON.parse(json, symbolize_names: true)
    end
    return data
  end

  def tweet()
    opt = get_option(ARGV)
    auth = get_json_file(opt[:auth])
    status = get_json_file(opt[:status])
    status_update(auth, status)
  end

end

Tweet.new().tweet()

