require 'hashie/mash'

class Hashie::Mash

  # Modified Hashie::Mash method missing
  def method_missing(method_name, *args, &blk)
    begin
      method_name = genability_method_name_converter(method_name)
    rescue; end
    return self.[](method_name, &blk) if key?(method_name)
    match = method_name.to_s.match(/(.*?)([?=!]?)$/)
    case match[2]
    when "="
      self[match[1]] = args.first
    when "?"
      !!self[match[1]]
    when "!"
      initializing_reader(match[1])
    else
      default(method_name, *args, &blk)
    end
  end

  # Convert camelcase methods begining with a lowercase letter
  # into underscored methods
  def genability_method_name_converter(method_name)
    method_name.to_s.gsub(/(?:^|_)(.)/){ $1.upcase }.gsub(/^[A-Z]/){ $&.downcase }.to_sym
  end

end

