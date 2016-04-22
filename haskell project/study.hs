reverse1 [] = []
reverse1 (x:xs)=reverse1 xs ++[x]
insert a [] = [a]
insert a (x:xs)= if a<x then [a]++(x:xs)
                else  [x]++insert a xs


sort [] =[]
sort (x:xs)=  insert x (sort xs)
square x = x*x
sqareAll (x:xs	)= map square (x:xs)


sumsquare list = foldr (+) 0 (map (^2) (filter (>0) list)) 
mystery 0 _ x = x
mystery n f x = mystery (n-1) f (f x)

