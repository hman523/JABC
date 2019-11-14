import Control.Monad
import System.Environment
import System.Exit
import Data.List

start = "#include <stdio.h>\n\
\int main()\n\
\{\n"
end = "\n}\n"

convert :: [[String]] -> String
convert str = (start ++ (concat (map btc str)) ++ end)

--Add label function
addL :: String -> String
addL l = ("label" ++ l ++ ": ")

btc :: [String] -> String
btc [num, "PRINT", val] = (addL num ++ "printf(" ++ val ++ ");\n")
btc [num, "GOTO", val] = (addL num ++ "goto label" ++ val ++ ";\n")
btc [num, "END"] = (addL num ++ "return 0;\n")
btc _ = ""
--btc [num, "LET", var, "=", val] = 


main :: IO ()
main = do
  putStrLn "Welcome to JABC"
  args <- getArgs
  when (length args /= 1) $ do
    putStrLn "Need a file to compile"
    exitFailure
  let filename = head args
  putStrLn filename
  contents <- readFile filename
  let splitted =  map words $ lines contents
  let result = convert splitted
  writeFile (filename ++ ".c") result
  putStrLn "Wrote to file!"
  exitSuccess
