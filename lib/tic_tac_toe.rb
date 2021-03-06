WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    input.to_i - 1
end

def move(board, pos, char)
    board[pos] = char
end

def position_taken?(board, index)
    return board[index] != "" && board[index] != " " && board[index] != nil
end

def valid_move?(board, index)
    if index >= 0 && index < 9
        return !position_taken?(board, index)
    else
        return false
    end
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets().strip
    index = input_to_index(input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

def turn_count(board)
    x_turns = 0
    o_turns = 0
    board.each do |turn|
        if turn == "X"
            x_turns += 1
        elsif turn == "O"
            o_turns +=1
        end
    end
    x_turns + o_turns
end

def current_player(board)
    turns = turn_count(board)
    if turns % 2 == 0
        return "X"
    else
        return "O"
    end
end

def won?(board)
    WIN_COMBINATIONS.each do |combo|
        entries = board[combo[0]] + board[combo[1]] + board[combo[2]]
        if entries == "XXX" || entries == "OOO"
            return combo
        end
    end
    false
end

def full?(board)
    board.all? do |entry|
        entry == "X" || entry == "O"
    end
end

def draw?(board)
    !won?(board) && full?(board)
end

def over?(board)
    won?(board) || draw?(board)
end

def winner(board)
    winning_entry = won?(board)
    if winning_entry
        return board[winning_entry[0]]
    end
end

def play(board)
    until over?(board) do
        turn(board)
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cats Game!"
    end
end
