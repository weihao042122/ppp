include <pp_cfg.scad>

module power_rod() {    
    //motor cup
    difference() {
            cylinder(r=cup_r+cup_thickness, h=cup_high, $fn=200);
            cylinder(r=cup_r, h=cup_high-cup_thickness, $fn=200);
            translate([rod_r+hole_r*1.3, 0, 0]) {
                cylinder(r=hole_r, h=cup_high, $fn=200);
            }
            translate([-rod_r-hole_r*1.3, 0, 0]) {
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
                cylinder(r=NUT_R2, h=nut_high, $fn=200);
            }
        }
        //Foolproof
        translate([-fixingRod_r-fp_size_l+0.2, 0, 0]) {
            cube([fp_size_l, fp_size_w, fp_size_h]);
        }
    }
}

module power_rod_all() {
    power_rod();
    translate([4, -0.4, 2]) {
        cube(size=[22, 1, 4]);
    }
    translate([30, 0, 0]) mirror([1, 0, 0])power_rod();
}
