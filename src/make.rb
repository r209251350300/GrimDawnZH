# -*- encoding: UTF-8 -*-
require "./grim"

def makeTwText()
    fileNames = txtFileNameList(Path::EN)
    fileNames.each do |fileName|
        data = loadYamlFile( Path::TEXT + fileName[0..-4] + "yml" )
        enText = ""
        File.open(Path::EN+fileName, "rb", encoding: "UTF-8") { |file| enText = file.read }
        enText = enText.split("\n")
	    if data[fileName] == nil
	        next
	    end
        data[fileName].each_pair do | k, v |
        	next if v["譯文"].empty?
        	enText[k] = v["譯文"].chomp
        end
        File.open(Path::ZH_TW+fileName, "w", encoding: "UTF-8") do |file|
        	enText.each { |str| file << str + "\n" }
        end
    end
end

makeTwText()
