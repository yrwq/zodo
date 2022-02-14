const std = @import("std")

const StrList = std.ArrayList([]u8);

pub const Todo = struct {
    alloc: std.mem.Allocator,
    todos: StrList,

    const Self = @This();
    
    pub fn init(alloc: std.mem.Allocator) !*Self {
        var todo = try alloc.create(Self);

        todo.* = .{
            .alloc = alloc,
            .todos = StrList.init(alloc),
        };

        return todo;
    }
}
