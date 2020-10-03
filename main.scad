include <pp_cfg.scad>

use <pp_power_rod.scad>
use <pp_wind_rod.scad>
use <pp_tail.scad>
use <pp_head.scad>
use <pp_bottom.scad>


if (1) {
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
    translate([0, ROD_H-25-fixingRod_high-8, 0]) {
        rotate([90, 0, 90]) {
            wind_rod();
        }
    }

    //tail
    tail();

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

    //head
    translate([0, -25-cup_high-fixingRod_high+cup_high+rod_high, -ROD_R]){
        half_head();
        mirror([1, 0, 0]) {
            half_head();
        }
    }

    #translate([0, -25-cup_high-fixingRod_high+cup_high+rod_high, -ROD_R]) bottom();

    // Gasket1();  // x6;
}
