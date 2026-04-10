<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AnimationController — Kullanım Rehberi</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/styles/atom-one-dark.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/highlight.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/languages/lua.min.js"></script>
    <script>hljs.highlightAll();</script>

    <style>
        :root {
            --bg-color: #0d1117;
            --container-bg: #161b22;
            --border-color: #30363d;
            --text-main: #c9d1d9;
            --text-muted: #8b949e;
            --accent: #58a6ff;
            --accent-hover: #79c0ff;
            --code-font: 'Fira Code', monospace;
            --main-font: 'Inter', sans-serif;
        }

        body {
            font-family: var(--main-font);
            background-color: var(--bg-color);
            color: var(--text-main);
            line-height: 1.6;
            margin: 0;
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        h1 {
            font-size: 2.2rem;
            color: var(--accent);
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 15px;
            margin-bottom: 30px;
        }

        h2 {
            font-size: 1.5rem;
            color: #ffffff;
            margin-top: 50px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        h2 span {
            color: var(--accent);
            font-family: var(--code-font);
            font-size: 1.2rem;
        }

        p {
            margin-bottom: 15px;
        }

        /* Tree View Styling */
        .tree-view {
            background-color: var(--container-bg);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 20px;
            font-family: var(--code-font);
            font-size: 0.9rem;
            color: var(--text-muted);
            line-height: 1.4;
            white-space: pre;
            overflow-x: auto;
            margin-bottom: 30px;
        }

        .tree-view .highlight { color: #7ee787; }
        .tree-view .comment { color: #8b949e; font-style: italic; }

        /* Code Block Styling */
        pre {
            margin: 0;
        }

        .code-wrapper {
            background-color: var(--container-bg);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .code-header {
            background-color: #010409;
            padding: 8px 15px;
            border-bottom: 1px solid var(--border-color);
            font-family: var(--code-font);
            font-size: 0.8rem;
            color: var(--text-muted);
            display: flex;
            justify-content: space-between;
        }

        code {
            font-family: var(--code-font);
            font-size: 0.95rem;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: var(--container-bg);
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: #010409;
            color: var(--accent);
            font-weight: 600;
        }

        tr:last-child td {
            border-bottom: none;
        }

        td:first-child {
            font-family: var(--code-font);
            color: #d2a8ff;
            font-size: 0.9rem;
        }

        td:last-child {
            color: var(--text-muted);
        }

        .category-row {
            background-color: #21262d;
            color: #ffffff;
            font-weight: 600;
            font-size: 0.9rem;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        /* Callouts */
        .callout {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            background-color: rgba(248, 81, 73, 0.1);
            border-left: 4px solid #f85149;
            color: #ff7b72;
        }

        .callout.success {
            background-color: rgba(46, 160, 67, 0.1);
            border-left-color: #2ea043;
            color: #3fb950;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>AnimationController — Kullanım Rehberi</h1>
    
    <p><code>replicated/libs/animationHandler/animationController.luau</code> konumu için modül kullanım dokümantasyonu.</p>

    <div class="tree-view">
<span class="highlight">AK47_Viewmodel</span> (Model)
  ├─ Humanoid
  ├─ HumanoidRootPart
  ├─ ... <span class="comment">(silah mesh parçaları)</span>
  └─ <span class="highlight">Animations</span> (Folder)
        ├─ Idle          <span class="comment">(Animation — Looped: true)</span>
        ├─ Equip         <span class="comment">(Animation — Looped: false)</span>
        ├─ Unequip       <span class="comment">(Animation — Looped: false)</span>
        ├─ Fire          <span class="comment">(Animation — Looped: false)</span>
        ├─ FireEmpty     <span class="comment">(Animation — Looped: false)  ← şarjör boşken</span>
        ├─ Reload        <span class="comment">(Animation — Looped: false)</span>
        ├─ ReloadEmpty   <span class="comment">(Animation — Looped: false)  ← komple boşken</span>
        ├─ Run           <span class="comment">(Animation — Looped: true)</span>
        ├─ Walk          <span class="comment">(Animation — Looped: true)</span>
        └─ Inspect       <span class="comment">(Animation — Looped: false)</span></div>

    <div class="code-wrapper">
        <div class="code-header"><span>Modülü Dahil Etme</span><span>Luau</span></div>
<pre><code class="language-lua">local AnimationController = require(
    game.ReplicatedStorage.replicated.libs.animationHandler.animationController
)</code></pre>
    </div>

    <h2><span>1.</span> Oluşturma</h2>
    <p>Viewmodel yüklendiğinde bir kez oluşturulmalıdır. Humanoid yoksa <code>nil</code> dönebilir, bu yüzden mutlaka kontrol edilmelidir.</p>
    <div class="code-wrapper">
<pre><code class="language-lua">local viewmodelModel: Model = workspace.Camera:FindFirstChild("AK47_Viewmodel") :: Model
local anim = AnimationController.new(viewmodelModel)

if not anim then
    error("AnimationController oluşturulamadı")
end</code></pre>
    </div>

    <h2><span>2.</span> Temel Oynatma</h2>
    <p><code>:play()</code> metodu looped (tekrarlanan) animasyonlar (Idle, Walk, Run) için idealdir. Eğer animasyon zaten oynuyorsa tekrar baştan başlatmaz.</p>
    <div class="code-wrapper">
<pre><code class="language-lua">anim:play("Idle")
anim:play("Walk")
anim:play("Run")

-- Özel config ile detaylı kullanım:
anim:play("Idle", {
    fadeIn   = 0.3,   -- geçiş süresi (saniye)
    fadeOut  = 0.2,
    speed    = 1.0,
    looped   = true,
    priority = "Idle",
})</code></pre>
    </div>

    <h2><span>3.</span> Tek Seferlik OYNATMA</h2>
    <p><code>:playOnce()</code> metodu bir kez oynar ve bittikten sonra belirlediğiniz callback fonksiyonunu çağırır. Fire, Equip, Inspect gibi one-shot animasyonlar için kullanılır.</p>
    <div class="code-wrapper">
<pre><code class="language-lua">-- Basit kullanım
anim:playOnce("Fire")

-- Callback ile — animasyon bittikten sonra Idle'a dön
anim:playOnce("Equip", nil, function()
    anim:play("Idle")
end)

-- Özel hız ayarı ve Callback
anim:playOnce("Reload", { speed = 1.2 }, function()
    print("Reload bitti, Idle başlıyor")
    anim:play("Idle")
end)</code></pre>
    </div>

    <h2><span>4.</span> Kilitli Oynatma</h2>
    <p><code>:playLocked()</code> metodu kullanıldığında, mevcut animasyon bitmeden başka bir animasyon başlatılamaz. Gelen istekler kuyruğa (queue) alınır.</p>
    <div class="code-wrapper">
<pre><code class="language-lua">-- Reload kilitli oynat
anim:playLocked("Reload", nil, function()
    print("Reload tamamlandı, kilit açıldı")
    anim:play("Idle")
end)

-- Kilit açılana kadar gelen Fire isteği queue'ya girer
-- Reload bittikten SONRA otomatik oynar
anim:queue("Fire")</code></pre>
    </div>

    <h2><span>5.</span> Kuyruk Sistemi (Queue)</h2>
    <p><code>:queue()</code> metodu animasyonları sıraya sokar ve peş peşe (zincirleme) oynatılmalarını sağlar.</p>
    <div class="code-wrapper">
<pre><code class="language-lua">-- Equip -> Idle zinciri
anim:queue("Equip", nil, function()
    print("Equip bitti")
end)
anim:queue("Idle")   -- Equip bittikten sonra otomatik başlar</code></pre>
    </div>

    <h2><span>6.</span> Durdurma</h2>
    <div class="code-wrapper">
<pre><code class="language-lua">-- Belirli animasyonu durdur
anim:stop("Fire")
anim:stop("Reload", 0.3)   -- 0.3 saniye fade (yumuşak geçiş) ile durdur

-- Şu anki oynayan animasyonu durdur
anim:stop()

-- Hepsini durdur (Kuyruğu temizler ve kilidi açar)
anim:stopAll()</code></pre>
    </div>

    <h2><span>7.</span> Hız ve Ağırlık Ayarları</h2>
    <div class="code-wrapper">
<pre><code class="language-lua">-- Reload animasyonunu 1.5x hızında oynat
anim:setSpeed("Reload", 1.5)

-- Birden fazla animasyon blend'i için ağırlık ayarla (0.0 - 1.0 arası)
anim:setWeight("Walk", 0.5)
anim:setWeight("Run",  1.0)</code></pre>
    </div>

    <h2><span>8.</span> Getter'lar (Sorgulama)</h2>
    <div class="code-wrapper">
<pre><code class="language-lua">-- Şu an hangi animasyon oynuyor?
local current = anim:getCurrent()
print("Şu an:", current)   -- "Idle"

-- Bir önceki animasyon
local prev = anim:getPrevious()
print("Önceki:", prev)

-- Belirli bir animasyon oynuyor mu?
if anim:isPlaying("Reload") then
    print("Reload devam ediyor, ateş etme!")
end

-- Animasyon ilerleme durumu? (0 = başlangıç, 1 = son)
local progress = anim:getProgress("Reload")
print(string.format("Reload: %%%.0f", progress * 100))  -- Örn: "Reload: %45"

-- Track objesini doğrudan al (Event bağlamak için)
local reloadTrack = anim:getTrack("Reload")
if reloadTrack then
    -- İstediğin saniyeye atla
    reloadTrack.TimePosition = 0.5

    -- Belirli bir Keyframe Marker'a gelince tetiklenen event
    reloadTrack:GetMarkerReachedSignal("BulletInserted"):Connect(function()
        print("Mermi yerleşti!")
        -- Not: Roblox Animation Editor'da keyframe'e sağ tık -> Add Marker
    end)
end</code></pre>
    </div>

    <h2><span>9.</span> Gerçek Kullanım Senaryoları</h2>
    <div class="code-wrapper">
        <div class="code-header"><span>Silah Mekanikleri Örneği</span><span>Luau</span></div>
<pre><code class="language-lua">-- ── Silah equip edildi ──
local function onEquip()
    anim:stopAll()
    anim:playOnce("Equip", { speed = 1.2 }, function()
        anim:play("Idle")
    end)
end

-- ── Ateş ──
local lastFireAnim = 0
local FIRE_ANIM_COOLDOWN = 0.1   -- çok sık çağrılmasını engellemek için

local function onFire(isEmpty: boolean)
    local now = os.clock()
    if (now - lastFireAnim) < FIRE_ANIM_COOLDOWN then return end
    lastFireAnim = now

    if anim:isPlaying("Reload") then return end   -- reload sırasında oynama

    local animName = isEmpty and "FireEmpty" or "Fire"
    anim:playOnce(animName)
    -- Not: Fire non-looped olduğu için otomatik biter, Idle ile beraber oynayabilir.
end

-- ── Reload ──
local function onReload(isEmpty: boolean)
    if anim:isPlaying("Reload") or anim:isPlaying("ReloadEmpty") then
        return   -- zaten reload yapılıyor
    end

    local animName = isEmpty and "ReloadEmpty" or "Reload"

    -- Kilitli oynat — reload bitmeden fire animasyonu başlamasın
    anim:playLocked(animName, nil, function()
        anim:play("Idle")
        -- Ammo güncelleme event'ini burada ateşleyebilirsin
    end)
end

-- ── Koşma / Yürüme / Durma ──
local function onMovementUpdate(speed: number)
    if anim:isPlaying("Reload") then return end   -- reload sırasında etkileme

    if speed > 14 then
        anim:play("Run")
    elseif speed > 1 then
        anim:play("Walk")
    else
        anim:play("Idle")
    end
end

-- ── Inspect ──
local function onInspect()
    if anim:isPlaying("Reload") then return end

    anim:playOnce("Inspect", { speed = 0.9 }, function()
        anim:play("Idle")
    end)
end

-- ── Silah unequip ──
local function onUnequip(destroyCallback: () -> ())
    anim:stopAll()
    anim:playOnce("Unequip", nil, function()
        destroyCallback()   -- viewmodel'i sil
    end)
end</code></pre>
    </div>

    <h2><span>10.</span> Temizlik (Garbage Collection)</h2>
    <p>Viewmodel unload olduğunda (silindiğinde) bellek sızıntısını (memory leak) önlemek için mutlaka temizlik fonksiyonu çağrılmalıdır.</p>
    
    <div class="callout">
        <strong>❌ YANLIŞ:</strong> <code>anim</code> objesini temizlemeden direkt <code>viewmodelModel:Destroy()</code> yaparsan animasyon trackleri arka planda bellek sızdırır.
    </div>
    
    <div class="callout success">
        <strong>✅ DOĞRU:</strong> Önce animasyon kontrolcüsünü, sonra modeli sil.
    </div>

    <div class="code-wrapper">
<pre><code class="language-lua">local function onViewmodelUnload()
    anim:destroy()
    -- viewmodelModel:Destroy() -> (Zaten viewmodel.unload() içinde yapılıyor varsayılır)
end</code></pre>
    </div>

    <h2>Fonksiyon Özeti (API Referans)</h2>
    <table>
        <thead>
            <tr>
                <th>Metot / Tip</th>
                <th>Açıklama</th>
            </tr>
        </thead>
        <tbody>
            <tr class="category-row"><td colspan="2">Oluşturma</td></tr>
            <tr>
                <td>AnimationController.new(model)</td>
                <td>Controller'ı başlatır. Humanoid/Animator eksikse <code>nil</code> dönebilir.</td>
            </tr>
            <tr class="category-row"><td colspan="2">Oynatma</td></tr>
            <tr>
                <td>:play(name, config?)</td>
                <td>Looped (sürekli tekrar eden) animasyonları oynatır.</td>
            </tr>
            <tr>
                <td>:playOnce(name, config?, callback?)</td>
                <td>One-shot animasyon oynatır, bitince callback tetikler.</td>
            </tr>
            <tr>
                <td>:playLocked(name, config?, callback?)</td>
                <td>Animasyon oynarken başka bir animasyonun araya girmesini kilitler.</td>
            </tr>
            <tr>
                <td>:queue(name, config?, callback?)</td>
                <td>Mevcut kilitli animasyon bitince sıraya alınan animasyonu başlatır.</td>
            </tr>
            <tr class="category-row"><td colspan="2">Durdurma</td></tr>
            <tr>
                <td>:stop(name?, fadeTime?)</td>
                <td>İstenilen veya halihazırda çalan animasyonu yumuşak geçişle durdurur.</td>
            </tr>
            <tr>
                <td>:stopAll()</td>
                <td>Tüm animasyonları durdurur, kuyruğu temizler, kilitleri açar.</td>
            </tr>
            <tr class="category-row"><td colspan="2">Ayarlar</td></tr>
            <tr>
                <td>:setSpeed(name, speed)</td>
                <td>Belirtilen animasyonun oynatma hızını değiştirir.</td>
            </tr>
            <tr>
                <td>:setWeight(name, weight, fade?)</td>
                <td>Animasyonun karışım ağırlığını (blend weight) ayarlar.</td>
            </tr>
            <tr class="category-row"><td colspan="2">Sorgulama</td></tr>
            <tr>
                <td>:getCurrent()</td>
                <td>Şu anda oynatılan ana animasyonun adını döner.</td>
            </tr>
            <tr>
                <td>:getPrevious()</td>
                <td>Bir önceki oynatılan animasyonun adını döner.</td>
            </tr>
            <tr>
                <td>:isPlaying(name)</td>
                <td>Belirtilen animasyonun şu an aktif olup olmadığını döner (boolean).</td>
            </tr>
            <tr>
                <td>:getProgress(name)</td>
                <td>Animasyonun ne kadarının tamamlandığını (0 ile 1 arası) döner.</td>
            </tr>
            <tr>
                <td>:getTrack(name)</td>
                <td>Roblox'un kendi <code>AnimationTrack</code> objesini döndürür (Event vs. için).</td>
            </tr>
            <tr class="category-row"><td colspan="2">Lifecycle (Yaşam Döngüsü)</td></tr>
            <tr>
                <td>:destroy()</td>
                <td>Sınıfı temizler, bağlanan tüm eventleri ve yüklenen trackleri yok eder.</td>
            </tr>
        </tbody>
    </table>

</div>

</body>
</html>