module Animation.Draw where

import Animation.State

-- Assuming speed = 1 block per second for version 1.
-- Refresh rate of 1 second.

drawState :: Env -> State -> String
drawState env@(Env (_, height)) state =
  unlines $ reverse $ map (\row -> drawRow env state row) [-1..height+1]

drawRow :: Env -> State -> Int -> String
drawRow env@(Env (width, _)) state row = map (\col -> charAt env state (col, row)) [-1..width+1]

charAt :: Env -> State -> Vector -> Char
charAt (Env (width, height)) (State (posX, posY) _) (x, y)
  | (posX, posY) == (x, y) = 'o'
  | y < 0 || y > height = '-'
  | x < 0 || x > width = '|'
  | otherwise = ' '