import random

@fieldwise_init
struct Grid(Copyable, Movable, StringableRaising):
    var rows: Int
    var cols: Int
    var data: List[List[Int]]
    
    def __str__(self) -> String:
        str = String()
        for row in range(self.rows):
            for col in range(self.cols):
                if self[row, col] == 1:
                    str += "*"
                else:
                    str += " "
            if row != self.rows-1:
                str += "\n"
        return str
    
    def __getitem__(self, row: Int, col: Int) -> Int:
        return self.data[row][col]
    
    def __setitem__(mut self, row: Int, col: Int, value: Int) -> None:
        self.data[row][col] = value
    
    @staticmethod
    def random(rows: Int, cols: Int) -> Self:
        random.seed() # seed based on current time -> value is always unique
        var data: List[List[Int]] = []
        for _ in range(rows): # _ follows the discard pattern. Otherwise the mojo compiler would throw a warning.
            var row_data: List[Int] = []
            for _ in range(cols):
                row_data.append(Int(random.random_si64(0, 1)))
            data.append(row_data)
        return Self(rows, cols, data)

    def evolve(self) -> Self:
        next_generation = List[List[Int]]()

        for row in range(self.rows):
            row_data = List[Int]()
            # calc neighboring row indicies
            row_above = (row - 1) % self.rows
            row_below = (row + 1) % self.rows

            for col in range(self.cols):
                # calc neighboring col indicies
                col_left = (col - 1) % self.cols
                col_right = (col + 1) % self.cols
                # determine the number of populated cells
                num_neighbors = (
                    self[row_above, col_left]
                    + self[row_above, col]
                    + self[row_above, col_right]
                    + self[row, col_left]
                    + self[row, col_right]
                    + self[row_below, col_left]
                    + self[row_below, col]
                    + self[row_below, col_right]
                )

                # determine the state of current cell for next generation
                new_state = 0
                if self[row, col] == 1 and (num_neighbors == 2 or num_neighbors == 3):
                    new_state = 1
                elif self[row, col] == 0 and num_neighbors == 3:
                    new_state = 1
                row_data.append(new_state)
            next_generation.append(row_data)
        return Self(self.rows, self.cols, next_generation)

