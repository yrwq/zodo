const esc = "\x1B";
const csi = esc ++ "[";

pub const fg_red = csi ++ "31m";
pub const fg_green = csi ++ "32m";

pub const bg_black = csi ++ "40m";

pub const res = csi ++ "m";
