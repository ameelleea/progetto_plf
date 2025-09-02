{- Programma Haskell per calcolare differenze tra relazioni e chiusure di relazioni -}

import Data.List -- necessario per usare nub, che elimina elementi duplicati da una lista

type Rel = [(Int, Int)]

main :: IO ()
main = do putStrLn "Inserisci l'insieme di numeri naturali racchiuso tra parentesi quadre:"
          insStr <- getLine
          let insieme = nub( read insStr :: [Int])
          putStr "Inserire la relazione binaria sull'insieme racchiusa tra parentesi quadre:"
          relazioneStr <- getLine
          let relazione = nub (read relazioneStr :: Rel)
          putStrLn "\nChiusura riflessiva di R1:"
          putStrLn $ show (riflessiva insieme r1)
          putStrLn "\nChiusura simmetrica di R2:"
          putStrLn $ show (simmetrica r2)

{- La funzione riflessiva calcola la chiusura riflessiva di una relazione:
   - il primo argomento è il codominio della relazione, ovvero l'insieme di numeri interi inserito
   - il secondo argomento è la relazione stessa -}

riflessiva :: [Int] -> Rel -> Rel
riflessiva [] rel = rel   
riflessiva (x:xs) rel =
    let coppia = (x, x)                 
        rel'   = if elem coppia rel   
                    then rel
                    else coppia : rel
    in riflessiva xs rel'       

{- La funzione simmetrica calcola la chiusura simmetrica di una relazione, 
   - il suo unico argomento è la relazione stessa -}

simmetrica :: Rel -> Rel
simmetrica [] = []                                
simmetrica ((a,b):xs) =
    let resto = simmetrica xs                     
        coppie = if elem (b,a) (a,b):xs         
                    then [(a,b)]                  
                    else [(a,b),(b,a)]            
    in nub (coppie ++ resto)                      