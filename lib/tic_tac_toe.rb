class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(space, letter)
    @board[space.to_i] = letter
  end

  def position_taken?(position)
    if @board[position.to_i] == " "
      false
    else
      true
    end
  end

  def valid_move?(index)
    true if !position_taken?(index) && index.to_i.between?(0, 8)
  end

  def turn_count
    @board.count{|space| space != " "}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    player = current_player
    if valid_move?(index)
      move(index, player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.find do |combo|
      first = combo[0]
      second = combo[1]
      third = combo[2]

      position_1 = @board[first]
      position_2 = @board[second]
      position_3 = @board[third]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
       combo
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
       combo
      else
       false
      end
    end
  end

  def full?
    true if !@board.any?{|space| space == " " }
  end

  def draw?
    true if full? && !won?
  end

  def over?
    true if draw? || won?
  end

  def winner
    if won?
      combo = won?
      @board[combo.first]
    else
      nil
    end
  end

  def play
    while !over?
      turn
    end

    if won?
      winning_team = winner
      puts "Congratulations #{winning_team}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
