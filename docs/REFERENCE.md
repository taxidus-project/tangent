# Tangent Game Engine Reference Manual

Version 0.1.0

## Introduction

Tangent is a modular game engine built in Lua that supports cross-language bindings. It operates on a host-client architecture where Lua scripts (client) interact with platform-specific implementations (host) through a well-defined interface.

## Architecture Overview

```diagram
┌──────────────┐      ┌──────────────┐
│ Client (Lua) │ ←──→ │   Lua VM     │
└──────────────┘      └───────┬──────┘
                            ↑
                      ┌─────────────┐
                      │ Host Engine │
                      └─────────────┘
```

## Core Principles

1. **Script-Driven**: All game logic is written in Lua scripts
2. **Platform Agnostic**: Can run on any platform supporting a Lua VM
3. **Secure Execution**: Scripts run in isolated Lua VM environments
4. **Minimal Complexity**: Uses standard Lua instead of custom DSL

## Components

### Client Scripts (Lua)

Client scripts form the game logic layer and must follow these conventions:

- Scripts must be valid Lua code (5.1+)
- Can only access host functionality through defined bindings
- Should handle lifecycle events (init, update, cleanup)
- Must be stateless or manage their own state explicitly

### Host Engine (Platform Bindings)

The host engine provides the runtime environment and platform-specific implementations:

- Manages the Lua VM instance
- Provides bindings for platform capabilities
- Handles resource management
- Controls script lifecycle
- Implements security policies

## Security Model

### Script Isolation

- Scripts run in sandboxed Lua environments
- Access to system resources is controlled by host bindings
- Memory usage can be limited by the host

### Trust Boundaries

- Host must validate all script inputs
- Scripts must validate all host-provided data
- Communication happens only through defined interfaces

## Standard Bindings

The following bindings must be implemented by all host engines:

### Core System

| Method | Description | Parameters | Returns |
|--------|-------------|------------|---------|
| `engine.version()` | Get engine version | None | String |
| `engine.platform()` | Get platform info | None | String |
| `engine.vendor()` | Get the vendor name | None | String |

### Lifecycle

| Method | Description | Parameters | Returns |
|--------|-------------|------------|---------|
| `engine.update(dt)` | Update tick | dt (number) | None |

### Resource Management

| Method | Description | Parameters | Returns |
|--------|-------------|------------|---------|
| `resource.load(path)` | Load resource | path (string) | Resource ID (string) |
| `resource.unload(id)` | Unload resource | id (number) | Boolean |
| `resource.exists(id)` | Check if exists | id (number) | Boolean |

### Data Management

> **IMPORTANT!**
>
> Data stores are global and are not tied to a single script execution lifecycle
> thus primarly designed for simple persistent data, that you may want to share
> between scripts

| Method | Description | Parameters | Returns |
| ------ | ----------- | ---------- | ------- |
| `store.create(id, n)` | Create a data store | id (string), n (primitive) | Store ID (string) |
| `store.get(id)` | Get the value from a store | id (string) | Primitive |
| `store.remove(id)` | Remove a store | id (string) | Boolean |
| `store.update(id, n)` | Update a store's value | id (string), n (primitive) | Store ID (string) |
| `store.exists(id)` | Check if store exists | id (string) | Boolean |

## Best Practices

### Script Development

1. Always check return values from host calls
2. Use error handling for host operations
3. Keep scripts modular and focused
4. Document dependencies clearly

### Host Implementation

1. Validate all script inputs
2. Provide meaningful error messages
3. Implement resource limits
4. Log important operations

## Error Handling

Scripts should use Lua's error handling mechanisms:

```lua
-- Example error handling
local success, result = pcall(engine.riskyOperation)
if not success then
    engine.log("Operation failed: " .. result)
end
```

## Version History

- 0.1.0 - Initial release

## Further Resources

- Lua Reference Manual: <https://www.lua.org/manual/5.1/>
