import raylib;

import std::io;

const CInt WIDTH = 800;
const CInt HEIGHT = 600;

fn int main() {
    raylib::Color c = {0,0,0,0};

    raylib::init_window(WIDTH, HEIGHT, "Hello");

    raylib::Vector2 rect_position = {100, 100};
    raylib::Rectangle rect = {.x = rect_position.x, .y = rect_position.y, .width = 10, .height = 10};

    raylib::set_target_FPS(60);

    while (!raylib::window_should_close()) {
        raylib::begin_drawing();

        raylib::clear_background(raylib::BLACK);

        raylib::draw_rectangle_rec(rect, {255,18,18,255});

        if (raylib::is_key_down((CInt)raylib::KEY_SPACE)) {
            raylib::clear_background(raylib::RAYWHITE);
        }

        raylib::draw_text("Hello", WIDTH / 2 - 10, HEIGHT / 2 - 10, 20, Color {10, 10, 255, 255});

        raylib::end_drawing();
    }

    raylib::close_window();


    return 0;
}
