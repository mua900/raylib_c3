module raylib;

const float PI = 3.14159265358979323846f;
const float DEG2RAD = (PI/180.0f);
const float RAD2DEG = (180.0f/PI);

// colors
// def Color = char[4];
struct Color {
    char r; char g; char b; char a;
}

const Color LIGHTGRAY    =      {200, 200, 200, 255};
const Color GRAY         =      {130, 130, 130, 255};
const Color DARKGRAY     =      {80, 80, 80, 255};
const Color YELLOW       =      {253, 249, 0, 255};
const Color GOLD         =      {255, 203, 0, 255};
const Color ORANGE       =      {255, 161, 0, 255};
const Color PINK         =      {255, 109, 194, 255};
const Color RED          =      {230, 41, 55, 255};
const Color MAROON       =      {190, 33, 55, 255};
const Color GREEN        =      {0, 228, 48, 255};
const Color LIME         =      {0, 158, 47, 255};
const Color DARKGREEN    =      {0, 117, 44, 255};
const Color SKYBLUE      =      {102, 191, 255, 255};
const Color BLUE         =      {0, 121, 241, 255};
const Color DARKBLUE     =      {0, 82, 172, 255};
const Color PURPLE       =      {200, 122, 255, 255};
const Color VIOLET       =      {135, 60, 190, 255};
const Color DARKPURPLE   =      {112, 31, 126, 255};
const Color BEIGE        =      {211, 176, 131, 255};
const Color BROWN        =      {127, 106, 79, 255};
const Color DARKBROWN    =      {76, 63, 47, 255};
const Color WHITE        =      {255, 255, 255, 255};
const Color BLACK        =      {0, 0, 0, 255};
const Color BLANK        =      {0, 0, 0, 0};
const Color MAGENTA      =      {255, 0, 255, 255};
const Color RAYWHITE     =      {245, 245, 245, 255};

// def Vector2 = float[2];
// def Vector3 = float[3];
// def Vector4 = float[4];

struct Vector2 {
    float x; float y;
}

struct Vector3 {
    float x; float y; float z;
}

struct Vector4 {
    float x; float y; float z; float w;
}

def Quaternion = Vector4;

// def Matrix = float[16];  // 4x4 matrix column major
struct Matrix {
    float m0, m4, m8, m12;  // Matrix first row (4 components)
    float m1, m5, m9, m13;  // Matrix second row (4 components)
    float m2, m6, m10, m14; // Matrix third row (4 components)
    float m3, m7, m11, m15; // Matrix fourth row (4 components)
}

struct Rectangle {
    float x; float y; float width; float height;
}

struct Image {
    void* data;
    CInt width; CInt height; CInt mipmaps; CInt format;
}

struct Texture {
    CUInt id;
    CInt width;
    CInt height;
    CInt mipmaps;
    CInt format;
}

def Texture2D = Texture;
def TextureCubeMap = Texture;

struct RenderTexture {
    CUInt id;               // OpenGL framebuffer object id
    Texture texture;        // Color buffer attachment texture
    Texture depth;          // Depth buffer attachment texture
}

def RenderTexture2D = RenderTexture;

struct NPatchInfo {
    Rectangle source;        // Texture source rectangle
    CInt left;               // Left border offset
    CInt top;                // Top border offset
    CInt right;              // Right border offset
    CInt bottom;             // Bottom border offset
    CInt layout;             // Layout of the n-patch: 3x3, 1x3 or 3x1
}

struct GlyphInfo {
    CInt value;              // Character value (Unicode)
    CInt offsetX;            // Character offset X when drawing
    CInt offsetY;            // Character offset Y when drawing
    CInt advanceX;           // Character advance position X
    Image image;             // Character image data
}
    
struct Font {
    CInt baseSize;           // Base size (default chars height)
    CInt glyphCount;         // Number of glyph characters
    CInt glyphPadding;       // Padding around the glyph characters
    Texture2D texture;      // Texture atlas containing the glyphs
    Rectangle *recs;        // Rectangles in texture for the glyphs
    GlyphInfo *glyphs;      // Glyphs info data
}

struct Camera3D {
    Vector3 position;       // Camera position
    Vector3 target;         // Camera target it looks-at
    Vector3 up;             // Camera up vector (rotation over its axis)
    float fovy;             // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
    CInt projection;        // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
}

def Camera = Camera3D;

struct Camera2D {
    Vector2 offset;         // Camera offset (displacement from target)
    Vector2 target;         // Camera target (rotation and zoom origin)
    float rotation;         // Camera rotation in degrees
    float zoom;             // Camera zoom (scaling), should be 1.0f by default
}

struct Mesh {
    CInt vertexCount;        // Number of vertices stored in arrays
    CInt triangleCount;      // Number of triangles stored (indexed or not)

    // Vertex attributes data
    float *vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    float *texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    float *texcoords2;      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    float *normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    float *tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    ushort *indices;    // Vertex indices (in case vertex data comes indexed)

    // Animation vertex data
    float *animVertices;    // Animated vertex positions (after bones transformations)
    float *animNormals;     // Animated normals (after bones transformations)
    char *boneIds; // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)
    float *boneWeights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
    Matrix *boneMatrices;   // Bones animated transformation matrices
    CInt boneCount;          // Number of bones

    // OpenGL identifiers
    CUInt vaoId;     // OpenGL Vertex Array Object id
    CUInt *vboId;    // OpenGL Vertex Buffer Objects id (default vertex data)
}

struct Shader {
    CUInt id;        // Shader program id
    CInt *locs;              // Shader locations array (RL_MAX_SHADER_LOCATIONS)
}

struct MaterialMap {
    Texture2D texture;      // Material map texture
    Color color;            // Material map color
    float value;            // Material map value
}

struct Material {
    Shader shader;          // Material shader
    MaterialMap *maps;      // Material maps array (MAX_MATERIAL_MAPS)
    float[4] params;        // Material generic parameters (if required)
}

struct Transform {
    Vector3 translation;    // Translation
    Quaternion rotation;    // Rotation
    Vector3 scale;          // Scale
}

struct BoneInfo {
    char[32] name;          // Bone name
    CInt parent;             // Bone parent
}

struct Model {
    Matrix transform;       // Local transform matrix

    CInt meshCount;          // Number of meshes
    CInt materialCount;      // Number of materials
    Mesh *meshes;           // Meshes array
    Material *materials;    // Materials array
    CInt *meshMaterial;      // Mesh material number

    // Animation data
    CInt boneCount;          // Number of bones
    BoneInfo *bones;        // Bones information (skeleton)
    Transform *bindPose;    // Bones base transformation (pose)
}

struct ModelAnimation {
    CInt boneCount;          // Number of bones
    CInt frameCount;         // Number of animation frames
    BoneInfo *bones;        // Bones information (skeleton)
    Transform **framePoses; // Poses array by frame
    char[32] name;          // Animation name
}

struct Ray {
    Vector3 position;       // Ray position (origin)
    Vector3 direction;      // Ray direction (normalized)
}

struct RayCollision {
    bool hit;               // Did the ray hit something?
    float distance;         // Distance to the nearest hit
    Vector3 point;          // Point of the nearest hit
    Vector3 normal;         // Surface normal of hit
}

struct BoundingBox {
    Vector3 min;            // Minimum vertex box-corner
    Vector3 max;            // Maximum vertex box-corner
}

struct Wave {
    CUInt frameCount;    // Total number of frames (considering channels)
    CUInt sampleRate;    // Frequency (samples per second)
    CUInt sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    CUInt channels;      // Number of channels (1-mono, 2-stereo, ...)
    void* data;                 // Buffer data pointer
}

struct AudioStream {
    // TODO RAudioBuffer *buffer;       // Pointer to internal data used by the audio system
    // TODO RAudioProcessor *processor; // Pointer to internal data processor, useful for audio effects

    CUInt sampleRate;    // Frequency (samples per second)
    CUInt sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    CUInt channels;      // Number of channels (1-mono, 2-stereo, ...)
}

struct Sound {
    AudioStream stream;         // Audio stream
    CUInt frameCount;    // Total number of frames (considering channels)
}

struct Music {
    AudioStream stream;         // Audio stream
    CUInt frameCount;    // Total number of frames (considering channels)
    bool looping;               // Music looping enable

    CInt ctxType;                // Type of music context (audio filetype)
    void* ctxData;              // Audio context data, depends on type
}

// TODO VrDeviceInfo VrStereoConfig

struct FilePathList {
    CUInt capacity;          // Filepaths max entries
    CUInt count;             // Filepaths entries count
    char **paths;                   // Filepaths entries
}

struct AutomationEvent {
    CUInt frame;             // Event frame
    CUInt type;              // Event type (AutomationEventType)
    CInt[4] params;                  // Event parameters (if required)
}

struct AutomationEventList {
    CUInt capacity;          // Events max entries (MAX_AUTOMATION_EVENTS)
    CUInt count;             // Events entries count
    AutomationEvent *events;        // Events entries
}

// enum definitions converted to distinct types
distinct ConfigFlags = CInt;
const ConfigFlags FLAG_VSYNC_HINT         = 0x00000040;   // Set to try enabling V-Sync on GPU
const ConfigFlags FLAG_FULLSCREEN_MODE    = 0x00000002;   // Set to run program in fullscreen
const ConfigFlags FLAG_WINDOW_RESIZABLE   = 0x00000004;   // Set to allow resizable window
const ConfigFlags FLAG_WINDOW_UNDECORATED = 0x00000008;   // Set to disable window decoration (frame and buttons)
const ConfigFlags FLAG_WINDOW_HIDDEN      = 0x00000080;   // Set to hide window
const ConfigFlags FLAG_WINDOW_MINIMIZED   = 0x00000200;   // Set to minimize window (iconify)
const ConfigFlags FLAG_WINDOW_MAXIMIZED   = 0x00000400;   // Set to maximize window (expanded to monitor)
const ConfigFlags FLAG_WINDOW_UNFOCUSED   = 0x00000800;   // Set to window non focused
const ConfigFlags FLAG_WINDOW_TOPMOST     = 0x00001000;   // Set to window always on top
const ConfigFlags FLAG_WINDOW_ALWAYS_RUN  = 0x00000100;   // Set to allow windows running while minimized
const ConfigFlags FLAG_WINDOW_TRANSPARENT = 0x00000010;   // Set to allow transparent framebuffer
const ConfigFlags FLAG_WINDOW_HIGHDPI     = 0x00002000;   // Set to support HighDPI
const ConfigFlags FLAG_WINDOW_MOUSE_PASSTHROUGH = 0x00004000; // Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
const ConfigFlags FLAG_BORDERLESS_WINDOWED_MODE = 0x00008000; // Set to run program in borderless windowed mode
const ConfigFlags FLAG_MSAA_4X_HINT       = 0x00000020;   // Set to try enabling MSAA 4X
const ConfigFlags FLAG_INTERLACED_HINT    = 0x00010000;   // Set to try enabling interlaced video format (for V3D)


distinct TraceLogLevel = CInt;
const TraceLogLevel LOG_ALL     = 0;          // Display all logs
const TraceLogLevel LOG_TRACE   = 1;          // Trace logging, intended for internal use only
const TraceLogLevel LOG_DEBUG   = 2;          // Debug logging, used for internal debugging, it should be disabled on release builds
const TraceLogLevel LOG_INFO    = 3;          // Info logging, used for program execution info
const TraceLogLevel LOG_WARNING = 4;          // Warning logging, used on recoverable failures
const TraceLogLevel LOG_ERROR   = 5;          // Error logging, used on unrecoverable failures
const TraceLogLevel LOG_FATAL   = 6;          // Fatal logging, used to abort program: exit(EXIT_FAILURE)
const TraceLogLevel LOG_NONE    = 7;          // Disable logging

distinct KeyboardKey = CInt;
const KeyboardKey KEY_NULL            = 0;        // Key: NULL, used for no key pressed
// Alphanumeric keys
const KeyboardKey KEY_APOSTROPHE      = 39;       // Key: '
const KeyboardKey KEY_COMMA           = 44;       // Key: ,
const KeyboardKey KEY_MINUS           = 45;       // Key: -
const KeyboardKey KEY_PERIOD          = 46;       // Key: .
const KeyboardKey KEY_SLASH           = 47;       // Key: /
const KeyboardKey KEY_ZERO            = 48;       // Key: 0
const KeyboardKey KEY_ONE             = 49;       // Key: 1
const KeyboardKey KEY_TWO             = 50;       // Key: 2
const KeyboardKey KEY_THREE           = 51;       // Key: 3
const KeyboardKey KEY_FOUR            = 52;       // Key: 4
const KeyboardKey KEY_FIVE            = 53;       // Key: 5
const KeyboardKey KEY_SIX             = 54;       // Key: 6
const KeyboardKey KEY_SEVEN           = 55;       // Key: 7
const KeyboardKey KEY_EIGHT           = 56;       // Key: 8
const KeyboardKey KEY_NINE            = 57;       // Key: 9
const KeyboardKey KEY_SEMICOLON       = 59;       // Key: ;
const KeyboardKey KEY_EQUAL           = 61;       // Key: =
const KeyboardKey KEY_A               = 65;       // Key: A | a
const KeyboardKey KEY_B               = 66;       // Key: B | b
const KeyboardKey KEY_C               = 67;       // Key: C | c
const KeyboardKey KEY_D               = 68;       // Key: D | d
const KeyboardKey KEY_E               = 69;       // Key: E | e
const KeyboardKey KEY_F               = 70;       // Key: F | f
const KeyboardKey KEY_G               = 71;       // Key: G | g
const KeyboardKey KEY_H               = 72;       // Key: H | h
const KeyboardKey KEY_I               = 73;       // Key: I | i
const KeyboardKey KEY_J               = 74;       // Key: J | j
const KeyboardKey KEY_K               = 75;       // Key: K | k
const KeyboardKey KEY_L               = 76;       // Key: L | l
const KeyboardKey KEY_M               = 77;       // Key: M | m
const KeyboardKey KEY_N               = 78;       // Key: N | n
const KeyboardKey KEY_O               = 79;       // Key: O | o
const KeyboardKey KEY_P               = 80;       // Key: P | p
const KeyboardKey KEY_Q               = 81;       // Key: Q | q
const KeyboardKey KEY_R               = 82;       // Key: R | r
const KeyboardKey KEY_S               = 83;       // Key: S | s
const KeyboardKey KEY_T               = 84;       // Key: T | t
const KeyboardKey KEY_U               = 85;       // Key: U | u
const KeyboardKey KEY_V               = 86;       // Key: V | v
const KeyboardKey KEY_W               = 87;       // Key: W | w
const KeyboardKey KEY_X               = 88;       // Key: X | x
const KeyboardKey KEY_Y               = 89;       // Key: Y | y
const KeyboardKey KEY_Z               = 90;       // Key: Z | z
const KeyboardKey KEY_LEFT_BRACKET    = 91;       // Key: [
const KeyboardKey KEY_BACKSLASH       = 92;       // Key: '\'
const KeyboardKey KEY_RIGHT_BRACKET   = 93;       // Key: ]
const KeyboardKey KEY_GRAVE           = 96;       // Key: `
// Function keys
const KeyboardKey KEY_SPACE           = 32;       // Key: Space
const KeyboardKey KEY_ESCAPE          = 256;      // Key: Esc
const KeyboardKey KEY_ENTER           = 257;      // Key: Enter
const KeyboardKey KEY_TAB             = 258;      // Key: Tab
const KeyboardKey KEY_BACKSPACE       = 259;      // Key: Backspace
const KeyboardKey KEY_INSERT          = 260;      // Key: Ins
const KeyboardKey KEY_DELETE          = 261;      // Key: Del
const KeyboardKey KEY_RIGHT           = 262;      // Key: Cursor right
const KeyboardKey KEY_LEFT            = 263;      // Key: Cursor left
const KeyboardKey KEY_DOWN            = 264;      // Key: Cursor down
const KeyboardKey KEY_UP              = 265;      // Key: Cursor up
const KeyboardKey KEY_PAGE_UP         = 266;      // Key: Page up
const KeyboardKey KEY_PAGE_DOWN       = 267;      // Key: Page down
const KeyboardKey KEY_HOME            = 268;      // Key: Home
const KeyboardKey KEY_END             = 269;      // Key: End
const KeyboardKey KEY_CAPS_LOCK       = 280;      // Key: Caps lock
const KeyboardKey KEY_SCROLL_LOCK     = 281;      // Key: Scroll down
const KeyboardKey KEY_NUM_LOCK        = 282;      // Key: Num lock
const KeyboardKey KEY_PRINT_SCREEN    = 283;      // Key: Print screen
const KeyboardKey KEY_PAUSE           = 284;      // Key: Pause
const KeyboardKey KEY_F1              = 290;      // Key: F1
const KeyboardKey KEY_F2              = 291;      // Key: F2
const KeyboardKey KEY_F3              = 292;      // Key: F3
const KeyboardKey KEY_F4              = 293;      // Key: F4
const KeyboardKey KEY_F5              = 294;      // Key: F5
const KeyboardKey KEY_F6              = 295;      // Key: F6
const KeyboardKey KEY_F7              = 296;      // Key: F7
const KeyboardKey KEY_F8              = 297;      // Key: F8
const KeyboardKey KEY_F9              = 298;      // Key: F9
const KeyboardKey KEY_F10             = 299;      // Key: F10
const KeyboardKey KEY_F11             = 300;      // Key: F11
const KeyboardKey KEY_F12             = 301;      // Key: F12
const KeyboardKey KEY_LEFT_SHIFT      = 340;      // Key: Shift left
const KeyboardKey KEY_LEFT_CONTROL    = 341;      // Key: Control left
const KeyboardKey KEY_LEFT_ALT        = 342;      // Key: Alt left
const KeyboardKey KEY_LEFT_SUPER      = 343;      // Key: Super left
const KeyboardKey KEY_RIGHT_SHIFT     = 344;      // Key: Shift right
const KeyboardKey KEY_RIGHT_CONTROL   = 345;      // Key: Control right
const KeyboardKey KEY_RIGHT_ALT       = 346;      // Key: Alt right
const KeyboardKey KEY_RIGHT_SUPER     = 347;      // Key: Super right
const KeyboardKey KEY_KB_MENU         = 348;      // Key: KB menu
// Keypad keys
const KeyboardKey KEY_KP_0            = 320;      // Key: Keypad 0
const KeyboardKey KEY_KP_1            = 321;      // Key: Keypad 1
const KeyboardKey KEY_KP_2            = 322;      // Key: Keypad 2
const KeyboardKey KEY_KP_3            = 323;      // Key: Keypad 3
const KeyboardKey KEY_KP_4            = 324;      // Key: Keypad 4
const KeyboardKey KEY_KP_5            = 325;      // Key: Keypad 5
const KeyboardKey KEY_KP_6            = 326;      // Key: Keypad 6
const KeyboardKey KEY_KP_7            = 327;      // Key: Keypad 7
const KeyboardKey KEY_KP_8            = 328;      // Key: Keypad 8
const KeyboardKey KEY_KP_9            = 329;      // Key: Keypad 9
const KeyboardKey KEY_KP_DECIMAL      = 330;      // Key: Keypad .
const KeyboardKey KEY_KP_DIVIDE       = 331;      // Key: Keypad /
const KeyboardKey KEY_KP_MULTIPLY     = 332;      // Key: Keypad *
const KeyboardKey KEY_KP_SUBTRACT     = 333;      // Key: Keypad -
const KeyboardKey KEY_KP_ADD          = 334;      // Key: Keypad +
const KeyboardKey KEY_KP_ENTER        = 335;      // Key: Keypad Enter
const KeyboardKey KEY_KP_EQUAL        = 336;      // Key: Keypad =
// Android key buttons
const KeyboardKey KEY_BACK            = 4;        // Key: Android back button
const KeyboardKey KEY_MENU            = 5;        // Key: Android menu button
const KeyboardKey KEY_VOLUME_UP       = 24;       // Key: Android volume up button
const KeyboardKey KEY_VOLUME_DOWN     = 25;       // Key: Android volume down button

distinct MouseButton = CInt;
const MouseButton MOUSE_BUTTON_LEFT    = 0;       // Mouse button left
const MouseButton MOUSE_BUTTON_RIGHT   = 1;       // Mouse button right
const MouseButton MOUSE_BUTTON_MIDDLE  = 2;       // Mouse button middle (pressed wheel)
const MouseButton MOUSE_BUTTON_SIDE    = 3;       // Mouse button side (advanced mouse device)
const MouseButton MOUSE_BUTTON_EXTRA   = 4;       // Mouse button extra (advanced mouse device)
const MouseButton MOUSE_BUTTON_FORWARD = 5;       // Mouse button forward (advanced mouse device)
const MouseButton MOUSE_BUTTON_BACK    = 6;       // Mouse button back (advanced mouse device)

distinct MouseCursor = CInt;
const MouseCursor MOUSE_CURSOR_DEFAULT       = 0;     // Default pointer shape
const MouseCursor MOUSE_CURSOR_ARROW         = 1;     // Arrow shape
const MouseCursor MOUSE_CURSOR_IBEAM         = 2;     // Text writing cursor shape
const MouseCursor MOUSE_CURSOR_CROSSHAIR     = 3;     // Cross shape
const MouseCursor MOUSE_CURSOR_POINTING_HAND = 4;     // Pointing hand cursor
const MouseCursor MOUSE_CURSOR_RESIZE_EW     = 5;     // Horizontal resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_NS     = 6;     // Vertical resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_NWSE   = 7;     // Top-left to bottom-right diagonal resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_NESW   = 8;     // The top-right to bottom-left diagonal resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_ALL    = 9;     // The omnidirectional resize/move cursor shape
const MouseCursor MOUSE_CURSOR_NOT_ALLOWED   = 10;    // The operation-not-allowed shape

distinct GamepadButton = CInt;
const GamepadButton GAMEPAD_BUTTON_UNKNOWN = 0;         // Unknown button, just for error checking
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_UP = 1;        // Gamepad left DPAD up button
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2;     // Gamepad left DPAD right button
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3;      // Gamepad left DPAD down button
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4;      // Gamepad left DPAD left button
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_UP = 5;       // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6;    // Gamepad right button right (i.e. PS3: Circle, Xbox: B)
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7;     // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8;     // Gamepad right button left (i.e. PS3: Square, Xbox: X)
const GamepadButton GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9;      // Gamepad top/back trigger left (first), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10;      // Gamepad top/back trigger left (second), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11;     // Gamepad top/back trigger right (first), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12;     // Gamepad top/back trigger right (second), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_MIDDLE_LEFT = 13;         // Gamepad center buttons, left one (i.e. PS3: Select)
const GamepadButton GAMEPAD_BUTTON_MIDDLE = 14;              // Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
const GamepadButton GAMEPAD_BUTTON_MIDDLE_RIGHT = 15;        // Gamepad center buttons, right one (i.e. PS3: Start)
const GamepadButton GAMEPAD_BUTTON_LEFT_THUMB = 16;          // Gamepad joystick pressed button left
const GamepadButton GAMEPAD_BUTTON_RIGHT_THUMB = 17;          // Gamepad joystick pressed button right

distinct GamepadAxis = CInt;
const GamepadAxis GAMEPAD_AXIS_LEFT_X        = 0;     // Gamepad left stick X axis
const GamepadAxis GAMEPAD_AXIS_LEFT_Y        = 1;     // Gamepad left stick Y axis
const GamepadAxis GAMEPAD_AXIS_RIGHT_X       = 2;     // Gamepad right stick X axis
const GamepadAxis GAMEPAD_AXIS_RIGHT_Y       = 3;     // Gamepad right stick Y axis
const GamepadAxis GAMEPAD_AXIS_LEFT_TRIGGER  = 4;     // Gamepad back trigger left, pressure level: [1..-1]
const GamepadAxis GAMEPAD_AXIS_RIGHT_TRIGGER = 5;      // Gamepad back trigger right, pressure level: [1..-1]

distinct MaterialMapIndex = CInt;
const MaterialMapIndex MATERIAL_MAP_ALBEDO = 0;        // Albedo material (same as: MATERIAL_MAP_DIFFUSE)
const MaterialMapIndex MATERIAL_MAP_METALNESS = 1;         // Metalness material (same as: MATERIAL_MAP_SPECULAR)
const MaterialMapIndex MATERIAL_MAP_NORMAL = 2;            // Normal material
const MaterialMapIndex MATERIAL_MAP_ROUGHNESS = 3;         // Roughness material
const MaterialMapIndex MATERIAL_MAP_OCCLUSION = 4;         // Ambient occlusion material
const MaterialMapIndex MATERIAL_MAP_EMISSION = 5;          // Emission material
const MaterialMapIndex MATERIAL_MAP_HEIGHT = 6;            // Heightmap material
const MaterialMapIndex MATERIAL_MAP_CUBEMAP = 7;           // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
const MaterialMapIndex MATERIAL_MAP_IRRADIANCE = 8;        // Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
const MaterialMapIndex MATERIAL_MAP_PREFILTER = 9;         // Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
const MaterialMapIndex MATERIAL_MAP_BRDF = 10;               // Brdf material

const MaterialMapIndex MATERIAL_MAP_DIFFUSE = MATERIAL_MAP_ALBEDO;
const MaterialMapIndex MATERIAL_MAP_SPECULAR = MATERIAL_MAP_METALNESS;

distinct ShaderLocationIndex = CInt;
const ShaderLocationIndex SHADER_LOC_VERTEX_POSITION = 0; // Shader location: vertex attribute: position
const ShaderLocationIndex SHADER_LOC_VERTEX_TEXCOORD01 = 1;   // Shader location: vertex attribute: texcoord01
const ShaderLocationIndex SHADER_LOC_VERTEX_TEXCOORD02 = 2;   // Shader location: vertex attribute: texcoord02
const ShaderLocationIndex SHADER_LOC_VERTEX_NORMAL = 3;       // Shader location: vertex attribute: normal
const ShaderLocationIndex SHADER_LOC_VERTEX_TANGENT = 4;      // Shader location: vertex attribute: tangent
const ShaderLocationIndex SHADER_LOC_VERTEX_COLOR = 5;        // Shader location: vertex attribute: color
const ShaderLocationIndex SHADER_LOC_MATRIX_MVP = 6;          // Shader location: matrix uniform: model-view-projection
const ShaderLocationIndex SHADER_LOC_MATRIX_VIEW = 7;         // Shader location: matrix uniform: view (camera transform)
const ShaderLocationIndex SHADER_LOC_MATRIX_PROJECTION = 8;   // Shader location: matrix uniform: projection
const ShaderLocationIndex SHADER_LOC_MATRIX_MODEL = 9;        // Shader location: matrix uniform: model (transform)
const ShaderLocationIndex SHADER_LOC_MATRIX_NORMAL = 10;       // Shader location: matrix uniform: normal
const ShaderLocationIndex SHADER_LOC_VECTOR_VIEW = 11;         // Shader location: vector uniform: view
const ShaderLocationIndex SHADER_LOC_COLOR_DIFFUSE = 12;       // Shader location: vector uniform: diffuse color
const ShaderLocationIndex SHADER_LOC_COLOR_SPECULAR = 13;      // Shader location: vector uniform: specular color
const ShaderLocationIndex SHADER_LOC_COLOR_AMBIENT = 14;       // Shader location: vector uniform: ambient color
const ShaderLocationIndex SHADER_LOC_MAP_ALBEDO = 15;          // Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
const ShaderLocationIndex SHADER_LOC_MAP_METALNESS = 16;       // Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
const ShaderLocationIndex SHADER_LOC_MAP_NORMAL = 17;          // Shader location: sampler2d texture: normal
const ShaderLocationIndex SHADER_LOC_MAP_ROUGHNESS = 18;       // Shader location: sampler2d texture: roughness
const ShaderLocationIndex SHADER_LOC_MAP_OCCLUSION = 19;       // Shader location: sampler2d texture: occlusion
const ShaderLocationIndex SHADER_LOC_MAP_EMISSION = 20;        // Shader location: sampler2d texture: emission
const ShaderLocationIndex SHADER_LOC_MAP_HEIGHT = 21;          // Shader location: sampler2d texture: height
const ShaderLocationIndex SHADER_LOC_MAP_CUBEMAP = 22;         // Shader location: samplerCube texture: cubemap
const ShaderLocationIndex SHADER_LOC_MAP_IRRADIANCE = 23;      // Shader location: samplerCube texture: irradiance
const ShaderLocationIndex SHADER_LOC_MAP_PREFILTER = 24;       // Shader location: samplerCube texture: prefilter
const ShaderLocationIndex SHADER_LOC_MAP_BRDF = 25;            // Shader location: sampler2d texture: brdf
const ShaderLocationIndex SHADER_LOC_VERTEX_BONEIDS = 26;      // Shader location: vertex attribute: boneIds
const ShaderLocationIndex SHADER_LOC_VERTEX_BONEWEIGHTS = 27;  // Shader location: vertex attribute: boneWeights
const ShaderLocationIndex SHADER_LOC_BONE_MATRICES = 28;        // Shader location: array of matrices uniform: boneMatrices

const ShaderLocationIndex SHADER_LOC_MAP_DIFFUSE = SHADER_LOC_MAP_ALBEDO;
const ShaderLocationIndex SHADER_LOC_MAP_SPECULAR = SHADER_LOC_MAP_METALNESS;

distinct ShaderUniformDataType = CInt;
const ShaderUniformDataType SHADER_UNIFORM_FLOAT = 0;       // Shader uniform type: float
const ShaderUniformDataType SHADER_UNIFORM_VEC2 = 1;            // Shader uniform type: vec2 (2 float)
const ShaderUniformDataType SHADER_UNIFORM_VEC3 = 2;            // Shader uniform type: vec3 (3 float)
const ShaderUniformDataType SHADER_UNIFORM_VEC4 = 3;            // Shader uniform type: vec4 (4 float)
const ShaderUniformDataType SHADER_UNIFORM_INT = 4;             // Shader uniform type: int
const ShaderUniformDataType SHADER_UNIFORM_IVEC2 = 5;           // Shader uniform type: ivec2 (2 int)
const ShaderUniformDataType SHADER_UNIFORM_IVEC3 = 6;           // Shader uniform type: ivec3 (3 int)
const ShaderUniformDataType SHADER_UNIFORM_IVEC4 = 7;           // Shader uniform type: ivec4 (4 int)
const ShaderUniformDataType SHADER_UNIFORM_SAMPLER2D = 8;       // Shader uniform type: sampler2d


distinct ShaderAttributeDataType = CInt;
const ShaderAttributeDataType SHADER_ATTRIB_FLOAT = 0;        // Shader attribute type: float
const ShaderAttributeDataType SHADER_ATTRIB_VEC2 = 1;             // Shader attribute type: vec2 (2 float)
const ShaderAttributeDataType SHADER_ATTRIB_VEC3 = 2;             // Shader attribute type: vec3 (3 float)
const ShaderAttributeDataType SHADER_ATTRIB_VEC4 = 3;             // Shader attribute type: vec4 (4 float)

distinct PixelFormat = CInt;
const PixelFormat PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1; // 8 bit per pixel (no alpha)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2;    // 8*2 bpp (2 channels)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3;        // 16 bpp
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4;        // 24 bpp
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5;      // 16 bpp (1 bit alpha)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6;      // 16 bpp (4 bit alpha)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7;      // 32 bpp
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R32 = 8;           // 32 bpp (1 channel - float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9;     // 32*3 bpp (3 channels - float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10;  // 32*4 bpp (4 channels - float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R16 = 11;           // 16 bpp (1 channel - half float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R16G16B16 = 12;     // 16*3 bpp (3 channels - half float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13;  // 16*4 bpp (4 channels - half float)
const PixelFormat PIXELFORMAT_COMPRESSED_DXT1_RGB = 14;        // 4 bpp (no alpha)
const PixelFormat PIXELFORMAT_COMPRESSED_DXT1_RGBA = 15;       // 4 bpp (1 bit alpha)
const PixelFormat PIXELFORMAT_COMPRESSED_DXT3_RGBA = 16;       // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_DXT5_RGBA = 17;       // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ETC1_RGB = 18;        // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ETC2_RGB = 19;        // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 20;   // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_PVRT_RGB = 21;        // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_PVRT_RGBA = 22;       // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ASTC_4X4_RGBA = 23;   // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ASTC_8X8_RGBA = 24;   // 2 bpp

distinct TextureFilter = CInt;
const TextureFilter TEXTURE_FILTER_POINT = 0;               // No filter, just pixel approximation
const TextureFilter TEXTURE_FILTER_BILINEAR = 1;                // Linear filtering
const TextureFilter TEXTURE_FILTER_TRILINEAR = 2;               // Trilinear filtering (linear with mipmaps)
const TextureFilter TEXTURE_FILTER_ANISOTROPIC_4X = 3;          // Anisotropic filtering 4x
const TextureFilter TEXTURE_FILTER_ANISOTROPIC_8X = 4;          // Anisotropic filtering 8x
const TextureFilter TEXTURE_FILTER_ANISOTROPIC_16X = 5;         // Anisotropic filtering 16x


distinct TextureWrap = CInt;
const TextureWrap TEXTURE_WRAP_REPEAT = 0;                // Repeats texture in tiled mode
const TextureWrap TEXTURE_WRAP_CLAMP = 1;                     // Clamps texture to edge pixel in tiled mode
const TextureWrap TEXTURE_WRAP_MIRROR_REPEAT = 2;             // Mirrors and repeats the texture in tiled mode
const TextureWrap TEXTURE_WRAP_MIRROR_CLAMP = 3;              // Mirrors and clamps to border the texture in tiled mode

distinct CubemapLayout = CInt;
const CubemapLayout CUBEMAP_LAYOUT_AUTO_DETECT         = 0;     // Automatically detect layout type
const CubemapLayout CUBEMAP_LAYOUT_LINE_VERTICAL       = 1;     // Layout is defined by a vertical line with faces
const CubemapLayout CUBEMAP_LAYOUT_LINE_HORIZONTAL     = 2;     // Layout is defined by a horizontal line with faces
const CubemapLayout CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3;     // Layout is defined by a 3x4 cross with cubemap faces
const CubemapLayout CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4;     // Layout is defined by a 4x3 cross with cubemap faces

distinct FontType = CInt;
const FontType FONT_DEFAULT = 0;               // Default font generation, anti-aliased
const FontType FONT_BITMAP  = 1;               // Bitmap font generation, no anti-aliasing
const FontType FONT_SDF     = 2;               // SDF font generation, requires external shader

distinct BlendMode = CInt;
const BlendMode BLEND_ALPHA            = 0;        // Blend textures considering alpha (default)
const BlendMode BLEND_ADDITIVE         = 1;        // Blend textures adding colors
const BlendMode BLEND_MULTIPLIED       = 2;        // Blend textures multiplying colors
const BlendMode BLEND_ADD_COLORS       = 3;        // Blend textures adding colors (alternative)
const BlendMode BLEND_SUBTRACT_COLORS  = 4;        // Blend textures subtracting colors (alternative)
const BlendMode BLEND_ALPHA_PREMULTIPLY= 5;        // Blend premultiplied textures considering alpha
const BlendMode BLEND_CUSTOM           = 6;        // Blend textures using custom src/dst factors (use rlSetBlendFactors())
const BlendMode BLEND_CUSTOM_SEPARATE  = 7;        // Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())

// NOTE: Provided as bit-wise flags to enable only desired gestures
distinct Gesture = CInt;
const Gesture GESTURE_NONE        = 0;        // No gesture
const Gesture GESTURE_TAP         = 1;        // Tap gesture
const Gesture GESTURE_DOUBLETAP   = 2;        // Double tap gesture
const Gesture GESTURE_HOLD        = 4;        // Hold gesture
const Gesture GESTURE_DRAG        = 8;        // Drag gesture
const Gesture GESTURE_SWIPE_RIGHT = 16;       // Swipe right gesture
const Gesture GESTURE_SWIPE_LEFT  = 32;       // Swipe left gesture
const Gesture GESTURE_SWIPE_UP    = 64;       // Swipe up gesture
const Gesture GESTURE_SWIPE_DOWN  = 128;      // Swipe down gesture
const Gesture GESTURE_PINCH_IN    = 256;      // Pinch in gesture
const Gesture GESTURE_PINCH_OUT   = 512;      // Pinch out gesture

distinct CameraMode = CInt;
const CameraMode CAMERA_CUSTOM       = 0;        // Camera custom, controlled by user (UpdateCamera() does nothing)
const CameraMode CAMERA_FREE         = 1;        // Camera free mode
const CameraMode CAMERA_ORBITAL      = 2;        // Camera orbital, around target, zoom supported
const CameraMode CAMERA_FIRST_PERSON = 3;        // Camera first person
const CameraMode CAMERA_THIRD_PERSON = 4;        // Camera third person

distinct CameraProjection = CInt;
const CameraProjection CAMERA_PERSPECTIVE  = 0;         // Perspective projection
const CameraProjection CAMERA_ORTHOGRAPHIC = 1;         // Orthographic projection

distinct NPatchLayout = CInt;
const NPatchLayout NPATCH_NINE_PATCH = 0;          // Npatch layout: 3x3 tiles
const NPatchLayout NPATCH_THREE_PATCH_VERTICAL = 1;    // Npatch layout: 1x3 tiles
const NPatchLayout NPATCH_THREE_PATCH_HORIZONTAL = 2;  // Npatch layout: 3x1 tiles


// TODO Callbacks (https://github.com/raysan5/raylib/blob/master/src/raylib.h#L1108)


//------------------------------------------------------------------------------------
// Global Variables Definition
// It's lonely here...
//------------------------------------------------------------------------------------

// window related functions
extern fn void init_window(CInt width, CInt height, char *title) @extern("InitWindow");  // Initialize window and OpenGL context
extern fn void close_window() @extern("CloseWindow");                                     // Close window and unload OpenGL context
extern fn bool window_should_close() @extern("WindowShouldClose");                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
extern fn bool is_window_ready() @extern("IsWindowReady");                                   // Check if window has been initialized successfully
extern fn bool is_window_fullscreen() @extern("IsWindowFullscreen");                              // Check if window is currently fullscreen
extern fn bool is_window_hidden() @extern("IsWindowHidden");                                  // Check if window is currently hidden
extern fn bool is_window_minimized() @extern("IsWindowMinimized");                               // Check if window is currently minimized
extern fn bool is_window_maximized() @extern("IsWindowMaximized");                               // Check if window is currently maximized
extern fn bool is_window_focused() @extern("IsWindowFocused");                                 // Check if window is currently focused
extern fn bool is_window_resized() @extern("IsWindowResized");                                 // Check if window has been resized last frame
extern fn bool is_window_state(CUInt flag) @extern("IsWindowState");                      // Check if one specific window flag is enabled
extern fn void set_window_state(CUInt flags) @extern("SetWindowState");                    // Set window configuration state using flags
extern fn void clear_window_state(CUInt flags) @extern("ClearWindowState");                  // Clear window configuration state flags
extern fn void toggle_fullscreen() @extern("ToggleFullscreen");                                // Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
extern fn void toggle_borderless_windowed() @extern("ToggleBorderlessWindowed");                        // Toggle window state: borderless windowed, resizes window to match monitor resolution
extern fn void maximize_window() @extern("MaximizeWindow");                                  // Set window state: maximized, if resizable
extern fn void minimize_window() @extern("MinimizeWindow");                                  // Set window state: minimized, if resizable
extern fn void restore_window() @extern("RestoreWindow");                                   // Set window state: not minimized/maximized
extern fn void set_window_icon(Image image) @extern("SetWindowIcon");                            // Set icon for window (single image, RGBA 32bit)
extern fn void set_window_icons(Image *images, CInt count) @extern("SetWindowIcons");              // Set icon for window (multiple images, RGBA 32bit)
extern fn void set_window_title(char *title) @extern("SetWindowTitle");                     // Set title for window
extern fn void set_window_position(CInt x, CInt y) @extern("SetWindowPosition");                       // Set window position on screen
extern fn void set_window_monitor(CInt monitor) @extern("SetWindowMonitor");                         // Set monitor for the current window
extern fn void set_window_min_size(CInt width, CInt height) @extern("SetWindowMinSize");               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
extern fn void set_window_max_size(CInt width, CInt height) @extern("SetWindowMaxSize");               // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
extern fn void set_window_size(CInt width, CInt height) @extern("SetWindowSize");                  // Set window dimensions
extern fn void set_window_opacity(float opacity) @extern("SetWindowOpacity");                       // Set window opacity [0.0f..1.0f]
extern fn void set_window_focused() @extern("SetWindowFocused");                                // Set window focused
extern fn void* get_window_handle() @extern("GetWindowHandle");                                // Get native window handle
extern fn CInt get_screen_width() @extern("GetScreenWidth");                                   // Get current screen width
extern fn CInt get_screen_height() @extern("GetScreenHeight");                                  // Get current screen height
extern fn CInt get_render_width() @extern("GetRenderWidth");                                   // Get current render width (it considers HiDPI)
extern fn CInt get_render_height() @extern("GetRenderHeight");                                  // Get current render height (it considers HiDPI)
extern fn CInt get_monitor_count() @extern("GetMonitorCount");                                  // Get number of connected monitors
extern fn CInt get_current_monitor() @extern("GetCurrentMonitor");                                // Get current monitor where window is placed
extern fn Vector2 get_monitor_position(CInt monitor) @extern("GetMonitorPosition");                    // Get specified monitor position
extern fn CInt get_monitor_width(CInt monitor) @extern("GetMonitorWidth");                           // Get specified monitor width (current video mode used by monitor)
extern fn CInt get_monitor_height(CInt monitor) @extern("GetMonitorHeight");                          // Get specified monitor height (current video mode used by monitor)
extern fn CInt get_monitor_physical_width(CInt monitor) @extern("GetMonitorPhysicalWidth");                   // Get specified monitor physical width in millimetres
extern fn CInt get_monitor_physical_height(CInt monitor) @extern("GetMonitorPhysicalHeight");                  // Get specified monitor physical height in millimetres
extern fn CInt get_monitor_refresh_rate(CInt monitor) @extern("GetMonitorRefreshRate");                     // Get specified monitor refresh rate
extern fn Vector2 get_window_position() @extern("GetWindowPosition");                            // Get window position XY on monitor
extern fn Vector2 get_window_scaleDPI() @extern("GetWindowScaleDPI");                            // Get window scale DPI factor
extern fn char* get_monitor_name(CInt monitor) @extern("GetMonitorName");                    // Get the human-readable, UTF-8 encoded name of the specified monitor
extern fn void set_clipboard_text(char *text) @extern("SetClipboardText");                    // Set clipboard text content
extern fn char* get_clipboard_text() @extern("GetClipboardText");                         // Get clipboard text content
extern fn Image get_clipboard_image() @extern("GetClipboardImage");                              // Get clipboard image content
extern fn void enable_event_waiting() @extern("EnableEventWaiting");                              // Enable waiting for events on EndDrawing(), no automatic event polling
extern fn void disable_event_waiting() @extern("DisableEventWaiting");                             // Disable waiting for events on EndDrawing(), automatic events polling

// Cursor-related functions
extern fn void show_cursor() @extern("ShowCursor");                                      // Shows cursor
extern fn void hide_cursor() @extern("HideCursor");                                      // Hides cursor
extern fn bool is_cursor_hidden() @extern("IsCursorHidden");                                  // Check if cursor is not visible
extern fn void enable_cursor() @extern("EnableCursor");                                    // Enables cursor (unlock cursor)
extern fn void disable_cursor() @extern("DisableCursor");                                   // Disables cursor (lock cursor)
extern fn bool is_cursor_on_screen() @extern("IsCursorOnScreen");                                // Check if cursor is on the screen

// Drawing-related functions
extern fn void clear_background(Color color) @extern("ClearBackground");                          // Set background color (framebuffer clear color)
extern fn void begin_drawing() @extern("BeginDrawing");                                    // Setup canvas (framebuffer) to start drawing
extern fn void end_drawing() @extern("EndDrawing");                                      // End canvas drawing and swap buffers (double buffering)
extern fn void begin_mode2D(Camera2D camera) @extern("BeginMode2D");                          // Begin 2D mode with custom camera (2D)
extern fn void end_mode2D() @extern("EndMode2D");                                       // Ends 2D mode with custom camera
extern fn void begin_mode3D(Camera3D camera) @extern("BeginMode3D");                          // Begin 3D mode with custom camera (3D)
extern fn void end_mode3D() @extern("EndMode3D");                                       // Ends 3D mode and returns to default 2D orthographic mode
extern fn void begin_texture_mode(RenderTexture2D target) @extern("BeginTextureMode");              // Begin drawing to render texture
extern fn void end_texture_mode() @extern("EndTextureMode");                                  // Ends drawing to render texture
extern fn void begin_shader_mode(Shader shader) @extern("BeginShaderMode");                        // Begin custom shader drawing
extern fn void end_shader_mode() @extern("EndShaderMode");                                   // End custom shader drawing (use default shader)
extern fn void begin_blend_mode(CInt mode) @extern("BeginBlendMode");                              // Begin blending mode (alpha, additive, multiplied, subtract, custom)
extern fn void end_blend_mode() @extern("EndBlendMode");                                    // End blending mode (reset to default: alpha blending)
extern fn void begin_scissor_mode(CInt x, CInt y, CInt width, CInt height) @extern("BeginScissorMode"); // Begin scissor mode (define screen area for following drawing)
extern fn void end_scissor_mode() @extern("EndScissorMode");                                  // End scissor mode
// extern fn void begin_vr_stereo_mode(VrStereoConfig config);              // Begin stereo rendering (requires VR simulator)
// extern fn void end_vr_stereo_mode();                                 // End stereo rendering (requires VR simulator)

// VR stereo config functions for VR simulator
// extern fn VrStereoConfig load_vr_stereo_config(VrDeviceInfo device);     // Load VR stereo config for VR simulator device parameters
// extern fn void unload_vr_stereo_config(VrStereoConfig config);           // Unload VR stereo config

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
extern fn Shader load_shader(char *vsFileName, char *fsFileName) @extern("LoadShader");   // Load shader from files and bind default locations
extern fn Shader load_shader_from_memory(char *vsCode, char *fsCode) @extern("LoadShaderFromMemory"); // Load shader from code strings and bind default locations
extern fn bool is_shader_valid(Shader shader) @extern("IsShaderValid");                                   // Check if a shader is valid (loaded on GPU)
extern fn CInt get_shader_location(Shader shader, char *uniformName) @extern("GetShaderLocation");       // Get shader uniform location
extern fn CInt get_shader_location_attrib(Shader shader, char *attribName) @extern("GetShaderLocationAttrib");  // Get shader attribute location
extern fn void set_shader_value(Shader shader, CInt locIndex, void *value, CInt uniformType) @extern("SetShaderValue");               // Set shader uniform value
extern fn void set_shader_valueV(Shader shader, CInt locIndex, void *value, CInt uniformType, CInt count) @extern("SetShaderValueV");   // Set shader uniform value vector
extern fn void set_shader_value_matrix(Shader shader, CInt locIndex, Matrix mat) @extern("SetShaderValueMatrix");         // Set shader uniform value (matrix 4x4)
extern fn void set_shader_value_texture(Shader shader, CInt locIndex, Texture2D texture) @extern("SetShaderValueTexture"); // Set shader uniform value for texture (sampler2d)
extern fn void unload_shader(Shader shader) @extern("UnloadShader");                                    // Unload shader from GPU memory (VRAM)

def get_mouse_ray = get_screen_to_world_ray;     // Compatibility hack for previous raylib versions
extern fn Ray get_screen_to_world_ray(Vector2 position, Camera camera) @extern("GetScreenToWorldRay");         // Get a ray trace from screen position (i.e mouse)
extern fn Ray get_screen_to_world_ray_ex(Vector2 position, Camera camera, CInt width, CInt height) @extern("GetScreenToWorldRayEx"); // Get a ray trace from screen position (i.e mouse) in a viewport
extern fn Vector2 get_world_to_screen(Vector3 position, Camera camera) @extern("GetWorldToScreen");        // Get the screen space position for a 3d world space position
extern fn Vector2 get_world_to_screen_ex(Vector3 position, Camera camera, CInt width, CInt height) @extern("GetWorldToScreenEx"); // Get size position for a 3d world space position
extern fn Vector2 get_world_to_screen2D(Vector2 position, Camera2D camera) @extern("GetWorldToScreen2D");    // Get the screen space position for a 2d camera world space position
extern fn Vector2 get_screen_to_world2D(Vector2 position, Camera2D camera) @extern("GetScreenToWorld2D");    // Get the world space position for a 2d camera screen space position
extern fn Matrix get_camera_matrix(Camera camera) @extern("GetCameraMatrix");                            // Get camera transform matrix (view matrix)
extern fn Matrix get_camera_matrix2D(Camera2D camera) @extern("GetCameraMatrix2D");                        // Get camera 2d transform matrix

// Timing-related functions
extern fn void set_target_FPS(CInt fps) @extern("SetTargetFPS");                                 // Set target FPS (maximum)
extern fn float get_frame_time() @extern("GetFrameTime");                                   // Get time in seconds for last frame drawn (delta time)
extern fn double get_time() @extern("GetTime");                                       // Get elapsed time in seconds since InitWindow()
extern fn CInt getFPS() @extern("GetFPS");                                           // Get current FPS

// Custom frame control functions
// NOTE: Those functions are intended for advanced users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
extern fn void swap_screen_buffer() @extern("SwapScreenBuffer");                                // Swap back buffer with front buffer (screen drawing)
extern fn void poll_input_events() @extern("PollInputEvents");                                 // Register all input events
extern fn void wait_time(double seconds) @extern("WaitTime");                              // Wait for some time (halt program execution)

// Random values generation functions
extern fn void set_random_seed(CUInt seed) @extern("SetRandomSeed");                      // Set the seed for the random number generator
extern fn CInt get_random_value(CInt min, CInt max) @extern("GetRandomValue");                       // Get a random value between min and max (both included)
extern fn CInt* load_random_sequence(CUInt count, CInt min, CInt max) @extern("LoadRandomSequence"); // Load random values sequence, no values repeated
extern fn void unload_random_sequence(CInt *sequence) @extern("UnloadRandomSequence");                   // Unload random values sequence

// Misc. functions
extern fn void take_screenshot(char *fileName) @extern("TakeScreenshot");                  // Takes a screenshot of current screen (filename extension defines format)
extern fn void set_config_flags(CUInt flags) @extern("SetConfigFlags");                    // Setup init configuration flags (view FLAGS)
extern fn void openURL(char *url) @extern("OpenURL");                              // Open URL with default system browser (if available)

// NOTE: Following functions implemented in module [utils]
//------------------------------------------------------------------
extern fn void trace_log(CInt logLevel, char *text, ...) @extern("TraceLog");         // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
extern fn void set_trace_log_level(CInt logLevel) @extern("SetTraceLogLevel");                        // Set the current threshold (minimum) log level
extern fn void* mem_alloc(CUInt size) @extern("MemAlloc");                          // Internal memory allocator
extern fn void* mem_realloc(void *ptr, CUInt size) @extern("MemRealloc");             // Internal memory reallocator
extern fn void mem_free(void *ptr) @extern("MemFree");                                    // Internal memory free

// Set custom callbacks
// WARNING: Callbacks setup is intended for advanced users
/*
extern fn void set_trace_log_callback(TraceLogCallback callback);         // Set custom trace log
extern fn void set_load_file_data_callback(LoadFileDataCallback callback); // Set custom file binary data loader
extern fn void set_save_file_data_callback(SaveFileDataCallback callback); // Set custom file binary data saver
extern fn void set_load_file_text_callback(LoadFileTextCallback callback); // Set custom file text data loader
extern fn void set_save_file_text_callback(SaveFileTextCallback callback); // Set custom file text data saver
*/

// Files management functions
extern fn char* load_file_data(char *fileName, CInt *dataSize) @extern("LoadFileData"); // Load file data as byte array (read)
extern fn void unload_file_data(char *data) @extern("UnloadFileData");                   // Unload file data allocated by LoadFileData()
extern fn bool save_file_data(char *fileName, void *data, CInt dataSize) @extern("SaveFileData"); // Save data to file from byte array (write), returns true on success
extern fn bool export_data_as_code(char *data, CInt dataSize, char *fileName) @extern("ExportDataAsCode"); // Export data to code (.h), returns true on success
extern fn char* load_file_text(char *fileName) @extern("LoadFileText");                   // Load text data from file (read), returns a '\0' terminated string
extern fn void unload_file_text(char *text) @extern("UnloadFileText");                            // Unload file text data allocated by LoadFileText()
extern fn bool save_file_text(char *fileName, char *text) @extern("SaveFileText");        // Save text data to file (write), string must be '\0' terminated, returns true on success
//------------------------------------------------------------------

// File system functions
extern fn bool file_exists(char *fileName) @extern("FileExists");                      // Check if file exists
extern fn bool directory_exists(char *dirPath) @extern("DirectoryExists");                  // Check if a directory path exists
extern fn bool is_file_extension(char *fileName, char *ext) @extern("IsFileExtension"); // Check file extension (including point: .png, .wav)
extern fn CInt get_file_length(char *fileName) @extern("GetFileLength");                    // Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
extern fn char* get_file_extension(char *fileName) @extern("GetFileExtension");         // Get pointer to extension for a filename string (includes dot: '.png')
extern fn char* get_file_name(char *filePath) @extern("GetFileName");              // Get pointer to filename for a path string
extern fn char* get_file_name_without_ext(char *filePath) @extern("GetFileNameWithoutExt");    // Get filename string without extension (uses static string)
extern fn char* get_directory_path(char *filePath) @extern("GetDirectoryPath");         // Get full path for a given fileName with path (uses static string)
extern fn char* get_prev_directory_path(char *dirPath) @extern("GetPrevDirectoryPath");      // Get previous directory path for a given path (uses static string)
extern fn char* get_working_directory() @extern("GetWorkingDirectory");                      // Get current working directory (uses static string)
extern fn char* get_application_directory() @extern("GetApplicationDirectory");                  // Get the directory of the running application (uses static string)
extern fn CInt make_directory(char *dirPath) @extern("MakeDirectory");                     // Create directories (including full path requested), returns 0 on success
extern fn bool change_directory(char *dir) @extern("ChangeDirectory");                      // Change working directory, return true on success
extern fn bool is_path_file(char *path) @extern("IsPathFile");                          // Check if a given path is a file or a directory
extern fn bool is_file_name_valid(char *fileName) @extern("IsFileNameValid");                 // Check if fileName is valid for the platform/OS
extern fn FilePathList load_directory_files(char *dirPath) @extern("LoadDirectoryFiles");       // Load directory filepaths
extern fn FilePathList load_directory_files_ex(char *basePath, char *filter, bool scanSubdirs) @extern("LoadDirectoryFilesEx"); // Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result
extern fn void unload_directory_files(FilePathList files) @extern("UnloadDirectoryFiles");              // Unload filepaths
extern fn bool is_file_dropped() @extern("IsFileDropped");                                   // Check if a file has been dropped into window
extern fn FilePathList load_dropped_files() @extern("LoadDroppedFiles");                        // Load dropped filepaths
extern fn void unload_dropped_files(FilePathList files) @extern("UnloadDroppedFiles");                // Unload dropped filepaths
extern fn CLong get_file_mod_time(char *fileName) @extern("GetFileModTime");                  // Get file modification time (last write time)


// Compression/Encoding functionality
extern fn char* compress_data(char *data, CInt dataSize, CInt *compDataSize) @extern("CompressData");        // Compress data (DEFLATE algorithm), memory must be MemFree()
extern fn char* decompress_data(char *compData, CInt compDataSize, CInt *dataSize) @extern("DecompressData");  // Decompress data (DEFLATE algorithm), memory must be MemFree()
extern fn char* encode_data_base64(char *data, CInt dataSize, CInt *outputSize) @extern("EncodeDataBase64");               // Encode data to Base64 string, memory must be MemFree()
extern fn char* decode_data_base64(char *data, CInt *outputSize) @extern("DecodeDataBase64");                    // Decode Base64 string data, memory must be MemFree()
extern fn CUInt computeCRC32(char *data, CInt dataSize) @extern("ComputeCRC32");     // Compute CRC32 hash code
extern fn CUInt *computeMD5(char *data, CInt dataSize) @extern("ComputeMD5");      // Compute MD5 hash code, returns static int[4] (16 bytes)
extern fn CUInt *computeSHA1(char *data, CInt dataSize) @extern("ComputeSHA1");     // Compute SHA1 hash code, returns static int[5] (20 bytes)


// Automation events functionality
extern fn AutomationEventList load_automation_event_list(char *fileName) @extern("LoadAutomationEventList");                // Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
extern fn void unload_automation_event_list(AutomationEventList list) @extern("UnloadAutomationEventList");                         // Unload automation events list from file
extern fn bool export_automation_event_list(AutomationEventList list, char *fileName) @extern("ExportAutomationEventList");   // Export automation events list as text file
extern fn void set_automation_event_list(AutomationEventList *list) @extern("SetAutomationEventList");                           // Set automation event list to record to
extern fn void set_automation_event_base_frame(CInt frame) @extern("SetAutomationEventBaseFrame");                                      // Set automation event internal base frame to start recording
extern fn void start_automation_event_recording() @extern("StartAutomationEventRecording");                                         // Start recording automation events (AutomationEventList must be set)
extern fn void stop_automation_event_recording() @extern("StopAutomationEventRecording");                                          // Stop recording automation events
extern fn void play_automation_event(AutomationEvent event) @extern("PlayAutomationEvent");                                  // Play a recorded automation event

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
extern fn bool is_key_pressed(CInt key) @extern("IsKeyPressed");                             // Check if a key has been pressed once
extern fn bool is_key_pressed_repeat(CInt key) @extern("IsKeyPressedRepeat");                       // Check if a key has been pressed again
extern fn bool is_key_down(CInt key) @extern("IsKeyDown");                                // Check if a key is being pressed
extern fn bool is_key_released(CInt key) @extern("IsKeyReleased");                            // Check if a key has been released once
extern fn bool is_key_up(CInt key) @extern("IsKeyUp");                                  // Check if a key is NOT being pressed
extern fn CInt get_key_pressed() @extern("GetKeyPressed");                                // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
extern fn CInt get_char_pressed() @extern("GetCharPressed");                               // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
extern fn void set_exit_key(CInt key) @extern("SetExitKey");                               // Set a custom key to exit program (default is ESC)
extern fn char* get_key_name(CInt key) @extern("GetKeyName");                        // Get name of a QWERTY key on the current keyboard layout (eg returns string "q" for KEY_A on an AZERTY keyboard)

// Input-related functions: gamepads
extern fn bool is_gamepad_available(CInt gamepad) @extern("IsGamepadAvailable");                                        // Check if a gamepad is available
extern fn char* get_gamepad_name(CInt gamepad) @extern("GetGamepadName");                                     // Get gamepad internal name id
extern fn bool is_gamepad_button_pressed(CInt gamepad, CInt button) @extern("IsGamepadButtonPressed");                        // Check if a gamepad button has been pressed once
extern fn bool is_gamepad_button_down(CInt gamepad, CInt button) @extern("IsGamepadButtonDown");                           // Check if a gamepad button is being pressed
extern fn bool is_gamepad_button_released(CInt gamepad, CInt button) @extern("IsGamepadButtonReleased");                       // Check if a gamepad button has been released once
extern fn bool is_gamepad_button_up(CInt gamepad, CInt button) @extern("IsGamepadButtonUp");                             // Check if a gamepad button is NOT being pressed
extern fn CInt get_gamepad_button_pressed() @extern("GetGamepadButtonPressed");                                           // Get the last gamepad button pressed
extern fn CInt get_gamepad_axis_count(CInt gamepad) @extern("GetGamepadAxisCount");                                        // Get gamepad axis count for a gamepad
extern fn float get_gamepad_axis_movement(CInt gamepad, CInt axis) @extern("GetGamepadAxisMovement");                         // Get axis movement value for a gamepad axis
extern fn CInt set_gamepad_mappings(char *mappings) @extern("SetGamepadMappings");                                // Set internal gamepad mappings (SDL_GameControllerDB)
extern fn void set_gamepad_vibration(CInt gamepad, float leftMotor, float rightMotor, float duration) @extern("SetGamepadVibration"); // Set gamepad vibration for both motors (duration in seconds)


// Input-related functions: mouse
extern fn bool is_mouse_button_pressed(CInt button) @extern("IsMouseButtonPressed");                  // Check if a mouse button has been pressed once
extern fn bool is_mouse_button_down(CInt button) @extern("IsMouseButtonDown");                     // Check if a mouse button is being pressed
extern fn bool is_mouse_button_released(CInt button) @extern("IsMouseButtonReleased");                 // Check if a mouse button has been released once
extern fn bool is_mouse_button_up(CInt button) @extern("IsMouseButtonUp");                       // Check if a mouse button is NOT being pressed
extern fn CInt get_mouse_x() @extern("GetMouseX");                                    // Get mouse position X
extern fn CInt get_mouse_y() @extern("GetMouseY");                                    // Get mouse position Y
extern fn Vector2 get_mouse_position() @extern("GetMousePosition");                         // Get mouse position XY
extern fn Vector2 get_mouse_delta() @extern("GetMouseDelta");                            // Get mouse delta between frames
extern fn void set_mouse_position(CInt x, CInt y) @extern("SetMousePosition");                    // Set mouse position XY
extern fn void set_mouse_offset(CInt offsetX, CInt offsetY) @extern("SetMouseOffset");          // Set mouse offset
extern fn void set_mouse_scale(float scaleX, float scaleY) @extern("SetMouseScale");         // Set mouse scaling
extern fn float get_mouse_wheel_move() @extern("GetMouseWheelMove");                          // Get mouse wheel movement for X or Y, whichever is larger
extern fn Vector2 get_mouse_wheel_move_v() @extern("GetMouseWheelMoveV");                       // Get mouse wheel movement for both X and Y
extern fn void set_mouse_cursor(CInt cursor) @extern("SetMouseCursor");                        // Set mouse cursor

// Input-related functions: touch
extern fn CInt get_touch_x() @extern("GetTouchX");                                    // Get touch position X for touch point 0 (relative to screen size)
extern fn CInt get_touch_y() @extern("GetTouchY");                                    // Get touch position Y for touch point 0 (relative to screen size)
extern fn Vector2 get_touch_position(CInt index) @extern("GetTouchPosition");                    // Get touch position XY for a touch point index (relative to screen size)
extern fn CInt get_touch_point_id(CInt index) @extern("GetTouchPointId");                         // Get touch point identifier for given index
extern fn CInt get_touch_point_count() @extern("GetTouchPointCount");                           // Get number of touch points

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: rgestures)
//------------------------------------------------------------------------------------
extern fn void set_gestures_enabled(CUInt flags) @extern("SetGesturesEnabled");      // Enable a set of gestures using flags
extern fn bool is_gesture_detected(CUInt gesture) @extern("IsGestureDetected");     // Check if a gesture have been detected
extern fn CInt get_gesture_detected() @extern("GetGestureDetected");                     // Get latest detected gesture
extern fn float get_gesture_hold_duration() @extern("GetGestureHoldDuration");               // Get gesture hold time in seconds
extern fn Vector2 get_gesture_drag_vector() @extern("GetGestureDragVector");               // Get gesture drag vector
extern fn float get_gesture_drag_angle() @extern("GetGestureDragAngle");                  // Get gesture drag angle
extern fn Vector2 get_gesture_pinch_vector() @extern("GetGesturePinchVector");              // Get gesture pinch delta
extern fn float get_gesture_pinch_angle() @extern("GetGesturePinchAngle");                 // Get gesture pinch angle

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------
extern fn void update_camera(Camera *camera, CInt mode) @extern("UpdateCamera");      // Update camera position for selected mode
extern fn void update_camera_pro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom) @extern("UpdateCameraPro"); // Update camera movement/rotation

//------------------------------------------------------------------------------------
// Basic Shapes Drawing Functions (Module: shapes)
//------------------------------------------------------------------------------------
// Set texture and rectangle to be used on shapes drawing
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call
extern fn void set_shapes_texture(Texture2D texture, Rectangle source) @extern("SetShapesTexture");       // Set texture and rectangle to be used on shapes drawing
extern fn Texture2D get_shapes_texture() @extern("GetShapesTexture");                                 // Get texture that is used for shapes drawing
extern fn Rectangle get_shapes_texture_rectangle() @extern("GetShapesTextureRectangle");                        // Get texture source rectangle that is used for shapes drawing

// Basic shapes drawing functions
extern fn void draw_pixel(CInt posX, CInt posY, Color color) @extern("DrawPixel");                                             // Draw a pixel using geometry [Can be slow, use with care]
extern fn void draw_pixel_v(Vector2 position, Color color) @extern("DrawPixelV");                                                    // Draw a pixel using geometry (Vector version) [Can be slow, use with care]
extern fn void draw_line(CInt startPosX, CInt startPosY, CInt endPosX, CInt endPosY, Color color) @extern("DrawLine");                // Draw a line
extern fn void draw_line_v(Vector2 startPos, Vector2 endPos, Color color) @extern("DrawLineV");                                     // Draw a line (using gl lines)
extern fn void draw_line_ex(Vector2 startPos, Vector2 endPos, float thick, Color color) @extern("DrawLineEx");                       // Draw a line (using triangles/quads)
extern fn void draw_line_strip(Vector2 *points, CInt pointCount, Color color) @extern("DrawLineStrip");                            // Draw lines sequence (using gl lines)
extern fn void draw_line_bezier(Vector2 startPos, Vector2 endPos, float thick, Color color) @extern("DrawLineBezier");                   // Draw line segment cubic-bezier in-out interpolation
extern fn void draw_circle(CInt centerX, CInt centerY, float radius, Color color) @extern("DrawCircle");                              // Draw a color-filled circle
extern fn void draw_circle_sector(Vector2 center, float radius, float startAngle, float endAngle, CInt segments, Color color) @extern("DrawCircleSector");      // Draw a piece of a circle
extern fn void draw_circle_sector_lines(Vector2 center, float radius, float startAngle, float endAngle, CInt segments, Color color) @extern("DrawCircleSectorLines"); // Draw circle sector outline
extern fn void draw_circle_gradient(CInt centerX, CInt centerY, float radius, Color inner, Color outer) @extern("DrawCircleGradient");         // Draw a gradient-filled circle
extern fn void draw_circle_v(Vector2 center, float radius, Color color) @extern("DrawCircleV");                                       // Draw a color-filled circle (Vector version)
extern fn void draw_circle_lines(CInt centerX, CInt centerY, float radius, Color color) @extern("DrawCircleLines");                         // Draw circle outline
extern fn void draw_circle_lines_v(Vector2 center, float radius, Color color) @extern("DrawCircleLinesV");                                  // Draw circle outline (Vector version)
extern fn void draw_ellipse(CInt centerX, CInt centerY, float radiusH, float radiusV, Color color) @extern("DrawEllipse");             // Draw ellipse
extern fn void draw_ellipse_lines(CInt centerX, int centerY, float radiusH, float radiusV, Color color) @extern("DrawEllipseLines");        // Draw ellipse outline
extern fn void draw_ring(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, CInt segments, Color color) @extern("DrawRing"); // Draw ring
extern fn void draw_ring_lines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, CInt segments, Color color) @extern("DrawRingLines");    // Draw ring outline
extern fn void draw_rectangle(CInt posX, CInt posY, CInt width, CInt height, Color color) @extern("DrawRectangle");                      // Draw a color-filled rectangle
extern fn void draw_rectangle_v(Vector2 position, Vector2 size, Color color) @extern("DrawRectangleV");                                  // Draw a color-filled rectangle (Vector version)
extern fn void draw_rectangle_rec(Rectangle rec, Color color) @extern("DrawRectangleRec");                                                 // Draw a color-filled rectangle
extern fn void draw_rectangle_pro(Rectangle rec, Vector2 origin, float rotation, Color color) @extern("DrawRectanglePro");                 // Draw a color-filled rectangle with pro parameters
extern fn void draw_rectangle_gradient_v(CInt posX, CInt posY, CInt width, CInt height, Color top, Color bottom) @extern("DrawRectangleGradientV");   // Draw a vertical-gradient-filled rectangle
extern fn void draw_rectangle_gradient_h(CInt posX, CInt posY, CInt width, CInt height, Color left, Color right) @extern("DrawRectangleGradientH");   // Draw a horizontal-gradient-filled rectangle
extern fn void draw_rectangle_gradient_ex(Rectangle rec, Color topLeft, Color bottomLeft, Color topRight, Color bottomRight) @extern("DrawRectangleGradientEx"); // Draw a gradient-filled rectangle with custom vertex colors
extern fn void draw_rectangle_lines(CInt posX, CInt posY, CInt width, CInt height, Color color) @extern("DrawRectangleLines");                   // Draw rectangle outline
extern fn void draw_rectangle_lines_ex(Rectangle rec, float lineThick, Color color) @extern("DrawRectangleLinesEx");                            // Draw rectangle outline with extended parameters
extern fn void draw_rectangle_rounded(Rectangle rec, float roundness, CInt segments, Color color) @extern("DrawRectangleRounded");              // Draw rectangle with rounded edges
extern fn void draw_rectangle_rounded_lines(Rectangle rec, float roundness, CInt segments, Color color) @extern("DrawRectangleRoundedLines");         // Draw rectangle lines with rounded edges
extern fn void draw_rectangle_rounded_lines_ex(Rectangle rec, float roundness, CInt segments, float lineThick, Color color) @extern("DrawRectangleRoundedLinesEx"); // Draw rectangle with rounded edges outline
extern fn void draw_triangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("DrawTriangle");                                // Draw a color-filled triangle (vertex in counter-clockwise order!)
extern fn void draw_triangle_lines(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("DrawTriangleLines");                           // Draw triangle outline (vertex in counter-clockwise order!)
extern fn void draw_triangle_fan(Vector2 *points, CInt pointCount, Color color) @extern("DrawTriangleFan");                          // Draw a triangle fan defined by points (first vertex is the center)
extern fn void draw_triangle_strip(Vector2 *points, CInt pointCount, Color color) @extern("DrawTriangleStrip");                        // Draw a triangle strip defined by points
extern fn void draw_poly(Vector2 center, CInt sides, float radius, float rotation, Color color) @extern("DrawPoly");               // Draw a regular polygon (Vector version)
extern fn void draw_poly_lines(Vector2 center, CInt sides, float radius, float rotation, Color color) @extern("DrawPolyLines");          // Draw a polygon outline of n sides
extern fn void draw_poly_lines_ex(Vector2 center, CInt sides, float radius, float rotation, float lineThick, Color color) @extern("DrawPolyLinesEx"); // Draw a polygon outline of n sides with extended parameters

// Splines drawing functions
extern fn void draw_spline_linear(Vector2 *poCInts, CInt poCIntCount, float thick, Color color) @extern("DrawSplineLinear");                  // Draw spline: Linear, minimum 2 poCInts
extern fn void draw_spline_basis(Vector2 *poCInts, CInt poCIntCount, float thick, Color color) @extern("DrawSplineBasis");                   // Draw spline: B-Spline, minimum 4 poCInts
extern fn void draw_spline_catmull_rom(Vector2 *poCInts, CInt poCIntCount, float thick, Color color) @extern("DrawSplineCatmullRom");              // Draw spline: Catmull-Rom, minimum 4 poCInts
extern fn void draw_spline_bezier_quadratic(Vector2 *poCInts, CInt poCIntCount, float thick, Color color) @extern("DrawSplineBezierQuadratic");         // Draw spline: Quadratic Bezier, minimum 3 poCInts (1 control poCInt): [p1, c2, p3, c4...]
extern fn void draw_spline_bezier_cubic(Vector2 *poCInts, CInt poCIntCount, float thick, Color color) @extern("DrawSplineBezierCubic");             // Draw spline: Cubic Bezier, minimum 4 poCInts (2 control poCInts): [p1, c2, c3, p4, c5, c6...]
extern fn void draw_spline_segment_linear(Vector2 p1, Vector2 p2, float thick, Color color) @extern("DrawSplineSegmentLinear");                    // Draw spline segment: Linear, 2 poCInts
extern fn void draw_spline_segment_basis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentBasis"); // Draw spline segment: B-Spline, 4 poCInts
extern fn void draw_spline_segment_catmull_rom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentCatmullRom"); // Draw spline segment: Catmull-Rom, 4 poCInts
extern fn void draw_spline_segment_bezier_quadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color) @extern("DrawSplineSegmentBezierQuadratic"); // Draw spline segment: Quadratic Bezier, 2 poCInts, 1 control poCInt
extern fn void draw_spline_segment_bezier_cubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentBezierCubic"); // Draw spline segment: Cubic Bezier, 2 poCInts, 2 control poCInts

// Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
extern fn Vector2 get_spline_point_linear(Vector2 startPos, Vector2 endPos, float t) @extern("GetSplinePointLinear");                           // Get (evaluate) spline poCInt: Linear
extern fn Vector2 get_spline_point_basis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @extern("GetSplinePointBasis");              // Get (evaluate) spline poCInt: B-Spline
extern fn Vector2 get_spline_point_catmull_rom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @extern("GetSplinePointCatmullRom");         // Get (evaluate) spline point: Catmull-Rom
extern fn Vector2 get_spline_point_bezier_quad(Vector2 p1, Vector2 c2, Vector2 p3, float t) @extern("GetSplinePointBezierQuad");                     // Get (evaluate) spline poCInt: Quadratic Bezier
extern fn Vector2 get_spline_point_bezier_cubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t) @extern("GetSplinePointBezierCubic");        // Get (evaluate) spline poCInt: Cubic Bezier

// Basic shapes collision detection functions
extern fn bool check_collision_recs(Rectangle rec1, Rectangle rec2) @extern("CheckCollisionRecs");                                           // Check collision between two rectangles
extern fn bool check_collision_circles(Vector2 center1, float radius1, Vector2 center2, float radius2) @extern("CheckCollisionCircles");        // Check collision between two circles
extern fn bool check_collision_circle_rec(Vector2 center, float radius, Rectangle rec) @extern("CheckCollisionCircleRec");                         // Check collision between circle and rectangle
extern fn bool check_collision_circle_line(Vector2 center, float radius, Vector2 p1, Vector2 p2) @extern("CheckCollisionCircleLine");               // Check if circle collides with a line created betweeen two poCInts [p1] and [p2]
extern fn bool check_collision_point_rec(Vector2 poCInt, Rectangle rec) @extern("CheckCollisionPointRec");                                         // Check if poCInt is inside rectangle
extern fn bool check_collision_point_circle(Vector2 poCInt, Vector2 center, float radius) @extern("CheckCollisionPointCircle");                       // Check if poCInt is inside circle
extern fn bool check_collision_point_triangle(Vector2 poCInt, Vector2 p1, Vector2 p2, Vector2 p3) @extern("CheckCollisionPointTriangle");               // Check if poCInt is inside a triangle
extern fn bool check_collision_point_line(Vector2 poCInt, Vector2 p1, Vector2 p2, CInt threshold) @extern("CheckCollisionPointLine");                // Check if poCInt belongs to line created between two poCInts [p1] and [p2] with defined margin in pixels [threshold]
extern fn bool check_collision_point_poly(Vector2 poCInt, Vector2 *poCInts, CInt poCIntCount) @extern("CheckCollisionPointPoly");                // Check if poCInt is within a polygon described by array of vertices
extern fn bool check_collision_lines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoCInt) @extern("CheckCollisionLines"); // Check the collision between two lines defined by two poCInts each, returns collision poCInt by reference
extern fn Rectangle get_collision_rec(Rectangle rec1, Rectangle rec2) @extern("GetCollisionRec");                                         // Get collision rectangle for two rectangles collision

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image loading functions
// NOTE: These functions do not require GPU access
extern fn Image load_image(char *fileName) @extern("LoadImage");                                                             // Load image from file into CPU memory (RAM)
extern fn Image load_image_raw(char *fileName, CInt width, CInt height, CInt format, CInt headerSize) @extern("LoadImageRaw");       // Load image from RAW file data
extern fn Image load_image_anim(char *fileName, CInt *frames) @extern("LoadImageAnim");                                            // Load image sequence from file (frames appended to image.data)
extern fn Image load_image_anim_from_memory(char *fileType, char *fileData, CInt dataSize, CInt *frames) @extern("LoadImageAnimFromMemory"); // Load image sequence from memory buffer
extern fn Image load_image_from_memory(char *fileType, char *fileData, CInt dataSize) @extern("LoadImageFromMemory");      // Load image from memory buffer, fileType refers to extension: i.e. '.png'
extern fn Image load_image_from_texture(Texture2D texture) @extern("LoadImageFromTexture");                                                     // Load image from GPU texture data
extern fn Image load_image_from_screen() @extern("LoadImageFromScreen");                                                                   // Load image from screen buffer and (screenshot)
extern fn bool is_image_valid(Image image) @extern("IsImageValid");                                                                    // Check if an image is valid (data and parameters)
extern fn void unload_image(Image image) @extern("UnloadImage");                                                                     // Unload image from CPU memory (RAM)
extern fn bool export_image(Image image, char *fileName) @extern("ExportImage");                                               // Export image data to file, returns true on success
extern fn char* export_image_to_memory(Image image, char *fileType, CInt *fileSize) @extern("ExportImageToMemory");              // Export image to memory buffer
extern fn bool export_image_as_code(Image image, char *fileName) @extern("ExportImageAsCode");                                         // Export image as code file defining an array of bytes, returns true on success

// Image generation functions
extern fn Image gen_image_color(CInt width, CInt height, Color color) @extern("GenImageColor");                                           // Generate image: plain color
extern fn Image gen_image_gradient_linear(CInt width, CInt height, CInt direction, Color start, Color end) @extern("GenImageGradientLinear");        // Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
extern fn Image gen_image_gradient_radial(CInt width, CInt height, float density, Color inner, Color outer) @extern("GenImageGradientRadial");      // Generate image: radial gradient
extern fn Image gen_image_gradient_square(CInt width, CInt height, float density, Color inner, Color outer) @extern("GenImageGradientSquare");      // Generate image: square gradient
extern fn Image gen_image_checked(CInt width, int height, int checksX, int checksY, Color col1, Color col2) @extern("GenImageChecked");    // Generate image: checked
extern fn Image gen_image_white_noise(CInt width, CInt height, float factor) @extern("GenImageWhiteNoise");                                     // Generate image: white noise
extern fn Image gen_image_perlin_noise(CInt width, CInt height, CInt offsetX, CInt offsetY, float scale) @extern("GenImagePerlinNoise");           // Generate image: perlin noise
extern fn Image gen_image_cellular(CInt width, CInt height, CInt tileSize) @extern("GenImageCellular");                                       // Generate image: cellular algorithm, bigger tileSize means bigger cells
extern fn Image gen_image_text(CInt width, CInt height, char *text) @extern("GenImageText");                                       // Generate image: grayscale image from text data

// Image manipulation functions
extern fn Image image_copy(Image image) @extern("ImageCopy");                                                                      // Create an image duplicate (useful for transformations)
extern fn Image image_from_image(Image image, Rectangle rec) @extern("ImageFromImage");                                                  // Create an image from another image piece
extern fn Image image_from_channel(Image image, CInt selectedChannel) @extern("ImageFromChannel");                                          // Create an image from a selected channel of another image (GRAYSCALE)
extern fn Image image_text(char *text, CInt fontSize, Color color) @extern("ImageText");                                      // Create an image from text (default font)
extern fn Image image_text_ex(Font font, char *text, float fontSize, float spacing, Color tint) @extern("ImageTextEx");         // Create an image from text (custom sprite font)
extern fn void image_format(Image *image, CInt newFormat) @extern("ImageFormat");                                                     // Convert image data to desired format
extern fn void image_to_POT(Image *image, Color fill) @extern("ImageToPOT");                                                         // Convert image to POT (power-of-two)
extern fn void image_crop(Image *image, Rectangle crop) @extern("ImageCrop");                                                      // Crop an image to a defined rectangle
extern fn void image_alpha_crop(Image *image, float threshold) @extern("ImageAlphaCrop");                                                // Crop image depending on alpha value
extern fn void image_alpha_clear(Image *image, Color color, float threshold) @extern("ImageAlphaClear");                                  // Clear alpha channel to desired color
extern fn void image_alpha_mask(Image *image, Image alphaMask) @extern("ImageAlphaMask");                                                // Apply alpha mask to image
extern fn void image_alpha_premultiply(Image *image) @extern("ImageAlphaPremultiply");                                                          // Premultiply alpha channel
extern fn void image_blur_gaussian(Image *image, CInt blurSize) @extern("ImageBlurGaussian");                                                // Apply Gaussian blur using a box blur approximation
extern fn void image_kernel_convolution(Image *image, float *kernel, CInt kernelSize) @extern("ImageKernelConvolution");                    // Apply custom square convolution kernel to image
extern fn void image_resize(Image *image, CInt newWidth, CInt newHeight) @extern("ImageResize");                                       // Resize image (Bicubic scaling algorithm)
extern fn void image_resize_NN(Image *image, CInt newWidth, CInt newHeight) @extern("ImageResizeNN");                                      // Resize image (Nearest-Neighbor scaling algorithm)
extern fn void image_resize_canvas(Image *image, CInt newWidth, CInt newHeight, CInt offsetX, CInt offsetY, Color fill) @extern("ImageResizeCanvas"); // Resize canvas and fill with color
extern fn void image_mipmaps(Image *image) @extern("ImageMipmaps");                                                                   // Compute all mipmap levels for a provided image
extern fn void image_dither(Image *image, CInt rBpp, CInt gBpp, CInt bBpp, CInt aBpp) @extern("ImageDither");                            // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
extern fn void image_flip_vertical(Image *image) @extern("ImageFlipVertical");                                                              // Flip image vertically
extern fn void image_flip_horizontal(Image *image) @extern("ImageFlipHorizontal");                                                            // Flip image horizontally
extern fn void image_rotate(Image *image, CInt degrees) @extern("ImageRotate");                                                       // Rotate image by input angle in degrees (-359 to 359)
extern fn void image_rotate_CW(Image *image) @extern("ImageRotateCW");                                                                  // Rotate image clockwise 90deg
extern fn void image_rotate_CCW(Image *image) @extern("ImageRotateCCW");                                                                 // Rotate image counter-clockwise 90deg
extern fn void image_color_tint(Image *image, Color color) @extern("ImageColorTint");                                                    // Modify image color: tint
extern fn void image_color_invert(Image *image) @extern("ImageColorInvert");                                                               // Modify image color: invert
extern fn void image_color_grayscale(Image *image) @extern("ImageColorGrayscale");                                                            // Modify image color: grayscale
extern fn void image_color_contrast(Image *image, float contrast) @extern("ImageColorContrast");                                             // Modify image color: contrast (-100 to 100)
extern fn void image_color_brightness(Image *image, CInt brightness) @extern("ImageColorBrightness");                                           // Modify image color: brightness (-255 to 255)
extern fn void image_color_replace(Image *image, Color color, Color replace) @extern("ImageColorReplace");                                  // Modify image color: replace color
extern fn Color *load_image_colors(Image image) @extern("LoadImageColors");                                                               // Load color data from image as a Color array (RGBA - 32bit)
extern fn Color *load_image_palette(Image image, CInt maxPaletteSize, CInt *colorCount) @extern("LoadImagePalette");                         // Load colors palette from image as a Color array (RGBA - 32bit)
extern fn void unload_image_colors(Color *colors) @extern("UnloadImageColors");                                                             // Unload color data loaded with LoadImageColors()
extern fn void unload_image_palette(Color *colors) @extern("UnloadImagePalette");                                                            // Unload colors palette loaded with LoadImagePalette()
extern fn Rectangle get_image_alpha_border(Image image, float threshold) @extern("GetImageAlphaBorder");                                       // Get image alpha border rectangle
extern fn Color get_image_color(Image image, CInt x, CInt y) @extern("GetImageColor");                                                    // Get image pixel color at (x, y) position

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
extern fn void image_clear_background(Image *dst, Color color) @extern("ImageClearBackground");                                                // Clear image background with given color
extern fn void image_draw_pixel(Image *dst, CInt posX, CInt posY, Color color) @extern("ImageDrawPixel");                                  // Draw pixel within an image
extern fn void image_draw_pixel_v(Image *dst, Vector2 position, Color color) @extern("ImageDrawPixelV");                                   // Draw pixel within an image (Vector version)
extern fn void image_draw_line(Image *dst, CInt startPosX, CInt startPosY, CInt endPosX, CInt endPosY, Color color) @extern("ImageDrawLine"); // Draw line within an image
extern fn void image_draw_line_v(Image *dst, Vector2 start, Vector2 end, Color color) @extern("ImageDrawLineV");                          // Draw line within an image (Vector version)
extern fn void image_draw_line_ex(Image *dst, Vector2 start, Vector2 end, CInt thick, Color color) @extern("ImageDrawLineEx");              // Draw a line defining thickness within an image
extern fn void image_draw_circle(Image *dst, CInt centerX, CInt centerY, CInt radius, Color color) @extern("ImageDrawCircle");               // Draw a filled circle within an image
extern fn void image_draw_circle_v(Image *dst, Vector2 center, CInt radius, Color color) @extern("ImageDrawCircleV");                        // Draw a filled circle within an image (Vector version)
extern fn void image_draw_circle_lines(Image *dst, CInt centerX, CInt centerY, CInt radius, Color color) @extern("ImageDrawCircleLines");          // Draw circle outline within an image
extern fn void image_draw_circle_lines_v(Image *dst, Vector2 center, CInt radius, Color color) @extern("ImageDrawCircleLinesV");                   // Draw circle outline within an image (Vector version)
extern fn void image_draw_rectangle(Image *dst, CInt posX, CInt posY, CInt width, CInt height, Color color) @extern("ImageDrawRectangle");       // Draw rectangle within an image
extern fn void image_draw_rectangle_v(Image *dst, Vector2 position, Vector2 size, Color color) @extern("ImageDrawRectangleV");                 // Draw rectangle within an image (Vector version)
extern fn void image_draw_rectangle_rec(Image *dst, Rectangle rec, Color color) @extern("ImageDrawRectangleRec");                                // Draw rectangle within an image
extern fn void image_draw_rectangle_lines(Image *dst, Rectangle rec, CInt thick, Color color) @extern("ImageDrawRectangleLines");                   // Draw rectangle lines within an image
extern fn void image_draw_triangle(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("ImageDrawTriangle");               // Draw triangle within an image
extern fn void image_draw_triangle_ex(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3) @extern("ImageDrawTriangleEx"); // Draw triangle with interpolated colors within an image
extern fn void image_draw_triangle_lines(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("ImageDrawTriangleLines");          // Draw triangle outline within an image
extern fn void image_draw_triangle_fan(Image *dst, Vector2 *points, CInt pointCount, Color color) @extern("ImageDrawTriangleFan");               // Draw a triangle fan defined by points within an image (first vertex is the center)
extern fn void image_draw_triangle_strip(Image *dst, Vector2 *points, CInt pointCount, Color color) @extern("ImageDrawTriangleStrip");             // Draw a triangle strip defined by points within an image
extern fn void image_draw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint) @extern("ImageDraw");             // Draw a source image within a destination image (tint applied to source)
extern fn void image_draw_text(Image *dst, char *text, CInt posX, CInt posY, CInt fontSize, Color color) @extern("ImageDrawText");   // Draw text (using default font) within an image (destination)
extern fn void image_draw_text_ex(Image *dst, Font font, char *text, Vector2 position, float fontSize, float spacing, Color tint) @extern("ImageDrawTextEx"); // Draw text (custom sprite font) within an image (destination)

// Texture loading functions
// NOTE: These functions require GPU access
extern fn Texture2D load_texture(char *fileName) @extern("LoadTexture");                                                       // Load texture from file into GPU memory (VRAM)
extern fn Texture2D load_texture_from_image(Image image) @extern("LoadTextureFromImage");                                                       // Load texture from image data
extern fn TextureCubeMap load_texture_cubemap(Image image, CInt layout) @extern("LoadTextureCubemap");                                        // Load cubemap from image, multiple image cubemap layouts supported
extern fn RenderTexture2D load_render_texture(CInt width, CInt height) @extern("LoadRenderTexture");                                          // Load texture for rendering (framebuffer)
extern fn bool is_texture_valid(Texture2D texture) @extern("IsTextureValid");                                                            // Check if a texture is valid (loaded in GPU)
extern fn void unload_texture(Texture2D texture) @extern("UnloadTexture");                                                             // Unload texture from GPU memory (VRAM)
extern fn bool is_render_texture_valid(RenderTexture2D target) @extern("IsRenderTextureValid");                                                 // Check if a render texture is valid (loaded in GPU)
extern fn void unload_render_texture(RenderTexture2D target) @extern("UnloadRenderTexture");                                                  // Unload render texture from GPU memory (VRAM)
extern fn void update_texture(Texture2D texture, void *pixels) @extern("UpdateTexture");                                         // Update GPU texture with new data
extern fn void update_texture_rec(Texture2D texture, Rectangle rec, void *pixels) @extern("UpdateTextureRec");                       // Update GPU texture rectangle with new data

// Texture configuration functions
extern fn void gen_texture_mipmaps(Texture2D *texture) @extern("GenTextureMipmaps");                                                        // Generate GPU mipmaps for a texture
extern fn void set_texture_filter(Texture2D texture, CInt filter) @extern("SetTextureFilter");                                              // Set texture scaling filter mode
extern fn void set_texture_wrap(Texture2D texture, CInt wrap) @extern("SetTextureWrap");                                                  // Set texture wrapping mode

// Texture drawing functions
extern fn void draw_texture(Texture2D texture, CInt posX, CInt posY, Color tint) @extern("DrawTexture");                               // Draw a Texture2D
extern fn void draw_texture_v(Texture2D texture, Vector2 position, Color tint) @extern("DrawTextureV");                                // Draw a Texture2D with position defined as Vector2
extern fn void draw_texture_ex(Texture2D texture, Vector2 position, float rotation, float scale, Color tint) @extern("DrawTextureEx");  // Draw a Texture2D with extended parameters
extern fn void draw_texture_rec(Texture2D texture, Rectangle source, Vector2 position, Color tint) @extern("DrawTextureRec");            // Draw a part of a texture defined by a rectangle
extern fn void draw_texture_pro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTexturePro"); // Draw a part of a texture defined by a rectangle with 'pro' parameters
extern fn void draw_texture_N_patch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTextureNPatch"); // Draws a texture (or part of it) that stretches or shrinks nicely

// Color/pixel related functions
extern fn bool color_is_equal(Color col1, Color col2) @extern("ColorIsEqual");                        // Check if two colors are equal
extern fn Color fade(Color color, float alpha) @extern("Fade");                                       // Get color with alpha applied, alpha goes from 0.0f to 1.0f
extern fn CInt color_to_int(Color color) @extern("ColorToInt");                                       // Get hexadecimal value for a Color (0xRRGGBBAA)
extern fn Vector4 color_normalize(Color color) @extern("ColorNormalize");                             // Get Color normalized as float [0..1]
extern fn Color color_from_normalized(Vector4 normalized) @extern("ColorFromNormalized");             // Get Color from normalized values [0..1]
extern fn Vector3 color_to_HSV(Color color) @extern("ColorToHSV");                                    // Get HSV values for a Color, hue [0..360], saturation/value [0..1]
extern fn Color color_from_HSV(float hue, float saturation, float value) @extern("ColorFromHSV");     // Get a Color from HSV values, hue [0..360], saturation/value [0..1]
extern fn Color color_tint(Color color, Color tint) @extern("ColorTint");                             // Get color multiplied with another color
extern fn Color color_brightness(Color color, float factor) @extern("ColorBrightness");               // Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
extern fn Color color_contrast(Color color, float contrast) @extern("ColorContrast");                 // Get color with contrast correction, contrast values between -1.0f and 1.0f
extern fn Color color_alpha(Color color, float alpha) @extern("ColorAlpha");                          // Get color with alpha applied, alpha goes from 0.0f to 1.0f
extern fn Color color_alpha_blend(Color dst, Color src, Color tint) @extern("ColorAlphaBlend");       // Get src alpha-blended into dst color with tint
extern fn Color color_lerp(Color color1, Color color2, float factor) @extern("ColorLerp");            // Get color lerp interpolation between two colors, factor [0.0f..1.0f]
extern fn Color get_color(CUInt hexValue) @extern("GetColor");                                        // Get Color structure from hexadecimal value
extern fn Color get_pixel_color(void *srcPtr, CInt format) @extern("GetPixelColor");                  // Get Color from a source pixel pointer of certain format
extern fn void set_pixel_color(void *dstPtr, Color color, CInt format) @extern("SetPixelColor");      // Set color formatted into destination pixel pointer
extern fn CInt get_pixel_data_size(CInt width, CInt height, CInt format) @extern("GetPixelDataSize");  // Get pixel data size in bytes for certain format

//------------------------------------------------------------------------------------
// Font Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// Font loading/unloading functions
extern fn Font get_font_default() @extern("GetFontDefault");                                                   // Get the default Font
extern fn Font load_font(char *fileName) @extern("LoadFont");                                                  // Load font from file into GPU memory (VRAM)
extern fn Font load_font_ex(char *fileName, CInt fontSize, CInt *codepoints, CInt codepointCount) @extern("LoadFontEx"); // Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
extern fn Font load_font_from_image(Image image, Color key, CInt firstChar) @extern("LoadFontFromImage");                // Load font from Image (XNA style)
extern fn Font load_font_from_memory(char *fileType, char *fileData, CInt dataSize, CInt fontSize, CInt *codepoints, CInt codepointCount) @extern("LoadFontFromMemory"); // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
extern fn bool is_font_valid(Font font) @extern("IsFontValid");                                                          // Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
extern fn GlyphInfo *load_font_data(char *fileData, CInt dataSize, CInt fontSize, CInt *codepoints, CInt codepointCount, CInt type) @extern("LoadFontData"); // Load font data for further use
extern fn Image gen_image_font_atlas(GlyphInfo *glyphs, Rectangle **glyphRecs, CInt glyphCount, CInt fontSize, CInt padding, CInt packMethod) @extern("GenImageFontAtlas"); // Generate image font atlas using chars info
extern fn void unload_font_data(GlyphInfo *glyphs, CInt glyphCount) @extern("UnloadFontData");                         // Unload font chars info data (RAM)
extern fn void unload_font(Font font) @extern("UnloadFont");                                                           // Unload font from GPU memory (VRAM)
extern fn bool export_font_as_code(Font font, char *fileName) @extern("ExportFontAsCode");                             // Export font as code file, returns true on success

// Text drawing functions
extern fn void draw_FPS(CInt posX, CInt posY) @extern("DrawFPS");                                                     // Draw current FPS
extern fn void draw_text(char *text, CInt posX, CInt posY, CInt fontSize, Color color) @extern("DrawText");       // Draw text (using default font)
extern fn void draw_text_ex(Font font, char *text, Vector2 position, float fontSize, float spacing, Color tint) @extern("DrawTextEx"); // Draw text using font and additional parameters
extern fn void draw_text_pro(Font font, char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint) @extern("DrawTextPro"); // Draw text using Font and pro parameters (rotation)
extern fn void draw_text_codepoint(Font font, CInt codepoint, Vector2 position, float fontSize, Color tint) @extern("DrawTextCodepoint"); // Draw one character (codepoint)
extern fn void draw_text_codepoints(Font font, CInt *codepoints, CInt codepointCount, Vector2 position, float fontSize, float spacing, Color tint) @extern("DrawTextCodepoints"); // Draw multiple character (codepoint)

// Text font info functions
extern fn void set_text_line_spacing(CInt spacing) @extern("SetTextLineSpacing");                                                 // Set vertical line spacing when drawing with line-breaks
extern fn CInt measure_text(char *text, CInt fontSize) @extern("MeasureText");                                      // Measure string width for default font
extern fn Vector2 measure_text_ex(Font font, char *text, float fontSize, float spacing) @extern("MeasureTextEx");    // Measure string size for Font
extern fn CInt get_glyph_index(Font font, CInt codepoint) @extern("GetGlyphIndex");                                          // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
extern fn GlyphInfo get_glyph_info(Font font, CInt codepoint) @extern("GetGlyphInfo");                                     // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
extern fn Rectangle get_glyph_atlas_rec(Font font, CInt codepoint) @extern("GetGlyphAtlasRec");                                 // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found

// Text codepoints management functions (unicode characters)
extern fn char *load_UTF8(CInt *codepoints, CInt length) @extern("LoadUTF8");                // Load UTF-8 text encoded from codepoints array
extern fn void unload_UTF8(char *text) @extern("UnloadUTF8");                                      // Unload UTF-8 text encoded from codepoints array
extern fn CInt *load_codepoints(char *text, CInt *count) @extern("LoadCodepoints");                // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
extern fn void unload_codepoints(CInt *codepoints) @extern("UnloadCodepoints");                           // Unload codepoints data from memory
extern fn CInt get_codepoint_count(char *text) @extern("GetCodepointCount");                          // Get total number of codepoints in a UTF-8 encoded string
extern fn CInt get_codepoint(char *text, CInt *codepointSize) @extern("GetCodepoint");           // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
extern fn CInt get_codepoint_next(char *text, CInt *codepointSize) @extern("GetCodepointNext");       // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
extern fn CInt get_codepoint_previous(char *text, CInt *codepointSize) @extern("GetCodepointPrevious");   // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
extern fn char *codepoint_to_UTF8(CInt codepoint, CInt *utf8Size) @extern("CodepointToUTF8");        // Encode one codepoint into UTF-8 byte array (array length returned as parameter)

// Text strings management functions (no UTF-8 strings, only byte chars)
// NOTE: Some strings allocate memory internally for returned strings, just be careful!
extern fn CInt text_copy(char *dst, char *src) @extern("TextCopy");                                             // Copy one string to another, returns bytes copied
extern fn bool text_is_equal(char *text1, char *text2) @extern("TextIsEqual");                               // Check if two text string are equal
extern fn CUInt text_length(char *text) @extern("TextLength");                                            // Get text length, checks for '\0' ending
extern fn char *text_format(char *text, ...) @extern("TextFormat");                                        // Text formatting with variables (sprintf() style)
extern fn char *text_subtext(char *text, CInt position, CInt length) @extern("TextSubtext");                  // Get a piece of a text string
extern fn char *text_replace(char *text, char *replace, char *by) @extern("TextReplace");             // Replace text string (WARNING: memory must be freed!)
extern fn char *text_insert(char *text, char *insert, CInt position) @extern("TextInsert");                 // Insert text in a position (WARNING: memory must be freed!)
extern fn char *text_join(char **textList, CInt count, char *delimiter) @extern("TextJoin");        // Join text strings with delimiter
extern fn char **text_split(char *text, char delimiter, CInt *count) @extern("TextSplit");                 // Split text into multiple strings
extern fn void text_append(char *text, char *append, CInt *position) @extern("TextAppend");                       // Append text at specific position and move cursor!
extern fn CInt text_find_index(char *text, char *find) @extern("TextFindIndex");                                // Find first text occurrence within a string
extern fn char *text_to_upper(char *text) @extern("TextToUpper");                      // Get upper case version of provided string
extern fn char *text_to_lower(char *text) @extern("TextToLower");                      // Get lower case version of provided string
extern fn char *text_to_pascal(char *text) @extern("TextToPascal");                     // Get Pascal case notation version of provided string
extern fn char *text_to_snake(char *text) @extern("TextToSnake");                      // Get Snake case notation version of provided string
extern fn char *text_to_camel(char *text) @extern("TextToCamel");                      // Get Camel case notation version of provided string

extern fn CInt text_to_integer(char *text) @extern("TextToInteger");                            // Get integer value from text (negative values not supported)
extern fn float text_to_float(char *text) @extern("TextToFloat");                            // Get float value from text (negative values not supported)

//------------------------------------------------------------------------------------
// Basic 3d Shapes Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Basic geometric 3D shapes drawing functions
extern fn void draw_line3D(Vector3 startPos, Vector3 endPos, Color color) @extern("DrawLine3D");                                    // Draw a line in 3D world space
extern fn void draw_point3D(Vector3 position, Color color) @extern("DrawPoint3D");                                                   // Draw a point in 3D space, actually a small line
extern fn void draw_circle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color) @extern("DrawCircle3D"); // Draw a circle in 3D world space
extern fn void draw_triangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color) @extern("DrawTriangle3D");                              // Draw a color-filled triangle (vertex in counter-clockwise order!)
extern fn void draw_triangle_strip3D(Vector3 *points, CInt pointCount, Color color) @extern("DrawTriangleStrip3D");                      // Draw a triangle strip defined by points
extern fn void draw_cube(Vector3 position, float width, float height, float length, Color color) @extern("DrawCube");             // Draw cube
extern fn void draw_cube_v(Vector3 position, Vector3 size, Color color) @extern("DrawCubeV");                                       // Draw cube (Vector version)
extern fn void draw_cube_wires(Vector3 position, float width, float height, float length, Color color) @extern("DrawCubeWires");        // Draw cube wires
extern fn void draw_cube_wires_v(Vector3 position, Vector3 size, Color color) @extern("DrawCubeWiresV");                                  // Draw cube wires (Vector version)
extern fn void draw_sphere(Vector3 centerPos, float radius, Color color) @extern("DrawSphere");                                     // Draw sphere
extern fn void draw_sphere_ex(Vector3 centerPos, float radius, CInt rings, CInt slices, Color color) @extern("DrawSphereEx");            // Draw sphere with extended parameters
extern fn void draw_sphere_wires(Vector3 centerPos, float radius, CInt rings, CInt slices, Color color) @extern("DrawSphereWires");         // Draw sphere wires
extern fn void draw_cylinder(Vector3 position, float radiusTop, float radiusBottom, float height, CInt slices, Color color) @extern("DrawCylinder"); // Draw a cylinder/cone
extern fn void draw_cylinder_ex(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, CInt sides, Color color) @extern("DrawCylinderEx"); // Draw a cylinder with base at startPos and top at endPos
extern fn void draw_cylinder_wires(Vector3 position, float radiusTop, float radiusBottom, float height, CInt slices, Color color) @extern("DrawCylinderWires"); // Draw a cylinder/cone wires
extern fn void draw_cylinder_wires_ex(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, CInt sides, Color color) @extern("DrawCylinderWiresEx"); // Draw a cylinder wires with base at startPos and top at endPos
extern fn void draw_capsule(Vector3 startPos, Vector3 endPos, float radius, CInt slices, CInt rings, Color color) @extern("DrawCapsule"); // Draw a capsule with the center of its sphere caps at startPos and endPos
extern fn void draw_capsule_wires(Vector3 startPos, Vector3 endPos, float radius, CInt slices, CInt rings, Color color) @extern("DrawCapsuleWires"); // Draw capsule wireframe with the center of its sphere caps at startPos and endPos
extern fn void draw_plane(Vector3 centerPos, Vector2 size, Color color) @extern("DrawPlane");                                      // Draw a plane XZ
extern fn void draw_ray(Ray ray, Color color) @extern("DrawRay");                                                                // Draw a ray line
extern fn void draw_grid(CInt slices, float spacing) @extern("DrawGrid");                                                          // Draw a grid (centered at (0, 0, 0))

//------------------------------------------------------------------------------------
// Model 3d Loading and Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Model management functions
extern fn Model load_model(char *fileName) @extern("LoadModel");                                                // Load model from files (meshes and materials)
extern fn Model load_model_from_mesh(Mesh mesh) @extern("LoadModelFromMesh");                                                   // Load model from generated mesh (default material)
extern fn bool is_model_valid(Model model) @extern("IsModelValid");                                                       // Check if a model is valid (loaded in GPU, VAO/VBOs)
extern fn void unload_model(Model model) @extern("UnloadModel");                                                        // Unload model (including meshes) from memory (RAM and/or VRAM)
extern fn BoundingBox get_model_bounding_box(Model model) @extern("GetModelBoundingBox");                                         // Compute model bounding box limits (considers all meshes)

// Model drawing functions
extern fn void draw_model(Model model, Vector3 position, float scale, Color tint) @extern("DrawModel");               // Draw a model (with texture if set)
extern fn void draw_model_ex(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint) @extern("DrawModelEx"); // Draw a model with extended parameters
extern fn void draw_model_wires(Model model, Vector3 position, float scale, Color tint) @extern("DrawModelWires");          // Draw a model wires (with texture if set)
extern fn void draw_model_wires_ex(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint) @extern("DrawModelWiresEx"); // Draw a model wires (with texture if set) with extended parameters
extern fn void draw_model_points(Model model, Vector3 position, float scale, Color tint) @extern("DrawModelPoints"); // Draw a model as points
extern fn void draw_model_points_ex(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint) @extern("DrawModelPointsEx"); // Draw a model as points with extended parameters
extern fn void draw_bounding_box(BoundingBox box, Color color) @extern("DrawBoundingBox");                                   // Draw bounding box (wires)
extern fn void draw_billboard(Camera camera, Texture2D texture, Vector3 position, float scale, Color tint) @extern("DrawBillboard");   // Draw a billboard texture
extern fn void draw_billboard_rec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint) @extern("DrawBillboardRec"); // Draw a billboard texture defined by source
extern fn void draw_billboard_pro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint) @extern("DrawBillboardPro"); // Draw a billboard texture defined by source and rotation

// Mesh management functions
extern fn void upload_mesh(Mesh *mesh, bool dynamic) @extern("UploadMesh");                                            // Upload mesh vertex data in GPU and provide VAO/VBO ids
extern fn void update_mesh_buffer(Mesh mesh, CInt index, void *data, CInt dataSize, CInt offset) @extern("UpdateMeshBuffer"); // Update mesh vertex data in GPU for a specific buffer index
extern fn void unload_mesh(Mesh mesh) @extern("UnloadMesh");                                                           // Unload mesh data from CPU and GPU
extern fn void draw_mesh(Mesh mesh, Material material, Matrix transform) @extern("DrawMesh");                        // Draw a 3d mesh with material and transform
extern fn void draw_mesh_instanced(Mesh mesh, Material material, Matrix *transforms, CInt instances) @extern("DrawMeshInstanced"); // Draw multiple mesh instances with material and different transforms
extern fn BoundingBox get_mesh_bounding_box(Mesh mesh) @extern("GetMeshBoundingBox");                                            // Compute mesh bounding box limits
extern fn void gen_mesh_tangents(Mesh *mesh) @extern("GenMeshTangents");                                                     // Compute mesh tangents
extern fn bool export_mesh(Mesh mesh, char *fileName) @extern("ExportMesh");                                     // Export mesh data to file, returns true on success
extern fn bool export_mesh_as_code(Mesh mesh, char *fileName) @extern("ExportMeshAsCode");                               // Export mesh as code file (.h) defining multiple arrays of vertex attributes

// Mesh generation functions
extern fn Mesh gen_mesh_poly(CInt sides, float radius) @extern("GenMeshPoly");                                            // Generate polygonal mesh
extern fn Mesh gen_mesh_plane(float width, float length, CInt resX, CInt resZ) @extern("GenMeshPlane");                     // Generate plane mesh (with subdivisions)
extern fn Mesh gen_mesh_cube(float width, float height, float length) @extern("GenMeshCube");                            // Generate cuboid mesh
extern fn Mesh gen_mesh_sphere(float radius, CInt rings, CInt slices) @extern("GenMeshSphere");                              // Generate sphere mesh (standard sphere)
extern fn Mesh gen_mesh_hemi_sphere(float radius, CInt rings, CInt slices) @extern("GenMeshHemiSphere");                          // Generate half-sphere mesh (no bottom cap)
extern fn Mesh gen_mesh_cylinder(float radius, float height, CInt slices) @extern("GenMeshCylinder");                         // Generate cylinder mesh
extern fn Mesh gen_mesh_cone(float radius, float height, CInt slices) @extern("GenMeshCone");                             // Generate cone/pyramid mesh
extern fn Mesh gen_mesh_torus(float radius, float size, CInt radSeg, CInt sides) @extern("GenMeshTorus");                   // Generate torus mesh
extern fn Mesh gen_mesh_knot(float radius, float size, CInt radSeg, CInt sides) @extern("GenMeshKnot");                    // Generate trefoil knot mesh
extern fn Mesh gen_mesh_heightmap(Image heightmap, Vector3 size) @extern("GenMeshHeightmap");                                 // Generate heightmap mesh from image data
extern fn Mesh gen_mesh_cubicmap(Image cubicmap, Vector3 cubeSize) @extern("GenMeshCubicmap");                               // Generate cubes-based map mesh from image data

// Material loading/unloading functions
extern fn Material *load_materials(char *fileName, CInt *materialCount) @extern("LoadMaterials");                    // Load materials from model file
extern fn Material load_materials_default() @extern("LoadMaterialDefault");                                                   // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
extern fn bool is_material_valid(Material material) @extern("IsMaterialValid");                                              // Check if a material is valid (shader assigned, map textures loaded in GPU)
extern fn void unload_material(Material material) @extern("UnloadMaterial");                                               // Unload material from GPU memory (VRAM)
extern fn void set_material_texture(Material *material, CInt mapType, Texture2D texture) @extern("SetMaterialTexture");          // Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
extern fn void set_model_mesh_material(Model *model, CInt meshId, CInt materialId) @extern("SetModelMeshMaterial");                  // Set material for a mesh

// Model animations loading/unloading functions
extern fn ModelAnimation *load_model_animations(char *fileName, CInt *animCount) @extern("LoadModelAnimations");            // Load model animations from file
extern fn void update_model_animation(Model model, ModelAnimation anim, CInt frame) @extern("UpdateModelAnimation");               // Update model animation pose (CPU)
extern fn void update_model_animation_bones(Model model, ModelAnimation anim, CInt frame) @extern("UpdateModelAnimationBones");          // Update model animation mesh bone matrices (GPU skinning)
extern fn void unload_model_animation(ModelAnimation anim) @extern("UnloadModelAnimation");                                       // Unload animation data
extern fn void unload_model_animations(ModelAnimation *animations, CInt animCount) @extern("UnloadModelAnimations");                // Unload animation array data
extern fn bool is_model_animation_valid(Model model, ModelAnimation anim) @extern("IsModelAnimationValid");                         // Check model animation skeleton match

// Collision detection functions
extern fn bool check_collision_spheres(Vector3 center1, float radius1, Vector3 center2, float radius2) @extern("CheckCollisionSpheres");   // Check collision between two spheres
extern fn bool check_collision_boxes(BoundingBox box1, BoundingBox box2) @extern("CheckCollisionBoxes");                                 // Check collision between two bounding boxes
extern fn bool check_collision_box_sphere(BoundingBox box, Vector3 center, float radius) @extern("CheckCollisionBoxSphere");                  // Check collision between box and sphere
extern fn RayCollision get_ray_collision_sphere(Ray ray, Vector3 center, float radius) @extern("GetRayCollisionSphere");                    // Get collision info between ray and sphere
extern fn RayCollision get_ray_collision_box(Ray ray, BoundingBox box) @extern("GetRayCollisionBox");                                    // Get collision info between ray and box
extern fn RayCollision get_ray_collision_mesh(Ray ray, Mesh mesh, Matrix transform) @extern("GetRayCollisionMesh");                       // Get collision info between ray and mesh
extern fn RayCollision get_ray_collision_triangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3) @extern("GetRayCollisionTriangle");            // Get collision info between ray and triangle
extern fn RayCollision get_ray_collision_quad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) @extern("GetRayCollisionQuad");    // Get collision info between ray and quad

// TODO remaining audio stuff
