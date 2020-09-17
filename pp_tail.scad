include <pp_cfg.scad>
use <prism.scad>

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

module tail() {
        //tail
    half_tail();
    mirror([1, 0, 0]){
        half_tail();
    }
}
