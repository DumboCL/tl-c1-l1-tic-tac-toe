# tic_tac_toe.rb
#
# Tealeaf Course 1 -- Lesson 1 Assignment
# 29/12/2014

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
  positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  if positions.include?(position_choose)
    if position_choose % 3 == 0
      board_status[position_choose/3-1][2] == ' '
    else
      board_status[position_choose/3][position_choose%3-1] == ' '
    end
  else
    return false
  end
end

def board_initial
  board_status = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]  
  for i in 0..2 do
    for j in 0..2 do
      board_status[i][j] = ' '
    end
  end
  board_status
end

def draw_board(board_status)
  system 'clear'
  puts "     |     |     "
  puts "  #{board_status[0][0]}  |  #{board_status[0][1]}  |  #{board_status[0][2]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board_status[1][0]}  |  #{board_status[1][1]}  |  #{board_status[1][2]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board_status[2][0]}  |  #{board_status[2][1]}  |  #{board_status[2][2]}   "
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
  # Horizontal line
  for i in 0..2 do
    if board_status[i][0] == ' '
      next
    end      
    if board_status[i][0] == board_status[i][1] && board_status[i][0] == board_status[i][2]
      winner_annoucement(board_status[i][0])
      return true
    end
  end

  # Vertical line
  for i in 0..2 do
    if board_status[0][i] == ' '
      next
    end      
    if board_status[0][i] == board_status[1][i] && board_status[0][i] == board_status[2][i]
      winner_annoucement(board_status[0][i])
      return true
    end
  end
  
  # Diagonal
  if board_status[0][0] != ' ' && (board_status[0][0] == board_status[1][1] && board_status[0][0] == board_status[2][2])
    winner_annoucement(board_status[0][0])
    return true
  end

  if board_status[0][2] != ' ' && (board_status[0][2] == board_status[1][1] && board_status[0][2] == board_status[2][0])
    winner_annoucement(board_status[0][2])
    return true
  end

  tie = true
  for i in 0..2 do
    for j in 0..2 do
      if board_status[i][j] == ' '
        tie = false
      end
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

def computer_AI_choose(board_status)
  player_win_position = 0
  # i is the target position
  for i in 1..9 do
    case i
    when 1
      if board_status[0][0] != ' '
        next
      end
      if board_status[0][1] == board_status[0][2] && board_status[0][1] != ' '
        if board_status[0][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[1][1] == board_status[2][2] && board_status[1][1] != ' '
        if board_status[1][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[1][0] == board_status[2][0] && board_status[1][0] != ' '
        if board_status[1][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 2
      if board_status[0][1] != ' '
        next
      end
      if board_status[0][0] == board_status[0][2] && board_status[0][0] != ' '
        if board_status[0][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[1][1] == board_status[2][1] && board_status[1][1] != ' '
        if board_status[1][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 3
      if board_status[0][2] != ' '
        next
      end
      if board_status[0][0] == board_status[0][1] && board_status[0][0] != ' '
        if board_status[0][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[1][2] == board_status[2][2] && board_status[1][2] != ' '
        if board_status[1][2] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[1][1] == board_status[2][0] && board_status[1][1] != ' '
        if board_status[1][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 4
      if board_status[1][0] != ' '
        next
      end
      if board_status[0][0] == board_status[2][0] && board_status[0][0] != ' '
        if board_status[0][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[1][1] == board_status[1][2] && board_status[1][1] != ' '
        if board_status[1][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 5
      if board_status[1][1] != ' '
        next
      end
      if board_status[1][0] == board_status[1][2] && board_status[1][0] != ' '
        if board_status[1][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][1] == board_status[2][1] && board_status[0][1] != ' '
        if board_status[0][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][0] == board_status[2][2] && board_status[0][0] != ' '
        if board_status[0][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][2] == board_status[2][0] && board_status[0][2] != ' '
        if board_status[0][2] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 6
      if board_status[1][2] != ' '
        next
      end
      if board_status[1][0] == board_status[1][1] && board_status[1][0] != ' '
        if board_status[1][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][2] == board_status[2][2] && board_status[0][2] != ' '
        if board_status[0][2] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 7
      if board_status[2][0] != ' '
        next
      end
      if board_status[2][1] == board_status[2][2] && board_status[2][1] != ' '
        if board_status[2][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][0] == board_status[1][0] && board_status[0][0] != ' '
        if board_status[0][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][2] == board_status[1][1] && board_status[0][2] != ' '
        if board_status[0][2] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 8
      if board_status[2][1] != ' '
        next
      end
      if board_status[2][0] == board_status[2][2] && board_status[2][0] != ' '
        if board_status[2][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][1] == board_status[1][1] && board_status[0][1] != ' '
        if board_status[0][1] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
    when 9
      if board_status[2][2] != ' '
        next
      end
      if board_status[2][0] == board_status[2][1] && board_status[2][0] != ' '
        if board_status[2][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][2] == board_status[1][2] && board_status[0][2] != ' '
        if board_status[0][2] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end
      if board_status[0][0] == board_status[1][1] && board_status[0][0] != ' '
        if board_status[0][0] == PLAYER_SIGNAL
          player_win_position = i
        else
          return i
        end
      end      
    end
  end
  if player_win_position > 0
    return player_win_position
  end

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
    if player_turn
      # player's turn
      begin                 
        say "Choose a position (from 1 to 9) to place a piece:"
        position_choose = gets.chomp.to_i
      end while !input_validation(board_status, position_choose)
    else
      # computer's turn
      begin
        position_choose = computer_AI_choose(board_status)
      end while !input_validation(board_status, position_choose)
    end
    
    # setting piece
    if position_choose % 3 == 0
      board_status[position_choose/3-1][2] = player_turn ? PLAYER_SIGNAL : COMPUTER_SIGNAL
    else
      board_status[position_choose/3][position_choose%3-1] = player_turn ? PLAYER_SIGNAL : COMPUTER_SIGNAL   
    end
    
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
