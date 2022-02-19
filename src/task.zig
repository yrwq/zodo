const std = @import("std");

pub const CharList = std.ArrayList(u8);

// Represents a single task
pub const Task = struct {
    id: u8 = 0,
    name: CharList,
    done: u8 = 0,

    const Self = @This();

    // Initialize a new task
    pub fn init(name: CharList, id: u8, done: u8) Self {
        return Task {
            .name = name,
            .done = done,
            .id = id,
        };
    }

};
