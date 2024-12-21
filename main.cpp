// #include <iostream>
#include <fstream>
#include <string>
// #include "include/SDL2/SDL.h"
#include "utils.hpp"
#include "camera.hpp"
#include "hittable.hpp"
#include "hittable_list.hpp"
#include "sphere.hpp"

#undef main

double hit_sphere(const point3& center, double radius, const ray& r) {
    vec3 oc = center - r.origin();

    auto a = r.direction().length_squared();
    auto h = dot(r.direction(), oc);
    auto c = oc.length_squared() - radius*radius;
    auto discriminant = h*h - a*c;
    
    if (discriminant < 0) {
        return -1.0;
    } else {
        return (h - std::sqrt(discriminant)) / a;
    }
}



const int WIDTH = 800, HEIGHT = 600;

int main( int argc, char *argv[] )
{
    hittable_list world;

    world.add(make_shared<sphere>(point3(0,0,-1), 0.5));
    world.add(make_shared<sphere>(point3(0,-100.5,-1), 100));

    camera cam;

    cam.aspect_ratio = 16.0 / 9.0;
    cam.image_width  = 400;

    cam.render(world);
    return 0;
}