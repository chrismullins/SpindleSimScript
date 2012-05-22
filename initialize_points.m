%%%%%%%%%%%%%%%%%%%%% make points %%%%%%%%%%%%%%%%
function [] = initialize_points( docNode, modelObjectList, name, points, xpos,ypos,zpos, visParams)

SHOW_DISKS = visParams{1};
SHOW_CYLINDERS = visParams{2};
SHOW_SPHERES = visParams{3};
DISK_CHANNEL = visParams{4};
CYLINDER_CHANNEL = visParams{5};
SPHERE_CHANNEL = visParams{6};

lkMT = docNode.createElement('PointSetModel');
modelObjectList.appendChild(lkMT);

lname = docNode.createElement('Name');
lkMT.appendChild(lname);
lname.setAttribute('value',name);

lvis = docNode.createElement('Visible');
lkMT.appendChild(lvis);
lvis.setAttribute('value',SHOW_SPHERES);

lposx = docNode.createElement('PositionX');
lkMT.appendChild(lposx);
lposx.setAttribute('value','0.0');
lposx.setAttribute('optimize','false');

lposy = docNode.createElement('PositionY');
lkMT.appendChild(lposy);
lposy.setAttribute('value','0.0');
lposy.setAttribute('optimize','false');

lposz = docNode.createElement('PositionZ');
lkMT.appendChild(lposz);
lposz.setAttribute('value','0.0');
lposz.setAttribute('optimize','false');

lrotangle = docNode.createElement('RotationAngle');
lkMT.appendChild(lrotangle);
lrotangle.setAttribute('value','0.0');
lrotangle.setAttribute('optimize','false');

lrotx = docNode.createElement('RotationVectorX');
lkMT.appendChild(lrotx);
lrotx.setAttribute('value','1.0');
lrotx.setAttribute('optimize','false');

lroty = docNode.createElement('RotationVectorY');
lkMT.appendChild(lroty);
lroty.setAttribute('value','0.0');
lroty.setAttribute('optimize','false');

lrotz = docNode.createElement('RotationVectorZ');
lkMT.appendChild(lrotz);
lrotz.setAttribute('value','0.0');
lrotz.setAttribute('optimize','false');

lvisradius = docNode.createElement('VisibleRadius');
lkMT.appendChild(lvisradius);
lvisradius.setAttribute('value','10.0');

lnumpoints = docNode.createElement('NumberofPoints');
lkMT.appendChild(lnumpoints);
lnumpoints.setAttribute('value',int2str(numel(xpos)));

lvfm = docNode.createElement('VerticesFluorophoreModel');
lkMT.appendChild(lvfm);
lvfm.setAttribute('optimize','false');
lvfm.setAttribute('intensityScale','1.0');
lvfm.setAttribute('channel',SPHERE_CHANNEL);
lvfm.setAttribute('enabled','true');

for i = 1:(numel(xpos))
    xvertex = docNode.createElement(['X' int2str(i)]);
    lkMT.appendChild(xvertex);
    xvertex.setAttribute('value',num2str(xpos(i)));
    xvertex.setAttribute('optimize','false');
    
    yvertex = docNode.createElement(['Y' int2str(i)]);
    lkMT.appendChild(yvertex);
    yvertex.setAttribute('value',num2str(ypos(i)));
    yvertex.setAttribute('optimize','false');
    
    zvertex = docNode.createElement(['Z' int2str(i)]);
    lkMT.appendChild(zvertex);
    zvertex.setAttribute('value',num2str(zpos(i)));
    zvertex.setAttribute('optimize','false');

end
