-- Answers to the exercise of typeclassopedia:
-- https://wiki.haskell.org/Typeclassopedia

module TypeclassEx where

import Control.Applicative
import Prelude hiding ((**))

-- Exercise: Implement a function
--   sequenceAL :: Applicative f => [f a] -> f [a]

-- 1. Fully evaluating a structure and collecting the results.

-- >>> sequenceA [Just 1, Just 2, Just 3]
-- Just [1,2,3]
-- >>> sequenceA [Right 1, Right 2, Right 3]
-- Right [1,2,3]

-- 2. Short circuit the resulting structure if present in the input.

-- >>> sequenceA [Just 1, Just 2, Just 3, Nothing]
-- Nothing
-- >>> sequenceA [Right 1, Right 2, Right 3, Left 4]
-- Left 4

seqA :: Applicative f => [f a] -> f [a]
seqA [] = pure []
seqA (m:ms) = (:) <$> m <*> seqA ms

-- Exercise: Implement pure and (<*>) in terms of unit and (**), and vice versa.

-- This is different from the numeric algebra monoidal, refer to:
-- Numeric Algebra, Monoidal
-- https://hackage.haskell.org/package/algebra-4.3.1/docs/Numeric-Algebra.html#t:Monoidal

class Applicative f => Monoidal f where
  unit :: f ()
  unit = pure ()

  (**) :: f a -> f b -> f (a, b)
  f ** v = (,) <$> f <*> v

class Monoidal f => MyApplicative f where
  pure' :: a -> f a
  pure' x = (const x) <$> unit

  -- this is <*>'
  (<*>*) :: f (a -> b) -> f a -> f b
  g <*>* m = (uncurry ($)) <$> (g ** m)

instance Monoidal Maybe where

instance MyApplicative Maybe where

-- test
test1 = (Just 1) ** (Just 2) -- Just (1, 2)
test2 = (Just even) <*>* (Just 1) -- Just False
