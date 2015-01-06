# tic_tac_toe.rb
#
# Tealeaf Course 1 -- Lesson 1 Assignment
# 29/12/2014

require 'pry'

PLAYER_SIGNAL = 'X'
COMPUTER_SIGNAL = 'O'

# printout a message to console
def say(msg)
  puts "#{msg}"
end

# the data validation method
def data_validation(options = ['Y', 'N'], choose)
  choose = choose.upcase
  options.include?(choose)
end

# return if user wanna continue
def continue_next(choose)
  choose = choose.upcase
  choose == 'Y'
end

def input_validation(board_status,position_choose) 

  if board_status.keys.include?(position_choose)
    board_status[position_choose] == ' '
  else
    return false
  end
end

def board_initial
  board_status = {}  
  (1..9).each{|position| board_status[position] = ' '}
  board_status
end

def draw_board(board_status)
  system 'clear'
  puts "     |     |     "
  puts "  #{board_status[1]}  |  #{board_status[2]}  |  #{board_status[3]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board_status[4]}  |  #{board_status[5]}  |  #{board_status[6]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board_status[7]}  |  #{board_status[8]}  |  #{board_status[9]}   "
  puts "     |     |     "
  puts
end

def winner_annoucement(signal)
  if signal == 'tie'
    say "It's a tie!"
  elsif signal == PLAYER_SIGNAL
    say "You won!"
  else
    say "Computer won!"
  end
end

def has_result(board_status)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  winning_lines.each do |line|
    if board_status[line[0]] == PLAYER_SIGNAL and board_status[line[1]] == PLAYER_SIGNAL and board_status[line[2]] == PLAYER_SIGNAL
      winner_annoucement(PLAYER_SIGNAL)
      return true
    elsif board_status[line[0]] == COMPUTER_SIGNAL and board_status[line[1]] == COMPUTER_SIGNAL and board_status[line[2]] == COMPUTER_SIGNAL
      winner_annoucement(COMPUTER_SIGNAL)
      return true
    end
  end

  tie = true
  board_status.each do |key,value|
    if value == ' '
      tie = false
    end
  end

  if tie
    winner_annoucement('tie')
    return true
  else
    return false
  end
end

def who_is_first
  say "Press ENTER to see who will be the first to play?"
  i = 0
  first_player = ' '
  who_is_first_thread = Thread.new do    
    while true
      if i % 2 == 0 
        first_player = "You     "
        print first_player
        print "\r"
      else
        first_player = "Computer"
        print first_player
        # STDOUT.flush
        print "\r"
      end
      i += 1
      sleep 0.1
    end
  end

  gets
  who_is_first_thread.kill

  if first_player == "You     "
    return "You"
  else
    return "Computer"
  end 
end

# checks to see if two in a row
def computer_AI_choose(board_status)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  # first try to win
  winning_lines.each do |line|
    test_line = {line[0] => board_status[line[0]],line[1] => board_status[line[1]], line[2] => board_status[line[2]]}
    if test_line.values.count(COMPUTER_SIGNAL) == 2 and test_line.values.count(' ') == 1
      return test_line.select{ |k,v| v == ' ' }.keys.first
    end
  end

  # second try to stop player wins
  winning_lines.each do |line|
    test_line = {line[0] => board_status[line[0]],line[1] => board_status[line[1]], line[2] => board_status[line[2]]}
    if test_line.values.count(PLAYER_SIGNAL) == 2 and test_line.values.count(' ') == 1
      return test_line.select{ |k,v| v == ' ' }.keys.first
    end
  end

  # last make a random choise
  random_number = Random.new
  return random_number.rand(1..9)

end

# main process
begin
  board_status = board_initial
  draw_board(board_status)   

  first_player = who_is_first
  if first_player == 'You'
    player_turn = true
  else
    player_turn = false    
  end
  
  # game begin
  begin
    draw_board(board_status)
    say "The first player is: #{first_player}"
    #binding.pry
    if player_turn
      # player's turn
      begin                 
        say "Choose a position (from 1 to 9) to place a piece:"
        position_choose = gets.chomp.to_i
      end while !input_validation(board_status, position_choose)
    else
      # computer's turn
      begin
        say "Computer's turn"
        position_choose = computer_AI_choose(board_status)
        puts position_choose
      end while !input_validation(board_status, position_choose)
    end
    
    # setting piece
    board_status[position_choose] = player_turn ? PLAYER_SIGNAL : COMPUTER_SIGNAL
   
    # change roles
    player_turn = !player_turn
    draw_board(board_status)
  end while !has_result(board_status)

  # validate input
  begin 
    say "Play again? (Y/N)"
    continue = gets.chomp
  end while !data_validation(choose = continue)

end while continue_next(continue)
say "Bye bye!"
