class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    puzzle_arr = convertTo2DArray

    # Check rows
    puzzle_arr.each do |row|
      if !validateRow(row)
        return "Sudoku is invalid."
      end
    end

    # Check columns
    for i in 0..8
      column = []
      puzzle_arr.each do |row|
        column << row[i]
      end
      if !validateColumn(column)
        return "Sudoku is invalid."
      end
    end

    # Check boxes
    for i in 0..2
      for j in 0..2
        box = []
        for k in 0..2
          for l in 0..2
            box << puzzle_arr[i*3 + k][j*3 + l]
          end
        end
        if !validateBox(box)
          return "Sudoku is invalid."
        end
      end
    end

    # Check for incompleteness
    puzzle_arr.each do |row|
      if row.count(0) > 0
        return "Sudoku is valid but incomplete."
      end
    end

    # Check for forbidden characters
    if !validateForbidenCharacters(puzzle_arr)
      return "Sudoku is invalid."
    end

    return "Sudoku is valid."
  end

  def convertTo2DArray
    puzzle_arr = []
    
    @puzzle_string.gsub!("|", "")
    @puzzle_string.gsub!("-", "")
    @puzzle_string.gsub!("+", "")

    @puzzle_string.split("\n").each do |row|
      if row == ""
        next
      end
      puzzle_arr << row.split(" ").map(&:to_i)
    end

    return puzzle_arr
  end

  def validateRow(row)
    for i in 1..9
      if row.count(i) > 1
        return false
      end
    end
    return true
  end

  def validateColumn(column)
    for i in 1..9
      if column.count(i) > 1
        return false
      end
    end
    return true
  end

  def validateBox(box)
    for i in 1..9
      if box.count(i) > 1
        return false
      end
    end
    return true
  end

  def validateForbidenCharacters(puzzle_arr)
    puzzle_arr.each do |row|
      row.each do |cell|
        if cell < 0 || cell > 9
          return false
        end
      end
    end
    return true
  end
end
