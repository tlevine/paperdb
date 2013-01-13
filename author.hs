import qualified Data.Map as Map 
--import qualified Data.Aeson
--import qualified Text.JSON

author :: String -> [Map.Map String a]
author jsonstring = map sql rows
  where
    rows = Data.Aeson.decode jsonstring

sql :: Map.Map String a -> String
sql row
  | rowType == "point" = "[" ++ (lookup "xlab" row) ++ "] FLOAT NOT NULL," ++ "[" ++ (lookup "ylab" row) ++ "] FLOAT NOT NULL"
  | rowType == "image" = "[" ++ (lookup "lab" row) ++ "] TEXT NOT NULL" -- Base64
  | rowType == "text" =  "[" ++ (lookup "lab" row) ++ "] TEXT NOT NULL"
  where
    rowType = lookup "type" row



main = do
  putStrLn $ author "[{\"type\":\"point\",\"xlim\":[0,12]}]"
