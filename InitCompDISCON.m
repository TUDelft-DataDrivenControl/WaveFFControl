% A script used to initialize the controller before compiling, then compile it to get a *.dll file.
% This script must be run before starting the compilation or the simulation.
% For compilation purposes, this script should be run separately. 

%% User input parameters
% General inputs
TimeStep           =  0.05;        % Simulation time step (s)
Turbine            = 'NREL5MW';    % Turbines: NREL5MW, DTU10MW, IEA10MW, IEA15MW
TurbineType        = 'Offshore';   % Turbine foundation type ['Offshore' or 'Onshore']. 
GenerateDLL        = false;        % A switch for DLL Generation

% FF controller 
WindSpeed          = 16;           % Operating point used to define the corresponding linear model     
Kff_gain           = 0.3;          % A static gain to manipulate the intensity of the FF controller  
%% Controller parameters
% In this section, the turbine parameters are defined 
DirContents    = cellstr(ls);
%TurbParamsFile = DirContents(contains(DirContents,Turbine,'IgnoreCase',true) & endsWith(DirContents, '.m'));      
TurbParamsFile = fullfile(['ControlParams_', Turbine, '.m']);
run(TurbParamsFile);


%% Controller Compiling
% This section is responsible for the compilation of the controller
% However, we should make sure that we delete the previous build files, to
% ensure that the compiling process will be pulled off independent of the
% Matlab version being used.

if GenerateDLL == 1    
    RemoveFolders = DirContents(strcmpi(DirContents, ['slprj', 'rtw']));
    rmdir(RemoveFolders, 's')
    
    % Now that the folders have been removed the compiling process can take place
    %rtwbuild('DISCON_NREL5MW_DLL_Generation');
    rtwbuild(['DISCON_' Turbine '_DLL_Generation']);
end
