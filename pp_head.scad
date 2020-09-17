include <pp_cfg.scad>

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

module half_head() {
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
        translate([0, 0, toffset+THICKNESS*2+1.5]) rotate([0, 0, -xRotate]) cube([PR_OFFSET_Y*4/7-0.6+0.1, 0.6, THICKNESS*2]);
        
        translate([0, 0, toffset+THICKNESS*2+1.5 + THICKNESS*2+1.5]) cube([PR_OFFSET_Y*0.59, 0.6, THICKNESS*2]);

    }
}

head();
mirror([1, 0, 0])  head();