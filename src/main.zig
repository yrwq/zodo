const std = @import("std");
const Todo = @import("todo.zig").Todo;

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

    for (todo.list.items) |item| {
        std.debug.print("{s}\n", .{item.name.items});
    }
}
