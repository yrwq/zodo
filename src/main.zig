const std = @import("std");
const Task = @import("task.zig").Task;

fn usage() void {}

pub fn main() anyerror!void {
    var t: Task = undefined;

    if (std.os.argv.len >= 2) {
        const arg = std.mem.span(std.os.argv[1]);
        t = Task.init(arg);
        std.debug.print("{s}", .{t.name});
    } else {
        usage();
    }
}
