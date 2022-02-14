const std = @import("std");
const todo = @import("todo.zig").Todo;

pub fn main() anyerror!void {
    const t:Todo = todo.init();
}

