include <pp_cfg.scad>

// use <pp_power_rod.scad>
// use <pp_wind_rod.scad>
// use <pp_tail.scad>
use <pp_head.scad>


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


half_head();
mirror([1, 0, 0]) {
    half_head();
}
