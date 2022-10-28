% ------ Control parameters for NREL 5-MW Reference Wind Turbine ------ 

% Description: This is an M-file used to collect all the parameters needed
% for the control of NREL 5-MW reference wind turbine in a structure called 'Control'.


Control.TimeStep                =       TimeStep;               % Simulation time step (s)


%% Filters
Control.Filters.LPF_CornerFreq  =       1.570796;               % Corner frequency (-3dB point) in the recursive, single-pole, low-pass filter, rad/s. -- chosen to be 1/4 the blade edgewise natural frequency ( 1/4 of approx. 1Hz = 0.25Hz = 1.570796rad/s)

%% Pitch Control Parameters
Control.Pitch.PC_DT             =       Control.TimeStep;       % Communication interval for pitch  controller (s)
if strcmpi(TurbineType,'Offshore')
    Control.Pitch.PC_KP         =       0.006275604;            % Proportional gain for pitch controller at rated pitch (zero), (s).
    Control.Pitch.PC_KI         =       0.0008965149;           % Integral gain for pitch controller at rated pitch (zero), (-).
else
    Control.Pitch.PC_KP         =       0.01882681;             % Proportional gain for pitch controller at rated pitch (zero), (s).
    Control.Pitch.PC_KI         =       0.008068634;            % Integral gain for pitch controller at rated pitch (zero), (-).
end
Control.Pitch.PC_KK             =       0.1099965;              % Pitch angle where the the derivative of the aerodynamic power w.r.t. pitch has increased by a factor of two relative to the derivative at rated pitch (zero), (rad).  
Control.Pitch.PC_MaxPit         =       1.570796;               % Maximum pitch setting in pitch controller, (rad).  
Control.Pitch.PC_MaxRat         =       0.1396263;              % Maximum pitch  rate (in absolute value) in pitch  controller, (rad/s).    
Control.Pitch.PC_MinPit         =       0.0;                    % Minimum pitch setting in pitch controller, (rad).  
Control.Pitch.PC_RefSpd         =       122.9096;               % Desired (reference) HSS speed for pitch controller, (rad/s).

%% Variable Speed Torque Control Parameters
Control.Torque.SigSmoother      =       1/20e-3;                % A constant used to smoothen the disctrete generator torque signal 
Control.Torque.GenEffec         =       0.944;                  % Generator efficiency
Control.Torque.VS_CtInSp        =       70.16224;               % Transitional generator speed (HSS side) between regions 1 and 1 1/2, (rad/s).
Control.Torque.VS_DT            =       Control.TimeStep;       % Communication interval for torque controller, (s).
Control.Torque.VS_MaxRat        =       15000.0;                % Maximum torque rate (in absolute value) in torque controller, (N.m/s).
Control.Torque.VS_MaxTq         =       47402.91;               % Maximum generator torque in Region 3 (HSS side), (N.m). Chosen to be 10% above VS_RtTq = 43.09355 (kNm)
Control.Torque.VS_Rgn2K         =       2.332287;               % Generator torque constant in Region 2 (HSS side), (N.m/(rad/s)^2).   
Control.Torque.VS_Rgn2Sp        =       91.21091;               % Transitional generator speed (HSS side) between regions 1 1/2 and 2, (rad/s).
Control.Torque.VS_Rgn3MP        =       0.01745329;             % Minimum pitch angle at which the torque is computed as if we are in region 3 regardless of the generator speed, (rad). Chosen to be 1.0 degree above PC_MinPit = 0.    
Control.Torque.VS_RtGnSp        =       121.6805;               % Rated generator speed (HSS side), (rad/s). Chosen to be 99% of PC_RefSpd.     
Control.Torque.VS_RtPwr         =       5296610.0;              % Rated generator generator power in Region 3, Watts. Chosen to be 5MW divided by the electrical generator efficiency of 94.4%
Control.Torque.VS_SlPc          =       10.0;                   % Rated generator slip percentage in Region 2 1/2.

%% FF Controller
Control.GainKff                 = Kff_gain;                     

load('NREL5MW_LinModels_Surge_Pitch_DOFs.mat')

Gd_Fwave                        = c2d(LinModel('omega_r','F_{hydro}'),Control.TimeStep,'tustin');  
Gd_Mwave                        = c2d(LinModel('omega_r','M_{hydro}'),Control.TimeStep,'tustin');  
Gp                              = c2d(LinModel('omega_r','beta_c'),Control.TimeStep,'tustin');  
InvGp                           = inv(Gp);

s=tf('s');
omega                           = 0.208;
beta                            = 0.02;
beta2                           = 0.2;
notch                           = (s^2 + 2*omega*beta*s + omega^2)/(s^2 + 2*omega*beta2*s +omega^2);
%Notch                           = (s^2 + 2*Wnotch*beta*s + Wnotch^2)/(s^2 + 2*Wnotch*beta2*s +Wnotch^2);
InvGp                           = InvGp*c2d(notch,Control.TimeStep,'tustin');
