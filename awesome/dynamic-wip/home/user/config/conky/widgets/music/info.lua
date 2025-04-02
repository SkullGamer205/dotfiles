conky.config = require("widgets.lib.common").extend_config {
    -- positioning
    gap_x = 50,
    gap_y =0,
    minimum_height = 200,

    -- text settings
    uppercase = true,
    use_xft = true,
    override_utf8_locale = true,
};

conky.text = [[
${if_match "" != "${exec ./scripts/get-metadata}"}${eval ${lua textcolor}}${font4}NOW PLAYING:
${eval ${lua textcolor}}${font4}
${eval ${lua textcolor}}${font3}           ${font3}${exec ./scripts/get-metadata artist}${font4}
${eval ${lua textcolor}}${font3}           ${font4}${exec ./scripts/get-metadata title}
${eval ${lua textcolor}}${font4}${lua now}${endif}
]];

