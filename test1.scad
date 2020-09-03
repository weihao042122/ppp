ROD_R = 1;
ROD_H = 150;
THICKNESS = 1;
PR_OFFSET_Y = 30;  //power rod offset of y axis

TAIL_WIDTH = 4;

module power_rod() {    
    cup_high = 20;
    cup_r = 8;
    cup_thickness=THICKNESS;
    hole_r = 1;

    rod_high = ROD_H;
    rod_r = ROD_R;

    fixingRod_high = 25;
    fixingRod_r = 3.5;
    nut_high = 2;   //螺母
    nut_r = 1.8;    //螺母

    // fp for fool-proofing
    fp_size_l = 1.5;
    fp_size_w = 0.5;
    fp_size_h = 3;
    //motor cup
    difference() {
            cylinder(r=cup_r, h=cup_high, $fn=200);
            cylinder(r=cup_r-cup_thickness, h=cup_high-cup_thickness, $fn=200);
            translate([hole_r+ROD_R, hole_r+ROD_R, 0]) {
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
        translate([fixingRod_r-0.3, 0, 0]) {
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
    cylinder(r=ROD_R, h=ROD_H, $fn=200, center=true);
        
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
           cube(size=[2*r1, r1+thickness/2, 10]);
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
            cube(size=[r*2+t, (r*2+t)/3, TAIL_WIDTH]);
    }
}
module Lib2() {
    difference() {
        translate([-(ROD_R*2+THICKNESS)*1.01, -TAIL_WIDTH/2, THICKNESS/2 ])
            cube(size=[ROD_R*2+THICKNESS+ROD_R, TAIL_WIDTH, (ROD_R*2+THICKNESS)/3]);
        translate([-(ROD_R*2+THICKNESS)*1.02, -TAIL_WIDTH/2*1.01, 0])
            cube(size=[ROD_R+THICKNESS*1.05, TAIL_WIDTH*1.02, (ROD_R*2+THICKNESS)*2/5]);
        rotate([90, 0, 0]) translate([0, 0, -TAIL_WIDTH]) Groove_hole(ROD_R*1.001, THICKNESS, 0);
    }
}
module half_tail() {
    difference()
    {
        translate([0, TAIL_WIDTH, ROD_R+(ROD_R+THICKNESS)]) {
            translate([PR_OFFSET_Y-THICKNESS+ROD_R, -ROD_R-THICKNESS-TAIL_WIDTH, -THICKNESS/2]) {
                Groove_body(ROD_R, THICKNESS);
            };

            //tail_wind
            translate([0, -TAIL_WIDTH, -(ROD_R+(ROD_R+THICKNESS))]) {
                zRotate = atan2(TAIL_WIDTH, PR_OFFSET_Y+ROD_R);
                yRotate = atan2(ROD_R+(ROD_R+THICKNESS), PR_OFFSET_Y+ROD_R);
                rotate([0, -yRotate, -zRotate]) {
                    cube(size=[PR_OFFSET_Y+ROD_R, TAIL_WIDTH, THICKNESS]);
                }
            }    
        };
        
        translate([PR_OFFSET_Y-THICKNESS+ROD_R, 10/2, ROD_R+(ROD_R+THICKNESS/2)]) {
            rotate([90, 0, 0]) Groove_hole(ROD_R*1.001, THICKNESS);    
        }
        translate([PR_OFFSET_Y-THICKNESS+ROD_R, +ROD_R+THICKNESS-TAIL_WIDTH, ROD_R+(ROD_R+THICKNESS/2)])
            Lib2();

    }
}

// half_tail();
// translate([PR_OFFSET_Y-THICKNESS+ROD_R, +ROD_R+THICKNESS-TAIL_WIDTH, ROD_R+(ROD_R+THICKNESS/2)+THICKNESS])
//     Lib2();

// difference(){
//     Groove_body(ROD_R, THICKNESS);
//     translate([0, TAIL_WIDTH, 0]) rotate([90, 0, 0]) Groove_hole(ROD_R*1.001, THICKNESS); 
//     Lib2();
// }
// difference(){
//     translate([0, 0, 1]) Lib2();
//     cylinder(r=1.4, h=10, $fn=200, center=true);
// }
///////////////////////////////////////////////////////////
if (1) {
    translate([-PR_OFFSET_Y, -40, ROD_R+(ROD_R+THICKNESS*0.5)]) {
            rotate([-90, 0, 0]) {
            power_rod();
        }   
    }

    mirror([1, 0, 0])  translate([-PR_OFFSET_Y, -40, ROD_R+(ROD_R+THICKNESS*0.5)]) {
            rotate([-90, 0, 0]) {
            power_rod();
        }   
    }

    translate([0, ROD_H+15-40, 0]) {
        rotate([90, 0, 90]) {
            wind_rod();
        }
    }

    half_tail();
    mirror([1, 0, 0])  half_tail();
}