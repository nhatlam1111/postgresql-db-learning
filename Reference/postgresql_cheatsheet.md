# PostgreSQL Cheatsheet — Tóm Tắt Toàn Khóa Học

> Tài liệu tổng hợp từ Tuần 1–9. Dùng để tra cứu nhanh khi quên cú pháp.
> Mỗi phần có ví dụ ngắn + so sánh Excel để dễ nhớ.

---

## Mục Lục

| Phần | Nội dung |
|---|---|
| [1](#1-khái-niệm-nền-tảng--excel-so-với-database) | Khái niệm nền tảng — Excel vs Database |
| [2](#2-kiểu-dữ-liệu-data-types) | Kiểu dữ liệu (Data Types) |
| [3](#3-tạo--xóa-bảng) | Tạo & Xóa bảng |
| [4](#4-ràng-buộc-constraints) | Ràng buộc (Constraints) |
| [5](#5-nhập-dữ-liệu--insert-into) | Nhập dữ liệu — INSERT INTO |
| [6](#6-đọc-dữ-liệu--select) | Đọc dữ liệu — SELECT |
| [7](#7-lọc-dữ-liệu--where) | Lọc dữ liệu — WHERE |
| [8](#8-sắp-xếp--giới-hạn) | Sắp xếp & Giới hạn |
| [9](#9-hàm-tổng-hợp) | Hàm tổng hợp |
| [10](#10-nhóm-dữ-liệu--group-by--having) | Nhóm dữ liệu — GROUP BY + HAVING |
| [11](#11-kết-nối-bảng--join) | Kết nối bảng — JOIN |
| [12](#12-truy-vấn-lồng-nhau--subquery) | Truy vấn lồng nhau — Subquery |
| [13](#13-phân-loại-điều-kiện--case-when) | Phân loại điều kiện — CASE WHEN |
| [14](#14-hàm-chuỗi) | Hàm chuỗi |
| [15](#15-hàm-ngàygiờ) | Hàm ngày/giờ |
| [16](#16-xử-lý-null) | Xử lý NULL |
| [17](#17-sửa-dữ-liệu--update) | Sửa dữ liệu — UPDATE |
| [18](#18-xóa-dữ-liệu--delete--truncate) | Xóa dữ liệu — DELETE & TRUNCATE |
| [19](#19-transaction) | Transaction |
| [20](#20-view) | VIEW |
| [21](#21-chỉnh-cấu-trúc-bảng--alter-table) | Chỉnh cấu trúc bảng — ALTER TABLE |
| [22](#22-tra-cứu-nhanh--bảng-tổng-hợp) | Tra cứu nhanh — Bảng tổng hợp |

---

## 1. Khái Niệm Nền Tảng — Excel so với Database

| Khái niệm Database | Tương đương Excel | Ghi chú |
|---|---|---|
| **Database** | Workbook (.xlsx) | Nơi chứa toàn bộ dữ liệu |
| **Table** | Sheet (trang tính) | Một tập dữ liệu có cấu trúc |
| **Column** | Cột (A, B, C...) | Một loại thông tin, có tên rõ ràng |
| **Row / Record** | Hàng (1, 2, 3...) | Một mục dữ liệu hoàn chỉnh |
| **Field** | Cell (ô) | Giao điểm của cột và hàng |
| **NULL** | Ô trống | Không có giá trị — khác số 0 và chuỗi rỗng |
| **Primary Key** | Cột STT không trùng | Định danh duy nhất cho mỗi hàng |
| **Foreign Key** | Cột dùng với VLOOKUP | Liên kết đến bảng khác |
| **SQL** | Công thức Excel | Ngôn ngữ giao tiếp với database |
| **Query** | Công thức | Một câu lệnh SQL |

**Quy tắc SQL cơ bản:**
```sql
-- Kết thúc bằng dấu chấm phẩy ;
-- Không phân biệt HOA/thường (nhưng quy ước: từ khóa VIẾT HOA)
-- Comment bắt đầu bằng --
SELECT * FROM nhan_vien;    -- Ví dụ câu SQL hoàn chỉnh
```

---

## 2. Kiểu Dữ Liệu (Data Types)

| Câu hỏi | Kiểu nên dùng | Ví dụ |
|---|---|---|
| Cột id tự tăng? | `SERIAL` | `id SERIAL PRIMARY KEY` |
| Số nguyên thông thường? | `INTEGER` | `so_luong INTEGER` |
| Tiền tệ, giá cả? | `NUMERIC(p,s)` | `luong NUMERIC(12,2)` |
| Tên, email (có giới hạn)? | `VARCHAR(n)` | `ho_ten VARCHAR(100)` |
| Mô tả, ghi chú dài? | `TEXT` | `mo_ta TEXT` |
| Chỉ lưu ngày? | `DATE` | `ngay_sinh DATE` |
| Ngày + giờ? | `TIMESTAMP` | `ngay_tao TIMESTAMP` |
| Đúng/Sai? | `BOOLEAN` | `dang_lam BOOLEAN` |

**Giải thích NUMERIC(p, s):**
```
NUMERIC(12, 2)
         ↑  ↑
         p  s
p = tổng số chữ số  →  12
s = chữ số thập phân →  2
Ví dụ: 9999999999.99  (10 chữ số nguyên + 2 thập phân)
```

> ⚠️ **Tiền tệ luôn dùng NUMERIC — không dùng REAL/FLOAT vì bị lỗi làm tròn!**

---

## 3. Tạo & Xóa Bảng

### CREATE TABLE
```sql
CREATE TABLE nhan_vien (
    id           SERIAL          PRIMARY KEY,
    ho_ten       VARCHAR(100)    NOT NULL,
    phong_ban    VARCHAR(50),
    luong        NUMERIC(12, 2)  CHECK (luong >= 0),
    ngay_sinh    DATE,
    email        VARCHAR(150)    UNIQUE,
    ngay_vao     DATE            DEFAULT CURRENT_DATE,
    dang_lam     BOOLEAN         DEFAULT TRUE
);

-- Tạo nếu chưa có (tránh lỗi khi chạy lại script)
CREATE TABLE IF NOT EXISTS ten_bang ( ... );
```

### DROP TABLE
```sql
DROP TABLE ten_bang;                  -- Xóa bảng và toàn bộ dữ liệu (không hoàn tác!)
DROP TABLE IF EXISTS ten_bang;        -- Không báo lỗi nếu bảng không tồn tại
DROP TABLE ten_bang CASCADE;          -- Xóa cả các bảng phụ thuộc (nguy hiểm!)
```

> ⚠️ **Trước khi DROP: `SELECT COUNT(*) FROM ten_bang;` để biết mình đang xóa bao nhiêu hàng.**

```
DROP TABLE   ↔  Excel: Xóa cả file sheet (bao gồm template)
TRUNCATE     ↔  Excel: Xóa dữ liệu, giữ lại tiêu đề cột
DELETE       ↔  Excel: Xóa từng hàng có chọn lọc
```

---

## 4. Ràng Buộc (Constraints)

| Ràng buộc | Ý nghĩa | Excel tương đương |
|---|---|---|
| `PRIMARY KEY` | Duy nhất + NOT NULL — định danh hàng | Cột STT, không được trùng |
| `NOT NULL` | Bắt buộc phải có giá trị | Trường bắt buộc trong form |
| `UNIQUE` | Giá trị không được trùng (cho phép NULL) | Data Validation không trùng |
| `DEFAULT value` | Tự điền nếu không nhập | Ô đã có giá trị mặc định |
| `CHECK (điều kiện)` | Điều kiện tùy chỉnh phải thỏa mãn | Data Validation → Custom |
| `REFERENCES bang(cot)` | Foreign Key — liên kết bảng khác | VLOOKUP kiểm tra danh sách |

```sql
-- Ví dụ đầy đủ:
luong     NUMERIC(12,2)  CHECK (luong >= 0),
gioi_tinh VARCHAR(3)     CHECK (gioi_tinh IN ('Nam', 'Nữ')),
email     VARCHAR(150)   UNIQUE,
ho_ten    VARCHAR(100)   NOT NULL,
pb_id     INTEGER        REFERENCES phong_ban(id)
```

---

## 5. Nhập Dữ Liệu — INSERT INTO

```sql
-- Một hàng
INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_sinh)
VALUES ('Trần Thị Mai', 'Kế toán', 15000000, '1995-03-20');

-- Nhiều hàng cùng lúc (nhanh hơn nhiều)
INSERT INTO nhan_vien (ho_ten, phong_ban, luong)
VALUES
    ('Nguyễn Văn An',  'Kinh doanh', 20000000),
    ('Lê Thị Bình',    'Nhân sự',    18000000),
    ('Phạm Minh Châu', 'IT',         25000000);

-- Lấy lại giá trị vừa INSERT (lấy id được tạo)
INSERT INTO nhan_vien (ho_ten, luong)
VALUES ('Nguyễn Mới', 18000000)
RETURNING id, ho_ten;
```

**Lưu ý:**
- Chuỗi và ngày dùng **dấu nháy đơn** `'...'`
- Số **không** cần dấu nháy
- Ngày dùng format **`'YYYY-MM-DD'`** (ISO 8601)
- Cột có `DEFAULT` hoặc không `NOT NULL` có thể bỏ qua

---

## 6. Đọc Dữ Liệu — SELECT

```sql
-- Xem tất cả
SELECT * FROM nhan_vien;

-- Chọn cột cụ thể
SELECT ho_ten, luong, phong_ban FROM nhan_vien;

-- Đặt tên hiển thị (Alias) — dấu nháy KÉP cho tiếng Việt
SELECT
    ho_ten    AS "Họ và tên",
    luong     AS "Mức lương (VNĐ)",
    phong_ban AS "Phòng ban"
FROM nhan_vien;

-- Tính toán trong SELECT
SELECT
    ho_ten,
    luong                   AS "Lương gross",
    ROUND(luong * 0.10, 0)  AS "Thuế 10%",
    ROUND(luong * 0.90, 0)  AS "Lương thực nhận"
FROM nhan_vien;
```

**Thứ tự thực thi (quan trọng!):**
```
1. FROM      → Lấy bảng
2. WHERE     → Lọc hàng
3. GROUP BY  → Nhóm
4. HAVING    → Lọc nhóm
5. SELECT    → Chọn cột, tính toán
6. ORDER BY  → Sắp xếp
7. LIMIT     → Cắt kết quả

⚠️  WHERE chạy trước SELECT → không dùng được alias trong WHERE!
```

**Toán tử số học:**
```sql
luong + 5000000   -- Cộng
luong - 2000000   -- Trừ
gia * so_luong    -- Nhân
luong / 12.0      -- Chia (dùng 12.0 để tránh bẫy số nguyên!)
so_luong % 10     -- Phần dư (MOD)
```

> ⚠️ **Bẫy chia số nguyên:** `7 / 2 = 3` (không phải 3.5!). Fix: `7.0 / 2` hoặc `7::NUMERIC / 2`

**DISTINCT — loại bỏ trùng:**
```sql
SELECT DISTINCT phong_ban FROM nhan_vien;           -- Danh sách phòng ban (không trùng)
SELECT COUNT(DISTINCT phong_ban) FROM nhan_vien;    -- Đếm số phòng ban
```
*Excel tương đương: Remove Duplicates*

---

## 7. Lọc Dữ Liệu — WHERE

```sql
SELECT * FROM nhan_vien WHERE phong_ban = 'IT';
```
*Excel tương đương: Filter*

### Toán tử so sánh

| Toán tử | Ý nghĩa | Ví dụ |
|---|---|---|
| `=` | Bằng | `phong_ban = 'IT'` |
| `<>` hoặc `!=` | Khác | `phong_ban <> 'IT'` |
| `>` | Lớn hơn | `luong > 15000000` |
| `<` | Nhỏ hơn | `luong < 20000000` |
| `>=` | Lớn hơn hoặc bằng | `luong >= 15000000` |
| `<=` | Nhỏ hơn hoặc bằng | `luong <= 20000000` |

### AND / OR / NOT
```sql
-- AND: cả hai điều kiện đều đúng
WHERE phong_ban = 'IT' AND luong > 20000000

-- OR: một trong hai điều kiện đúng
WHERE phong_ban = 'IT' OR phong_ban = 'Kinh doanh'

-- NOT: phủ định
WHERE NOT phong_ban = 'IT'
-- hoặc:
WHERE phong_ban <> 'IT'

-- Kết hợp — dùng () để rõ ý
WHERE (phong_ban = 'IT' OR phong_ban = 'Kinh doanh') AND luong > 20000000
```

### BETWEEN / IN
```sql
-- BETWEEN: khoảng giá trị (bao gồm cả 2 đầu)
WHERE luong BETWEEN 15000000 AND 25000000
WHERE ngay_sinh BETWEEN '1990-01-01' AND '2000-12-31'

-- IN: nằm trong danh sách
WHERE phong_ban IN ('IT', 'Kinh doanh', 'Nhân sự')

-- NOT IN: không nằm trong danh sách
WHERE phong_ban NOT IN ('Kế toán')
```

### LIKE — Tìm kiếm theo mẫu
```sql
WHERE ho_ten LIKE 'Nguyễn%'     -- Bắt đầu bằng "Nguyễn"
WHERE ho_ten LIKE '%Văn%'       -- Chứa "Văn" ở bất kỳ đâu
WHERE email LIKE '%@gmail.com'  -- Kết thúc bằng "@gmail.com"
WHERE ho_ten ILIKE '%mai%'      -- ILIKE: không phân biệt hoa/thường
```
```
% = thay thế bất kỳ số ký tự nào (kể cả 0)
_ = thay thế đúng 1 ký tự
```
*Excel tương đương: Filter → "Contains"*

### IS NULL / IS NOT NULL
```sql
WHERE email IS NULL        -- Tìm hàng không có email
WHERE email IS NOT NULL    -- Tìm hàng có email
-- ❌ KHÔNG dùng: WHERE email = NULL  (luôn cho kết quả rỗng!)
```
*Excel tương đương: Filter → Blanks / Non-Blanks*

---

## 8. Sắp Xếp & Giới Hạn

### ORDER BY
```sql
-- Sắp xếp tăng dần (mặc định)
SELECT * FROM nhan_vien ORDER BY luong;
SELECT * FROM nhan_vien ORDER BY luong ASC;     -- ASC = Ascending = tăng dần

-- Sắp xếp giảm dần
SELECT * FROM nhan_vien ORDER BY luong DESC;    -- DESC = Descending = giảm dần

-- Sắp xếp nhiều cột
SELECT * FROM nhan_vien ORDER BY phong_ban ASC, luong DESC;
-- → Sắp xếp theo phòng ban A→Z, trong cùng phòng ban thì lương cao nhất trên
```
*Excel tương đương: Sort*

### LIMIT / OFFSET
```sql
SELECT * FROM nhan_vien LIMIT 10;               -- Chỉ lấy 10 hàng đầu
SELECT * FROM nhan_vien LIMIT 10 OFFSET 20;     -- Bỏ qua 20 hàng, lấy 10 tiếp theo

-- Phân trang: trang 1, 2, 3... (mỗi trang 10 hàng)
-- Trang 1: LIMIT 10 OFFSET 0
-- Trang 2: LIMIT 10 OFFSET 10
-- Trang 3: LIMIT 10 OFFSET 20
-- Công thức: OFFSET = (trang - 1) × số_hàng_mỗi_trang
```

> ⚠️ **Không có ORDER BY → thứ tự không đảm bảo!** Luôn kết hợp LIMIT với ORDER BY.

---

## 9. Hàm Tổng Hợp

| Hàm SQL | Excel | Ý nghĩa |
|---|---|---|
| `COUNT(*)` | `=COUNTA()` | Đếm tất cả hàng (kể cả NULL) |
| `COUNT(cot)` | `=COUNT()` | Đếm hàng không NULL ở cột đó |
| `COUNT(DISTINCT cot)` | *(hàm phức tạp)* | Đếm giá trị khác nhau |
| `SUM(cot)` | `=SUM()` | Tính tổng |
| `AVG(cot)` | `=AVERAGE()` | Tính trung bình (bỏ qua NULL) |
| `MIN(cot)` | `=MIN()` | Giá trị nhỏ nhất |
| `MAX(cot)` | `=MAX()` | Giá trị lớn nhất |

```sql
-- Thống kê toàn bảng
SELECT
    COUNT(*)                AS "Tổng số nhân viên",
    COUNT(email)            AS "Số người có email",
    ROUND(AVG(luong), 0)    AS "Lương trung bình",
    MIN(luong)              AS "Lương thấp nhất",
    MAX(luong)              AS "Lương cao nhất",
    SUM(luong)              AS "Tổng quỹ lương"
FROM nhan_vien;
```

---

## 10. Nhóm Dữ Liệu — GROUP BY + HAVING

*Excel tương đương: Pivot Table*

```sql
-- GROUP BY cơ bản: thống kê theo phòng ban
SELECT
    phong_ban,
    COUNT(*)                AS "Số nhân viên",
    ROUND(AVG(luong), 0)    AS "Lương trung bình"
FROM nhan_vien
GROUP BY phong_ban;

-- GROUP BY nhiều cột
SELECT phong_ban, dang_lam, COUNT(*) AS so_nguoi
FROM nhan_vien
GROUP BY phong_ban, dang_lam;

-- HAVING: lọc sau khi đã nhóm (WHERE lọc trước khi nhóm)
SELECT
    phong_ban,
    COUNT(*)    AS so_nguoi
FROM nhan_vien
GROUP BY phong_ban
HAVING COUNT(*) >= 2;      -- Chỉ lấy phòng ban có từ 2 người trở lên
```

**Phân biệt WHERE vs HAVING:**
```
WHERE  → lọc từng HÀNG (trước khi nhóm)   ≈ Filter trên dữ liệu gốc
HAVING → lọc từng NHÓM (sau khi nhóm)     ≈ Filter trên kết quả Pivot Table
```

**Công thức hoàn chỉnh (đúng thứ tự):**
```sql
SELECT   phong_ban, COUNT(*) AS so_nguoi, AVG(luong) AS luong_tb
FROM     nhan_vien
WHERE    dang_lam = TRUE                   -- lọc trước khi nhóm
GROUP BY phong_ban
HAVING   AVG(luong) > 15000000             -- lọc sau khi nhóm
ORDER BY luong_tb DESC
LIMIT    5;
```

> ⚠️ **Quy tắc GROUP BY:** Mọi cột trong SELECT (không phải hàm tổng hợp) **bắt buộc** phải có trong GROUP BY.

---

## 11. Kết Nối Bảng — JOIN

*Excel tương đương: VLOOKUP / INDEX-MATCH*

### Sơ Đồ 4 Loại JOIN

```
  Bảng A    Bảng B        Bảng A    Bảng B
  ┌────┐   ┌────┐         ┌────┐   ┌────┐
  │ 1  │   │ 1  │ ←khớp  │ 1  │   │ 1  │
  │ 2  │   │ 3  │         │ 2  │   │ 3  │
  │ 3  │   │ 4  │         │ 3  │   │ 4  │
  └────┘   └────┘         └────┘   └────┘

  INNER JOIN              LEFT JOIN
  → Chỉ hàng khớp        → Tất cả A + khớp B
  (1, 3)                  (1, 2→NULL, 3)

  RIGHT JOIN              FULL JOIN
  → Khớp A + tất cả B    → Tất cả A + tất cả B
  (1, 3, 4→NULL)          (1, 2→NULL, 3, 4→NULL)
```

### Cú Pháp
```sql
-- INNER JOIN: chỉ hàng có khớp ở cả hai bảng
SELECT nv.ho_ten, pb.ten_phong
FROM nhan_vien AS nv
INNER JOIN phong_ban AS pb ON nv.pb_id = pb.id;

-- LEFT JOIN: tất cả bảng trái, NULL nếu không khớp bên phải
SELECT kh.ho_ten, dh.ngay_dat, dh.tong_tien
FROM khach_hang AS kh
LEFT JOIN don_hang AS dh ON kh.id = dh.khach_id;
-- → Hiển thị cả khách hàng chưa có đơn hàng nào (NULL ở cột đơn)

-- JOIN nhiều bảng
SELECT kh.ho_ten, dh.id AS don_hang_id, ctdh.ten_sp, ctdh.so_luong
FROM khach_hang AS kh
JOIN don_hang AS dh ON kh.id = dh.khach_id
JOIN chi_tiet_don_hang AS ctdh ON dh.id = ctdh.don_hang_id;
```

**Nguyên tắc đặt alias bảng:**
```sql
FROM nhan_vien AS nv    -- "nv" là alias cho bảng nhan_vien
-- Sau đó dùng: nv.ho_ten, nv.luong (thay vì nhan_vien.ho_ten)
-- Từ khóa AS có thể bỏ: FROM nhan_vien nv
```

> ⚠️ **Lỗi hay gặp:** Quên điều kiện ON → tạo ra Cartesian product (nhân chéo toàn bộ — hàng triệu hàng rác!)

---

## 12. Truy Vấn Lồng Nhau — Subquery

*Excel tương đương: Hàm lồng nhau như `=AVERAGE(IF(...))`*

```sql
-- Subquery trong WHERE: tìm nhân viên lương cao hơn trung bình
SELECT ho_ten, luong
FROM nhan_vien
WHERE luong > (SELECT AVG(luong) FROM nhan_vien);

-- Subquery với IN: tìm khách hàng đã đặt đơn trong tháng 1
SELECT ho_ten
FROM khach_hang
WHERE id IN (
    SELECT DISTINCT khach_id
    FROM don_hang
    WHERE EXTRACT(MONTH FROM ngay_dat) = 1
);

-- Subquery trong FROM (bảng tạm): tính rồi lọc tiếp
SELECT phong_ban, luong_tb
FROM (
    SELECT phong_ban, AVG(luong) AS luong_tb
    FROM nhan_vien
    GROUP BY phong_ban
) AS bang_tam
WHERE luong_tb > 18000000;
```

---

## 13. Phân Loại Điều Kiện — CASE WHEN

*Excel tương đương: `=IF()` / `=IFS()`*

```sql
-- Dạng cơ bản — Searched CASE
SELECT
    ho_ten,
    luong,
    CASE
        WHEN luong >= 25000000 THEN 'Cao'
        WHEN luong >= 15000000 THEN 'Trung bình'
        ELSE 'Thấp'
    END AS "Nhóm lương"
FROM nhan_vien;

-- Dạng rút gọn — Simple CASE (so sánh một giá trị)
SELECT
    ten_sp,
    CASE danh_muc
        WHEN 'Đồ uống'  THEN 'Thức uống'
        WHEN 'Đồ ăn'   THEN 'Thực phẩm'
        ELSE 'Khác'
    END AS "Nhóm"
FROM san_pham;

-- CASE WHEN kết hợp GROUP BY
SELECT
    CASE
        WHEN luong >= 20000000 THEN 'Senior'
        WHEN luong >= 15000000 THEN 'Mid'
        ELSE 'Junior'
    END AS cap_bac,
    COUNT(*) AS so_nguoi
FROM nhan_vien
GROUP BY cap_bac;
```

---

## 14. Hàm Chuỗi

| Hàm | Ý nghĩa | Ví dụ | Excel |
|---|---|---|---|
| `UPPER(s)` | Chữ HOA | `UPPER('hello')` → `'HELLO'` | `=UPPER()` |
| `LOWER(s)` | chữ thường | `LOWER('HI')` → `'hi'` | `=LOWER()` |
| `INITCAP(s)` | Viết Hoa Đầu Từ | `INITCAP('hello world')` → `'Hello World'` | `=PROPER()` |
| `LENGTH(s)` | Độ dài chuỗi | `LENGTH('hello')` → `5` | `=LEN()` |
| `TRIM(s)` | Xóa khoảng trắng 2 đầu | `TRIM('  hi  ')` → `'hi'` | `=TRIM()` |
| `LEFT(s,n)` | Lấy n ký tự trái | `LEFT('hello',3)` → `'hel'` | `=LEFT()` |
| `RIGHT(s,n)` | Lấy n ký tự phải | `RIGHT('hello',3)` → `'llo'` | `=RIGHT()` |
| `SUBSTRING(s,from,count)` | Cắt từ vị trí | `SUBSTRING('hello',2,3)` → `'ell'` | `=MID()` |
| `REPLACE(s,old,new)` | Thay thế | `REPLACE('abc','b','X')` → `'aXc'` | `=SUBSTITUTE()` |
| `POSITION(sub IN s)` | Tìm vị trí | `POSITION('l' IN 'hello')` → `3` | `=FIND()` |
| `SPLIT_PART(s,sep,n)` | Tách chuỗi | `SPLIT_PART('a,b,c',',',2)` → `'b'` | *(không có)* |
| `LPAD(s,n,c)` | Thêm ký tự bên trái | `LPAD('5',3,'0')` → `'005'` | `=TEXT(A1,"000")` |
| `CONCAT(...)` | Nối chuỗi (an toàn hơn `\|\|`) | `CONCAT('A',' ','B')` → `'A B'` | `=CONCAT()` |
| `s1 \|\| s2` | Nối chuỗi | `'Xin' \|\| ' chào'` → `'Xin chào'` | `=A1&" "&B1` |

> ⚠️ **`\|\|` với NULL cho kết quả NULL!** Dùng `CONCAT()` hoặc `COALESCE()` để an toàn hơn.

```sql
-- Ví dụ thực tế
SELECT
    'NV-' || LPAD(id::TEXT, 3, '0')    AS "Mã NV",     -- NV-001, NV-002...
    UPPER(TRIM(email))                  AS "Email chuẩn",
    SPLIT_PART(email, '@', 1)           AS "Username",
    LENGTH(ho_ten)                      AS "Độ dài tên"
FROM nhan_vien;
```

---

## 15. Hàm Ngày/Giờ

| Hàm | Ý nghĩa | Excel |
|---|---|---|
| `CURRENT_DATE` | Ngày hôm nay | `=TODAY()` |
| `CURRENT_TIMESTAMP` | Thời điểm hiện tại | `=NOW()` |
| `AGE(date)` | Khoảng thời gian từ ngày đó đến hôm nay | *(không có)* |
| `AGE(d1, d2)` | Khoảng cách giữa 2 ngày | `=DATEDIF(d2,d1,"Y")` |
| `EXTRACT(field FROM date)` | Lấy thành phần ngày/giờ | `=YEAR()`, `=MONTH()`, ... |
| `TO_CHAR(date, 'format')` | Ngày → chuỗi theo format | `=TEXT(A1,"DD/MM/YYYY")` |
| `TO_DATE(string, 'format')` | Chuỗi → ngày | `=DATEVALUE()` |

```sql
-- Ví dụ EXTRACT
EXTRACT(YEAR    FROM ngay_sinh)   -- 1995
EXTRACT(MONTH   FROM ngay_sinh)   -- 3
EXTRACT(DAY     FROM ngay_sinh)   -- 20
EXTRACT(DOW     FROM ngay_sinh)   -- 0=CN, 1=T2 ... 6=T7
EXTRACT(QUARTER FROM ngay_sinh)   -- 1, 2, 3, 4

-- Ví dụ TO_CHAR
TO_CHAR(ngay_sinh, 'DD/MM/YYYY')         -- 20/03/1995
TO_CHAR(ngay_sinh, 'DD "tháng" MM "năm" YYYY')  -- 20 tháng 03 năm 1995
TO_CHAR(now(), 'HH24:MI:SS')             -- 14:30:25

-- Tính toán với ngày
CURRENT_DATE + 7           -- Ngày sau 7 ngày
CURRENT_DATE - 30          -- Ngày trước 30 ngày
date1 - date2              -- Số ngày giữa 2 ngày

-- Ví dụ thực tế
SELECT
    ho_ten,
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY')          AS "Ngày sinh",
    EXTRACT(YEAR FROM AGE(ngay_sinh))          AS "Tuổi",
    EXTRACT(YEAR FROM AGE(ngay_vao))           AS "Năm làm việc",
    CURRENT_DATE - ngay_vao                    AS "Số ngày đã làm"
FROM nhan_vien;
```

---

## 16. Xử Lý NULL

*Excel tương đương: `=IFERROR()`, `=IF(ISBLANK(...))`*

```sql
-- Kiểm tra NULL — LUÔN dùng IS NULL, không dùng = NULL
WHERE email IS NULL        -- Có NULL
WHERE email IS NOT NULL    -- Không có NULL

-- COALESCE: lấy giá trị đầu tiên không NULL
COALESCE(email, 'Chưa có email')       -- Nếu email NULL → 'Chưa có email'
COALESCE(luong, 0) * 12               -- Nếu lương NULL → tính bằng 0
COALESCE(a, b, c, 'Mặc định')         -- Lấy giá trị đầu tiên không NULL trong list

-- NULLIF: chuyển giá trị thành NULL theo điều kiện
NULLIF(so_luong, 0)        -- Nếu = 0 thì trả NULL (tránh lỗi chia cho 0)
NULLIF(ghi_chu, '')        -- Chuỗi rỗng '' → NULL

-- NULL trong phép tính → luôn cho kết quả NULL
5 + NULL = NULL,  NULL * 100 = NULL,  'abc' || NULL = NULL

-- Các hàm tổng hợp xử lý NULL
COUNT(*)        -- Đếm tất cả, kể cả hàng có NULL
COUNT(email)    -- Chỉ đếm hàng email không NULL
AVG(luong)      -- Tính trung bình, bỏ qua NULL (không tính NULL là 0)
```

---

## 17. Sửa Dữ Liệu — UPDATE

*Excel tương đương: Sửa nội dung ô*

```sql
UPDATE ten_bang
SET
    cot_1 = gia_tri_moi_1,
    cot_2 = gia_tri_moi_2
WHERE dieu_kien;    -- ← LUÔN CÓ WHERE!
```

```sql
-- Sửa một hàng cụ thể
UPDATE nhan_vien SET luong = 16000000 WHERE id = 5;

-- Sửa nhiều hàng
UPDATE nhan_vien SET luong = luong * 1.10 WHERE phong_ban = 'IT';

-- Sửa nhiều cột
UPDATE nhan_vien
SET
    phong_ban = 'Kế toán',
    dang_lam  = FALSE
WHERE id = 3;

-- Xem kết quả sau khi UPDATE
UPDATE nhan_vien
SET luong = 20000000
WHERE id = 1
RETURNING id, ho_ten, luong;    -- Xem hàng vừa sửa
```

> ⚠️ **Quy trình an toàn trước khi UPDATE:**
> ```sql
> -- Bước 1: Chạy SELECT với cùng WHERE để xem sẽ ảnh hưởng những hàng nào
> SELECT * FROM nhan_vien WHERE phong_ban = 'IT';
> -- Bước 2: Nếu đúng → thay SELECT * thành UPDATE
> UPDATE nhan_vien SET luong = luong * 1.10 WHERE phong_ban = 'IT';
> ```

---

## 18. Xóa Dữ Liệu — DELETE & TRUNCATE

```sql
-- DELETE: xóa có chọn lọc
DELETE FROM nhan_vien WHERE id = 5;
DELETE FROM nhan_vien WHERE dang_lam = FALSE;

-- Xem kết quả sau khi DELETE
DELETE FROM nhan_vien WHERE id = 5 RETURNING id, ho_ten;

-- TRUNCATE: xóa tất cả, giữ cấu trúc bảng (nhanh hơn DELETE)
TRUNCATE TABLE nhan_vien;
TRUNCATE TABLE nhan_vien RESTART IDENTITY;   -- Reset cả SERIAL về 1
```

> ⚠️ **Quy trình an toàn trước khi DELETE:**
> ```sql
> -- Bước 1: SELECT trước để xem có bao nhiêu hàng sẽ bị xóa
> SELECT * FROM nhan_vien WHERE dang_lam = FALSE;
> -- Bước 2: Nếu đúng → thay SELECT * thành DELETE FROM
> DELETE FROM nhan_vien WHERE dang_lam = FALSE;
> ```

---

## 19. Transaction

*Excel tương đương: Ctrl+Z nhiều bước liên tiếp*

```sql
BEGIN;          -- Bắt đầu transaction (mọi thay đổi sau đây có thể undo)

    UPDATE nhan_vien SET luong = luong * 1.10 WHERE phong_ban = 'IT';
    DELETE FROM nhan_vien WHERE dang_lam = FALSE;

COMMIT;         -- Xác nhận — lưu vĩnh viễn
-- hoặc
ROLLBACK;       -- Hủy bỏ — quay về trạng thái trước BEGIN
```

```sql
-- SAVEPOINT: điểm lưu giữa chừng
BEGIN;
    UPDATE nhan_vien SET luong = 20000000 WHERE id = 1;
    SAVEPOINT buoc_1;                   -- Đánh dấu điểm an toàn

    DELETE FROM nhan_vien WHERE id = 3; -- Thao tác nguy hiểm
    -- Phát hiện sai!
    ROLLBACK TO SAVEPOINT buoc_1;       -- Quay về buoc_1 (UPDATE vẫn còn)

COMMIT;         -- Chỉ lưu UPDATE, không lưu DELETE
```

**Khi nào cần Transaction:**
- Nhiều thao tác liên quan phải thành công CÙNG LÚC (chuyển tiền: trừ A + cộng B)
- Muốn xem trước rồi mới quyết định lưu
- Thao tác nguy hiểm cần "net an toàn"

---

## 20. VIEW

*Excel tương đương: Named Range / Pivot Table đã lưu*

```sql
-- Tạo VIEW
CREATE VIEW nhan_vien_dang_lam AS
SELECT id, ho_ten, phong_ban, luong
FROM nhan_vien
WHERE dang_lam = TRUE;

-- Dùng VIEW như bảng bình thường
SELECT * FROM nhan_vien_dang_lam;
SELECT * FROM nhan_vien_dang_lam WHERE phong_ban = 'IT';

-- Tạo lại VIEW (nếu muốn sửa)
CREATE OR REPLACE VIEW nhan_vien_dang_lam AS
SELECT id, ho_ten, phong_ban, luong, email
FROM nhan_vien
WHERE dang_lam = TRUE;

-- Xóa VIEW
DROP VIEW nhan_vien_dang_lam;
DROP VIEW IF EXISTS nhan_vien_dang_lam;
```

**Lợi ích của VIEW:**
- Lưu câu truy vấn phức tạp — dùng lại như bảng
- Giấu chi tiết kỹ thuật — người dùng chỉ thấy VIEW đơn giản
- Hạn chế quyền truy cập — chỉ cho xem một số cột/hàng nhất định

---

## 21. Chỉnh Cấu Trúc Bảng — ALTER TABLE

```sql
-- Thêm cột
ALTER TABLE nhan_vien ADD COLUMN so_dien_thoai VARCHAR(20);
ALTER TABLE nhan_vien ADD COLUMN cap_bac VARCHAR(20) DEFAULT 'Nhân viên';

-- Xóa cột (vĩnh viễn!)
ALTER TABLE nhan_vien DROP COLUMN so_dien_thoai;
ALTER TABLE nhan_vien DROP COLUMN IF EXISTS so_dien_thoai;

-- Đổi tên cột
ALTER TABLE nhan_vien RENAME COLUMN ho_ten TO ten_day_du;

-- Đổi kiểu dữ liệu
ALTER TABLE nhan_vien ALTER COLUMN phong_ban TYPE VARCHAR(100);

-- Thêm/bỏ NOT NULL
ALTER TABLE nhan_vien ALTER COLUMN phong_ban SET NOT NULL;
ALTER TABLE nhan_vien ALTER COLUMN phong_ban DROP NOT NULL;

-- Thêm/bỏ DEFAULT
ALTER TABLE nhan_vien ALTER COLUMN dang_lam SET DEFAULT TRUE;
ALTER TABLE nhan_vien ALTER COLUMN dang_lam DROP DEFAULT;

-- Thêm UNIQUE sau khi tạo
ALTER TABLE nhan_vien ADD CONSTRAINT nhan_vien_email_unique UNIQUE (email);

-- Thêm CHECK sau khi tạo
ALTER TABLE nhan_vien ADD CONSTRAINT luong_duong CHECK (luong >= 0);

-- Xóa constraint
ALTER TABLE nhan_vien DROP CONSTRAINT luong_duong;

-- Đổi tên bảng
ALTER TABLE nhan_vien RENAME TO nhan_su;
```

---

## 22. Tra Cứu Nhanh — Bảng Tổng Hợp

### Excel → SQL

| Làm trong Excel | Tương đương SQL |
|---|---|
| Mở sheet, nhìn toàn bộ | `SELECT * FROM bang;` |
| Chỉ để lại vài cột | `SELECT cot1, cot2 FROM bang;` |
| Đổi tên header cột | `SELECT cot AS "Tên mới"` |
| Filter | `WHERE dieu_kien` |
| Sort A→Z | `ORDER BY cot ASC` |
| Sort Z→A | `ORDER BY cot DESC` |
| Remove Duplicates | `SELECT DISTINCT cot` |
| `=SUM()` | `SUM(cot)` |
| `=AVERAGE()` | `AVG(cot)` |
| `=COUNT()` | `COUNT(*)` |
| `=MIN()` / `=MAX()` | `MIN(cot)` / `MAX(cot)` |
| Pivot Table | `GROUP BY + hàm tổng hợp` |
| VLOOKUP | `JOIN` |
| `=IF()` / `=IFS()` | `CASE WHEN ... THEN ... END` |
| `=IFERROR()` / `=IF(ISBLANK())` | `COALESCE()` |
| `=CONCATENATE()` / `&` | `\|\|` hoặc `CONCAT()` |
| `=UPPER()` / `=LOWER()` | `UPPER()` / `LOWER()` |
| `=LEFT()` / `=RIGHT()` | `LEFT()` / `RIGHT()` |
| `=MID()` | `SUBSTRING()` |
| `=LEN()` | `LENGTH()` |
| `=TRIM()` | `TRIM()` |
| `=ROUND()` | `ROUND()` |
| `=TODAY()` | `CURRENT_DATE` |
| `=YEAR()` / `=MONTH()` | `EXTRACT(YEAR FROM ...)` |
| `=TEXT(A1,"DD/MM/YYYY")` | `TO_CHAR(cot, 'DD/MM/YYYY')` |
| Sửa nội dung ô | `UPDATE bang SET cot = gia_tri WHERE ...` |
| Xóa hàng | `DELETE FROM bang WHERE ...` |
| Ctrl+Z nhiều bước | `BEGIN; ... ROLLBACK;` |
| Named Range / Pivot đã lưu | `CREATE VIEW ...` |
| Tạo sheet mới | `CREATE TABLE ...` |
| Xóa toàn bộ sheet | `DROP TABLE ...` |
| Xóa nội dung, giữ tiêu đề | `TRUNCATE TABLE ...` |

### Hàm Làm Tròn Số

| Hàm | Kết quả | Ghi nhớ |
|---|---|---|
| `ROUND(9.567, 2)` | `9.57` | Làm tròn thông thường |
| `ROUND(9.567, 0)` | `10` | Làm tròn đến số nguyên |
| `CEIL(9.1)` | `10` | Làm tròn **lên** (ceiling — trần nhà) |
| `FLOOR(9.9)` | `9` | Làm tròn **xuống** (floor — sàn nhà) |
| `TRUNC(9.99, 1)` | `9.9` | Cắt bỏ, không làm tròn |
| `ABS(-5)` | `5` | Giá trị tuyệt đối |

### Kiểm Tra Cấu Trúc Bảng

```sql
-- Xem tất cả bảng trong database
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- Xem cột của một bảng
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'nhan_vien' AND table_schema = 'public'
ORDER BY ordinal_position;
```

### Lỗi Thường Gặp & Cách Fix

| Thông báo lỗi | Nguyên nhân | Cách fix |
|---|---|---|
| `null value in column "..." violates not-null constraint` | Bỏ qua cột NOT NULL khi INSERT | Thêm giá trị cho cột đó |
| `duplicate key value violates unique constraint` | Trùng giá trị UNIQUE/PRIMARY KEY | Kiểm tra trùng trước khi INSERT |
| `invalid input syntax for type date` | Sai format ngày | Dùng `'YYYY-MM-DD'` |
| `value too long for type character varying(n)` | Chuỗi quá dài | Tăng n hoặc cắt bớt chuỗi |
| `column "..." does not exist` | Sai tên cột / Dùng alias trong WHERE | Kiểm tra tên cột, không dùng alias trong WHERE |
| `ERROR: operator does not exist: text = integer` | So sánh sai kiểu dữ liệu | Ép kiểu: `cot::INTEGER` hoặc `CAST(cot AS INTEGER)` |
| `ERROR: column "..." must appear in GROUP BY` | Cột trong SELECT không có trong GROUP BY | Thêm cột vào GROUP BY hoặc bọc vào hàm tổng hợp |

---

*Tài liệu này tổng hợp từ khóa học PostgreSQL 9 tuần. Xem chi tiết tại thư mục `Lessons & Examples/Lesson/`.*
