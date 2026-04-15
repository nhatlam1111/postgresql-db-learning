# CLAUDE.md — PostgreSQL Learning Project

## Project Overview

This project is a **beginner-friendly PostgreSQL learning curriculum** designed for a specific learner profile. All content, explanations, exercises, and feedback must be written in **Vietnamese**.

## Target Learner Profile

The learner is a person who:
- Has **zero programming or coding background**
- Has **excellent Excel and data analysis skills** (pivot tables, VLOOKUP, filters, formulas)
- Is **highly intelligent and detail-oriented**
- Learns best through **analogies to tools they already know** (Excel)

This profile is critical — every explanation should bridge from Excel concepts to SQL/database concepts.

## Teaching Methodology

**Core principle: Excel as the bridge.**

Every new SQL concept must be introduced by comparison to its Excel equivalent:

| SQL concept | Map to Excel equivalent |
|---|---|
| Database | Workbook (.xlsx file) |
| Table | Sheet (worksheet) |
| Column | Column (A, B, C…) |
| Row/Record | Row (1, 2, 3…) |
| Data Type | Data Validation |
| WHERE | Filter |
| ORDER BY | Sort |
| JOIN | VLOOKUP / INDEX-MATCH |
| GROUP BY | Pivot Table |
| Aggregate functions | SUM(), AVERAGE(), COUNT() |
| CASE WHEN | IF() / IFS() |
| DISTINCT | Remove Duplicates |
| COALESCE | IFERROR() |
| VIEW | Named formula / saved pivot |

**Other teaching guidelines:**
- Use real, relatable examples (employees, products, orders, coffee shop)
- Introduce concepts gradually — never jump ahead
- Always show the "why" before the "how"
- Include warnings about dangerous operations (DELETE/UPDATE without WHERE)
- Exercises should progress: basic → intermediate → advanced within each week

## Project Structure

```
postgresql-db-learning/
├── README.md                                      # Project overview & learning guide
├── plan.md                                       # Main 10-week curriculum
├── requirement.md                                # Original project requirement
├── .gitignore
│
├── Lessons & Examples/                           # Lessons + runnable SQL examples
│   ├── Lesson/                                  # Theory content (.md files)
│   │   ├── 01.Why_Database_lesson.md
│   │   ├── 02.Setup_PostgreSQL_lesson.md
│   │   ├── 03.Datatype_and_Table_lesson.md
│   │   └── 04.SELECT_Basics_lesson.md
│   ├── Example/                                 # Runnable SQL examples (.sql files)
│   │   ├── 01.Why_Database_examples.sql
│   │   ├── 02.Setup_PostgreSQL_examples.sql
│   │   ├── 03.Datatype_and_Table_examples.sql
│   │   └── 04.SELECT_Basics_examples.sql
│   └── Advanced/                                 # Advanced topics (future)
│
├── Exercises/                                    # Practice exercises (separate from lessons)
│   ├── 01.Why_Database_exercises.md
│   ├── 02.Setup_PostgreSQL_exercises.md
│   ├── 03.Datatype_and_Table_exercises.md
│   └── 04.SELECT_Basics_exercises.md
│
├── Reference/                                    # Quick-reference documents
│   ├── type_casting.md
│   └── datatypes_reference.md
│
├── temp/
│   └── ... (notes, drafts)
└── .claude/
    └── CLAUDE.md                                 # This file

```

### Folder Structure Rationale

**Lessons & Examples/Lesson/** — All theory content
- Files: `0X.Topic_lesson.md`
- Easy to find all lessons in one place

**Lessons & Examples/Example/** — All runnable examples
- Files: `0X.Topic_examples.sql`
- Separated from lessons for clarity — learners know where to find working code

**Exercises/** — All practice problems
- Files: `0X.Topic_exercises.md`
- Flat structure (not nested by week) makes it easy to find exercises

This structure clearly separates:
1. **Theory** (Lesson/)
2. **Working Examples** (Example/)
3. **Practice** (Exercises/)
4. **Reference** (Reference/)

### File Naming Convention

All learning content files follow the pattern: `0X.Topic_Type.ext`

| Element | Example | Notes |
|---|---|---|
| `0X` | `01`, `02`, `03`, `04` | Sequential number (matches week order) |
| `.Topic` | `.Why_Database`, `.Setup_PostgreSQL` | Descriptive topic name |
| `_Type` | `_lesson`, `_examples`, `_exercises` | Content type |
| `.ext` | `.md` (lesson/exercise), `.sql` (examples) | File extension |

**Example file naming:**
- `01.Why_Database_lesson.md` ← theory for topic 1
- `01.Why_Database_examples.sql` ← working SQL examples for topic 1
- `01.Why_Database_exercises.md` ← practice problems for topic 1

### plan.md — The Core File

The 10-week curriculum at `plan.md` is structured as:

| Week | Topic | Status |
|---|---|---|
| 1 | Why databases? Excel vs Database concepts | ✅ Done |
| 2 | Installing PostgreSQL & DBeaver | ✅ Done |
| 3 | CREATE TABLE, data types, INSERT | ✅ Done |
| 4 | SELECT basics — viewing data | ✅ Done |
| 5 | WHERE, ORDER BY, LIMIT — filtering & sorting | 📝 In progress |
| 6 | Aggregate functions & GROUP BY (Pivot Table equivalent) | 📝 In progress |
| 7 | JOIN — connecting tables (VLOOKUP equivalent) | 📝 In progress |
| 8 | Subqueries, CASE WHEN, date/string functions | 📝 In progress |
| 9 | UPDATE, DELETE, transactions, VIEWs, CSV import | 📝 In progress |
| 10 | Capstone project — Coffee shop management system | 📝 In progress |

## Content Conventions

### Language
- **All content must be in Vietnamese** — explanations, comments, exercise instructions, column/table names in examples
- SQL keywords remain in English (SELECT, WHERE, etc.) — these are universal
- Use formal but friendly tone (không quá cứng nhắc, gần gũi như giải thích cho bạn bè)

### File Organization
- **Lesson files** (`*_lesson.md`): Theory, explanations, concepts — stored in `Lessons & Examples/Lesson/`
- **Example files** (`*_examples.sql`): Runnable code, demonstrations — stored in `Lessons & Examples/Example/`
- **Exercise files** (`*_exercises.md`): Practice problems with solutions — stored in `Exercises/`

### SQL Examples
- SQL keywords in UPPERCASE: `SELECT`, `FROM`, `WHERE`, `GROUP BY`
- Table/column names in Vietnamese snake_case: `nhan_vien`, `ho_ten`, `ngay_sinh`
- Always include comments (`--`) explaining what each query does
- For dangerous operations (UPDATE/DELETE), always show the safety pattern:
  1. Run SELECT with same WHERE first
  2. Then run UPDATE/DELETE

### Exercises
- Each topic has a "Bài tập" section in `*_exercises.md`
- Exercises are numbered and have three difficulty tiers where appropriate:
  - Cơ bản (basic)
  - Trung bình (intermediate)  
  - Nâng cao (advanced)
- Exercises use the same example datasets introduced during that topic

### Example Datasets Used
The curriculum uses these consistent example tables throughout:
- `nhan_vien` — employee data
- `san_pham` — product catalog
- `khach_hang` — customer data
- `don_hang` — orders
- `chi_tiet_don_hang` — order line items
- Week 10 capstone uses a coffee shop domain (menu, hoa_don, chi_tiet_hoa_don)

## When Expanding This Project

If adding new content (additional lessons, exercises, reference sheets):

1. **Maintain the Excel analogy pattern** — every new concept needs an Excel comparison
2. **Use the established table names** — don't introduce new example schemas unless starting a new topic section
3. **Vietnamese first** — write the explanation in Vietnamese before showing SQL code
4. **Progressive complexity** — simpler version first, then add complexity
5. **Warn about gotchas** — use `> ⚠️ **CẢNH BÁO:**` blocks for dangerous operations
6. **Follow file naming convention** — `0X.TopicName_Type.ext` (e.g., `05.Filter_Data_lesson.md`)
7. **Place files in correct folders**:
   - Lessons → `Lessons & Examples/Lesson/`
   - Examples → `Lessons & Examples/Example/`
   - Exercises → `Exercises/`
   - References → `Reference/`

## Notes

- The learner is comfortable with data analysis logic — you don't need to over-explain analytical reasoning
- She IS NOT comfortable with technical jargon — always define terms in plain language
- Analogies matter more than precision at the beginner stage — prefer clear over technically exhaustive
- Practical exercises are essential — theory without hands-on practice won't stick
- Clear folder structure helps learners focus on content, not searching for files

