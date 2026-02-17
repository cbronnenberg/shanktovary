
can we do a quick refactoring to keep the original and filtered signals and units easier to program. I propose the following changes:
orignal accel -> aOrig (input)
unfiltered accel in interernal units -> aInt (internal)
filtered accel in internal units -> aFInt
filtered accel in external units -> aF

Can you advise on what would have to be updated? I may be ablel to do some of this