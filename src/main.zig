const std = @import("std");
const Todo = @import("todo.zig").Todo;

const ansi = @import("ansi.zig");

fn usage() void {}

pub fn main() anyerror!void {
    var todo: Todo = undefined;

    // simple page allocator
    const alloc: std.mem.Allocator = std.heap.page_allocator;

    // initialize the todolist
    todo = Todo.init(alloc);

    // load data
    try todo.load_data("example");

    // parse loaded data
    try todo.parse_data();

    std.debug.print("\n\n", .{});
    for (todo.list.items) |item| {
        switch(item.done) {
            't' => {
                std.debug.print("\t{c} {s}{s}  {s}\n", .{
                    item.id,
                    ansi.fg_green,
                    ansi.res,
                    item.name.items,
                });
            },
            'f' => {
                std.debug.print("\t{c} {s}{s}  {s}\n", .{
                    item.id,
                    ansi.fg_red,
                    ansi.res,
                    item.name.items,
                });
            },
            else => {},
        }
    }
    std.debug.print("\n\n", .{});
}
