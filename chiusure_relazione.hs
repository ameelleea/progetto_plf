{- Programma Haskell per calcolare le chiusure di una relazione -}

import Data.List -- necessario per usare nub, che elimina elementi duplicati da una lista

main :: IO ()
main = do putStrLn "Inserisci l'insieme di numeri naturali separati da spazi:"
          insiemeStr <- getLine
          let insieme = nub (map read (words insiemeStr) :: [Int])
          putStrLn $ "Insieme privo di elementi duplicati: " ++ show insieme
          relazione <- acquisisci_relazione insieme
          putStrLn $ "Relazione priva di elementi duplicati: " ++ show relazione
          putStr "Chiusura riflessiva di R:"
          putStrLn $ show (riflessiva relazione)
          putStr "Chiusura simmetrica di R:"
          putStrLn $ show (simmetrica relazione)
          putStr "Chiusura transitiva di R:"
          putStrLn $ show (transitiva relazione)

{- L'azione di input/output acquisisci_relazione acquisisce la relazione da tastiera, verifica che sia valida sull'insieme
   e la restituisce priva di eventuali duplicati:
   -il suo unico argomento è l'insieme, precedentemente inserito, sul quale la relazione deve essere valida. -}

acquisisci_relazione :: [Int] -> IO [(Int, Int)]
acquisisci_relazione insieme = do putStrLn "Inserisci le coppie separate da spazi (es 1,2 2,3):"
                                  relazioneStr <- getLine
                                  let rel = nub (map parse_coppia (words relazioneStr))
                                  if all (\(a,b) -> a `elem` insieme && b `elem` insieme) rel
                                     then return rel
                                  else do putStrLn "Errore: alcune coppie contengono elementi non presenti nell'insieme."
                                          acquisisci_relazione insieme

{- La funzione parse_coppia converte una stringa del tipo "1,2" in una coppia di interi (1,2):
   -il suo unico argomento è la stringa da trasformare. -}

parse_coppia :: String -> (Int, Int)
parse_coppia s = let [a,b] = map read (split_stringa (==',') s)
                 in (a,b)

{- La funzione split_stringa spezza una stringa in sottostringhe, usando come separatore qualunque carattere soddisfi p:
   -il primo argomento è il predicato da soddisfare
   -il secondo argomento è la stringa da spezzare -}

split_stringa :: (Char -> Bool) -> String -> [String]
split_stringa p s = case dropWhile p s of
                    "" -> []
                    s' -> w : split_stringa p s''
                        where (w, s'') = break p s'

{- La funzione riflessiva calcola la chiusura riflessiva di una relazione:
   - il suo unico argomento è la relazione stessa -}

riflessiva :: [(Int, Int)] -> [(Int, Int)]
riflessiva [] = []
riflessiva rel = nub (rel ++ [(x,x) | (a,b) <- rel, x <- [a,b], (x,x) `notElem` rel])      

{- La funzione simmetrica calcola la chiusura simmetrica di una relazione, 
   - il suo unico argomento è la relazione stessa -}

simmetrica :: [(Int, Int)] -> [(Int, Int)]
simmetrica [] = []
simmetrica rel = nub $ rel ++ [(b,a) | (a,b) <- rel, (b,a) `notElem` rel]   

{- La funzione transitiva calcola la chiusura transitiva di una relazione:
   -il suo unico argomento è la relazione stessa.-}

transitiva :: [(Int, Int)] -> [(Int, Int)]
transitiva [] = []  -- caso base esplicito
transitiva rel = let nuove = [(a,d) | (a,b) <- rel, (c,d) <- rel, b == c, (a,d) `notElem` rel]
                 in if null nuove
                    then rel
                    else transitiva (nub (rel ++ nuove))
            