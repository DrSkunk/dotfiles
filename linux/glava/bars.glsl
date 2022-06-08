
/* Center line thickness (pixels) */
#define C_LINE 1
/* Width (in pixels) of each bar */
#define BAR_WIDTH 30
/* Width (in pixels) of each bar gap */
#define BAR_GAP 10
/* Outline color */
#define BAR_OUTLINE #262626
// #define BAR_OUTLINE #ffffff
/* Outline width (in pixels, set to 0 to disable outline drawing) */
#define BAR_OUTLINE_WIDTH 0
/* Amplify magnitude of the results each bar displays */
#define AMPLIFY 700
/* Whether the current settings use the alpha channel;
   enabling this is required for alpha to function
   correctly on X11 with `"native"` transparency. */
#define USE_ALPHA /

// This is what worksm but only in 1.frag because there it uses abs(p)
// #define COLOR mix(mix(#7812b8, #e70049 , p), #e6004b , clamp(d / 1000, 0, 1))

/* Direction that the bars are facing, 0 for inward, 1 for outward */
#define DIRECTION 1
/* Whether to switch left/right audio buffers */
#define INVERT 0
/* Whether to flip the output vertically */
#define FLIP 1
/* Whether to mirror output along `Y = X`, causing output to render on the left side of the window */
/* Use with `FLIP 1` to render on the right side */
#define MIRROR_YX 0

