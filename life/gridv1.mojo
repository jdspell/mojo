@fieldwise_init
struct Grid(Copyable, Movable):
    var rows: Int
    var cols: Int
    var data: List[List[Int]]
    # fn __init__(out self, rows: Int, cols: Int, data: List[List[Int]]):
    #     self.rows = rows
    #     self.cols = cols
    #     self.data = data