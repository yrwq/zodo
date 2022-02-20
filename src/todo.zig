const std = @import("std");
const Task = @import("task.zig").Task;

// list of tasks
pub const TaskList = std.ArrayList(Task);
// list of strings
pub const StrList = std.ArrayList([]u8);
// list of characters (managing strings easier)
pub const CharList = std.ArrayList(u8);

// Represents a task list
pub const Todo = struct {
    alloc: std.mem.Allocator,
    // list of tasks
    list: TaskList,
    // TODO path of data to be loaded
    data_path: []const u8,
    data: StrList,

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
            
            // add each line as a task to the todo list
            // TODO get id
            var t: Task = Task.init(name, id, done);
            try self.add(t);
        }
    }

    pub fn add(self: *Self, t: Task) !void {
        try self.list.append(t);
    }
};
