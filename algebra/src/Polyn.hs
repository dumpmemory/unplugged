module Polyn where

-- Polynomial long division
-- a polynomial a(x) = a_0 x^n + a_1 x^{n-1} + ... =a_n x + a_{n+1}
-- as = [a_0, a_1, ..., a_{n+1}]
-- assume |as| >= |bs|, all numbers are integer
-- a(x) = q(x)b(x) + r(x)
polyndiv as bs = pdiv as (length as - length bs) [] where
  pdiv as i qs = if i == 0 then (reverse (q:qs), as')
                 else pdiv as' (i - 1) (q:qs)
    where
      q = head as `div` head bs
      as' = dropWhile (== 0) [a - b*q | (a, b) <- zip as (bs ++ repeat 0)]

-- e.g. (x^3 - 1) = (x - 1)(x^2 + x + 1)
e1 = [1, 0, 0, -1] `polyndiv` [1, -1]
e2 = [1, 0, 0, -1] `polyndiv` [1, 1, 1]
