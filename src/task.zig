const std = @import("std");

// Represents a single task
pub const Task = struct {
    // TODO: id
    
    name: []u8,
    done: bool = false,

    const Self = @This();

    // Initialize a new task
    pub fn init(name: []u8) Self {
        return Task {
            .name = name,
            .done = false,
        };
    }

};
