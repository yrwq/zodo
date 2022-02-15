const std = @import("std");
const Task = @import("task.zig").Task;

pub const StrList = std.ArrayList(Task);

pub const Todo = struct {
    alloc: std.mem.Allocator,
    list: StrList,
    // TODO config
    
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return Todo {
            .alloc = allocator,
            .list = StrList.init(allocator),
        };
    }

    pub fn add(self: *Self, t: Task) !void {
        try self.list.append(t);
    }
};
