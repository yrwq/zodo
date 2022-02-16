const std = @import("std");
const Task = @import("task.zig").Task;

pub const TaskList = std.ArrayList(Task);
pub const StrList = std.ArrayList([]u8);
pub const max_size = 1 * 1024 * 1024;

pub const Todo = struct {
    alloc: std.mem.Allocator,
    list: TaskList,
    data: StrList,
    // TODO config
    
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return Todo {
            .alloc = allocator,
            .list = TaskList.init(allocator),
            .data = StrList.init(allocator),
        };
    }

    pub fn load_data(self: *Self, path: []const u8) !void {
        const file = try std.fs.cwd().openFile(path, .{});
        defer file.close();
        while (try file.reader().readUntilDelimiterOrEofAlloc(self.alloc, '\n', max_size)) |line| {
            try self.data.append(line);
        }
    }

    pub fn add(self: *Self, t: Task) !void {
        try self.list.append(t);
    }
};
