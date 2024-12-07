(Not complete) Raylib bindings for the C3 programming language.

This is a direct translation of the raylib.h from raylib 5.5 to c3. This is not at all complete and
would only give the raylib core module.

raylib:
- https://www.raylib.com/
- https://github.com/raysan5/raylib


C3:
- https://c3-lang.org/
- https://github.com/c3lang/c3c

Notes:
- The C enumaretions are turned to distinct types and constants instead of using C3 enums.
- CInt's are used instead of C3 int's
- All function names are snake cased because the C3 compiler does not allow function names starting in uppercase
