function trainvars = traindefine()
%
% trainvars = traindefine()
%
% Define the parameters of a training process (number of epochs, step sizes, momentum, etc.).
%
% This file should be edited to reflect the parameters desired for the
% training process.

nepochs = 1000;             % Number of epochs to be performed in each training run

desiredcost = 0;            % Value of cost at which to stop the training run

weightrange = .5;

eta0 = .01;                 % Initial step sizes
alpha = 0.7;                % Momentum coefficient

adaptivesteps = true;       % Whether to perform step size adaptation
etaup = 1.1;                % Factor for step size increase
etadown = .9;               % Factor for step size decrease

costcontrol = true;         % Whether to perform cost control
costtolerance = 1.00000001;          % This is a multiplicative factor.  For example, costtolerance = 1.05 means a tolerance of 5%
etareduce = .5;             % Step size reduction factor in backtracking


costfun='mse';              % Default cost function

epoch = 0;                  % Current epoch
falseepochs = 0;            % To check: is this used elsewhere, or not?
costmin = Inf;              % Minimum cost achieved thus far
cost = [];                  % Clear cost values

reporteveryepoch = 0;       % If =0 will only report every 20 epochs


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Below we copy these values into the 'trainvars' structure.  %
%  Lines below here shouldn't be edited.                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear trainvars                     % Get rid of old data

trainvars.nepochs       = nepochs;
trainvars.desiredcost   = desiredcost;
trainvars.weightrange   = weightrange;
trainvars.eta0          = eta0;
trainvars.alpha         = alpha;
trainvars.adaptivesteps = adaptivesteps;
trainvars.etaup         = etaup;
trainvars.etadown       = etadown;
trainvars.costcontrol   = costcontrol;
trainvars.costtolerance = costtolerance;
trainvars.etareduce     = etareduce;
trainvars.costfun       = costfun;
trainvars.epoch         = epoch;
trainvars.falseepochs   = falseepochs;
trainvars.costmin       = costmin;
trainvars.cost          = cost;
trainvars.reporteveryepoch = reporteveryepoch;


return
