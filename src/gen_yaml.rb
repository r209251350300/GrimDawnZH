# -*- encoding: UTF-8 -*-
require "./grim"


def makeLineYaml( line , en , cn: nil, comment: nil )
    return %Q[
#-------------------------------#
    #{line} :
        標註 : #{comment}
        原文 : >-
            #{en}
        譯文 : >-
            #{cn}]
end

def checkFiles()
    en = File.open( Path::EN + "bq_bl04.txt", "r", encoding: "UTF-8" ).to_a
    cn = File.open( Path::ZH_CN + "bq_bl04.txt", "r", encoding: "UTF-8" ).to_a
    data = loadYamlFile(Path::TEXT + "bq_bl04.yml" )
    for i in (0.. en.size-1)
        next if en[i].all_blink?
        puts en[i]
        puts cn[i]
        puts data >> "bq_bl04.txt" >> i+1 >> "原文"
        puts data >> "bq_bl04.txt" >> i+1 >> "譯文"
        puts "------------------------------------"
    end
end

def makeYamlFiles()
    txtFileNameList( Path::EN ).each do | fileName |
        enLines = File.open( Path::EN + fileName, "r", encoding: "UTF-8" ).to_a
        cnLines = File.open( Path::ZH_CN + fileName, "r", encoding: "UTF-8" ).to_a
        size = enLines
        str = ""
	str << fileName << " : \n"
        for i in ( 0 .. enLines.size - 1 )
            next if enLines[i].all_blink?
            cnLine = if cnLines[i]
                if cnLines[i].all_blink? then enLines[i] else cnLines[i] end
            else
                enLines[i] if cnLines[i]==nil
            end
            str << makeLineYaml( i , enLines[i].chomp , cn: cnLine.chomp )
        end
        File.open(Path::TEXT + fileName[0..-4] + "yml" , "w", encoding: "UTF-8") do |file|
    	    file.write str
    	end
    end
end

makeYamlFiles()
puts "WTF"
