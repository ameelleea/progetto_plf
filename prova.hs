import Data.List
-- necessario per usare nub, che elimina elementi duplicati da una lista
main :: IO ()
main = do as <- acquisisci_insieme "primo"
          putStrLn $ "Insieme:" ++ show as

{- L’azione di input/output acquisisci_insieme acquisisce un insieme di numeri interi:
- il suo unico argomento è una stringa che specifica di quale insieme si tratta. -}
acquisisci_insieme :: String -> IO [Int]
acquisisci_insieme quale = do putStr "Inserire il "
                              putStr quale
                              putStrLn " insieme di numeri interi racchiuso tra parentesi quadre:"
                              insiemeStr <- getLine
                              let insieme = nub (read insiemeStr :: [Int])
                              putStrLn ">> Stesso insieme privo di eventuali elementi duplicati:"
                              putStrLn $ show insieme
                              return insieme