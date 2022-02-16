const std = @import("std");
const Task = @import("task.zig").Task;
const Todo = @import("todo.zig").Todo;

fn usage() void {}

pub fn main() anyerror!void {
    var task: Task = undefined;
    var todo: Todo = undefined;

    if (std.os.argv.len >= 2) {
        const arg = std.mem.span(std.os.argv[1]);

        // initialize a new task
        task = Task.init(arg);

        // initialize a new todo list
        todo = Todo.init(std.heap.page_allocator);

        // add the initialized task to the todo list
        try todo.add(task);

        // print each todo item
        for (todo.list.items) |item| {
            std.debug.print("{s}", .{item.name});
        }

    } else {
        usage();
    }
}
