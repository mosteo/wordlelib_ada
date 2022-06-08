private with AAA.Strings;

generic
   Word_Length : Positive := 5;
package Wordlelib with Preelaborate is

   --  Types

   type Game (<>) is tagged private;

   type Guess_Kind is (Hit, Missplaced, Miss);

   type Guess_Result is array (1 .. Word_Length) of Guess_Kind;

   type Guess_Array is array (Positive range <>) of Guess_Result;

   subtype Word is String (1 .. Word_Length);

   type Attempt_Array is array (Positive range <>) of Word;

   --  Subprograms

   function New_Game (Target : Word) return Game;

   procedure Make_Attempt (This : in out Game; Attempt : Word);

   function Attempt_Count (This : Game) return Natural;

   function Attempts (This : Game) return Attempt_Array;

   function Guesses (This : Game) return Guess_Array;

   function Target (This : Game) return Word;

   function Won (This : Game) return Boolean
     with Post =>
       Won'Result =
         (This.Attempt_Count > 0 and then
          This.Attempts (This.Attempt_Count) = This.Target);

private

   subtype Attempt_Vector is AAA.Strings.Vector;

   type Game is tagged record
      Target   : Word;
      Attempts : Attempt_Vector;
   end record;

end Wordlelib;
