include <pp_cfg.scad>

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
