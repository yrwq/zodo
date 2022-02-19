const std = @import("std");
const Task = @import("task.zig").Task;

pub const TaskList = std.ArrayList(Task);
pub const StrList = std.ArrayList([]u8);
pub const CharList = std.ArrayList(u8);
pub const max_size = 1 * 1024 * 1024;

pub const Todo = struct {
    alloc: std.mem.Allocator,
    list: TaskList,
    data_path: []const u8,
    data: StrList,
    // TODO config

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return Todo{
            .alloc = allocator,
            .list = TaskList.init(allocator),
            .data_path = undefined,
            .data = StrList.init(allocator),
        };
    }

    pub fn load_data(self: *Self, path: []const u8) !void {
        const file = try std.fs.cwd().openFile(path, .{});
        defer file.close();

        self.data_path = path;
        while (try file.reader().readUntilDelimiterOrEofAlloc(self.alloc, '\n', 1024 * 1024)) |line| {
            try self.data.append(line);
        }
    }

    pub fn parse_data(self: *Self) !void {

        for (self.data.items) |line| {

            var id: u8 = 0;
            var done: u8 = 0;
            var name: CharList = CharList.init(self.alloc);

            id = line[0];
            done = line[2];

            // iterate each character in the current line,
            // from the start of the name
            var i: usize = 4;
            while (i < line.len) : (i += 1) {
                try name.append(line[i]);
            }
            
            var t: Task = Task.init(name, id, done);
            try self.add(t);
        }

        // std.debug.print("id : {c}\n", .{id});
        // std.debug.print("done : {c}\n", .{done});
        // std.debug.print("name : {s}\n", .{name.items});
    }

    pub fn add(self: *Self, t: Task) !void {
        try self.list.append(t);
    }
};
