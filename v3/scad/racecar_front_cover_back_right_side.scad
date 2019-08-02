$include_rfcfrs = true;
include <racecar_front_cover_front_right_side.scad>

rfcbrs_cover_left_x = rff_side_wall_x_offset - rff_side_wall_length/2.0;;
rfcbrs_cover_left_y = rff_side_wall_right_y_offset-rff_side_wall_width/2.0;
rfcbrs_cover_left_z = rff_side_wall_z_offset + rff_side_wall_height/2.0;
rfcbrs_cover_right_x = rff_side_wall_x_offset - rff_side_wall_length/2.0;
rfcbrs_cover_right_y = -rff_base_width/2.0;
rfcbrs_cover_right_z = rff_side_wall_z_offset + rff_side_wall_height/2.0;

if ($include_rfcbrs==undef) {
    RacecarFrontCoverBackRightSide();
}

module RacecarFrontCoverBackRightSide() {
    
    rfcbrs_wall_length = rfcfrs_cover_right_x - rfcbrs_cover_right_x;
    rfcbrs_wall_width = rfcbrs_cover_left_y - rfcbrs_cover_right_y;
    rfcbrs_wall_height = rff_side_wall_height;
    rfcbrs_wall_x_offset = (rfcfrs_cover_right_x+rfcbrs_cover_right_x)/2.0;
    rfcbrs_wall_y_offset = (rfcbrs_cover_left_y+rfcbrs_cover_right_y)/2.0;
    rfcbrs_wall_z_offset = rff_base_height/2.0 + rff_side_wall_height/2.0;
    
    difference() {
        union() {
            polyhedron(points=[
            [rfcc_rbct_right_top_x,rfcc_rbct_right_top_y,rfcc_rbct_right_top_z], // 0
            [rfcc_rbct_right_bottom_x,rfcc_rbct_right_bottom_y,rfcc_rbct_right_bottom_z], // 1
            [rfcfrs_cover_left_x,rfcfrs_cover_left_y,rfcfrs_cover_left_z], // 2
            [rfcfrs_cover_right_x,rfcfrs_cover_right_y,rfcfrs_cover_right_z], // 3
            [rfcbrs_cover_left_x,rfcbrs_cover_left_y,rfcbrs_cover_left_z], // 4
            [rfcbrs_cover_right_x,rfcbrs_cover_right_y,rfcbrs_cover_right_z] // 5         
            ], faces=[[0,3,5],[1,4,2],[1,0,5,4],[0,1,2,3], [3,2,4,5]]);
            
            
            translate([rfcbrs_wall_x_offset,rfcbrs_wall_y_offset,rfcbrs_wall_z_offset]) {
                cube([rfcbrs_wall_length, rfcbrs_wall_width, rfcbrs_wall_height], true);
            }   
        }
        translate([rff_side_screw_front_x_offset, rfcbrs_wall_y_offset, rfcbrs_wall_z_offset]) {
            scale([1,1.001,1]) {
                rotate([90,0,0]) {
                    _m2_5_flathead_screw(rfcbrs_wall_width);
                }
            }
        }
        translate([rff_side_screw_back_x_offset, rfcbrs_wall_y_offset, rfcbrs_wall_z_offset]) {
            scale([1,1.001,1]) {
                rotate([90,0,0]) {
                    _m2_5_flathead_screw(rfcbrs_wall_width);
                }
            }
        }
        RacecarFrontCoverCenterUSB();
    }
}