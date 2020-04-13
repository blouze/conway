// Conway's Game of Life
// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

int res = 210;
boolean[][] cells;
PVector[] neighbours;

void setup() {
  size(840, 840);

  neighbours = new PVector[8];
  neighbours[0] = new PVector(-1, -1);
  neighbours[1] = new PVector( 0, -1);
  neighbours[2] = new PVector( 1, -1);
  neighbours[3] = new PVector( 1, 0);
  neighbours[4] = new PVector( 1, 1);
  neighbours[5] = new PVector( 0, 1);
  neighbours[6] = new PVector(-1, 1);
  neighbours[7] = new PVector(-1, 0);
  
  reset();
}

void reset() {
  cells = new boolean[res][res];

  for (int j = 0; j < res; j++) {
    for (int i = 0; i < res; i++) {
      cells[i][j] = random(1) > 0.33;
    }
  }
}

void mouseClicked() {
  reset();
}

void draw() {
  background(#16161d);
  noStroke();

  float w = width / res;
  float h = height / res;
  boolean[][] next = new boolean[res][res];

  for (int j = 0; j < res; j++) {
    for (int i = 0; i < res; i++) {
      boolean c = cells[i][j];
      int count = 0;
      for (PVector n : neighbours) {
        if (cells[(i + int(n.x) + res) % res][(j + int(n.y) + res) % res]) {
          count++;
        }
      }

      next[i][j] = cells[i][j];
      
      if (c) {
        if (count > 3 || count < 2) next[i][j] = false;
      } else if (count == 3) next[i][j] = true;
    }
  }

  for (int j = 0; j < res; j++) {
    for (int i = 0; i < res; i++) {
      fill(next[i][j] ? 255 : color(#16161d));
      rect(i * w, j * h, w, h);
    }
  }

  arrayCopy(next, cells);
}
