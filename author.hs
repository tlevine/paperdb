import qualified Data.Map as Map 
--import qualified Data.Aeson
--import qualified Text.JSON

import Data.String.Utils

author :: String -> [Map.Map String a]
author jsonstring = "CREATE TABLE tablename (\n" ++ schema ++ "\n);"
  where
    rows = Data.Aeson.decode jsonstring
    schema = join ",\n" $ map sql rows

sql :: Map.Map String a -> String
sql row
  | rowType == "point" = "[" ++ (lookup "xlab" row) ++ "] FLOAT NOT NULL,\n" ++ "[" ++ (lookup "ylab" row) ++ "] FLOAT NOT NULL"
  | rowType == "image" = "[" ++ (lookup "lab" row) ++ "] TEXT NOT NULL" -- Base64
  | rowType == "text" =  "[" ++ (lookup "lab" row) ++ "] TEXT NOT NULL"
  where
    rowType = lookup "type" row



main = do
  putStrLn $ author "[{\"type\":\"point\",\"xlim\":[0,12]}]"
