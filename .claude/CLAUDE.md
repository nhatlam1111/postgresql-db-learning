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
├── README.md            # Project overview & learning guide (start here)
├── plan.md              # Main 10-week curriculum (the core deliverable)
├── requirement.md       # Original project requirement
├── .gitignore           # Git ignore rules
├── Week-1/
│   ├── lesson.md        # Detailed lesson content for Week 1
│   ├── exercises.md     # Exercises for Week 1
│   └── examples.sql     # SQL examples used in Week 1
├── Week-2/
│   ├── lesson.md        # Detailed lesson content for Week 2
│   ├── exercises.md     # Exercises for Week 2
│   └── examples.sql     # SQL examples used in Week 2
├── Week-3/
│   ├── lesson.md        # Detailed lesson content for Week 3
│   ├── exercises.md     # Exercises for Week 3
│   ├── examples.sql     # SQL examples used in Week 3
│   └── type_casting.md  # Supplementary reference: Type Casting deep-dive
├── Week-4/
│   ├── lesson.md        # Detailed lesson content for Week 4
│   ├── exercises.md     # Exercises for Week 4
│   └── examples.sql     # SQL examples used in Week 4
├── temp/
│   ├── handover.md      # Session handover notes
│   └── Week-*/plan.md   # Draft/planning notes per week
└── .claude/
    └── CLAUDE.md        # This file — AI assistant instructions

```

### Supplementary Reference Files

Some weeks include extra deep-dive reference files alongside the main lesson:

| File | Week | Purpose |
|---|---|---|
| `Week-3/type_casting.md` | 3 | Full reference for CAST, ::, TO_CHAR, TO_DATE, TO_NUMBER |

When adding new supplementary files, link them from the main `lesson.md` of that week and add a row to this table.

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

### SQL Examples
- SQL keywords in UPPERCASE: `SELECT`, `FROM`, `WHERE`, `GROUP BY`
- Table/column names in Vietnamese snake_case: `nhan_vien`, `ho_ten`, `ngay_sinh`
- Always include comments (`--`) explaining what each query does
- For dangerous operations (UPDATE/DELETE), always show the safety pattern:
  1. Run SELECT with same WHERE first
  2. Then run UPDATE/DELETE

### Exercises
- Each week ends with a "Bài tập" section
- Exercises are numbered and have three difficulty tiers where appropriate:
  - Cơ bản (basic)
  - Trung bình (intermediate)  
  - Nâng cao (advanced)
- Exercises use the same example datasets introduced during that week

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

## Notes

- The learner is comfortable with data analysis logic — you don't need to over-explain analytical reasoning
- She IS NOT comfortable with technical jargon — always define terms in plain language
- Analogies matter more than precision at the beginner stage — prefer clear over technically exhaustive
- Practical exercises are essential — theory without hands-on practice won't stick
