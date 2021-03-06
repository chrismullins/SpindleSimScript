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
function [] = initialize(filename,ypos,zpos, lkMTpos, rkMTpos,xplanes,radius)

leftTubelengths = lkMTpos - xplanes(1);
rightTubelengths = -rkMTpos + xplanes(2);

docNode = com.mathworks.xml.XMLUtils.createDocument('SimulatedExperiments');
SimulatedExperiments = docNode.getDocumentElement;
fn = ['C:/users/chris/Desktop/NSRG/Spindle/script/' filename];
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
FSim.setAttribute('gain','1');
FSim.setAttribute('offset','0.000000');
FSim.setAttribute('pixelSize','65.000000');
%FSim.setAttribute('psfName','C:/users/chris/Desktop/NSRG/Spindle/script/rescaled_bloom_psf.tif'); %%%%% FIX THIS TO TAKE THE RIGHT PSF %%%%
FSim.setAttribute('psfName','None');
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
FSim.setAttribute('maximumIntensityLevel','4095.000000');
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
lvis.setAttribute('value','true');

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
lRadius.setAttribute('value',num2str(radius));
lRadius.setAttribute('optimize','false');

lsfm = docNode.createElement('SurfaceFluorophoreModel');
LPlane.appendChild(lsfm);
lsfm.setAttribute('enabled','true');
lsfm.setAttribute('channel','all');
lsfm.setAttribute('density','100.000000');
lsfm.setAttribute('numberOfFluorophores','0');
lsfm.setAttribute('samplingMode','fixedDensity');
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
rvis.setAttribute('value','true');

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
rRadius.setAttribute('value',num2str(radius));
rRadius.setAttribute('optimize','false');

rsfm = docNode.createElement('SurfaceFluorophoreModel');
RPlane.appendChild(rsfm);
rsfm.setAttribute('enabled','true');
rsfm.setAttribute('channel','all');
rsfm.setAttribute('density','100.000000');
rsfm.setAttribute('numberOfFluorophores','0');
rsfm.setAttribute('samplingMode','fixedDensity');
rsfm.setAttribute('samplePattern','singlePoint');
rsfm.setAttribute('numberOfRingFluorophores','2');
rsfm.setAttribute('ringRadius','10.000000');
rsfm.setAttribute('randomizePatternOrientations','false');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RPlane

%%%%%%%%%%%%%%%%%%%%% make spheres %%%%%%%%%%%%%%%

for i = 1:(numel(lkMTpos))
	lkMT = docNode.createElement('SphereModel');
	ModelObjectList.appendChild(lkMT);
	lname = docNode.createElement('Name');
	lkMT.appendChild(lname);
	lname.setAttribute('value',['lkMT - ' int2str(i)]);
	
	lvis = docNode.createElement('Visible');
	lkMT.appendChild(lvis);
	lvis.setAttribute('value','true');
	
	lscan = docNode.createElement('Scannable');
	lkMT.appendChild(lscan);
	lscan.setAttribute('value','true');

	lposx = docNode.createElement('PositionX');
	lkMT.appendChild(lposx);
	lposx.setAttribute('value',num2str(lkMTpos(i)));
	lposx.setAttribute('optimize','false');

	lposy = docNode.createElement('PositionY');
	lkMT.appendChild(lposy);
	lposy.setAttribute('value',num2str(ypos(i)));
	lposy.setAttribute('optimize','false');

	lposz = docNode.createElement('PositionZ');
	lkMT.appendChild(lposz);
	lposz.setAttribute('value',num2str(zpos(i)));
	lposz.setAttribute('optimize','false');

	lradius = docNode.createElement('Radius');
	lkMT.appendChild(lradius);
	lradius.setAttribute('value','10.000000');
	lradius.setAttribute('optimize','false');
end


for i = 1:(numel(rkMTpos))
	rkMT = docNode.createElement('SphereModel');
	ModelObjectList.appendChild(rkMT);
	rname = docNode.createElement('Name');
	rkMT.appendChild(rname);
	rname.setAttribute('value',['rkMT - ' int2str(i)]);
	
	rvis = docNode.createElement('Visible');
	rkMT.appendChild(rvis);
	rvis.setAttribute('value','true');
	
	rscan = docNode.createElement('Scannable');
	rkMT.appendChild(rscan);
	rscan.setAttribute('value','true');

	rposx = docNode.createElement('PositionX');
	rkMT.appendChild(rposx);
	rposx.setAttribute('value',num2str(rkMTpos(i)));
	rposx.setAttribute('optimize','false');

	rposy = docNode.createElement('PositionY');
	rkMT.appendChild(rposy);
	rposy.setAttribute('value',num2str(ypos(i)));
	rposy.setAttribute('optimize','false');

	rposz = docNode.createElement('PositionZ');
	rkMT.appendChild(rposz);
	rposz.setAttribute('value',num2str(zpos(i)));
	rposz.setAttribute('optimize','false');

	rradius = docNode.createElement('Radius');
	rkMT.appendChild(rradius);
	rradius.setAttribute('value','10.000000');
	rradius.setAttribute('optimize','false');
end

%%%%%%%%%%%%%%%%%% make the tubules %%%%%%%%%%%%%%%%%%%%%%%%%5

for i = 1:(numel(rkMTpos))
	rtube = docNode.createElement('FlexibleTubeModel');
	ModelObjectList.appendChild(rtube);
	
	rtubeName = docNode.createElement('Name');
	rtube.appendChild(rtubeName);
	rtubeName.setAttribute('value',['RTubule - ' num2str(i)]);

	rtubeVis = docNode.createElement('Visible');
	rtube.appendChild(rtubeVis);
	rtubeVis.setAttribute('value','true');

	rtubePosX = docNode.createElement('PositionX');
	rtube.appendChild(rtubePosX);
	rtubePosX.setAttribute('value',num2str(xplanes(2)));
	rtubePosX.setAttribute('optimize','false');
	
	rtubePosY = docNode.createElement('PositionY');
	rtube.appendChild(rtubePosY);
	rtubePosY.setAttribute('value',num2str(ypos(i)));
	rtubePosY.setAttribute('optimize','false');

	rtubePosZ = docNode.createElement('PositionZ');
	rtube.appendChild(rtubePosZ);
	rtubePosZ.setAttribute('value',num2str(zpos(i)));
	rtubePosZ.setAttribute('optimize','false');

	rtubeRotAngle = docNode.createElement('RotationAngle');
	rtube.appendChild(rtubeRotAngle);
	rtubeRotAngle.setAttribute('value','0.000000');
	rtubeRotAngle.setAttribute('optimize','false');

	rtubeRotVecX = docNode.createElement('RotationVectorX');
	rtube.appendChild(rtubeRotVecX);
	rtubeRotVecX.setAttribute('value','1.000000');
	rtubeRotVecX.setAttribute('optimize','false');

	rtubeRotVecY = docNode.createElement('RotationVectorY');
	rtube.appendChild(rtubeRotVecY);
	rtubeRotVecY.setAttribute('value','0.000000');
	rtubeRotVecY.setAttribute('optimize','false');

	rtubeRotVecZ = docNode.createElement('RotationVectorZ');
	rtube.appendChild(rtubeRotVecZ);
	rtubeRotVecZ.setAttribute('value','0.000000');
	rtubeRotVecZ.setAttribute('optmize','false');

	rtubeRadius = docNode.createElement('Radius');
	rtube.appendChild(rtubeRadius);
	rtubeRadius.setAttribute('value','5.000000');
	rtubeRadius.setAttribute('optimize','false');
	
	rtubeNoP = docNode.createElement('NumberofPoints');
	rtube.appendChild(rtubeNoP);
	rtubeNoP.setAttribute('value','2');

	rtubeSFM = docNode.createElement('SurfaceFluorophoreModel');
	rtube.appendChild(rtubeSFM);
	rtubeSFM.setAttribute('enabled','true');
	rtubeSFM.setAttribute('channel','all');
	rtubeSFM.setAttribute('density','100.000000');
	rtubeSFM.setAttribute('numberOfFluorophores','0');
	rtubeSFM.setAttribute('samplingMode','fixedDensity');
	rtubeSFM.setAttribute('samplePattern','singlePoint');
	rtubeSFM.setAttribute('numberOfRingFluorophores','2');
	rtubeSFM.setAttribute('ringRadius','10.000000');
	rtubeSFM.setAttribute('randomizePatternOrientations','false');

	rtubeVFM = docNode.createElement('VolumeFluorophoreMode');
	rtube.appendChild(rtubeVFM);
	rtubeVFM.setAttribute('enabled','true');
	rtubeVFM.setAttribute('channel','all');
	rtubeVFM.setAttribute('density','100.000000');
	rtubeVFM.setAttribute('numberOfFluorophores','0');
	rtubeVFM.setAttribute('samplingMode','fixedDensity');
	rtubeVFM.setAttribute('samplePattern','singlePoint');
	rtubeVFM.setAttribute('numberOfRingFluorophores','2');
	rtubeVFM.setAttribute('ringRadius','10.000000');
	rtubeVFM.setAttribute('randomizePatternOrientations','false');

	rtubeX1 = docNode.createElement('X1');
	rtube.appendChild(rtubeX1);
	rtubeX1.setAttribute('value',num2str(-1*rightTubelengths(i)));
	rtubeX1.setAttribute('optimize','false');
	
	rtubeY1 = docNode.createElement('Y1');
	rtube.appendChild(rtubeY1);
	rtubeY1.setAttribute('value','0.000000');
	rtubeY1.setAttribute('optimize','false');
	
	rtubeZ1 = docNode.createElement('Z1');
	rtube.appendChild(rtubeZ1);
	rtubeZ1.setAttribute('value','0.000000');
	rtubeZ1.setAttribute('optimize','false');
	
	rtubeX2 = docNode.createElement('X2');
	rtube.appendChild(rtubeX2);
	rtubeX2.setAttribute('value','0.000000');
	rtubeX2.setAttribute('optimize','false');
	
	rtubeY2 = docNode.createElement('Y2');
	rtube.appendChild(rtubeY2);
	rtubeY2.setAttribute('value','0.000000');
	rtubeY2.setAttribute('optimize','false');

	rtubeZ2 = docNode.createElement('Z2');
	rtube.appendChild(rtubeZ2);
	rtubeZ2.setAttribute('value','0.000000');
	rtubeZ2.setAttribute('optimize','false');
end


for i = 1:(numel(lkMTpos))
	ltube = docNode.createElement('FlexibleTubeModel');
	ModelObjectList.appendChild(ltube);
	
	ltubeName = docNode.createElement('Name');
	ltube.appendChild(ltubeName);
	ltubeName.setAttribute('value',['LTubule - ' num2str(i)]);

	ltubeVis = docNode.createElement('Visible');
	ltube.appendChild(ltubeVis);
	ltubeVis.setAttribute('value','true');

	ltubePosX = docNode.createElement('PositionX');
	ltube.appendChild(ltubePosX);
	ltubePosX.setAttribute('value',num2str(xplanes(1)));
	ltubePosX.setAttribute('optimize','false');
	
	ltubePosY = docNode.createElement('PositionY');
	ltube.appendChild(ltubePosY);
	ltubePosY.setAttribute('value',num2str(ypos(i)));
	ltubePosY.setAttribute('optimize','false');

	ltubePosZ = docNode.createElement('PositionZ');
	ltube.appendChild(ltubePosZ);
	ltubePosZ.setAttribute('value',num2str(zpos(i)));
	ltubePosZ.setAttribute('optimize','false');

	ltubeRotAngle = docNode.createElement('RotationAngle');
	ltube.appendChild(ltubeRotAngle);
	ltubeRotAngle.setAttribute('value','0.000000');
	ltubeRotAngle.setAttribute('optimize','false');

	ltubeRotVecX = docNode.createElement('RotationVectorX');
	ltube.appendChild(ltubeRotVecX);
	ltubeRotVecX.setAttribute('value','1.000000');
	ltubeRotVecX.setAttribute('optimize','false');

	ltubeRotVecY = docNode.createElement('RotationVectorY');
	ltube.appendChild(ltubeRotVecY);
	ltubeRotVecY.setAttribute('value','0.000000');
	ltubeRotVecY.setAttribute('optimize','false');

	ltubeRotVecZ = docNode.createElement('RotationVectorZ');
	ltube.appendChild(ltubeRotVecZ);
	ltubeRotVecZ.setAttribute('value','0.000000');
	ltubeRotVecZ.setAttribute('optmize','false');

	ltubeRadius = docNode.createElement('Radius');
	ltube.appendChild(ltubeRadius);
	ltubeRadius.setAttribute('value','5.000000');
	ltubeRadius.setAttribute('optimize','false');
	
	ltubeNoP = docNode.createElement('NumberofPoints');
	ltube.appendChild(ltubeNoP);
	ltubeNoP.setAttribute('value','2');

	ltubeSFM = docNode.createElement('SurfaceFluorophoreModel');
	ltube.appendChild(ltubeSFM);
	ltubeSFM.setAttribute('enabled','true');
	ltubeSFM.setAttribute('channel','all');
	ltubeSFM.setAttribute('density','100.000000');
	ltubeSFM.setAttribute('numberOfFluorophores','0');
	ltubeSFM.setAttribute('samplingMode','fixedDensity');
	ltubeSFM.setAttribute('samplePattern','singlePoint');
	ltubeSFM.setAttribute('numberOfRingFluorophores','2');
	ltubeSFM.setAttribute('ringRadius','10.000000');
	ltubeSFM.setAttribute('randomizePatternOrientations','false');

	ltubeVFM = docNode.createElement('VolumeFluorophoreMode');
	ltube.appendChild(ltubeVFM);
	ltubeVFM.setAttribute('enabled','true');
	ltubeVFM.setAttribute('channel','all');
	ltubeVFM.setAttribute('density','100.000000');
	ltubeVFM.setAttribute('numberOfFluorophores','0');
	ltubeVFM.setAttribute('samplingMode','fixedDensity');
	ltubeVFM.setAttribute('samplePattern','singlePoint');
	ltubeVFM.setAttribute('numberOfRingFluorophores','2');
	ltubeVFM.setAttribute('ringRadius','10.000000');
	ltubeVFM.setAttribute('randomizePatternOrientations','false');

	ltubeX1 = docNode.createElement('X1');
	ltube.appendChild(ltubeX1);
	ltubeX1.setAttribute('value','0.000000');
	ltubeX1.setAttribute('optimize','false');
	
	ltubeY1 = docNode.createElement('Y1');
	ltube.appendChild(ltubeY1);
	ltubeY1.setAttribute('value','0.000000');
	ltubeY1.setAttribute('optimize','false');
	
	ltubeZ1 = docNode.createElement('Z1');
	ltube.appendChild(ltubeZ1);
	ltubeZ1.setAttribute('value','0.000000');
	ltubeZ1.setAttribute('optimize','false');
	
	ltubeX2 = docNode.createElement('X2');
	ltube.appendChild(ltubeX2);
	ltubeX2.setAttribute('value',num2str(leftTubelengths(i)));
	ltubeX2.setAttribute('optimize','false');
	
	ltubeY2 = docNode.createElement('Y2');
	ltube.appendChild(ltubeY2);
	ltubeY2.setAttribute('value','0.000000');
	ltubeY2.setAttribute('optimize','false');

	ltubeZ2 = docNode.createElement('Z2');
	ltube.appendChild(ltubeZ2);
	ltubeZ2.setAttribute('value','0.000000');
	ltubeZ2.setAttribute('optimize','false');
end
	

	
	





xmlwrite(filename,docNode);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Take this out once the regexp is not necessary (Cory's fix should take care of it) %%%%%%%%

apos = '''';

removeNewline = unix(['sed -i ' apos ':a;N;$!ba;s/\n//g' apos ' ' filename]);

%sed -i 's/>[ \t]*</></g' sedtest.xml 

removeSpaces = unix(['sed -i ' apos 's/>[ \t]*</></g' apos ' ' filename]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

