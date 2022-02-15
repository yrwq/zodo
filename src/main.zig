const std = @import("std");
const Task = @import("task.zig").Task;
const Todo = @import("todo.zig").Todo;

fn usage() void {}

pub fn main() anyerror!void {
    var task: Task = undefined;
    var todo: Todo = undefined;

    if (std.os.argv.len >= 2) {
        const arg = std.mem.span(std.os.argv[1]);
        task = Task.init(arg);
        todo = Todo.init(std.heap.page_allocator);
        try todo.add(task);

        for (todo.list.items) |item| {
            std.debug.print("{s}", .{item.name});
        }
    } else {
        usage();
    }
}
