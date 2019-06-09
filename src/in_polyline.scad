/**
* in_polyline.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-in_polyline.html
*
**/

include <__private__/__to3d.scad>;
include <__private__/__in_line.scad>;

function _in_polyline_sub(pts, pt, epsilon, iend, i = 0) = 
    i == iend ? false : (
        __in_line([pts[i], pts[i + 1]], pt, epsilon) ? true :
            _in_polyline_sub(pts, pt, epsilon, iend, i + 1)
    );

function in_polyline(line_pts, pt, epsilon = 0.0001) = 
    _in_polyline_sub(line_pts, pt, epsilon, len(pts) - 1);
    