from gridv1 import Grid

def run_display(owned grid: Grid) -> None:
    while True:
        print(String(grid))
        print()
        if input("Enter 'q' to quit or press <Enter> to continue: ") == "q":
            break
        grid = grid.evolve()

def main():
    start = Grid.random(16,16)
    run_display(start)