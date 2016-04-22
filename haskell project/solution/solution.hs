import MusicResources

append1 [] = []
append1 (x:xs) = x ++ append1 xs

makestats =  mainfinal chars  (append1 training)
remove1 (y:[]) = []
remove1  (y:y2:ys) = if  y==y2 then remove1 (y:ys)
else [y2] ++ remove1 (y:ys) 

countandremove (y:ys) = (length (y:ys)) -( length (remove1 (y:ys)))
makepairlist [] = []
makepairlist (y:ys) = [(countandremove (y:ys),y)]++makepairlist (remove1 (y:ys)) 



insert (x,c) [] = [(x,c)]
insert (x,c) ((y,c2):ys) | x > y = (x,c):(y,c2):ys
                         | otherwise = (y,c2):insert (x,c) ys
sort [] = []
sort ((x,c):xs) = insert (x,c) (sort xs)


trackstring2 x (y:[]) = []
trackstring2 x (y1:y2:ys)= if x == y1 then [y2]++trackstring2 x (y2:ys) 
else trackstring2 x (y2:ys)
main1 x (y:ys) = sort( makepairlist (trackstring2 x (y:ys)))
mainfinal [] (y:ys) = []
mainfinal (x:xs) (y:ys) = [(x,main1 x (y:ys))]++mainfinal xs (y:ys)


sumfr [] = 0
sumfr ((f,c):xs)=f+sumfr xs
hamada x =sumfr (main1 x (append1 training))
rnd x =randomZeroToX (hamada x)
check a [] l = check a l l 
check a  ((y,z):xs)  l =if a<=y then z else check (a-y) l xs
compose x =check (rnd x) (main1 x (append1 training)) (main1 x (append1 training))
composefinal x 1= [(compose x)]
composefinal x n =  [x]++composefinal (compose x) (n-1)
compose3 x n= composefinal x n




frequencies [] = []
frequencies ((x,y):zs)= if x>0 then [y]++frequencies (((x-1),y):zs) else frequencies zs 
helpercompose (x:xs) = (x:xs) !! randomZeroToX((length(x:xs)-1))
sndcompose c 0 = []
sndcompose c n =[helpercompose (frequencies (main1 c (append1 training)))] ++ sndcompose (helpercompose (frequencies (main1 c (append1 training)))) (n-1)








