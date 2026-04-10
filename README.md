---

## ✨ Features

- 🎬 Supports both **looped** and **one-shot** animations  
- 🔒 `playLocked` system to prevent interruptions (e.g. Reload)  
- ⏳ Built-in **queue system** for chaining animations  
- ⚡ Real-time control with `setSpeed` and `setWeight`  
- 🧩 Callback support when animations finish  
- 🛠️ Fully compatible with **Rojo workflows**  
- 🧹 Safe `destroy()` method to prevent memory leaks  
- 🎯 Designed for **FPS systems, characters, and ability systems**

---

## 🚀 Setup

### 1️⃣ Install Module

Place the module inside your project:
```text
ReplicatedStorage
└── replicated
    └── libs
        └── animationHandler
            └── animationController.luau

```
---

### 2️⃣ Model Requirements

- Your model must follow this structure:
```text
Viewmodel / Character (Model)
├─ Humanoid
├─ HumanoidRootPart
└─ Animations (Folder)
    ├─ Idle
    ├─ Equip / Run
    ├─ Fire / Attack
    ├─ Reload / Jump

```

> ⚠️ **Important**
> - Animations must be `Animation` instances  
> - Each must have a valid `AnimationId`  
> - Animator is created automatically  

---

## 🧠 How It Works

- The system scans the `Animations` folder inside the model  
- All animations are loaded using `Animator:LoadAnimation()`  
- Tracks are cached internally for fast access  
- A smart system handles:
  - smooth transitions (fade in/out) **optional fade usage: fadeIn = 0 (disables the fade)**
  - animation conflicts
  - queue execution  
- Animations are accessed by **name (string)**

---

## 📦 Usage

### 1️⃣ Create Controller

```luau
local AnimationController = require(
    game.ReplicatedStorage.replicated.libs.animationHandler.animationController
)

local viewmodelOrCharacter = Model or Character
local anim = AnimationController.new(viewmodel)

if not anim then
    error("Failed to create AnimationController")
end
```

---

### 2️⃣ Basic Playback (Looped)

```luau
anim:play("Idle")

anim:play("Walk", {
    fadeIn = 0.3,
    speed = 1.2,
    looped = true
})
```
---

### 3️⃣ One-Shot & Callback

```luau
anim:playOnce("Fire")
```

```luau
anim:playOnce("Equip", nil, function()
    anim:play("Idle")
end)
```

### 4️⃣ Locked Playback & Queue

```luau
anim:playLocked("Reload", nil, function()
    anim:play("Idle")
end)
```

```luau
-- Will wait until reload finishes
anim:queue("Fire")
```
---

### 🧩 API Reference

- `AnimationController.new(model: Model)`
- Creates a new controller instance.
- Model must contain `Humanoid` and `Animations`.

---

- `:play(name: string, config?: table)`
- Plays looped animations.
- Will not restart if already playing.

---

- `:playOnce(name: string, config?: table, callback?: function)`
- Plays animation once and optionally runs callback when finished.

---

- `:playLocked(name: string, config?: table, callback?: function)`
- Locks the controller until animation finishes.
- Incoming requests are queued.

---

- `:queue(name: string, config?: table, callback?: function)`
- Adds animation to queue.
- Plays automatically when previous finishes.

---

- `:stop(name?: string, fadeTime?: number)`
- Stops specific animation or current one.

---

- `:stopAll()`
- Stops all animations, clears queue, unlocks controller.

---

- `:setSpeed(name: string, speed: number)`
- Adjusts animation speed.

---

- `:setWeight(name: string, weight: number, fadeTime?: number)`
- Adjusts blending weight.

---

- `:destroy()`
- Destroys all tracks and connections.
- **Must be called when model is removed.**

---

## 🛡️ Best Practices

### 🔄 Queue System Flow

```text
[PlayLocked: Reload]
        ↓
   (LOCKED)
        ↓
[Queue: Fire]
[Queue: Inspect]
        ↓
   Reload Ends
        ↓
   Fire Plays
        ↓
   Inspect Plays
```

---

### 🗑️ Destroy Properly

```luau
anim:destroy()
```
- Always destroy before removing the model.

---

### ⏱️ Use Cooldowns

- Prevent animation spam:

```luau
if os.clock() - lastFire > 0.1 then
    anim:playOnce("Fire")
end
```

---

### 🏷️ Naming Convention

- Use clean animation names:

```text
Idle
Walk
Run
Fire
Reload
Inspect
```

---

### 🔥 Critical Note

- ❗ Always create the controller using the **GONNABE USED / CLONED** model, not the template.

```luau
-- ❌ Wrong
AnimationController.new(template)

-- ✅ Correct
local clone = template:Clone()
AnimationController.new(clone)
```

---

### 🤝 Contributing

- Pull requests and issues are welcome.
- For major changes, please open an issue first.