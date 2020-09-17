include <pp_cfg.scad>

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
