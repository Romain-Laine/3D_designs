

module roundedBox(w=10, h=10, d=10, r=2){
    translate([-(w-2*r)/2,-(h-2*r)/2,0]) {
        minkowski(){
            cylinder(r,r,r);
            cube([w-2*r, h-2*r, d-r]);
        }
    }
}


$fn = 100;

// ----- Parameters -----
plateWidth = 40.6;
plateBottomThickness = 5.5;
plateTotalThickness = 10;
rodSpacing = 30;
rodRadius = 3.25;
pinOffsetHorizontal = 10.5;
pinOffsetVertical = 12.5;
pinDiameter = 2.2;
//pinHeight = 4.5;
cameraRadius = 3.9;
recessDepth = 2.6;
wireStripWidth = 17;

fixingHoleRadius = 1.25;

// ----- -----
pinHeight = plateTotalThickness-plateBottomThickness;

union(){
difference(){
    // Main box
    roundedBox(plateWidth,plateWidth,plateTotalThickness,5);
union(){
    // Main inner box
    translate([0,0,plateBottomThickness]) roundedBox(rodSpacing+2*rodRadius,rodSpacing+2*rodRadius,plateTotalThickness,rodRadius);
    
    // Holes for the rods
    translate([rodSpacing/2, rodSpacing/2, -2]) cylinder(plateTotalThickness+4, rodRadius, rodRadius);
    translate([rodSpacing/2, -rodSpacing/2, -2]) cylinder(plateTotalThickness+4, rodRadius, rodRadius);
    translate([-rodSpacing/2, rodSpacing/2, -2]) cylinder(plateTotalThickness+4, rodRadius, rodRadius);
    translate([-rodSpacing/2, -rodSpacing/2, -2]) cylinder(plateTotalThickness+4, rodRadius, rodRadius);
    
    // Hole for the cameras
    translate([0,0,-2]) cylinder(plateTotalThickness+4,cameraRadius,cameraRadius);
    
    // Recess for the electronics
    translate([0,0,plateBottomThickness-recessDepth+5]) cube([2*pinOffsetHorizontal-pinDiameter, rodSpacing+2*rodRadius, 10], true);
    
    // Cut for the strip coming out
    translate([0,-rodSpacing/2,plateBottomThickness+10]) cube([wireStripWidth, 20,20],true);
    
    // Holes for holding the rods
    translate([rodSpacing/2,rodSpacing/2,plateBottomThickness/2]) rotate(-90,[1,0,0]) cylinder(10,fixingHoleRadius,fixingHoleRadius);
    
    translate([rodSpacing/2,-rodSpacing/2,plateBottomThickness/2]) rotate(90,[1,0,0]) cylinder(10,fixingHoleRadius,fixingHoleRadius);
    
    translate([-rodSpacing/2,rodSpacing/2,plateBottomThickness/2]) rotate(-90,[1,0,0]) cylinder(10,fixingHoleRadius,fixingHoleRadius);
    
    translate([-rodSpacing/2,-rodSpacing/2,plateBottomThickness/2]) rotate(90,[1,0,0]) cylinder(10,fixingHoleRadius,fixingHoleRadius);
    
    }
}
union(){
    // Pins to hold the chip
    translate([pinOffsetHorizontal, 0, plateBottomThickness]) cylinder(pinHeight, pinDiameter/2, pinDiameter/2);
    translate([pinOffsetHorizontal, pinOffsetVertical, plateBottomThickness]) cylinder(pinHeight, pinDiameter/2, pinDiameter/2);
    translate([-pinOffsetHorizontal, 0, plateBottomThickness]) cylinder(pinHeight, pinDiameter/2, pinDiameter/2);
    translate([-pinOffsetHorizontal, pinOffsetVertical, plateBottomThickness]) cylinder(pinHeight, pinDiameter/2, pinDiameter/2);
    }
}