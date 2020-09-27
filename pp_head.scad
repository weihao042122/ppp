include <pp_cfg.scad>
use <prism.scad>

module head_cup() {
    // translate([0, 0, cup_high+rod_high]) {
        //fixing head
        difference(){
            cylinder(r=fixingRod_r+cup_thickness/2, h=fixingRod_high+cup_thickness*0.7, $fn=200);
            translate([-fixingRod_r-0.8, 0, 0]) {
                cube([fp_size_l, fp_size_w, fp_size_h]);
            }
            translate([0, 0, fixingRod_high+cup_thickness*0.7-1]) {
                cylinder(r=SCREW_R, h=2, $fn=200);
            }
        }
    // }
}

module half_head() {
    // translate([-PR_OFFSET_Y, -25-cup_high-fixingRod_high+cup_high+rod_high, ROD_R+(ROD_R+THICKNESS*0.5)]) {
    translate([-PR_OFFSET_Y, 0, ROD_R+(ROD_R+THICKNESS*0.5)]) {
        difference(){
            translate([0, 0, 0]) {
                rotate([-90, 0, 0]) head_cup();

                head_toffset = 0.5;
                translate([0, head_toffset, (-fixingRod_r-cup_thickness/2)-0.12]){
                    difference(){
                        translate([0, 0, 0]){
                            //connectingRod1
                            head_zRotate = atan2(-5-head_toffset, PR_OFFSET_Y*5/8);
                            rotate([0, 0, head_zRotate])  cube([PR_OFFSET_Y*5/8, THICKNESS*2, 0.8]);
                            //nut base
                            translate([PR_OFFSET_Y*5/8-0.8-NUT_R*4, -5+THICKNESS*2-head_toffset, 0]) cube([NUT_R*4, NUT_R*4, NUT_H / 0.9]);
                        }
                        // head nut1
                        translate([PR_OFFSET_Y*5/8-0.8-NUT_R*4 + NUT_R*2, -5+THICKNESS*2+NUT_R*2-head_toffset, 0]) cylinder(r=NUT_R, h=NUT_H, $fn=200);
                    }

                    translate([PR_OFFSET_Y*5/8-0.8, -5-head_toffset, 0]){
                        //botton
                        cube([PR_OFFSET_Y*3/8+0.8, THICKNESS*5, 0.8]);
                        translate([0, fixingRod_high+5+6-THICKNESS*1, 0]) cube([PR_OFFSET_Y*3/8+0.8, THICKNESS*1, 0.8]);
                        //wall side
                        translate([0, 0, 0]) cube([0.8, fixingRod_high+5+6, HEAD_WALL_H]);
                        //wall top
                        translate([0, fixingRod_high+5+6-0.8, 0]) cube([PR_OFFSET_Y*3/8+0.8, 0.8, HEAD_WALL_H*0.2]);
                    }
                }

                //connectingRod2
                head_yRotate = atan2(HEAD_WALL_H-(fixingRod_r+cup_thickness/2) ,PR_OFFSET_Y*5/8-(fixingRod_r+cup_thickness/2-0.3));
                head_toffset2 = head_toffset+THICKNESS*2+1;
                translate([fixingRod_r+cup_thickness/2-0.2, head_toffset2, 0]){
                    rotate([0, -head_yRotate, 0]) cube([PR_OFFSET_Y*5/8-(fixingRod_r+cup_thickness/2)+0.35, THICKNESS*2, 0.8]);

                    translate([PR_OFFSET_Y*5/8-(fixingRod_r+cup_thickness/2)-0.3, 0, HEAD_WALL_H-(fixingRod_r+cup_thickness/2)-0.12]) cube([PR_OFFSET_Y*3/8+1, THICKNESS*2, 0.8]);
                }
                
                //connectingRod3
                head_toffset3 = head_toffset2 + THICKNESS*2+1;
                zRotate2 = atan2(fixingRod_high-head_toffset3+6-THICKNESS*2+0.5, PR_OFFSET_Y*5/8);
                difference(){
                    translate([fixingRod_r*1.01, head_toffset3, 0]) rotate([0, 0, zRotate2]) cube([PR_OFFSET_Y*0.7, THICKNESS*2, 0.8]);
                    translate([PR_OFFSET_Y*5/8, fixingRod_high-2, -0.1]) cube([THICKNESS*2,THICKNESS*4,1]);
                }

                // head nut
                translate([PR_OFFSET_Y*5/8-0.8-NUT_R*3, 0, (-fixingRod_r-cup_thickness/2)-0.12]){
                    difference(){
                        //nut base
                        translate([-NUT_R*2, fixingRod_high+6-NUT_R*5, 0]) cube([NUT_R*5+0.8, NUT_R*5, NUT_H / 0.9]);
                        //nut
                        translate([NUT_R*1.5, fixingRod_high+6-NUT_R*5+NUT_R*1.5, 0]) #cylinder(r=NUT_R, h=NUT_H, $fn=200);
                    }
                }

                //head pillar
                difference(){
                    translate([PR_OFFSET_Y*5/8-0.8-NUT_R*6, fixingRod_high+6-NUT_R*6, (-fixingRod_r-cup_thickness/2)-0.12]){
                        difference(){
                            translate([0, 0, 0]) cube([NUT_R*6+0.8, NUT_R*6+6, HEAD_WALL_H]);
                            translate([0+1, 1, 0]) cube([NUT_R*6+0.8-1, NUT_R*6-1+6, HEAD_WALL_H-1]);
                        }
                        //top
                        translate([0, NUT_R*6, HEAD_WALL_H- 1]){
                            prism( PR_OFFSET_Y*5/8, 6, 1);
                        }
                    }

                    translate([PR_OFFSET_Y*5/8, fixingRod_high+6+NUT_R*6+1, HEAD_WALL_H- 1.5 + (-fixingRod_r-cup_thickness/2)]){
                        rotate([0, 0, 180]) prism( NUT_R*6+0.8, 1.6, 1.6);
                    }
                }

                //mid pillar
                translate([PR_OFFSET_Y*0.87, head_toffset2, HEAD_WALL_H-(fixingRod_r+cup_thickness/2)-0.12]){
                    cube([THICKNESS*2, fixingRod_high+6-NUT_R*6+NUT_R*6-NUT_R*4, 0.8]);
                    //head
                    translate([0, fixingRod_high+6-NUT_R*6+NUT_R*6-NUT_R*4 - 2, -1]) cube([THICKNESS*2+3, 2, 1.6]);
                }
            }
            rotate([-90, 0, 0]) cylinder(r=fixingRod_r*1.01, h=fixingRod_high, $fn=200);
        }
        
    }
}
