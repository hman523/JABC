import Control.Monad
import System.Environment
import System.Exit


start = "#include <stdio.h>\n\
\int main()\n\
\{\n"
end = "\n}\n"

convert :: [[String]] -> String
convert str = (start ++ (unwords (map btc str)) ++ end)

btc :: [String] -> String
btc [num, "PRINT", val] = ("label" ++ num ++ ": printf(" ++ val ++ ");\n")
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
