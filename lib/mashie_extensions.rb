require 'hashie/mash'

# @private
class Hashie::Mash

  # Convert results to Ruby / Rails friendly attributes
  def to_friendly_hash
    out = {}
    keys.each do |k|
      out[genability_to_ruby_friendly(k)] = case self[k]
      when Hashie::Hash
        self[k].to_friendly_hash
      when Array
        self[k].collect(&:to_friendly_hash)
      else
        self[k]
      end
      #Hashie::Hash === self[k] ? self[k].to_friendly_hash : self[k]
    end
    out
  end

  # Modified Hashie::Mash method missing
  def method_missing(method_name, *args, &blk)
    begin
      method_name = ruby_to_genability_friendly(method_name)
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

  def ruby_to_genability_friendly(method_name)
    method_name.to_s.gsub(/(?:^|_)(.)/){ $1.upcase }.gsub(/^[A-Z]/){ $&.downcase }.to_sym
  end

  def genability_to_ruby_friendly(method_name)
    method_name.to_s.gsub(/^[A-Z]/){ $&.downcase }.gsub(/[A-Z]/){ "_#{$&.downcase}" }.to_sym
  end

end

