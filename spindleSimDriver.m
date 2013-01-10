function u = spindleSimDriver(varargin)
nArgs = numel(varargin);
if nArgs == 8
visParams = varargin;
showDisks = varargin{1};
showCylinders = varargin{2};
showSpheres = varargin{3};
diskFC = varargin{4};
cylinderFC = varargin{5};
sphereFC = varargin{6};
kmtRadius = varargin{7};
kmtUncertaintySphereRadiusEdit = varargin{8};
end
%function = spindleSimDriver(showDisks,showCylinders,showSpheres,diskFC,cylinderFC,sphereFC)
%KMT_LENGTH_FILE = 'Boundsfix T 1 C1.csv'; %keep in mind I deleted the top line of strings
%SPINDLE_LENGTH_FILE = 'Boundsfix T 1 C1_Lip.csv';
[KMT_LENGTH_FILE KLFPATH] = uigetfile('*.csv','Select the simulation file:');
%[SPINDLE_LENGTH_FILE SLFPATH] = uigetfile('*.csv','Select the Spindle Length File');
NUM_TIMESTEPS = 100;
NUM_KMTS = 16; %per side
SIMULATION_DIRECTORY = 'SimDir';
ORIGIN = [6500 6500 0];



fprintf('Reading the CSV files...\n');
simFile = csvread([KLFPATH KMT_LENGTH_FILE])
simFile = simFile * 10^9;
%lengthFile = csvread([SLFPATH SPINDLE_LENGTH_FILE],1,1); %figure out how to not delete the header lines
%lengthFile = lengthFile * 10^9;

fprintf('Making the simulation directory...\n');
makeSimDir = unix(['mkdir -p ' SIMULATION_DIRECTORY]);
chageDir = unix(['cd ' SIMULATION_DIRECTORY]);

l = zeros(NUM_KMTS,1);
r = zeros(NUM_KMTS,1);

dt = (2*pi)/NUM_KMTS;
t = 0:dt:(2*pi);
t = t(1:NUM_KMTS);   %  angles of kMTS

y = kmtRadius*cos(t) + ORIGIN(2);
z = kmtRadius*sin(t);

%xplane = [ORIGIN(1)-(SPINDLE_LENGTH/2) ORIGIN(1)+(SPINDLE_LENGTH/2)];

fprintf('Performing iterations...\n');
for iter = 1:NUM_TIMESTEPS

	l = simFile(iter,2:NUM_KMTS+1);
	r = simFile(iter,NUM_KMTS+2:2*NUM_KMTS+1);

	SPINDLE_LENGTH = simFile(iter,1);
	xplane = [ORIGIN(1)-(SPINDLE_LENGTH/2) ORIGIN(1)+(SPINDLE_LENGTH/2)];

	l_pos = l + xplane(1);
	r_pos = (-1*r) + xplane(2);
	
	filename = [SIMULATION_DIRECTORY '/iter' num2str(iter) '.xml'];

	initialize_cylinder(filename, y,z,l_pos,r_pos,xplane,kmtRadius,...
        kmtUncertaintySphereRadiusEdit,visParams);
end









