# Skill: Create HTML Slide Presentation

## Purpose

Convert a lesson Markdown file (`*_lesson.md`) into a single-file HTML slide deck that the learner can open directly in a browser — no server, no dependencies, no install required.

## Output Location & Naming

```
docs/Slides/0X.TopicName_slides.html
```

| Source file | Slide output |
|---|---|
| `Lessons & Examples/Lesson/03.Datatype_and_Table_lesson.md` | `docs/Slides/03.Datatype_and_Table_slides.html` |
| `Lessons & Examples/Lesson/05.Filter_Data_lesson.md` | `docs/Slides/05.Filter_Data_slides.html` |

**Never** place slide files in `temp/` — always use `docs/Slides/`.

---

## Design System

### Color Palette (CSS custom properties)

```css
:root {
    --primary:       #336791;   /* PostgreSQL blue */
    --primary-light: #4a8db7;
    --primary-dark:  #264d6e;
    --accent:        #f9a825;   /* Gold — headings, highlights */
    --accent-light:  #fdd835;
    --bg:            #0f172a;   /* Dark background */
    --bg-card:       #1e293b;   /* Card background */
    --bg-code:       #0d1117;   /* Code block background */
    --text:          #e2e8f0;
    --text-dim:      #94a3b8;
    --text-bright:   #f8fafc;
    --success:       #22c55e;
    --danger:        #ef4444;
    --warning:       #f59e0b;
    --info:          #3b82f6;
    --excel-green:   #217346;   /* Excel brand green for comparison cards */
    --pg-blue:       #336791;
}
```

### Fonts

```html
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Fira+Code:wght@400;500&display=swap">
```

- **Inter** — body text, UI
- **Fira Code** — all code blocks

---

## Slide Types

Each lesson maps to several slide types. Use the right type for each content category:

### 1. Title Slide (first slide only)
```html
<div class="slide title-slide active">
    <div class="week-badge">TUẦN X</div>
    <h1>Tiêu đề bài</h1>
    <p class="subtitle">Subtopics · Listed · Here</p>
    <p>⏱ Thời lượng: X giờ | Yêu cầu: ...</p>
    <p>Hướng dẫn phím tắt ← → Space M</p>
</div>
```

### 2. Section Divider Slide (start of each major section)
```html
<div class="slide section-slide">
    <div class="section-num">3.1</div>
    <h1>Tên Section</h1>
    <p class="subtitle">Mô tả ngắn</p>
</div>
```

### 3. Content Slide (most slides)
```html
<div class="slide">
    <h2>Tiêu đề Slide</h2>
    <!-- content here -->
</div>
```

### 4. Closing Slide (last slide)
```html
<div class="slide title-slide">
    <div class="week-badge" style="border-color:var(--success);color:var(--success);">TIẾP THEO</div>
    <h1>Tuần X+1: ...</h1>
    <p class="subtitle">...</p>
</div>
```

---

## Layout Components

### Two-column grid
```html
<div class="columns-2">
    <div><!-- left --></div>
    <div><!-- right --></div>
</div>
```

### Three-column grid
```html
<div class="columns-3">
    <div><!-- ... --></div>
    <div><!-- ... --></div>
    <div><!-- ... --></div>
</div>
```

### Excel vs PostgreSQL comparison (side-by-side)
```html
<div class="compare">
    <div>
        <!-- left border = excel-green -->
        <h3>📊 Excel</h3>
        ...
    </div>
    <div>
        <!-- left border = pg-blue -->
        <h3>🐘 PostgreSQL</h3>
        ...
    </div>
</div>
```

### Visual flow diagram
```html
<div class="diagram">
    <div class="box">Bước 1</div>
    <div class="arrow">→</div>
    <div class="box">Bước 2</div>
    <div class="arrow">→</div>
    <div class="box">Kết quả</div>
</div>
```

---

## Card Variants

```html
<!-- Default card -->
<div class="card">...</div>

<!-- Excel analogy (green left border) -->
<div class="card excel">
    <p>📊 <strong>Excel:</strong> ...</p>
</div>

<!-- Warning / danger (red) -->
<div class="card warning">
    <p>⚠️ <strong>CẢNH BÁO:</strong> ...</p>
</div>

<!-- Tip / success (green) -->
<div class="card tip">
    <p>💡 ...</p>
</div>

<!-- Info / note (blue) -->
<div class="card info">
    <p>📌 ...</p>
</div>
```

---

## Code Blocks with Syntax Highlighting

All SQL code uses `<pre>` with manual span-based highlighting (no JS library):

```html
<pre>
<span class="keyword">SELECT</span> ho_ten, <span class="func">COALESCE</span>(email, <span class="string">'Chưa có'</span>)
<span class="keyword">FROM</span> nhan_vien
<span class="keyword">WHERE</span> luong > <span class="number">10000000</span>;
<span class="comment">-- Lấy tất cả nhân viên có lương cao</span>
</pre>
```

Span classes:
| Class | Color | Used for |
|---|---|---|
| `.keyword` | `#ff7b72` red | SQL keywords: SELECT, FROM, WHERE, INSERT, CREATE... |
| `.type` | `#7ee787` green | Data types: INTEGER, VARCHAR, BOOLEAN, DATE... |
| `.string` | `#a5d6ff` light blue | String literals: `'text'` |
| `.number` | `#79c0ff` blue | Numeric literals |
| `.comment` | `#8b949e` gray italic | Comments: `-- ...` |
| `.func` | `#d2a8ff` purple | Functions: COALESCE, NOW, COUNT, AVG... |

---

## Navigation System

Every slide deck includes:

1. **Progress bar** — thin colored bar at top, tracks position
2. **Nav bar** — fixed at bottom with prev/next buttons and page counter
3. **TOC overlay** — sidebar with all slide titles, opens with `M` key
4. **Keyboard shortcuts**:
   - `→` / `Space` / `PageDown` — next slide
   - `←` / `PageUp` — previous slide
   - `Home` / `End` — first / last slide
   - `M` — toggle table of contents
   - `Escape` — close TOC
5. **Scrollable content** — slides with long content use `.slide-content` wrapper with `overflow-y: auto`

### TOC structure pattern
```html
<div class="toc-panel" onclick="event.stopPropagation()">
    <h3>📑 Mục Lục</h3>
    <a href="#" class="section-header" onclick="goSlide(0)">Trang bìa</a>
    <a href="#" onclick="goSlide(1)">Mục tiêu</a>
    <a href="#" class="section-header" onclick="goSlide(2)">3.1 Tên Section</a>
    <a href="#" onclick="goSlide(3)">Sub-slide 1</a>
    ...
</div>
```

---

## Content Guidelines for Slides

### Slide density rule
- **Max 1 main concept per slide**
- If content is long, use `.slide-content` (scrollable) or split into 2 slides
- Never cram > 6 bullet points on a single slide

### Every concept slide must have (where applicable)
1. Vietnamese explanation (h2 heading + paragraph)
2. SQL code example (styled `<pre>`)
3. Excel analogy card (`<div class="card excel">`)
4. Warning card if it's a dangerous/tricky operation (`<div class="card warning">`)

### Section structure per lesson
Follow the lesson's own sections — each `## Section X.Y` in the `.md` becomes:
- 1 section divider slide
- 2–5 content slides depending on depth

### Warning slides
Any content with `> ⚠️ **CẢNH BÁO:**` in the lesson gets a `<div class="card warning">` on the relevant slide — never skip warnings.

---

## Complete HTML Template

The full boilerplate for a new slide file:

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tuần X: [Tên Bài] — PostgreSQL</title>
    <style>
        /* ── paste full CSS from design system ── */
    </style>
</head>
<body>

<div class="progress-bar" id="progressBar"></div>

<!-- TOC Overlay -->
<div class="toc-overlay" id="tocOverlay" onclick="closeTOC()">
    <div class="toc-panel" onclick="event.stopPropagation()">
        <h3>📑 Mục Lục</h3>
        <!-- TOC links here -->
    </div>
</div>

<div class="slide-deck" id="deck">
    <!-- SLIDE 0: Title -->
    <!-- SLIDE 1: Mục tiêu -->
    <!-- SLIDE 2: Mở đầu -->
    <!-- SLIDE N: Section divider -->
    <!-- ... content slides ... -->
    <!-- SLIDE LAST: Cầu nối tuần tiếp -->
</div>

<!-- Nav bar -->
<div class="nav-bar">
    <div><button onclick="toggleTOC()">☰ Mục Lục</button></div>
    <div class="page-info">
        <span id="slideNum">1</span> / <span id="totalSlides">?</span>
    </div>
    <div class="controls">
        <button onclick="prevSlide()">◀ Trước</button>
        <button onclick="nextSlide()">Tiếp ▶</button>
    </div>
</div>

<script>
    const slides = document.querySelectorAll('.slide');
    const totalSlides = slides.length;
    let current = 0;

    document.getElementById('totalSlides').textContent = totalSlides;

    function showSlide(n) {
        slides[current].classList.remove('active');
        current = Math.max(0, Math.min(n, totalSlides - 1));
        slides[current].classList.add('active');
        document.getElementById('slideNum').textContent = current + 1;
        document.getElementById('progressBar').style.width =
            ((current + 1) / totalSlides * 100) + '%';
    }

    function nextSlide() { showSlide(current + 1); }
    function prevSlide() { showSlide(current - 1); }
    function goSlide(n)  { showSlide(n); closeTOC(); }

    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'PageDown') {
            e.preventDefault(); nextSlide();
        } else if (e.key === 'ArrowLeft' || e.key === 'PageUp') {
            e.preventDefault(); prevSlide();
        } else if (e.key === 'Home') {
            e.preventDefault(); showSlide(0);
        } else if (e.key === 'End') {
            e.preventDefault(); showSlide(totalSlides - 1);
        } else if (e.key === 'm' || e.key === 'M') {
            toggleTOC();
        } else if (e.key === 'Escape') {
            closeTOC();
        }
    });

    function toggleTOC() { document.getElementById('tocOverlay').classList.toggle('open'); }
    function closeTOC()  { document.getElementById('tocOverlay').classList.remove('open'); }

    showSlide(0);
</script>
</body>
</html>
```

---

## Reference: 03.Datatype_and_Table_slides.html

The canonical example of a complete slide deck built with this skill:

```
docs/Slides/03.Datatype_and_Table_slides.html
```

Consult it for:
- Full CSS implementation
- All component examples in context
- TOC structure pattern
- How to balance content across ~27 slides for a 4–5 hour lesson
