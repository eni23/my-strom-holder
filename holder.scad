space_between = 0.3;
in_w = 38.4+space_between*2;
in_h = 80+space_between*2;
in_d = 52.3+space_between*2;
wall_side = 3;
wall_front = 5;
wall_back = 3;
wall_z = 3;
lid_height = 2.5;
border_radius = 5;

epsilon = 0.01;

w = in_w + wall_side*2;
h = in_h + wall_front+wall_back;
d = in_d + wall_z + lid_height;

// wall_mount();
// color("red") lid();


module wall_mount() {
  difference() {
    linear_extrude(d)
      plate();
    translate([0,wall_front-epsilon,wall_z+epsilon])
      inside();
    lid_cutout();
    translate([-in_w/2,wall_front+space_between+52.8,in_d/2+wall_z])
      bottom_plug_cutout();
    translate([in_w/2,wall_front+space_between+57.6,wall_z])
      top_plug_cutout();
    translate([0,wall_front+10,wall_z+epsilon])
      wall_screw_cutout();
    translate([0,in_h+wall_front-10,wall_z+epsilon])
      wall_screw_cutout();
  }
}

module lid(gap=0) {
  fraction = 1;
  min_outer_wall = 1.5;
  delta = 2*min_outer_wall-gap*2;
  dh = wall_back;
  lid_top_d=1.5;
  translate([0,0,d]) {
    intersection() {
      union() {
        hull() {
          translate([0,0,-lid_height])
            linear_extrude(epsilon) lid_base(delta, dh);
          linear_extrude(epsilon) lid_base(delta+lid_height*fraction*2, dh);
        }
        translate([-w/2,0,0]) cube([w,h,lid_top_d]);
      }
      translate([0,0,-lid_height])
        linear_extrude(lid_height+lid_top_d) plate();
    }
  }
  
  module lid_base(delta_w, delta_h) {
    translate([-(w-delta_w)/2,0])
      square([w-delta_w, h-delta_h]);
  }
}

module lid_cutout() {
  lid(0.3);
}

module plate(delta_w=0, delta_h=0) {
  my_w = w - delta_w;
  my_h = h - delta_h;
  translate([-my_w/2,border_radius])
    square([my_w, my_h-border_radius]);
  translate([-my_w/2+border_radius,0])
    square([my_w-2*border_radius, my_h-border_radius]);
  translate([my_w/2-border_radius, border_radius])
    circle(border_radius);
  translate([-my_w/2+border_radius, border_radius])
    circle(border_radius);
}

module inside() {
  translate([-in_w/2,0,0])
    cube([in_w, in_h, in_d]);
}

module bottom_plug_cutout() {
  plug_d = 35.3;
  plug_h = 19.8;
  space_per_side = 1.5;
  my_h = plug_h + 2*space_per_side;
  my_d = plug_d + 2*space_per_side;
  translate([-wall_side-epsilon, -space_per_side, -my_d/2])
    cube([wall_side+2*epsilon, my_h, my_d]);
}

module top_plug_cutout() {
  plug_h = 20;
  plug_d_offset =  7.5;
  space_per_side = 1.5;
  my_h = plug_h+2*space_per_side;
  my_d = in_d - space_between - plug_d_offset + lid_height;
  translate([-epsilon-5, -space_per_side, plug_d_offset+space_between+epsilon])
    cube([wall_side+2*epsilon+5, my_h, my_d]);
}

module wall_screw_cutout() {
  screw_d = 3;
  screw_l = 19.5;
  head_d = 6;
  head_l = 2.75;

  hull() {
    linear_extrude(epsilon) circle(d=head_d);
    translate([0,0,-head_l]) linear_extrude(epsilon) circle(d=screw_d);
  }
  translate([0,0,-head_l-screw_l]) linear_extrude(screw_l) circle(d=screw_d);
}
