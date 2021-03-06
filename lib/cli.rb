class Cli
    def greeting
        puts "~~~~~~~~~~~~~~~".colorize(:green)
        puts "Welcome to the Breaking Bad Experience. Tread Lightly.".colorize(:green)
        puts "~~~~~~~~~~~~~~~".colorize(:green)
        Api.get_character_info 
        view_char_list
        self.sub_heading
    end

    def view_char_list
        Character.all.each do |info|
            puts info.name.colorize(:yellow)
            puts "---------------".colorize(:green)
        end
    end

    def sub_heading
        puts "Please select a character from the above list. Remember to type the first and last name!".colorize(:yellow)
        input = gets.chomp
        new_character = Character.find_by_name(input)
        if new_character 
        character_options(new_character)
        self.user_input(new_character)
        else
            begin
                raise InputError
            rescue InputError => error
                puts error.message
                input = gets.chomp
                if input == "Yes"
                    view_char_list
                    self.sub_heading
                else
                    exit_cli
                end
            end
        end
    end


    def character_options(new_character)
        puts "Please choose from the following list to see more information"
        puts "1. Birthday"
        puts "2. Occupation"
        puts "3. Status"
        puts "4. Appearance"
        puts "5. Portrayed By"
        puts "6. Image"
        puts "7. Nickname"
    end
    
    def user_input(char)
        input = gets.chomp
        if input == "1" ||  input.include?("Birthday") ||  input.include?("birthday")
            puts "#{char.name} was born on #{char.birthday}."
            yes_or_no
        elsif input == "2" ||  input.include?("Occupation") ||  input.include?("occupation")
            puts "Throughout the show, #{char.name} was a #{char.occupation}."
            yes_or_no
        elsif input == "3" ||  input.include?("Status") ||  input.include?("status")
            puts "#{char.name} was #{char.status} at the end of the series."
            yes_or_no
        elsif input == "4" ||  input.include?("Appearance") ||  input.include?("appearance")
            puts "#{char.name} appeared in seasons #{char.appearance}."
            yes_or_no
        elsif input == "5" ||  input.include?("Portrayed By")  || input.include?("Portrayed") ||  input.include?("portrayed by")
            puts "#{char.name} is portrayed by #{char.portrayed}."
            yes_or_no
        elsif input == "6" ||  input.include?("Image")  ||  input.include?("image")
            puts "Click #{char.img} to see an image of #{char.name}."
            yes_or_no
        elsif input == "7" ||  input.include?("Nickname") ||  input.include?("nickname") 
            puts "#{char.name} is also referred to as #{char.nickname} throughout the show."
            yes_or_no
        else
            begin
                raise InputError
            rescue InputError => error
                puts error.message
                input = gets.chomp
                if input == "No"
                    exit_cli
                else
                    self.sub_heading
                    
                end
            end
        end
    end

    def yes_or_no
        puts "Would you like to see something else? Please enter Yes or No".colorize(:yellow)
        input = gets.chomp
        if input == "Yes"
            sub_heading
        else input == "No"
            exit_cli
        end
    end

    def exit_cli
        abort("Thanks for visiting the Breaking Bad CLI! I hope to see you again soon.")
    end

    class InputError < StandardError
        def message
            puts "Input not found. Please ensure the first letters of the first and last name are captitalized, and all words are spelled correctly. Would you like to continue? Enter Yes or No".colorize(:red)
        end
    end
end
