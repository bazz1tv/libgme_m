libGME_M
========

Title stands for libGME Modified. Focused on the SNES aspect alone, it reconstructs the SPC emulator
to allow a greater level of external access to its insides to the user (program). Also features a memory
read-write-execute reporting API.

This is a fusion of libGME 0.5.2 and Snes_Spc 0.9.0

* Facilities were added to allow interaction between parts of the emulator and the user (program).
* Blargg custom implemented an optional Dsp Smoothing algorithm to reduce clicks and pops on tracks that rapidly adjust volume.