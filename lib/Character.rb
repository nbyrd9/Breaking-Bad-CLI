require_relative('../lib/api')


class Character 
    attr_accessor :name, :birthday, :occupation, :status, :appearance, :portrayed

    @@all = []

    def initialize(hash)
         hash.each do |key, value|
            self.send("#{key}=" , value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_name(name)
        self.all.find{|char| char.name == name}
    end       
end


        



