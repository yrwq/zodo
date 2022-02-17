const std = @import("std");
const Task = @import("task.zig").Task;

pub const TaskList = std.ArrayList(Task);
pub const max_size = 1 * 1024 * 1024;

pub const Todo = struct {
    alloc: std.mem.Allocator,
    list: TaskList,
    data_path: []const u8,
    data: ?[]u8,
    // TODO config
    
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return Todo {
            .alloc = allocator,
            .list = TaskList.init(allocator),
            .data_path = undefined,
            .data = undefined,
        };
    }

    pub fn load_data(self: *Self, path: []const u8) !void {
        const file = try std.fs.cwd().openFile(path, .{});
        defer file.close();

        const content = try file.reader().readUntilDelimiterOrEofAlloc(self.alloc, '\n', 1024*1024);
        self.data_path = path;
        self.data = content;
    }

    pub fn add(self: *Self, t: Task) !void {
        try self.list.append(t);
    }
};
