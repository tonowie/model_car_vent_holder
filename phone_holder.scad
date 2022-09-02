$fn = 50;

adapter_ball_diameter = 17;
adapter_length = 30;
adapter_thickness = 10;

outliet_angle = 20;

holder_width = 50;
holder_thickness = 3;
support_height = 10;

grapler_length = 15;
grapler_width = 5;
grapler_thickness = 2;
grapler_hook_width = 2;
grapler_hook_length = 3;

// grapler
module grapler() {
    translate([-grapler_width/2, -grapler_thickness/2, 0]) {
        rotate(a=outliet_angle, v=[1,0,0]) {
            cube([grapler_width, grapler_thickness, grapler_length]);
            translate([0, 0, grapler_length])
                cube([grapler_width, grapler_hook_width + 2* grapler_thickness, grapler_thickness]);
            translate([0, grapler_hook_width + grapler_thickness, grapler_length-grapler_hook_length])
                cube([grapler_width, grapler_thickness, grapler_hook_length]);
        }
    }
}

// adapter with ball at the end
module holder() {
    y_length = adapter_thickness/cos(outliet_angle);
    // ball with the stick
    translate([0, -y_length/2, 0]) {
        difference() {
            // adapter with ball at the end rotated accordingly
            rotate(a=outliet_angle, v=[1,0,0])
                translate([0, adapter_thickness/2, -adapter_length]) {
                    sphere(d=adapter_ball_diameter);
                    cylinder(h=adapter_length, d=adapter_thickness);
                }
            // cut off the adapter to match the angle
            translate([-adapter_thickness/2, 0, 0])
                cube([adapter_thickness, y_length, adapter_thickness]);    
        }
    }
    // holder
    holder_height = y_length + adapter_ball_diameter - adapter_thickness;
    translate([-holder_width/2, -holder_height/2, 0])
        cube([holder_width, holder_height, holder_thickness]);
    // support sticking out of the bottom
    holder_support_width = holder_height;
    translate([-holder_support_width/2, holder_height/2, 0])
        cube([holder_support_width, support_height, holder_thickness]);
    // graplers
    grapler_offset_x = holder_width/2 - grapler_width/2;
    grappler_offset_y = holder_height/2 - grapler_thickness/2;
    // left grapler
    translate([-grapler_offset_x, -grappler_offset_y, 0])
        grapler();
    // right grapler
    translate([grapler_offset_x, -grappler_offset_y, 0])
        grapler();
}

holder();

