conky.config = require("widgets.lib.common").extend_config {
   -- positioning
   alignment = 'bottom_left',
    gap_x = 50,
    gap_y = -200,
    minimum_width = 128,
    minimum_height = 128,
};

conky.text = [[
${if_match "" != "${exec ./scripts/get-metadata}"}
	${execp ./scripts/fetch-art}
${endif}
]];
