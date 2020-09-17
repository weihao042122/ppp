ROD_R = 1.5;
ROD_H = 145;
WIND_LEN = 135;
THICKNESS = 2;
PR_OFFSET_Y = 37.5;  //power rod offset of y axis

TAIL_WIDTH = 5;
SCREW_R = 1.2/2;
NUT_H = 2*0.9;             //螺母
NUT_R = 1.8 * 0.95 / 2;    //螺母

    cup_high = 16.4;
    cup_r = 6.8/2;
    cup_thickness=1;
    hole_r = 0.35;

    rod_high = ROD_H;
    rod_r = ROD_R;

    fixingRod_high = 20;
    fixingRod_r = ROD_R+0.5;
    nut_high = NUT_H;
    nut_r = NUT_R;

    // fp for fool-proofing
    fp_size_l = 1;
    fp_size_w = 0.5;
    fp_size_h = 3;
SPACE = 5;

module power_rod() {    
    //motor cup
    difference() {
            cylinder(r=cup_r+cup_thickness, h=cup_high, $fn=200);
            cylinder(r=cup_r, h=cup_high-cup_thickness, $fn=200);
            translate([rod_r+hole_r*2, 0, 0]) {
                cylinder(r=hole_r, h=cup_high, $fn=200);
            }
            translate([-rod_r-hole_r*2, 0, 0]) {
                cylinder(r=hole_r, h=cup_high, $fn=200);
            }
    }
    //rod
    translate([0, 0, cup_high]) {
        cylinder(r=rod_r, h=rod_high, $fn=200);
    }
    //fixing head
    translate([0, 0, cup_high+rod_high]) {
        difference(){
            cylinder(r=fixingRod_r, h=fixingRod_high, $fn=200);
            translate([0, 0, fixingRod_high]) {
                cylinder(r=nut_r, h=nut_high, $fn=200);
            }
        }
        //Foolproof
        translate([-fixingRod_r-0.6, 0, 0]) {
            cube([fp_size_l, fp_size_w, fp_size_h]);
        }
    }
}

module half_ring(){
    difference(){    //ring
        cylinder(r=ROD_R+THICKNESS*0.8, h=THICKNESS, $fn=200, center=true);
        cylinder(r=ROD_R+ROD_R*0.1, h=THICKNESS, $fn=200, center=true);
        translate([-0.7, ROD_R*1.3, 0]) {
            cube(size=[(ROD_R+THICKNESS)*1.7, ROD_R+THICKNESS, ROD_R+THICKNESS], center=true);
        }
    }
}

module wind_rod() {
    cylinder(r=ROD_R, h=WIND_LEN, $fn=200, center=true);
        
    translate([0, ROD_R+(ROD_R+THICKNESS*0.5), -PR_OFFSET_Y]) {
        rotate([90, 0, 90]) half_ring();
    }

    translate([0, ROD_R+(ROD_R+THICKNESS*0.5), PR_OFFSET_Y]) {
        rotate([270, 0, 90]) half_ring();
    }
}

// cube(ROD_R+THICKNESS, center=true);

module Groove_hole(r1, thickness, need_cube = 1) {
    if (need_cube != 0) {
        translate([-r1, 0, 0]) {
           cube(size=[2*r1, r1+thickness, 10]);
        }
    }
    cylinder(r=r1, h=10,$fn=200);
}
//Groove
module Groove_body(r, t) {
    rotate([90, 0, 0]) /*difference()*/ {
        // cylinder(r=r+t, h=TAIL_WIDTH,$fn=200, center=true);
        cube(size=[r*2+t, r*2+t, TAIL_WIDTH], center=true);
        translate([-(r*2+t), (r/2), -TAIL_WIDTH/2])
            cube(size=[r*2+t, (r/2+t/2), TAIL_WIDTH]);
    }
}
module Lib2() {
    difference() {
        translate([-(ROD_R*2+THICKNESS)*1.01, -TAIL_WIDTH/2, THICKNESS/2 ])
            cube(size=[ROD_R*2+THICKNESS+ROD_R, TAIL_WIDTH, (ROD_R)]);
        translate([-(ROD_R*2+THICKNESS)*1.02, -TAIL_WIDTH/2*1.01, 0])
            cube(size=[ROD_R+THICKNESS*1.05, TAIL_WIDTH*1.02, (ROD_R*2+THICKNESS)*2/5]);
        rotate([90, 0, 0]) translate([0, 0, -TAIL_WIDTH]) Groove_hole(ROD_R*1.001, THICKNESS, 0);
    }
}
module prism(x, y, z){
    polyhedron(
        points=[[0,0,0], [x,0,0], [0,y,0], [0,0,z], [x,0,z], [0,y,z]],
        faces=[[5,4,1,2],[5,2,0,3],[0,1,4,3],[3,4,5],[0,2,1]]
        );
} 

module half_tail() {
    difference()
    {
        translate([0, -TAIL_WIDTH, ROD_R+(ROD_R+THICKNESS)]) {
            // Groove_body
            translate([PR_OFFSET_Y, -TAIL_WIDTH/2-SPACE, -THICKNESS/2]) {
                Groove_body(ROD_R, THICKNESS);
            };

            //tail_wind
            translate([0, 0, -(ROD_R+(ROD_R+THICKNESS))]) {
                zRotate = atan2(SPACE+TAIL_WIDTH, PR_OFFSET_Y-THICKNESS);
                yRotate = atan2(ROD_R+THICKNESS, PR_OFFSET_Y-THICKNESS-ROD_R);
                rotate([0, -yRotate, -zRotate]) {
                    cube(size=[PR_OFFSET_Y-THICKNESS*0.3, TAIL_WIDTH, THICKNESS]);
                }
            }
        };
        //Groove_hole
        translate([PR_OFFSET_Y, -TAIL_WIDTH/2-SPACE, ROD_R+(ROD_R+THICKNESS/2)]) {
            rotate([90, 0, 0]) Groove_hole(ROD_R*1.001, THICKNESS);    
        }
        translate([PR_OFFSET_Y, -TAIL_WIDTH-TAIL_WIDTH/2-SPACE, ROD_R+(ROD_R+THICKNESS/2)])
            Lib2();

        // nut hole
        translate([PR_OFFSET_Y-2*ROD_R-THICKNESS/4, -TAIL_WIDTH-TAIL_WIDTH/2-SPACE, ROD_R+(ROD_R+THICKNESS)+1.8/2]) cylinder(r=NUT_R, h=1.8, $fn=200, center=true);
    }

    //mid
    difference(){
        translate([0, -TAIL_WIDTH, -0.6]){
            cube(size=[TAIL_WIDTH*0.6, TAIL_WIDTH, THICKNESS+0.6]);
            translate([0.15, TAIL_WIDTH, 0])
            cube(size=[TAIL_WIDTH*0.6, TAIL_WIDTH*2, 0.6-0.3]);
        }

        rotate([180, 180, 0])
        translate([-0.15-TAIL_WIDTH*0.6, -TAIL_WIDTH*2, -0.6-0.1]) { 
            prism(1.2,2*TAIL_WIDTH,0.6);
        }
        rotate([180, 0, 0])
        translate([0, -TAIL_WIDTH*2, 0]) { 
            prism(1.2,3.5,0.8);
        }

        rotate([0, 0, 0])
        translate([0, 0, -0.7]) { 
            prism(0.5,TAIL_WIDTH*1.8,1);
        }
    }
}
module head_cup() {
    // translate([0, 0, cup_high+rod_high]) {
        //fixing head
        difference(){
            cylinder(r=fixingRod_r+cup_thickness/2, h=fixingRod_high+cup_thickness*0.7, $fn=200);
            cylinder(r=fixingRod_r*1.01, h=fixingRod_high, $fn=200);
                    //Foolproof
            translate([-fixingRod_r-0.6, 0, 0]) {
                cube([fp_size_l, fp_size_w, fp_size_h]);
            }
            translate([0, 0, fixingRod_high+cup_thickness*0.7-1]) {
                cylinder(r=SCREW_R, h=2, $fn=200);
            }
        }
    // }
}

module head() {
    translate([-PR_OFFSET_Y, -25-cup_high-fixingRod_high+cup_high+rod_high, ROD_R+(ROD_R+THICKNESS*0.5)]) rotate([-90, 0, 0]) {
        head_cup();
        toffset = 0.5;
        translate([0, fixingRod_r+0.02, toffset]){
            yRotate = atan2(5+toffset, PR_OFFSET_Y*4/7);
            rotate([0, yRotate, -0])  cube([PR_OFFSET_Y*0.59, 0.6, THICKNESS*2]);
            translate([PR_OFFSET_Y*4/7-0.6, 0, -5-toffset]){
                cube([PR_OFFSET_Y*3/7+0.6, 0.4, THICKNESS*5]);
                rotate([0, 0, 180]) cube([0.6, 7, fixingRod_high]);
            }
        }

        xRotate = atan2(8,PR_OFFSET_Y*4/7-0.6+0.1);
        #translate([0, 0, toffset+THICKNESS*2+1.5]) rotate([0, 0, -xRotate]) cube([PR_OFFSET_Y*4/7-0.6+0.1, 0.6, THICKNESS*2]);
        
        translate([0, 0, toffset+THICKNESS*2+1.5 + THICKNESS*2+1.5]) cube([PR_OFFSET_Y*0.59, 0.6, THICKNESS*2]);

    }
}
// translate([PR_OFFSET_Y-THICKNESS+ROD_R, +ROD_R+THICKNESS-TAIL_WIDTH, ROD_R+(ROD_R+THICKNESS/2)+THICKNESS])
//     Lib2();

// difference(){
//     Groove_body(ROD_R, THICKNESS);
//     translate([0, TAIL_WIDTH, 0]) rotate([90, 0, 0]) Groove_hole(ROD_R*1.001, THICKNESS); 
//     Lib2();
//     // nut hole
//     translate([-2*ROD_R-THICKNESS/5, 0, ROD_R+THICKNESS/2]) cylinder(r=NUT_R, h=2, $fn=200, center=true);
// }
// difference(){
//     translate([0, 0, 2]) Lib2();
//     translate([-2*ROD_R-THICKNESS/5, 0, 0]) cylinder(r=SCREW_R, h=10, $fn=200, center=true);
// }

// half_tail();
// //LIB
// translate([PR_OFFSET_Y, -TAIL_WIDTH-TAIL_WIDTH/2-SPACE, ROD_R+(ROD_R+THICKNESS/2)]) difference(){
//     translate([0, 0, 1]) Lib2();
//     translate([-2*ROD_R-THICKNESS/4, 0, 0]) cylinder(r=SCREW_R, h=10, $fn=200, center=true);
// }


head();
mirror([1, 0, 0])  head();

///////////////////////////////////////////////////////////
if (0) {
    //power rod left
    translate([-PR_OFFSET_Y, -25-cup_high-fixingRod_high, ROD_R+(ROD_R+THICKNESS*0.5)]) {
            rotate([-90, 0, 0]) {
            power_rod();
        }   
    }

    //power rod right
    mirror([1, 0, 0])  translate([-PR_OFFSET_Y, -25-cup_high-fixingRod_high, ROD_R+(ROD_R+THICKNESS*0.5)]) {
            rotate([-90, 0, 0]) {
            power_rod();
        }   
    }

    //wind rod
    translate([0, ROD_H-25-fixingRod_high-5, 0]) {
        rotate([90, 0, 90]) {
            wind_rod();
        }
    }

    //tail
    half_tail();
    mirror([1, 0, 0]){
        half_tail();
    }

    //LIB left
    translate([PR_OFFSET_Y, -TAIL_WIDTH-TAIL_WIDTH/2-SPACE, ROD_R+(ROD_R+THICKNESS/2)]) difference(){
        translate([0, 0, 1.5]) Lib2();
        translate([-2*ROD_R-THICKNESS/4, 0, 0]) cylinder(r=SCREW_R, h=10, $fn=200, center=true);
    }
    //LIB right
    mirror([1, 0, 0]){
        translate([PR_OFFSET_Y, -TAIL_WIDTH-TAIL_WIDTH/2-SPACE, ROD_R+(ROD_R+THICKNESS/2)]) difference(){
            translate([0, 0, 1.5]) Lib2();
            translate([-2*ROD_R-THICKNESS/4, 0, 0]) cylinder(r=SCREW_R, h=10, $fn=200, center=true);
        }
    }  
}