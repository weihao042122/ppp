include <pp_cfg.scad>
use <pp_tail.scad>


module half_bottom(){
    head_toffset = 0.5;
    translate([0, 0, (ROD_R*2-head_toffset)]) rotate([0, 180, 0]){
        translate([0, -HEAD_OUT_TAIL, 0/*-ROD_R*2+0.5*/]){
            cube([PR_OFFSET_Y*3/8+1, fixingRod_high+HEAD_OUT_TAIL+HEAD_OUT_HEAD, (ROD_R*2-head_toffset)]);
        }

        //nut base
        translate([PR_OFFSET_Y*3/8+HEAD_CR_THICKNESS-head_toffset, -HEAD_OUT_TAIL+THICKNESS*2, 0])  difference(){
            //nut base
            cube([NUT_R*4, NUT_R*4, 1.5]);
            // head nut1
            translate([NUT_R*2+head_toffset, NUT_R*2, -5]) cylinder(r=SCREW_R, h=10, $fn=200);
        }

        translate([PR_OFFSET_Y*3/8+HEAD_CR_THICKNESS+NUT_R, 0, 0]){
            difference(){
                //nut base
                translate([-NUT_R*2, fixingRod_high+HEAD_OUT_HEAD-NUT_R*6, 0]) cube([NUT_R*5, NUT_R*5, 1.5]);
                //nut
                translate([NUT_R*0.5, fixingRod_high+HEAD_OUT_HEAD-NUT_R*5+NUT_R*1.5, -5]) cylinder(r=SCREW_R, h=10, $fn=200);
            }
        }

        translate([0, 0-3, 2.5]) cube(size=[0.5, 7, 5]);
    }
}

module mpu6050(){
    MPU6050_X = 20.8;
    MPU6050_Y = 15.8;
    MPU6050_Z = 1.4;
    MPU6050_Z1 = 3.2;
    MPU6050_H_OFFSET = 1;  //hold offset
    MPU6050_HOLD_ROD = 3.2/2;
    difference(){
        translate([0, 0, 0]) {
            cube(size=[MPU6050_X, MPU6050_Y, MPU6050_Z]);
            translate([MPU6050_X/2, MPU6050_H_OFFSET*2, 0]) {
                cube(size=[2,2,MPU6050_Z1]);
            }
        }

        translate([MPU6050_H_OFFSET+MPU6050_HOLD_ROD, MPU6050_H_OFFSET+MPU6050_HOLD_ROD, -1]) {
            cylinder(r=MPU6050_HOLD_ROD, h=10, $fn=200);
        }
        translate([MPU6050_X-MPU6050_H_OFFSET-MPU6050_HOLD_ROD, MPU6050_H_OFFSET+MPU6050_HOLD_ROD, -1]) {
            cylinder(r=MPU6050_HOLD_ROD, h=10, $fn=200);
        }
    }
}

module ble8253_pa(){
    BLE_PA_X = 11.6;
    BLE_PA_Y = 26.2;
    BLE_PA_Z = 2;
    BLE_PA_X1 = 13.4;
    BLE_PA_Y1 = 15.2;
    BLE_PA_Z1 = 2;

    cube(size=[BLE_PA_X, BLE_PA_Y, BLE_PA_Z]);
    cube(size=[BLE_PA_X1, BLE_PA_Y1, BLE_PA_Z]);
    translate([5, 3, 0]) {
        cube(size=[1, 2, 2]);
    }
}

module ble8253(){
    BLE_PA_X = 17.8;
    BLE_PA_Y = 14.8;
    BLE_PA_Z = 0.8;
    BLE_PA_X1 = 6.6;
    BLE_PA_Y1 = 15.8;
    BLE_PA_Z1 = 2;

    cube(size=[BLE_PA_X, BLE_PA_Y, BLE_PA_Z]);
    cube(size=[BLE_PA_X1, BLE_PA_Y1, BLE_PA_Z]);
    translate([BLE_PA_X-5, 3, 0]) {
        cube(size=[1, 2, 2]);
    }
}

module bottom(){
    difference(){
        translate([0, 0, 0]) {
            half_bottom();
            mirror([1, 0, 0]) {
                half_bottom();
            }
        }

        translate([13.1, -2.5, (ROD_R*2-0.5)-2]) {
            rotate([0, 0, 90]) {
                ble8253_pa();   
            }
            // nut
            translate([0, 14+NUT_R, 0]){
                cylinder(r=NUT_R, h=NUT_H, $fn=200);                
            }
            // nut
            translate([-26, 12.5+NUT_R, 0]){
                cylinder(r=NUT_R, h=NUT_H, $fn=200);
            }

            // nut
            translate([-18, -1, 0]){
                cylinder(r=NUT_R, h=NUT_H, $fn=200);
            }
        }
        translate([-10.4, fixingRod_high+6-15, 1.2]){
            mpu6050();
            translate([1+3.2/2, 1+3.2/2, 1.4-NUT_H]) {
                cylinder(r=NUT_R, h=NUT_H, $fn=200);                
            }
            translate([20.8-(1+3.2/2), 1+3.2/2, 1.4-NUT_H]) {
                cylinder(r=NUT_R, h=NUT_H, $fn=200);
            }
        }
    }
}

module Gasket1() {
    difference() {
        cylinder(r=2.3, h=0.8, $fn=200);
        cylinder(r=SCREW_R, h=1, $fn=200);
    }
}

module Gasket2() {
    difference() {
        cylinder(r=2.3, h=0.8, $fn=200);
        cylinder(r=SCREW_R, h=1, $fn=200);
    }
}

module misc_all() {
    module gasket_x2() {
        Gasket1();
        translate([2.2, -0.4, 0]) cube(size=[1, 0.8, 0.6]);
        translate([2.2+2.2+0.6, 0, 0]) Gasket1();
    }
    
    gasket_x2();

    //
    translate([0, 2.3*2+0.6, 0]) {
        gasket_x2();
    }
    translate([-0.4, 2.2, 0]) {
        cube(size=[0.8, 1, 0.6]);
    }
    //
    translate([0, (2.3*2+0.6)*2, 0]) {
        gasket_x2();
    }
    translate([-0.4, (2.2)+(2.3*2+0.6), 0]) {
        cube(size=[0.8, 1, 0.6]);
    }


    //LIB  //x2
    translate([0, -4.5, -3.2]) {
        rotate([0, 0, 90]) difference(){
            translate([0, 0, 1.5]) Lib2();
            translate([-2*ROD_R-THICKNESS/4, 0, 0]) cylinder(r=SCREW_R, h=10, $fn=200, center=true);
        }        
    }
    translate([-0.4, -2.3-1, 0]) {
        cube(size=[0.8, 2, 0.6]);
    }

    //LIB  //x2
    translate([0, 4.5+(2.3*2+0.6)*2, -3.2]) {
        rotate([0, 0, -90]) difference(){
            translate([0, 0, 1.5]) Lib2();
            translate([-2*ROD_R-THICKNESS/4, 0, 0]) cylinder(r=SCREW_R, h=10, $fn=200, center=true);
        }        
    }

    translate([-0.4, 2.2+(2.3*2+0.6)*2, 0]) {
        cube(size=[0.8, 2, 0.6]);
    }
}