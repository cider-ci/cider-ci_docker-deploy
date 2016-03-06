#!/usr/bin/ruby
# WANT_JSON



class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end
  def present?
    !blank?
  end
  def presence
    self if present?
  end
end

class NilClass
  def blank?
    true
  end
end

class FalseClass
  def blank?
    true
  end
end

class TrueClass
  def blank?
    false
  end
end

class String
  BLANK_RE = /\A[[:space:]]*\z/
  def blank?
    BLANK_RE === self
  end
end

class Numeric
  def blank?
    false
  end
end

require 'rubygems'
require 'json'
require 'yaml'
require 'securerandom'


args = JSON.parse(File.open(ARGV[0]).read)

#puts args

PATH = args['path']

secrets = if File.exists? PATH
            YAML.load_file PATH
          else
            {}
          end

initial_secrets = secrets.dup

args['keys'].each do |key|
  secrets[key] ||= ENV[key.upcase].presence || SecureRandom.base64(24)
end

File.write(PATH,secrets.to_yaml)

print JSON.dump(
  "changed" => (initial_secrets != secrets),
  "stdout" => {args: args}.to_json
)

exit 0
