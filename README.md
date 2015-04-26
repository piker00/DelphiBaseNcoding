# DelphiBaseNcoding
Port of BaseNcoding to Delphi


Original Source code location: https://github.com/KvanTTT/BaseNcoding

Porting guidelines:

DelphiBaseNcoding is a straight clone of BaseNcoding with as little changes as possible, to allow easy Synchronization in the future.
    
All file names (units) are the same, but with a "u" prefix.
Some variables were closely named.
Some functions were written by me because i could not find a Delphi Equivalent of the C# function used in the RTL or for Backwards Compability with older Unicode versions of Delphi.

Hints about the code:

    Multi-condition "for" loops and loops where iterator gets changed inside the loop, 
    were converted to while loops. 
    Log method (Delphi Equivalent "LogN"), two arguments (a, newBase) needed to be 
    swapped in Delphi.
    All Strings were ported as 1-Based (Index) because that is what Delphi Desktop 
    Compilers Uses by Default.
    The "Base Strings" were converted to Constant Arrays in Delphi.
    Delphi needs manual disposal of objects created , as they don't have built-in 
    destructor (automatic garbage collectors) support in them.

This Library is written with Delphi XE7 Update 1.
The Library supports only Unicode versions of Delphi (Delphi 2009 and above).
Mobile Compilers are NOT Supported. you could make a fork and implement it.


Some functions that needed BigInteger for operations were not ported due to the fact that Delphi does not offer Built in Support for Big Integers.
(might port them later if i find a suitable Library).

Common pitfalls during porting:
 
    Calling Log methods without swapping arguments places.
    Writing for .. to .. do loop instead of for .. downto .. do in rare cases.
    Wrong Indexing of values from Strings.

To Do Lists:

    Port BaseN and BaseBigN.
    (May be) Add Test Units.

