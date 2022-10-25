clear all; close all; clc
% A script used to initialize the controller before compiling, then compile it to get a *.dll, or *.so file when run on a Windows or Linux machine, respectively.
% This script must be run before starting the compilation or the simulation.
% For compilation purposes, this script should be run separately. 

%% User input parameters
% General inputs
TimeStep           =  0.05;        % Simulation time step (s)
Turbine            = 'NREL5MW';    % Turbines: NREL5MW, DTU10MW, IEA10MW, IEA15MW
TurbineType        = 'Offshore';   % Turbine foundation type ['Offshore' or 'Onshore']. 
GenerateDLL        = true;        % A switch for DLL Generation

% FF controller 
WindSpeed          = 16;           % Operating point used to define the corresponding linear model     
Kff_gain           = 0.3;          % A static gain to manipulate the intensity of the FF controller  

%% Controller parameters
% In this section, the turbine parameters are defined 
DirContents    = cellstr(ls);
TurbParamsFile = fullfile(['ControlParams_', Turbine, '.m']);
run(TurbParamsFile);


%% Controller Compiling
% This section is responsible for the compilation of the controller
if GenerateDLL == 1 
    rtwbuild(['DISCON_' Turbine '_WaveFF']);
end
