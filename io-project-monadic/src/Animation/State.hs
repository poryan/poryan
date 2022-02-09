module Animation.State where

type Vector = (Int, Int)

-- direction vector will be something like (x, y) where x and y can be 0, 1, -1
data State = State { position :: Vector, direction :: Vector } -- speed :: Int }
  deriving (Show)

data Env = Env { frame :: Vector } -- maxSpeed :: Int, chargeSpeed :: Int }
  deriving (Show)

--------------------------------------------------------------------------------
-- State
next :: Env -> State -> State
next (Env (width, height)) (State (posX, posY) (dirX, dirY)) =
  let posX' = posX + dirX
      posY' = posY + dirY
      hasCrossedTopEdge = posY' > height
      hasCrossedBottomEdge = posY' < 0
      hasCrossedLeftEdge = posX' < 0
      hasCrossedRightEdge = posX' > width
      dirXFinal = if hasCrossedLeftEdge || hasCrossedRightEdge then (-dirX) else dirX
      dirYFinal = if hasCrossedTopEdge || hasCrossedBottomEdge then (-dirY) else dirY
      posXFinal = if hasCrossedLeftEdge || hasCrossedRightEdge
                    then posX + dirXFinal
                    else posX'
      posYFinal = if hasCrossedTopEdge || hasCrossedBottomEdge
                    then posY + dirYFinal
                    else posY'
  in State {
    position = (posXFinal, posYFinal),
    direction = (dirXFinal, dirYFinal)
  }

