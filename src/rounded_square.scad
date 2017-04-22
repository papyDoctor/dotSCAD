/**
* rounded_square.scad
*
* Creates a rounded square or rectangle in the first quadrant. 
* When center is true the square is centered on the origin.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_square.html
*
**/

module rounded_square(size, corner_r, center = false) {
    frags = $fn > 0 ? 
        ($fn >= 3 ? $fn : 3) : 
        max(min(360 / $fa, corner_r * 2 * 3.14159 / $fs), 5);

    quarter_frags = 360 / (frags + frags % 4);
    step_a = 360 / (frags + frags % 4);

    x = len(size) == undef ? size : size[0];
    y = len(size) == undef ? size : size[1];

    half_x = x / 2;
    half_y = y / 2; 
    half_w = half_x - corner_r;
    half_h = half_y - corner_r;

    translate(center ? [0, 0] : [half_x, half_y]) polygon(concat(
        [[half_x, -half_h], [half_x, half_h]],
        [for(a = [step_a:step_a:90 - step_a]) [corner_r * cos(a) + half_w, corner_r * sin(a) + half_h]],
        [[half_w, half_y], [-half_w, half_y]],
        [for(a = [90 + step_a:step_a:180 - step_a]) [corner_r * cos(a) - half_w, corner_r * sin(a) + half_h]], 
        [[-half_x, half_h], [-half_x, -half_h]],
        [for(a = [180 + step_a:step_a:270 - step_a]) [corner_r * cos(a) - half_w, corner_r * sin(a) - half_h]],
        [[-half_w, -half_y], [half_w, -half_y]],
        [for(a = [270 + step_a:step_a:360 - step_a]) [corner_r * cos(a) + half_w, corner_r * sin(a) - half_h]]
    ));
}