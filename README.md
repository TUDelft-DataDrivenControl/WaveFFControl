# WaveFFControl
Wave feedforward control input files for NREL 5MW on top of the OC3 floating platform in the above-rated region. So, only the blade pitch controller is included.

In order to run such files, you need the precompiled binaries from OpenFAST v3.0.0 in here [OpenFAST precompied binaries](https://github.com/OpenFAST/openfast/releases under Assets. The required binaries are: openfast_x64.exe and OpenFAST-Simulink_x64.dll

This repository contains 2 simulink files:
1) DISCON_NREL5MW_WaveFF.slx: The file used to compile a DLL to be used either with OpenFAST or Qblade.
2) OpenFAST_SFunc_NREL5MW_FF.slx: An example of an OpenFAST model in Simulink.

### Steps to use the controller:
- In order to generate a DLL, the controller has to be initialized first. All you need to do is to open "InitCompDISCON.m", set the flag 'GenerateDLL' to true, then run   the file.  
- If you are interested in running the OpenFAST example in Simulink, first, you will need the input files to run OpenFAST, which are not provided here, but can be downloaded from OpenFAST github repository. Once the input files are set up, run "Run_OpenLoop.m" file.
