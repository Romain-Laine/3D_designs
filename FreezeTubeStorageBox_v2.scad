module roundedBox(w=10, h=10, d=10, r=2){
    translate([-(w-2*r)/2,-(h-2*r)/2,r]) {
        minkowski(){
            sphere(r);
            cube([w-2*r, h-2*r, d-2*r]);
        }
    }
}


// ----- Parameters (all in mm) -----
boxWidth = 122; 
boxLength = 122;
minSPacingBetweenHoles = 0.5;

boxHeight = 18;
holeDiameter = 12.8;
holeDepth = 11;

roundRadius = 1; // smoothes the edges of the box
edgeWidth = 3; // space between the edge of the hole and the edge of the box
// ----- -----

$fn = 100;
nWidth = floor((boxWidth - 2*edgeWidth - holeDiameter)/(holeDiameter+minSPacingBetweenHoles))+1;
spacingWidth = (boxWidth - 2*edgeWidth - holeDiameter)/(nWidth-1);

startPositionWidth = -(spacingWidth/2 + (nWidth/2-1)*spacingWidth); // if even numbers of holes
if ((nWidth-2*floor(nWidth/2)) > 0) {startPositionWidth = (n-1)/2*spacingWidth;} // if odd


nLength = floor((boxLength - 2*edgeWidth - holeDiameter)/(holeDiameter+minSPacingBetweenHoles))+1;
spacingLength = (boxLength - 2*edgeWidth - holeDiameter)/(nLength-1);

startPositionLength = -(spacingLength/2 + (nLength/2-1)*spacingLength); // if even numbers of holes
if ((nLength-2*floor(nLength/2)) > 0) {startPositionLength = (n-1)/2*spacingLength;} // if odd

difference(){
    roundedBox(boxWidth, boxLength, boxHeight, roundRadius);
    union(){
        for (i = [0:1:(nWidth-1)]){
            for (j = [0:1:(nLength-1)]){
                translate([startPositionWidth + i*spacingWidth, startPositionLength + j*spacingLength, boxHeight-holeDepth]) cylinder(boxHeight, holeDiameter/2, holeDiameter/2);
            }
        }
    }
}

