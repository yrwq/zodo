const std = @import("std");

// Represents a single task
pub const Task = struct {
    // TODO: id
    name: []const u8 = "task",
    done: bool = false,

    const Self = @This();


    pub fn init(name: []const u8) Self {
        return Task {
            .name = name,
            .done = false,
        };
    }
};
