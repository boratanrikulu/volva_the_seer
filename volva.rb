class Volva

  def initialize(input)
    @input = input.to_s
    set_app_name
    set_err_messages
  end

  # almost all methods are private except this one.
  # it used to start all process.
  def start
    # creates hash by using splitted input
    create_hash(@input.split(','))
    check_percentages ? volva_says(tell_me_what_to_do) : @err[:total_percentage]
  end

  def help
    help_message = "Völva is a seer. She says you what should do." \
                   "\nYou can use the bot as the following example." \
                   "\nargument_1 percentage_1, argument_2 percentage_2" \
                   "\n\nExample:" \
                   "\ngo to cinema 30, hangout with friends 20, coding whole night 50"
  end

  private

  def create_hash(inputs)
    @hash_inputs = []

    # This method works by accepting the input like this:
    #    go to cinema 50, complete the project 30, read a book 20
    # It splits the string like this:
    #    ["go to cinema", 50] ["complete the project", 30] ["read a book", 20]
    previous = 0
    inputs.each do |input|
      argument_and_percentage = input.split

      # takes all arguments except the percentage argument
      argument = argument_and_percentage[0...-1].join(' ')

      # sets percentage_range
      percentage = argument_and_percentage.last.to_i
      unless percentage.zero?
        percentage_range = previous + percentage
        previous +=  percentage

        @hash_inputs << { argument: argument, percentage_range: percentage_range }
      end
    end
  end

  def check_percentages
    @hash_inputs.last[:percentage_range] == 100 unless @hash_inputs.size.zero?
  end

  def tell_me_what_to_do
    # This method works by checking 'percentage_range's.
    # Sets the argument as the result if the random number is in percentage_range of the argument
    random_number = rand(100) + 1

    previous = 0
    @hash_inputs.each do |hash|
      percentage_range = hash[:percentage_range]

      if random_number > previous && random_number <= percentage_range
        # returns argument as the result
        return hash[:argument]
      else
        previous = percentage_range
      end
    end
  end

  def difference(value_1, value_2)
    (value_1 - value_2).abs
  end

  def set_app_name
    @app_name = 'Völva'
  end

  def set_err_messages
    # all error messages that used in the app.
    @err = { couple_arguments: "#{@app_name} needs couple arguments",
             total_percentage: "Percentage totals are not 100."}
  end

  def volva_says(argument)
    "#{@app_name} says you should do \'#{argument}\'"
  end
end
