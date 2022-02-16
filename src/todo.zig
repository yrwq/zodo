const std = @import("std");
const Task = @import("task.zig").Task;

pub const TaskList = std.ArrayList(Task);
pub const max_size = 1 * 1024 * 1024;

pub const Todo = struct {
    alloc: std.mem.Allocator,
    list: TaskList,
    // TODO config
    
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return Todo {
            .alloc = allocator,
            .list = TaskList.init(allocator),
        };
    }

    pub fn add(self: *Self, t: Task) !void {
        try self.list.append(t);
    }
};
