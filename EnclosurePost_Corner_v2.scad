
module roundedBox(w=10, h=10, d=10, r=2){
    translate([-(w-2*r)/2,-(h-2*r)/2,0]) {
        minkowski(){
            cylinder(r,r,r);
            cube([w-2*r, h-2*r, d-r]);
        }
    }
}

module baseplate(baseWidth=20, holeSpacing=6, baseThickness=5, roundRadius=2){
    translate([0,holeSpacing/2,0]){
        difference(){
            roundedBox(baseWidth,holeSpacing+baseWidth,baseThickness,roundRadius);
            union(){
                translate([0,holeSpacing/2,-2]) cylinder(baseThickness*2,clearanceHole/2,clearanceHole/2);
                }
            }
    }
}


$fn = 50;
// ----- Parameters (all in mm) -----
holeSpacing = 25; // standard metric Thorlabs optical table
clearanceHole = 6.6; // for M6 screws
baseWidth = 20;
baseThickness = 5;
pilarWidth = 12*sqrt(2);
pilarHeight = 100;
roundRadius = 1;
boardThickness = 4.76; // thickness of the cardboard/plastic board to be used
slotDepth = 5;

difference(){
    union(){
        union(){
            rotate(-45, [0,0,1]) baseplate(baseWidth, sqrt(2)*holeSpacing/2, baseThickness, roundRadius);
            rotate(-225, [0,0,1]) baseplate(baseWidth, sqrt(2)*holeSpacing/2, baseThickness, roundRadius);

        }
        roundedBox(pilarWidth,pilarWidth,pilarHeight, roundRadius);
        }
    union(){
        translate([3*slotDepth/2+pilarWidth/2-slotDepth,0,-2]) roundedBox(3*slotDepth, boardThickness+0.5,pilarHeight+4,roundRadius);
        translate([0,-(3*slotDepth/2+pilarWidth/2-slotDepth),-2]) roundedBox(boardThickness+0.5,3*slotDepth, pilarHeight+4,roundRadius);
        }
}