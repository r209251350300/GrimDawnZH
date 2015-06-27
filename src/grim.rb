# -*- encoding: UTF-8 -*-
require "rubygems"
require "psych"

class Hash
  def >>( k )
    self.fetch(k)
  end
end

def loadYamlFile( path )
    data = nil
    File.open( path, "r", encoding: "UTF-8" ) do | file |
        fileText = file.read
        begin
            data = Psych.load(fileText)
        rescue Psych::SyntaxError => ex
            $stderr << ex.message
        end
    end
    return data
end

class String
    def all_blink?
        self.each_char do |ch|
            case ch
            when "\n", " ", "\r", "\t"
                next
            else
                return false
            end
        end
        return true
    end
end

module Path
    EN = '../res/en/'
    ZH_TW = './tw/'
    TEXT = './text/'
end


def txtFileNameList( path )
    files = Array.new()
    Dir.foreach( path ) do |fileName|
        files << fileName if fileName.end_with?(".txt")
    end
    return files
end
