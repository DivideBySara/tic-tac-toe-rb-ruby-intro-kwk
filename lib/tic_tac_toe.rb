# Tic-Tac-Toe helper methods located in this file

WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # 1st column
  [1, 4, 7], # 2nd column
  [2, 5, 8], # 3rd column
  [0, 4, 8], # upper-left to lower-right diagonal
  [2, 4, 6]  # upper-right to lower-left diagonal
]

#display_board displays the tic-tac-toe board in its current state
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index converts user_input to a space on the board
def input_to_index(user_input)
  user_input.to_i - 1
end

#move assigns a character to a board position
def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#valid_move? determines if 1) the user inputted position is part of the board
# and 2) if the user inputted position is occupied
def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_count = 0

  board.each do |position|
    if position == "X" || position == "O"
      turn_count += 1
    end # else position is unoccupied
  end

  return turn_count
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

#won? returns either 1) false or 2) the winning combination of positions
# as an array
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    # get indices of each win_combination
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    # get values from board that map to each index in each win_combination
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    # Are all values X's?
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end # else not a win_combination

  end # WIN_COMBINATIONS.each iteration

  return false
end #won?

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

#winner returns the winning character
def winner(board)
  winner = won?(board)
  # if winner is an array, change winner to winning character
  if winner.class == Array
    winner = board[winner[0]]
  end # else winner is nil
end

#play is the main method for tic_tac_toe.
# It gives players turns until the game is over,
# and either congratulates the winner or says it's a draw.
def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else # game was a draw
    puts "Cats Game!"
  end

end #play
