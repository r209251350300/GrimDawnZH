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


def makeYamlFiles()
    fileNames = txtFileNameList(Path::EN)
    fileNames.each do |fileName|
        #data = loadYamlFile(Path::TEXT + fileName[0..-4] + "yml" )
        File.open( Path::EN + fileName, "r", encoding: "UTF-8" ) do |file|
            fileStr = ""
            fileStr << fileName + ":\n"
            lineCount = 0
            file.each_line do |enLine|
                lineCount += 1
                if (enLine.split('#').size > 1) || enLine.all_blink?()
		    next
		end
		puts fileName
		#cnText = data >> fileName >> lineCount >> "譯文"
                #if cnText == nil or cnText.empty?()
		    #cnText == enText
		#end
                fileStr << makeLineYaml( lineCount, enLine.chomp )
            end
            File.open( Path::TEXT + fileName[0..-4] + "yml" , "w", encoding: "UTF-8" ) do |outFile|
                outFile.write(fileStr)
            end
        end
    end
end

makeYamlFiles()
