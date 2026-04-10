<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>AnimationController Documentation</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #0d1117;
        color: #c9d1d9;
        line-height: 1.6;
        padding: 40px;
    }
    h1, h2, h3 {
        color: #58a6ff;
    }
    code {
        background: #161b22;
        padding: 4px 6px;
        border-radius: 6px;
        font-size: 14px;
    }
    pre {
        background: #161b22;
        padding: 15px;
        border-radius: 10px;
        overflow-x: auto;
    }
    .box {
        background: #161b22;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
</style>
</head>

<body>

<h1>🚀 AnimationController</h1>
<p>A lightweight and flexible animation system for Roblox models and viewmodels.</p>

<hr>

<h2>📦 Setup</h2>

<h3>1. Install Module</h3>
<pre>
ReplicatedStorage
└── replicated
    └── libs
        └── animationHandler
            └── animationController.luau
</pre>

<h3>2. Model Requirements</h3>
<pre>
Viewmodel (Model)
├─ Humanoid
├─ HumanoidRootPart
└─ Animations (Folder)
    ├─ Idle
    ├─ Equip
    ├─ Fire
    ├─ Reload
</pre>

<div class="box">
<strong>Important:</strong>
<ul>
<li>Animations must be <code>Animation</code> instances</li>
<li>Each animation must have a valid <code>AnimationId</code></li>
<li>Animator is created automatically</li>
</ul>
</div>

<hr>

<h2>🧠 How It Works</h2>
<ul>
<li>Animations are loaded from the <code>Animations</code> folder</li>
<li>Each animation is cached as an <code>AnimationTrack</code></li>
<li>Handles current and previous animations</li>
<li>Supports queue system</li>
<li>Supports locking system to prevent conflicts</li>
</ul>

<hr>

<h2>📦 Usage</h2>

<h3>1. Create Controller</h3>
<pre>
local AnimationController = require(path.to.animationController)

local anim = AnimationController.new(model)

if not anim then
    error("Failed to create AnimationController")
end
</pre>

<h3>2. Play Loop Animations</h3>
<pre>
anim:play("Idle")
anim:play("Walk")
</pre>

<h3>Custom Config</h3>
<pre>
anim:play("Idle", {
    fadeIn = 0.2,
    fadeOut = 0.1,
    speed = 1,
    looped = true,
    priority = "Idle"
})
</pre>

<h3>3. Play Once (One-shot)</h3>
<pre>
anim:playOnce("Fire")
</pre>

<pre>
anim:playOnce("Reload", nil, function()
    anim:play("Idle")
end)
</pre>

<h3>4. Locked Play</h3>
<pre>
anim:playLocked("Reload", nil, function()
    anim:play("Idle")
end)
</pre>

<p>Prevents other animations from interrupting.</p>

<h3>5. Queue System</h3>
<pre>
anim:queue("Equip")
anim:queue("Idle")
</pre>

<hr>

<h2>🛑 Stopping</h2>

<pre>
anim:stop("Reload")
anim:stop()
anim:stopAll()
</pre>

<hr>

<h2>⚙️ Adjustments</h2>

<pre>
anim:setSpeed("Reload", 1.5)
anim:setWeight("Walk", 0.5)
</pre>

<hr>

<h2>🔍 Get Info</h2>

<pre>
anim:getCurrent()
anim:getPrevious()
anim:isPlaying("Reload")
anim:getProgress("Reload")
anim:getTrack("Reload")
</pre>

<hr>

<h2>🎯 Example Use Cases</h2>

<h3>Fire</h3>
<pre>
if not anim:isPlaying("Reload") then
    anim:playOnce("Fire")
end
</pre>

<h3>Reload</h3>
<pre>
anim:playLocked("Reload", nil, function()
    anim:play("Idle")
end)
</pre>

<h3>Movement</h3>
<pre>
if speed > 10 then
    anim:play("Run")
elseif speed > 1 then
    anim:play("Walk")
else
    anim:play("Idle")
end
</pre>

<h3>Inspect</h3>
<pre>
anim:playOnce("Inspect", nil, function()
    anim:play("Idle")
end)
</pre>

<hr>

<h2>⚠️ Important Notes</h2>

<div class="box">
<strong>Always use cloned models:</strong>
<pre>
-- WRONG
AnimationController.new(template)

-- CORRECT
local clone = template:Clone()
AnimationController.new(clone)
</pre>
</div>

<div class="box">
<strong>Animations won't replay if already playing</strong>
</div>

<div class="box">
<strong>Looped animations must be stopped manually</strong>
</div>

<hr>

<h2>🧹 Cleanup</h2>

<pre>
anim:destroy()
</pre>

<ul>
<li>Stops all animations</li>
<li>Disconnects events</li>
<li>Prevents memory leaks</li>
</ul>

<hr>

<h2>📋 API Summary</h2>

<h3>Playback</h3>
<ul>
<li>:play()</li>
<li>:playOnce()</li>
<li>:playLocked()</li>
<li>:queue()</li>
</ul>

<h3>Control</h3>
<ul>
<li>:stop()</li>
<li>:stopAll()</li>
</ul>

<h3>Settings</h3>
<ul>
<li>:setSpeed()</li>
<li>:setWeight()</li>
</ul>

<h3>Query</h3>
<ul>
<li>:getCurrent()</li>
<li>:getPrevious()</li>
<li>:isPlaying()</li>
<li>:getProgress()</li>
<li>:getTrack()</li>
</ul>

<h3>Lifecycle</h3>
<ul>
<li>:destroy()</li>
</ul>

<hr>

<h2>🔥 Final Notes</h2>
<p>
This system is suitable for:
</p>
<ul>
<li>FPS Viewmodels</li>
<li>Character animations</li>
<li>Ability systems</li>
</ul>

<p>
Built for flexibility, performance, and clean architecture.
</p>

</body>
</html>