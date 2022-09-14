% make sure the OpenFAST directory where the FAST_SFunc.mex* file is located
% is in the MATLAB path (also make sure any other OpenFAST library files that
% are needed are on the MATLAB path)
%    (relative path names are not recommended in addpath()):
% addpath(genpath('../../../install')); % cmake default install location

%addpath('C:\OpenFAST_3.0\openfast\build\bin'); % install location for Windows Visual Studio builds

% these variables are defined in the OpenLoop model's FAST_SFunc block:
FAST_InputFileName = '5MW_OC3Spar_DLL_WTurb_WavesIrr\5MW_OC3Spar_DLL_WTurb_WavesIrr.fst';
TMax               = 3000; % seconds
DT = TimeStep;
load('OutList.mat')
sim('OpenFAST_SFunc_NREL5MW_FF.slx',[0,TMax]);
