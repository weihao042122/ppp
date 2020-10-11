ROD_R = 1.5;
ROD_H = 120;
WIND_LEN = 135;
THICKNESS = 2.3;
PR_OFFSET_Y = 37.5;  //power rod offset of y axis

TAIL_WIDTH = 5;
SCREW_R = 1.2*1.05/2;
NUT_H = 2.1;             //螺母
NUT_R = 1.8 * 0.95 / 2;    //螺母

NUT_H2 = 3;             //螺母
NUT_R2 = 2 * 0.99 / 2;    //螺母

cup_high = 16.4;
cup_r = (7+0.8)/2;
cup_thickness=1.2;
hole_r = 0.7;

rod_high = ROD_H;
rod_r = ROD_R;

fixingRod_high = 20;
fixingRod_r = ROD_R+1;
nut_high = NUT_H;
nut_r = NUT_R;

// fp for fool-proofing
fp_size_l = 1.2;
fp_size_w = 0.8;
fp_size_h = 3;
SPACE = 5;

HEAD_WALL_H = 11;
HEAD_CR_THICKNESS = 1.2;    //CR for Connect Rod
HEAD_OUT_TAIL = 5;
HEAD_OUT_HEAD = 8;



module tail(){
    //tail
    half_tail();
    mirror([1, 0, 0]){
        half_tail();
    }
}
