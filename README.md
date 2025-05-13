# VestingContract


=> beneficiary - the address of a person for whom the token will receive over a time period

=> start - (unix timestamp) when the vesting process actually begins 

// unix timestamp -  the number of seconds that have passed since January 1, 1970, at 00:00:00 UTC (called the "Unix epoch").
                  -  In Solidity, time is tracked using the [ block.timestamp ] variable, which returns the current block’s Unix timestamp.

=> cliff - A cliff is the minimum time the beneficiary must wait before they can claim any tokens at all.
         - Before this date, they get nothing.
         - After this point, tokens begin to vest.
         - example: If the start time is today, and the cliff is 3 months, the beneficiary can’t claim anything for 3 months. After that, tokens start unlocking.

=> duration - The total time it takes for the full amount of tokens to be unlocked.
            - From the start time, the tokens are slowly released over this duration.
            - example: If duration is 1 year, then by the end of that year, the full amount will be released gradually.

=> release - This keeps track of how many tokens have already been claimed (or "released") to the beneficiary.
           - Prevents double claiming
