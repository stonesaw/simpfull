require 'yaml'

file = File.read('./assets/index.yml')

$optimize  = false

data = YAML.load(file)

def create_html(data, depth = 0)
  indent  = '  ' * depth
  if data.class == Hash
    buf = ''
    i = 0
    data.each do |key, value|
      if $optimize 
        buf << ("<#{key}>" + create_html(value, depth + 1) + "</#{key}>")
      else
        buf << ("#{indent}<#{key}>\n#{indent}" + create_html(value, depth + 1) + " \n#{indent}</#{key}>")
        buf << "\n" if data.size > 1 && i < data.size - 1
      end
      i += 1
    end
    return buf
  else
    if $optimize 
      return data.to_s
    else
      return "#{'  ' * (depth - 1)}#{data}"
    end
  end
end

puts output = create_html(data)

if $optimize
  output = "<!DOCTYPE html><html lang=\"en\">" + output + "</html>\n" 
else
  output = "<!DOCTYPE html>\n<!-- generate width Simpfull -->\n<html lang=\"en\">\n" + output + "\n</html>\n" 
end

File.open('./public/index.html', 'w') { |file| file.write(output) }
