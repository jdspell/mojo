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