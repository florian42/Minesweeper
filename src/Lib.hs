module Lib
    ( someFunc
    , Field(..)
    , Board(..)
    , createBoard
    , showBoard
    , stringBoard
    , openField
    ) where

import Data.List

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Data Types

data Field = Field 
                    { xCor :: Int
                    , yCor :: Int
                    , hasMine :: Bool -- Noch ein Feld -> Opened :: Bool
                    , surroundingMines :: Int
                    , isOpened :: Bool
                    } deriving (Show)

data Board = Board
                   { fields :: [Field]
                   , size :: Int
                   } deriving (Show) 

-- Methods

createBoard :: Int -> Board
createBoard m = Board [ Field x y False 0 False | x <- [1..m], y <- [1..m]] m

--printRow :: Board -> [Field] -- Testweise irgendeine Reihe

-- convert to printable row
--makePrintableField :: Field -> (String, String)
--makePrintableField x y = (xAsString, yAsString) where xAsString = show x
--                                                      yAsString = show y

stringBoard :: Board -> [String]
stringBoard board = [ if yCor feld >= size board
                      then show (xCor feld, yCor feld, hasMine feld, surroundingMines feld, isOpened feld) ++ "\n"
                      else show (xCor feld, yCor feld, hasMine feld, surroundingMines feld, isOpened feld) | feld <- fields board
                    ]

showBoard :: [String] -> IO ()
showBoard strings = putStrLn board where board = intercalate " " strings

openField :: Int -> Int -> Board -> [Field]                      
openField x y (Board fields m) = [ if xCor field == x && yCor field == y 
                                   then do let xCoord = xCor field 
                                               yCoord = yCor field
                                               mine = hasMine field
                                               surr = surroundingMines field
                                               newField = Field xCoord yCoord mine surr True
                                            in newField    
                                   else field | field <- fields]