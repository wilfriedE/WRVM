`gem install rubyzip`

require 'open-uri'
require 'rubygems'
require 'zip/zip'

puts 'Select the number for which ruby you wish to install.'
puts '1: Ruby -Version=2.0.0-p451'
puts '2: Ruby -Version=2.0.0-p451 (x64)'
puts '3: Ruby -Version=1.9.3-p484'
puts '4: Ruby -Version=1.8.7-p371'
puts '5: JRuby -Version=1.7.12'
puts '6: JRuby -Version=1.6.8'
puts '7: Rubinius -Version=2.2.6'
choice = gets.chomp.to_i

#use link to better zip files
@rubies = { 1 => { 'url' => 'https://www.dropbox.com/s/mlgue7rwnlh9438/ruby-2.0.0.zip', 'name' => 'ruby-2.0.0' },
			2 => { 'url' => 'https://www.dropbox.com/s/th2s9uablb9s6pt/ruby-2.0.0-x64.zip', 'name' => 'ruby-2.0.0-x64' }, 
			3 => { 'url' => 'https://www.dropbox.com/s/800xq52842yfzvo/ruby-1.9.3.zip', 'name' => 'ruby-1.9.3' },
			4 => { 'url' => 'https://www.dropbox.com/s/fz1h09zlie8r7oo/ruby-1.8.7.zip', 'name' => 'ruby-1.8.7' },
			5 => { 'url' => 'http://jruby.org.s3.amazonaws.com/downloads/1.7.12/jruby-bin-1.7.12.zip', 'name' => 'jruby-bin-1.7.12' },
			6 => { 'url' => 'http://jruby.org.s3.amazonaws.com/downloads/1.6.8/jruby-bin-1.6.8.zip', 'name' => 'jruby-bin-1.6.8' },
			7 => { 'url' => 'https://www.dropbox.com/s/10g3xq51gkn6jas/rubinius-2.2.6.zip', 'name' => 'rubinius-2.2.6' }
		}

def unzip_file (file, destination)
  Zip::ZipFile.open(file) { |zip_file|
   zip_file.each { |f|
     f_path=File.join(destination, f.name)
     FileUtils.mkdir_p(File.dirname(f_path))
     zip_file.extract(f, f_path) unless File.exist?(f_path)
   }
  }
end

def install(arg)
	puts @rubies[arg]['name']
	puts @rubies[arg]['url']
	
	open("temp/#{@rubies[arg]['name']}.zip", 'wb') do |f|
	  f.print open("#{@rubies[arg]['url']}").read
	end
	puts 'This may take a while'
	unzip_file "temp/#{@rubies[arg]['name']}.zip", "Rubies/"
end

install choice

`rm -fr temp/*`
#ARGV[0] 

#FileUtils.cp_r('c:/wrvm/packages/', 'c:/wrvm/rubies/')