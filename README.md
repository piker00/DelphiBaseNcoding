#DelphiBaseNcoding#

**`Port of BaseNcoding to Delphi`**

**`CSharp Source Code Location:`** [https://github.com/KvanTTT/BaseNcoding](https://github.com/KvanTTT/BaseNcoding)

    

**`Porting guidelines:`**


   
     DelphiBaseNcoding is a straight clone of BaseNcoding with as little changes as 
     possible, to allow easy Synchronization in the future.

    1. All file names (units) are the same, but with a "u" prefix. 
    2. Some variables were closely named. 
    3. Some functions were written by me because i could not find a Delphi Equivalent
       of the C# function used, in the RTL or for Backwards Compatibility with older
       Unicode versions of Delphi.

    
**`Hints about the code:`**



    1.  Multi-condition "for" loops and loops where iterator gets changed inside 
      the loop were converted to while loops. 

    2.  Log method (Delphi Equivalent "LogN"), two arguments (a, newBase) needed to be 
        swapped in Delphi.

    3.  All Strings were ported as 1-Based (Index) because that is what Delphi Desktop 
       Compilers Uses by Default.

    4.  The "Base Strings" were converted to Constant Arrays in Delphi.
       
    5.  Delphi needs manual disposal of objects created , as they don't have built-in 
        destructor (automatic garbage collectors) support in them.
    
    6.  This Library is written with (Delphi XE7 Update 1). 
        This Library supports only Unicode versions of Delphi (Delphi 2009 and above). 
        Mobile Compilers are NOT Supported. you could make a fork and implement it.

    7.  Some functions that needed the (BigInteger Type) in C# for operations 
        were not ported due to the fact that Delphi does not offer Built in Support for 
        Big Integers. (might port them later if i find a suitable Library).

    
   
**`Common pitfalls during porting:`**


    1. Calling Log methods without swapping arguments places.
    2. Writing for .. to .. do loop instead of for .. downto .. do in rare cases.
    3. Wrong Indexing of values from Strings.

  
**`To Do Lists:`**

    1. Port BaseN and BaseBigN.
    2. (May be) Add Test Units.
