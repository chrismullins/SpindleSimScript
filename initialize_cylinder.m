%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% filename: name (or path) of xml file to be written
%% ypos,zpos:  the spindle is oriented so as to be radially symmetric
%%             around the x-axis.  Therefore, the y and z positions of
%%             the microtubules should remain constant.
%% [l,r]kMTpos:  this should be the actual parameter taken by the MS,
%%           calculated from the simulation timesteps
%% xplanes:    these are calculated from SPINDLE_LENGTH from the Lip csv
%%             file, and are used to place the two disks
%% radius:     this refers to the radius of the spindle, around which the
%%             kMTs are placed
%
function [] = initialize_cylinder(filename,t, lkMTpos, rkMTpos,xplanes,params)

SHOW_DISKS = params.showDisksText;
SHOW_CYLINDERS = params.showCylindersText;
DISK_CHANNEL = params.diskFC;
CYLINDER_CHANNEL = params.cylinderFC;
ORIGIN = [6500 6500 0];

NUM_DISK_FLUOROPHORES = 5;

% Always show the first set of kmts
kmtShow2 = params.kmtShow2;
kmtShow3 = params.kmtShow3;

kmtRadius1 = params.kmtRadius1;
kmtRadius2 = params.kmtRadius2;
kmtRadius3 = params.kmtRadius3;

kmtUncertaintySphereRadius1 = params.kmtUncertaintySphereRadius1;
kmtUncertaintySphereRadius2 = params.kmtUncertaintySphereRadius2;
kmtUncertaintySphereRadius3 = params.kmtUncertaintySphereRadius3;


ypos1 = kmtRadius1*cos(t) + ORIGIN(2);
zpos1 = kmtRadius1*sin(t);
ypos2 = kmtRadius2*cos(t) + ORIGIN(2);
zpos2 = kmtRadius2*sin(t);
ypos3 = kmtRadius3*cos(t) + ORIGIN(2);
zpos3 = kmtRadius3*sin(t);

% Perturb ktm positions by random uniform draw from the volume of
% a sphere
lxpos1 = lkMTpos;
lypos1 = ypos1;
lzpos1 = zpos1;
rxpos1 = rkMTpos;
rypos1 = ypos1;
rzpos1 = zpos1;
lxpos2 = lkMTpos;
lypos2 = ypos2;
lzpos2 = zpos2;
rxpos2 = rkMTpos;
rypos2 = ypos2;
rzpos2 = zpos2;
lxpos3 = lkMTpos;
lypos3 = ypos3;
lzpos3 = zpos3;
rxpos3 = rkMTpos;
rypos3 = ypos3;
rzpos3 = zpos3;
for i=1:length(ypos1)
    randSphere = randomPointInSphere(kmtUncertaintySphereRadius1);
    lxpos1(i)  = lxpos1(i) + randSphere(1);
    lypos1(i)  = lypos1(i) + randSphere(2);
    lzpos1(i)  = lzpos1(i) + randSphere(3);

    randSphere = randomPointInSphere(kmtUncertaintySphereRadius1);
    rxpos1(i)  = rxpos1(i) + randSphere(1);
    rypos1(i)  = rypos1(i) + randSphere(2);
    rzpos1(i)  = rzpos1(i) + randSphere(3);

    randSphere = randomPointInSphere(kmtUncertaintySphereRadius2);
    lxpos2(i)  = lxpos2(i) + randSphere(1);
    lypos2(i)  = lypos2(i) + randSphere(2);
    lzpos2(i)  = lzpos2(i) + randSphere(3);

    randSphere = randomPointInSphere(kmtUncertaintySphereRadius2);
    rxpos2(i)  = rxpos2(i) + randSphere(1);
    rypos2(i)  = rypos2(i) + randSphere(2);
    rzpos2(i)  = rzpos2(i) + randSphere(3);
    
    randSphere = randomPointInSphere(kmtUncertaintySphereRadius3);
    lxpos3(i)  = lxpos3(i) + randSphere(1);
    lypos3(i)  = lypos3(i) + randSphere(2);
    lzpos3(i)  = lzpos3(i) + randSphere(3);

    randSphere = randomPointInSphere(kmtUncertaintySphereRadius3);
    rxpos3(i)  = rxpos3(i) + randSphere(1);
    rypos3(i)  = rypos3(i) + randSphere(2);
    rzpos3(i)  = rzpos3(i) + randSphere(3);
end

leftTubelengths  =  lxpos1 - xplanes(1);
rightTubelengths = -rxpos1 + xplanes(2);

docNode = com.mathworks.xml.XMLUtils.createDocument('SimulatedExperiments');
SimulatedExperiments = docNode.getDocumentElement;
%fn = ['C:/users/chris/Desktop/NSRG/Spindle/script/' filename];
%fn = ['C:/user/chris/Desktop/Andrew/' filename];
%fn = ['C:/Users/nanowork/Desktop/Deleteme' filename];
fn = ['/Users/quammen/Desktop/Deleteme' filename];

SimulatedExperiments.setAttribute('file',fn);
SimulatedExperiments.setAttribute('modified',datestr(now));
SimulatedExperiments.setAttribute('created',datestr(now));

product = docNode.createElement('Version');
product.setAttribute('major','2');
product.setAttribute('minor','0');
product.setAttribute('revision','0');
SimulatedExperiments.appendChild(product);

AFMSimulation = docNode.createElement('AFMSimulation');
AFMSimulation.setAttribute('pixelSize','10.00000');
AFMSimulation.setAttribute('imageWidth','300');
AFMSimulation.setAttribute('imageHeight','300');
AFMSimulation.setAttribute('clipGroundPlane','false');
AFMSimulation.setAttribute('displayAsWireframe','false');
AFMSimulation.setAttribute('surfaceOpacity','1.000000');
SimulatedExperiments.appendChild(AFMSimulation);

FSim = docNode.createElement('FluorescenceSimulation');
FSim.setAttribute('focalPlaneIndex','0');
FSim.setAttribute('focalPlaneSpacing','200.000000');
FSim.setAttribute('numberOfFocalPlanes','1');   %%%%%%%  changed for most focused plane
FSim.setAttribute('useCustomFocalPlanePositions','false');
FSim.setAttribute('gain','0.01961378');
FSim.setAttribute('offset','0.000000');
FSim.setAttribute('pixelSize','65.000000');
FSim.setAttribute('psfName','Compiled Expreimental PSF 16bit.tif'); %%%%% FIX THIS TO TAKE THE RIGHT PSF %%%%
%FSim.setAttribute('psfName','None');
FSim.setAttribute('imageWidth','200');
FSim.setAttribute('imageHeight','200');
FSim.setAttribute('shearInX','0.000000');
FSim.setAttribute('shearInY','0.000000');
FSim.setAttribute('addGaussianNoise','false');
FSim.setAttribute('noiseStdDev','0.000000');
FSim.setAttribute('showImageVolumeOutline','false');
FSim.setAttribute('showRefGrid','false');
FSim.setAttribute('refGridSpacing','50.000000');
FSim.setAttribute('superimposeSimulatedImage','false');
FSim.setAttribute('superimposeComparisonImage','false');
FSim.setAttribute('minimumIntensityLevel','0.000000');
FSim.setAttribute('maximumIntensityLevel','200.000000'); %%changed to 200, gain should scale
%FSim.setAttribute('maximumIntensityLevel','0.00463436311110854'); %it didn't scale, lets see if this works
SimulatedExperiments.appendChild(FSim);

FocalPlanes = docNode.createElement('FocalPlanes');
FSim.appendChild(FocalPlanes);

for i = 0:29
	Plane = docNode.createElement('Plane');
	Plane.setAttribute('index',int2str(i));
	Plane.setAttribute('position','0.000000');
	FocalPlanes.appendChild(Plane);
end

gdfo = docNode.createElement('GradientDescentFluorescenceOptimizer');
FSim.appendChild(gdfo);
gdfoIterations = docNode.createElement('Iterations');
gdfoIterations.setAttribute('value','100');
gdfo.appendChild(gdfoIterations);

dess = docNode.createElement('DerivativeEstimateStepSize');
dess.setAttribute('value','1e-008');
gdfo.appendChild(dess);

ssf = docNode.createElement('StepScaleFactor');
ssf.setAttribute('value','1');
gdfo.appendChild(ssf);

nmfo = docNode.createElement('NelderMeadFluorescenceOptimizer');
FSim.appendChild(nmfo);
maxiter = docNode.createElement('MaximumIterations');
maxiter.setAttribute('value','100');
nmfo.appendChild(maxiter);

pct = docNode.createElement('ParameterConvergenceTolerance');
pct.setAttribute('value','1e-008');
nmfo.appendChild(pct);

pgfo = docNode.createElement('PointsGradientFluorescenceOptimizer');
FSim.appendChild(pgfo);
pgfoStepSize = docNode.createElement('StepSize');
pgfoStepSize.setAttribute('value','1');
pgfo.appendChild(pgfoStepSize);

pgfoIterations = docNode.createElement('Iterations');
pgfoIterations.setAttribute('value','100');
pgfo.appendChild(pgfoIterations);

fcio = docNode.createElement('FluorescenceComparisonImageModelObject');
fcio.setAttribute('name','None');
FSim.appendChild(fcio);

ModelObjectList = docNode.createElement('ModelObjectList');
SimulatedExperiments.appendChild(ModelObjectList);

LPlane = docNode.createElement('DiskModel');
ModelObjectList.appendChild(LPlane);
LName = docNode.createElement('Name');
LPlane.appendChild(LName);
LName.setAttribute('value','LDisk');

lvis = docNode.createElement('Visible');
LPlane.appendChild(lvis);
%lvis.setAttribute('value','true');
lvis.setAttribute('value',SHOW_DISKS);

lposx = docNode.createElement('PositionX');
LPlane.appendChild(lposx);
lposx.setAttribute('value',num2str(xplanes(1)));
lposx.setAttribute('optimize','false');

lposy = docNode.createElement('PositionY');
LPlane.appendChild(lposy);
lposy.setAttribute('value','6500.000000');
lposy.setAttribute('optimize','false');

lposz = docNode.createElement('PositionZ');
LPlane.appendChild(lposz);
lposz.setAttribute('value','0.000000');
lposz.setAttribute('optimize','false');

lRotAngle = docNode.createElement('RotationAngle');
LPlane.appendChild(lRotAngle);
lRotAngle.setAttribute('value','90.000000');
lRotAngle.setAttribute('optimize','false');

lRotVecX = docNode.createElement('RotationVectorX');
LPlane.appendChild(lRotVecX);
lRotVecX.setAttribute('value','0.000000');
lRotVecX.setAttribute('optimize','false');

lRotVecY = docNode.createElement('RotationVectorY');
LPlane.appendChild(lRotVecY);
lRotVecY.setAttribute('value','1.000000');
lRotVecY.setAttribute('optimize','false');

lRotVecZ = docNode.createElement('RotationVectorZ');
LPlane.appendChild(lRotVecZ);
lRotVecZ.setAttribute('value','0.000000');
lRotVecZ.setAttribute('optimize','false');

lRadius = docNode.createElement('Radius');
LPlane.appendChild(lRadius);
lRadius.setAttribute('value',num2str(kmtRadius1));
lRadius.setAttribute('optimize','false');

lsfm = docNode.createElement('SurfaceFluorophoreModel');
LPlane.appendChild(lsfm);
lsfm.setAttribute('enabled','true');
%lsfm.setAttribute('channel','all');
lsfm.setAttribute('channel',DISK_CHANNEL);
lsfm.setAttribute('density','100.000000');
lsfm.setAttribute('numberOfFluorophores',num2str(NUM_DISK_FLUOROPHORES));
lsfm.setAttribute('samplingMode','fixedNumber');
lsfm.setAttribute('samplePattern','singlePoint');
lsfm.setAttribute('numberOfRingFluorophores','2');
lsfm.setAttribute('ringRadius','10.000000');
lsfm.setAttribute('randomizePatternOrientations','false');

%%%%%%%%%%%%%%%%  LPLANE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%  RPLANE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

RPlane = docNode.createElement('DiskModel');
ModelObjectList.appendChild(RPlane);
RName = docNode.createElement('Name');
RPlane.appendChild(RName);
RName.setAttribute('value','RDisk');

rvis = docNode.createElement('Visible');
RPlane.appendChild(rvis);
%rvis.setAttribute('value','true');
rvis.setAttribute('value',SHOW_DISKS);
rposx = docNode.createElement('PositionX');
RPlane.appendChild(rposx);
rposx.setAttribute('value',num2str(xplanes(2)));
rposx.setAttribute('optimize','false');

rposy = docNode.createElement('PositionY');
RPlane.appendChild(rposy);
rposy.setAttribute('value','6500.000000');
rposy.setAttribute('optimize','false');

rposz = docNode.createElement('PositionZ');
RPlane.appendChild(rposz);
rposz.setAttribute('value','0.000000');
rposz.setAttribute('optimize','false');

rRotAngle = docNode.createElement('RotationAngle');
RPlane.appendChild(rRotAngle);
rRotAngle.setAttribute('value','90.000000');
rRotAngle.setAttribute('optimize','false');

rRotVecX = docNode.createElement('RotationVectorX');
RPlane.appendChild(rRotVecX);
rRotVecX.setAttribute('value','0.000000');
rRotVecX.setAttribute('optimize','false');

rRotVecY = docNode.createElement('RotationVectorY');
RPlane.appendChild(rRotVecY);
rRotVecY.setAttribute('value','1.000000');
rRotVecY.setAttribute('optimize','false');

rRotVecZ = docNode.createElement('RotationVectorZ');
RPlane.appendChild(rRotVecZ);
rRotVecZ.setAttribute('value','0.000000');
rRotVecZ.setAttribute('optimize','false');

rRadius = docNode.createElement('Radius');
RPlane.appendChild(rRadius);
rRadius.setAttribute('value',num2str(kmtRadius1));
rRadius.setAttribute('optimize','false');

rsfm = docNode.createElement('SurfaceFluorophoreModel');
RPlane.appendChild(rsfm);
rsfm.setAttribute('enabled','true');
%rsfm.setAttribute('channel','all');
rsfm.setAttribute('channel',DISK_CHANNEL);
rsfm.setAttribute('density','100.000000');
rsfm.setAttribute('numberOfFluorophores',num2str(NUM_DISK_FLUOROPHORES));
rsfm.setAttribute('samplingMode','fixedNumber');
rsfm.setAttribute('samplePattern','singlePoint');
rsfm.setAttribute('numberOfRingFluorophores','2');
rsfm.setAttribute('ringRadius','10.000000');
rsfm.setAttribute('randomizePatternOrientations','false');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RPlane

%%%%%%%%%%%%%%%%%%%%% make points to represent the kMT positions %%%%%%%%%%%%%%%%
initialize_points(docNode, ModelObjectList, 'lkMT1', lxpos1, lypos1, lzpos1, params);
initialize_points(docNode, ModelObjectList, 'rkMT1', rxpos1, rypos1, rzpos1, params);

if kmtShow2
    initialize_points(docNode, ModelObjectList, 'lkMT2', lxpos2, lypos2, lzpos2, params);
    initialize_points(docNode, ModelObjectList, 'rkMT2', rxpos2, rypos2, rzpos2, params);
end

if kmtShow3
    initialize_points(docNode, ModelObjectList, 'lkMT3', lxpos3, lypos3, lzpos3, params);
    initialize_points(docNode, ModelObjectList, 'rkMT3', rxpos3, rypos3, rzpos3, params);
end

%%%%%%%%%%%%%%%%%% make the tubules %%%%%%%%%%%%%%%%%%%%%%%%%%
% These aren't currently needed and serve only to slow down  %
% loading of the files.                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:(numel(rxpos1))
	rtube = docNode.createElement('CylinderModel');
	ModelObjectList.appendChild(rtube);

	rtubeName = docNode.createElement('Name');
	rtube.appendChild(rtubeName);
	rtubeName.setAttribute('value',['RTubule - ' num2str(i)]);

	rtubeVis = docNode.createElement('Visible');
	rtube.appendChild(rtubeVis);
	%rtubeVis.setAttribute('value','true');
	rtubeVis.setAttribute('value',SHOW_CYLINDERS);

	rtubePosX = docNode.createElement('PositionX');
	rtube.appendChild(rtubePosX);
	%rtubePosX.setAttribute('value',num2str(xplanes(2)));
	x = xplanes(2) - (rightTubelengths(i)/2);
	rtubePosX.setAttribute('value', num2str(x) );
	rtubePosX.setAttribute('optimize','false');

	rtubePosY = docNode.createElement('PositionY');
	rtube.appendChild(rtubePosY);
	y = rypos1(i);
	rtubePosY.setAttribute('value',num2str(y));
	rtubePosY.setAttribute('optimize','false');

	rtubePosZ = docNode.createElement('PositionZ');
	rtube.appendChild(rtubePosZ);
	z = rzpos1(i);
	rtubePosZ.setAttribute('value',num2str(z));
	rtubePosZ.setAttribute('optimize','false');

	rtubeRotAngle = docNode.createElement('RotationAngle');
	rtube.appendChild(rtubeRotAngle);
	rtubeRotAngle.setAttribute('value','90.000000');
	rtubeRotAngle.setAttribute('optimize','false');

	rtubeRotVecX = docNode.createElement('RotationVectorX');
	rtube.appendChild(rtubeRotVecX);
	rtubeRotVecX.setAttribute('value','0.000000');
	rtubeRotVecX.setAttribute('optimize','false');

	rtubeRotVecY = docNode.createElement('RotationVectorY');
	rtube.appendChild(rtubeRotVecY);
	rtubeRotVecY.setAttribute('value','0.000000');
	rtubeRotVecY.setAttribute('optimize','false');

	rtubeRotVecZ = docNode.createElement('RotationVectorZ');
	rtube.appendChild(rtubeRotVecZ);
	rtubeRotVecZ.setAttribute('value','1.000000');
	rtubeRotVecZ.setAttribute('optmize','false');

	rtubeRadius = docNode.createElement('Radius');
	rtube.appendChild(rtubeRadius);
	rtubeRadius.setAttribute('value','5.000000');
	rtubeRadius.setAttribute('optimize','false');

	rtubeLength = docNode.createElement('Length');
	rtube.appendChild(rtubeLength);
	rtubeLength.setAttribute('value',num2str( rightTubelengths(i) ));
	rtubeLength.setAttribute('optimize','false');


	rtubeSFM = docNode.createElement('SurfaceFluorophoreModel');
	rtube.appendChild(rtubeSFM);
	rtubeSFM.setAttribute('enabled','true');
	%rtubeSFM.setAttribute('channel','all');
	rtubeSFM.setAttribute('channel',CYLINDER_CHANNEL);
	rtubeSFM.setAttribute('density','100.000000');
	rtubeSFM.setAttribute('numberOfFluorophores','0');
	rtubeSFM.setAttribute('samplingMode','fixedDensity');
	rtubeSFM.setAttribute('samplePattern','singlePoint');
	rtubeSFM.setAttribute('numberOfRingFluorophores','2');
	rtubeSFM.setAttribute('ringRadius','10.000000');
	rtubeSFM.setAttribute('randomizePatternOrientations','false');

	rtubeVFM = docNode.createElement('VolumeFluorophoreModel');
	rtube.appendChild(rtubeVFM);
	rtubeVFM.setAttribute('enabled','true');
	%rtubeVFM.setAttribute('channel','all');
	rtubeVFM.setAttribute('channel',CYLINDER_CHANNEL);
	rtubeVFM.setAttribute('density','100.000000');
	rtubeVFM.setAttribute('numberOfFluorophores','0');
	rtubeVFM.setAttribute('samplingMode','fixedDensity');
	rtubeVFM.setAttribute('samplePattern','singlePoint');
	rtubeVFM.setAttribute('numberOfRingFluorophores','2');
	rtubeVFM.setAttribute('ringRadius','10.000000');
	rtubeVFM.setAttribute('randomizePatternOrientations','false');

    rtubeGFM = docNode.createElement('GridFluorophoreModel');
    rtube.appendChild(rtubeGFM);
    rtubeGFM.setAttribute('enabled','false');
    rtubeGFM.setAttribute('channel','all');
	rtubeGFM.setAttribute('intensity','1.0');
    rtubeGFM.setAttribute('spacing','50.0');
end


for i = 1:(numel(lxpos1))
	ltube = docNode.createElement('CylinderModel');
	ModelObjectList.appendChild(ltube);

	ltubeName = docNode.createElement('Name');
	ltube.appendChild(ltubeName);
	ltubeName.setAttribute('value',['LTubule - ' num2str(i)]);

	ltubeVis = docNode.createElement('Visible');
	ltube.appendChild(ltubeVis);
	%ltubeVis.setAttribute('value','true');
	ltubeVis.setAttribute('value',SHOW_CYLINDERS);

	ltubePosX = docNode.createElement('PositionX');
	ltube.appendChild(ltubePosX);
	%ltubePosX.setAttribute('value',num2str(xplanes(1)));
	x = xplanes(1) + (leftTubelengths(i)/2);
	ltubePosX.setAttribute('value',num2str(x));
	ltubePosX.setAttribute('optimize','false');

	ltubePosY = docNode.createElement('PositionY');
	ltube.appendChild(ltubePosY);
	y = lypos1(i);
	ltubePosY.setAttribute('value',num2str(y));
	ltubePosY.setAttribute('optimize','false');

	ltubePosZ = docNode.createElement('PositionZ');
	ltube.appendChild(ltubePosZ);
	z = lzpos1(i);
	ltubePosZ.setAttribute('value',num2str(z));
	ltubePosZ.setAttribute('optimize','false');

	ltubeRotAngle = docNode.createElement('RotationAngle');
	ltube.appendChild(ltubeRotAngle);
	ltubeRotAngle.setAttribute('value','90.000000');
	ltubeRotAngle.setAttribute('optimize','false');

	ltubeRotVecX = docNode.createElement('RotationVectorX');
	ltube.appendChild(ltubeRotVecX);
	ltubeRotVecX.setAttribute('value','0.000000');
	ltubeRotVecX.setAttribute('optimize','false');

	ltubeRotVecY = docNode.createElement('RotationVectorY');
	ltube.appendChild(ltubeRotVecY);
	ltubeRotVecY.setAttribute('value','0.000000');
	ltubeRotVecY.setAttribute('optimize','false');

	ltubeRotVecZ = docNode.createElement('RotationVectorZ');
	ltube.appendChild(ltubeRotVecZ);
	ltubeRotVecZ.setAttribute('value','1.000000');
	ltubeRotVecZ.setAttribute('optmize','false');

	ltubeRadius = docNode.createElement('Radius');
	ltube.appendChild(ltubeRadius);
	ltubeRadius.setAttribute('value','5.000000');
	ltubeRadius.setAttribute('optimize','false');

	ltubeLength = docNode.createElement('Length');
	ltube.appendChild(ltubeLength);
	ltubeLength.setAttribute('value',num2str( leftTubelengths(i) ));
	ltubeLength.setAttribute('optimize','false');

	ltubeSFM = docNode.createElement('SurfaceFluorophoreModel');
	ltube.appendChild(ltubeSFM);
	ltubeSFM.setAttribute('enabled','true');
	%ltubeSFM.setAttribute('channel','all');
	ltubeSFM.setAttribute('channel',CYLINDER_CHANNEL);
	ltubeSFM.setAttribute('density','100.000000');
	ltubeSFM.setAttribute('numberOfFluorophores','0');
	ltubeSFM.setAttribute('samplingMode','fixedDensity');
	ltubeSFM.setAttribute('samplePattern','singlePoint');
	ltubeSFM.setAttribute('numberOfRingFluorophores','2');
	ltubeSFM.setAttribute('ringRadius','10.000000');
	ltubeSFM.setAttribute('randomizePatternOrientations','false');

	ltubeVFM = docNode.createElement('VolumeFluorophoreModel');
	ltube.appendChild(ltubeVFM);
	ltubeVFM.setAttribute('enabled','true');
	%ltubeVFM.setAttribute('channel','all');
	ltubeVFM.setAttribute('channel',CYLINDER_CHANNEL);
	ltubeVFM.setAttribute('density','100.000000');
	ltubeVFM.setAttribute('numberOfFluorophores','0');
	ltubeVFM.setAttribute('samplingMode','fixedDensity');
	ltubeVFM.setAttribute('samplePattern','singlePoint');
	ltubeVFM.setAttribute('numberOfRingFluorophores','2');
	ltubeVFM.setAttribute('ringRadius','10.000000');
	ltubeVFM.setAttribute('randomizePatternOrientations','false');

	ltubeGFM = docNode.createElement('GridFluorophoreModel');
    ltube.appendChild(ltubeGFM);
    ltubeGFM.setAttribute('enabled','false');
    ltubeGFM.setAttribute('channel','all');
	ltubeGFM.setAttribute('intensity','1.0');
    ltubeGFM.setAttribute('spacing','50.0');
end


xmlwrite(filename,docNode);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Take this out once the regexp is not necessary (Cory's fix should take care of it) %%%%%%%%

apos = '''';

%removeNewline = unix(['sed -i ' apos ':a;N;$!ba;s/\n//g' apos ' ' filename]);

%sed -i 's/>[ \t]*</></g' sedtest.xml 

%removeSpaces = unix(['sed -i ' apos 's/>[ \t]*</></g' apos ' ' filename]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

