
module roundedBox(w=10, h=10, d=10, r=2){
    translate([-(w-2*r)/2,-(h-2*r)/2,0]) {
        minkowski(){
            cylinder(r,r,r);
            cube([w-2*r, h-2*r, d-r]);
        }
    }
}

module baseplate(baseWidth=20, holeSpacing=6, baseThickness=5, roundRadius=2){
    difference(){
        roundedBox(baseWidth,holeSpacing+baseWidth,baseThickness,roundRadius);
        union(){
            translate([0,holeSpacing/2,-2]) cylinder(baseThickness*2,clearanceHole/2,clearanceHole/2);
            translate([0,-holeSpacing/2,-2]) cylinder(baseThickness*2,clearanceHole/2,clearanceHole/2);
        }
    }
}



$fn = 50;
// ----- Parameters (all in mm) -----
holeSpacing = 25; // standard metric Thorlabs optical table
clearanceHole = 6.6; // for M6 screws
baseWidth = 20;
baseThickness = 5;
pilarThickness = 12;
pilarHeight = 100;
roundRadius = 1; // smoothes the angles
boardThickness = 4.76; // thickness of the cardboard/plastic board to be used
slotDepth = 8;

difference(){
    union(){
        baseplate(baseWidth, holeSpacing, baseThickness, roundRadius);
        roundedBox(baseWidth,pilarThickness,pilarHeight, roundRadius);
        }
    union(){
        translate([baseWidth/2,0,-2]) roundedBox(2*slotDepth, boardThickness+0.5,pilarHeight+4,roundRadius);
        translate([-baseWidth/2,0,-2]) roundedBox(2*slotDepth, boardThickness+0.5,pilarHeight+4,roundRadius);
        }
}