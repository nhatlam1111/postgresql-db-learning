# Chuyển Đổi Kiểu Dữ Liệu Trong PostgreSQL (Type Casting)

> **File bổ sung cho Tuần 3 — Section 3.1**
>
> File này là tài liệu tham khảo — bạn sẽ quay lại đây nhiều lần khi làm việc thực tế.

---

## Type Casting Là Gì?

**Type casting** = "dịch" một giá trị từ kiểu dữ liệu này sang kiểu dữ liệu khác.

**So sánh Excel:** Trong Excel, bạn đổi format ô từ "Number" sang "Text", hoặc dùng hàm `TEXT(A1, "DD/MM/YYYY")` để chuyển ngày thành chuỗi. Type casting trong PostgreSQL làm điều tương tự, nhưng mạnh mẽ và chính xác hơn.

```
Excel:                              PostgreSQL:
┌──────────────────────────────┐    ┌──────────────────────────────┐
│ Ô A1 = 42 (Number)           │    │ Cột luong = 15000000 (NUMERIC)│
│ Đổi format → Text            │    │ CAST(luong AS TEXT)           │
│ Kết quả: "42" (Text)         │    │ Kết quả: '15000000' (TEXT)   │
└──────────────────────────────┘    └──────────────────────────────┘
```

**Biểu Diễn Trực Quan — Luồng Type Casting**

```
                      CAST(x AS type)   hoặc   x::type
                      ──────────────────────────────────
  ┌──────────────────┐                   ┌──────────────────┐
  │   Giá trị gốc    │ ─────────────────▶│  Giá trị đích    │
  │   (Kiểu A)       │                   │  (Kiểu B)        │
  └──────────────────┘                   └──────────────────┘

  Ví dụ các chiều chuyển đổi hay gặp:

  42           (INTEGER)   ──[::TEXT]──────▶  '42'          (TEXT)    ✅ Luôn OK
  '123'        (TEXT)      ──[::INTEGER]───▶  123           (INTEGER) ⚠️ Lỗi nếu không phải số
  '2024-01-15' (TEXT)      ──[::DATE]──────▶  2024-01-15    (DATE)    ⚠️ Lỗi nếu sai format
  3.99         (NUMERIC)   ──[::INTEGER]───▶  3    ← CẮT!   (INTEGER) ⚠️ Mất phần thập phân
  TRUE         (BOOLEAN)   ──[::INTEGER]───▶  1             (INTEGER) ✅ Luôn OK
  now()        (TIMESTAMP) ──[::DATE]──────▶  2026-04-14    (DATE)    ✅ Luôn OK
```

---

## Hai Cú Pháp Cast

PostgreSQL có **hai cách** viết type cast — cả hai cho kết quả giống nhau:

### Cú Pháp 1: CAST() — Chuẩn SQL (Dùng được ở mọi database)

```sql
CAST(expression AS target_type)
```

### Cú Pháp 2: :: — Rút Gọn Của PostgreSQL (Ngắn hơn, phổ biến hơn)

```sql
expression::target_type
```

**Ví dụ so sánh — cả hai cho kết quả giống nhau:**

```sql
-- Chuyển số thành text
CAST(42 AS TEXT)          -- Kết quả: '42'
42::TEXT                  -- Kết quả: '42'  ← Cách này ngắn hơn

-- Chuyển text thành số
CAST('123' AS INTEGER)    -- Kết quả: 123
'123'::INTEGER            -- Kết quả: 123

-- Chuyển text thành ngày
CAST('2024-01-15' AS DATE)     -- Kết quả: 2024-01-15
'2024-01-15'::DATE             -- Kết quả: 2024-01-15
```

> **Khuyến nghị:** Dùng `::` trong PostgreSQL cho ngắn gọn. Dùng `CAST()` nếu code cần chạy trên nhiều loại database khác nhau.

---

## Bảng Chuyển Đổi Thường Gặp

> 📋 **Bảng tra cứu nhanh** — Tất cả chuyển đổi thường gặp trong một chỗ.
> Cột **Thất bại khi** giúp bạn biết trước trường hợp nào sẽ báo lỗi.

### Nhóm 1: Bất Kỳ Kiểu → TEXT

Hầu hết mọi kiểu đều chuyển sang TEXT được — đây là chiều **luôn an toàn**.

| Từ kiểu | Sang | Cú pháp PostgreSQL | Ví dụ đầu vào | Kết quả | Thất bại khi | Excel tương đương |
|---|---|---|---|---|---|---|
| `INTEGER` | `TEXT` | `42::TEXT` | `42` | `'42'` | Không bao giờ | `=TEXT(A1,"0")` |
| `NUMERIC` | `TEXT` | `3.14::TEXT` | `3.14` | `'3.14'` | Không bao giờ | `=TEXT(A1,"0.00")` |
| `DATE` | `TEXT` | `current_date::TEXT` | `2026-04-13` | `'2026-04-13'` | Không bao giờ | `=TEXT(A1,"YYYY-MM-DD")` |
| `TIMESTAMP` | `TEXT` | `now()::TEXT` | *(thời gian hiện tại)* | `'2026-04-13 14:30:25+07'` | Không bao giờ | `=TEXT(A1,"YYYY-MM-DD HH:MM:SS")` |
| `BOOLEAN` | `TEXT` | `TRUE::TEXT` | `TRUE` | `'true'` | Không bao giờ | `=IF(A1,"true","false")` |
| `INTERVAL` | `TEXT` | `INTERVAL '1 year 2 months'::TEXT` | *(interval)* | `'1 year 2 mons'` | Không bao giờ | Không có |

---

### Nhóm 2: TEXT → Các Kiểu Khác

Chiều này **có thể thất bại** nếu chuỗi không hợp lệ — cần kiểm tra dữ liệu trước.

| Từ kiểu | Sang | Cú pháp PostgreSQL | Ví dụ đầu vào | Kết quả | Thất bại khi | Excel tương đương |
|---|---|---|---|---|---|---|
| `TEXT` | `INTEGER` | `'123'::INTEGER` | `'123'` | `123` | Chứa chữ hoặc dấu phẩy (`'12.5'`, `'abc'`) | `=VALUE("123")` |
| `TEXT` | `NUMERIC` | `'99.5'::NUMERIC` | `'99.5'` | `99.5` | Chứa dấu phẩy ngăn nhóm (`'1,000'`) | `=VALUE("99.5")` |
| `TEXT` | `DATE` | `'2024-01-15'::DATE` | `'2024-01-15'` | `2024-01-15` | Không đúng format `YYYY-MM-DD` | `=DATEVALUE("2024-01-15")` |
| `TEXT` | `TIMESTAMP` | `'2024-01-15 14:30:00'::TIMESTAMP` | `'2024-01-15 14:30:00'` | `2024-01-15 14:30:00` | Sai format ngày/giờ | Không có hàm trực tiếp |
| `TEXT` | `BOOLEAN` | `'true'::BOOLEAN` | `'true'` / `'yes'` / `'1'` | `TRUE` | Giá trị không nằm trong danh sách hợp lệ (VD: `'maybe'`) | Không có hàm trực tiếp |
| `TEXT` | `INTERVAL` | `'3 months'::INTERVAL` | `'3 months'` | `3 mons` | Sai cú pháp interval | Không có |

> 💡 **Giải pháp khi TEXT có dấu phẩy:** Dùng `TO_NUMBER('1,000,000', '9,999,999')` thay vì `::NUMERIC`.

---

### Nhóm 3: Số ↔ Số

| Từ kiểu | Sang | Cú pháp PostgreSQL | Ví dụ đầu vào | Kết quả | Thất bại khi | Excel tương đương |
|---|---|---|---|---|---|---|
| `INTEGER` | `NUMERIC` | `42::NUMERIC(10,2)` | `42` | `42.00` | Không bao giờ | Format ô → Number (2 decimal) |
| `INTEGER` | `BIGINT` | `42::BIGINT` | `42` | `42` | Không bao giờ | Không cần (Excel tự xử lý) |
| `INTEGER` | `REAL` | `42::REAL` | `42` | `42.0` | Không bao giờ | Không cần |
| `NUMERIC` | `INTEGER` | `9.9::INTEGER` | `9.9` | `9` ⚠️ **CẮT**, không làm tròn! | Không bao giờ (nhưng mất dữ liệu) | `=INT(9.9)` → `9` |
| `NUMERIC` | `INTEGER` | `ROUND(9.9)::INTEGER` | `9.9` | `10` ✅ Làm tròn đúng | Không bao giờ | `=ROUND(9.9,0)` → `10` |
| `BIGINT` | `INTEGER` | `9999999999::INTEGER` | `9,999,999,999` | **LỖI!** | Vượt quá ±2.1 tỷ | Không cần |
| `REAL` | `NUMERIC` | `3.14::REAL::NUMERIC(10,4)` | `3.14` | `3.1400` (có thể sai ở chữ số cuối) | Không bao giờ (nhưng có sai số) | Format ô Number |

> ⚠️ **Nhớ:** `NUMERIC → INTEGER` dùng phép **cắt** (truncate), không phải làm tròn. `9.9` → `9`, không phải `10`.
> Muốn làm tròn: `ROUND(9.9, 0)::INTEGER` → `10`.

---

### Nhóm 4: Ngày / Giờ ↔ Ngày / Giờ

| Từ kiểu | Sang | Cú pháp PostgreSQL | Ví dụ đầu vào | Kết quả | Thất bại khi | Excel tương đương |
|---|---|---|---|---|---|---|
| `DATE` | `TIMESTAMP` | `'2024-01-15'::DATE::TIMESTAMP` | `2024-01-15` | `2024-01-15 00:00:00` | Không bao giờ | Format ô Date → Custom Date+Time |
| `DATE` | `TIMESTAMPTZ` | `'2024-01-15'::DATE::TIMESTAMPTZ` | `2024-01-15` | `2024-01-15 00:00:00+07` | Không bao giờ | Không có (Excel không có múi giờ) |
| `TIMESTAMP` | `DATE` | `now()::DATE` | *(thời gian hiện tại)* | `2026-04-13` (bỏ giờ) | Không bao giờ | `=INT(A1)` (phần nguyên của datetime) |
| `TIMESTAMP` | `TIME` | `now()::TIME` | *(thời gian hiện tại)* | `14:30:25` (bỏ ngày) | Không bao giờ | `=MOD(A1,1)` (phần thập phân của datetime) |
| `TIMESTAMP` | `TIMESTAMPTZ` | `now()::TIMESTAMPTZ` | *(timestamp)* | *(thêm múi giờ)* | Không bao giờ | Không có |
| `DATE` | `TEXT` | `ngay_sinh::TEXT` | `1995-03-20` | `'1995-03-20'` | Không bao giờ | `=TEXT(A1,"YYYY-MM-DD")` |
| `DATE` | `TEXT` (định dạng VN) | `TO_CHAR(ngay_sinh, 'DD/MM/YYYY')` | `1995-03-20` | `'20/03/1995'` | Không bao giờ | `=TEXT(A1,"DD/MM/YYYY")` |
| `TEXT` | `DATE` (format VN) | `TO_DATE('20/03/1995', 'DD/MM/YYYY')` | `'20/03/1995'` | `1995-03-20` | Sai format | `=DATEVALUE(TEXT(A1,"YYYY-MM-DD"))` |

---

### Nhóm 5: BOOLEAN ↔ Các Kiểu Khác

| Từ kiểu | Sang | Cú pháp PostgreSQL | Ví dụ đầu vào | Kết quả | Thất bại khi | Excel tương đương |
|---|---|---|---|---|---|---|
| `BOOLEAN` | `TEXT` | `TRUE::TEXT` | `TRUE` | `'true'` | Không bao giờ | `=IF(A1,"true","false")` |
| `BOOLEAN` | `INTEGER` | `TRUE::INTEGER` | `TRUE` / `FALSE` | `1` / `0` | Không bao giờ | `=IF(A1,1,0)` hoặc `=1*(A1=TRUE)` |
| `INTEGER` | `BOOLEAN` | `1::BOOLEAN` | `1` / `0` | `TRUE` / `FALSE` | Số khác 0 và 1 | `=A1<>0` |
| `TEXT` | `BOOLEAN` | `'yes'::BOOLEAN` | `'true'`/`'yes'`/`'1'`/`'on'` | `TRUE` | Giá trị không hợp lệ | Không có hàm trực tiếp |
| `TEXT` | `BOOLEAN` | `'no'::BOOLEAN` | `'false'`/`'no'`/`'0'`/`'off'` | `FALSE` | Giá trị không hợp lệ | Không có hàm trực tiếp |

---

### Tóm Tắt: Chiều Nào An Toàn, Chiều Nào Nguy Hiểm?

| Chiều chuyển đổi | Mức độ an toàn | Ghi chú |
|---|---|---|
| Bất kỳ kiểu → `TEXT` | ✅ **Luôn an toàn** | Không bao giờ lỗi |
| Số nhỏ → Số lớn (`INTEGER → BIGINT`) | ✅ **Luôn an toàn** | Phạm vi lớn hơn chứa được |
| `DATE` → `TIMESTAMP` | ✅ **Luôn an toàn** | Tự thêm `00:00:00` |
| `NUMERIC` → `INTEGER` | ⚠️ **Mất dữ liệu** | Cắt phần thập phân, không làm tròn |
| `TIMESTAMP` → `DATE` | ⚠️ **Mất dữ liệu** | Mất thông tin giờ phút giây |
| Số lớn → Số nhỏ (`BIGINT → INTEGER`) | ❌ **Có thể lỗi** | Lỗi nếu vượt phạm vi |
| `TEXT` → Số/Ngày/Boolean | ❌ **Có thể lỗi** | Lỗi nếu chuỗi không hợp lệ |

---

## Chi Tiết Từng Nhóm Chuyển Đổi — Ví Dụ SQL

### Chuyển Sang TEXT (Chuỗi)

Hầu hết mọi kiểu đều có thể chuyển sang TEXT.

```sql
-- Số nguyên → Text
SELECT 42::TEXT;
-- Kết quả: '42'

SELECT (-100)::TEXT;
-- Kết quả: '-100'

-- Số thập phân → Text
SELECT 15000000.50::TEXT;
-- Kết quả: '15000000.5'  (bỏ số 0 cuối)

SELECT 3.14::NUMERIC(5,2)::TEXT;
-- Kết quả: '3.14'

-- Ngày → Text (format mặc định: YYYY-MM-DD)
SELECT '1995-03-20'::DATE::TEXT;
-- Kết quả: '1995-03-20'

SELECT current_date::TEXT;
-- Kết quả: ngày hôm nay dạng 'YYYY-MM-DD'

-- Timestamp → Text
SELECT now()::TEXT;
-- Kết quả: '2026-04-13 14:30:25.123456+07'

-- Boolean → Text
SELECT TRUE::TEXT;
-- Kết quả: 'true'

SELECT FALSE::TEXT;
-- Kết quả: 'false'
```

---

### Chuyển Text Sang Các Kiểu Khác

> ⚠️ **Chú ý:** Chuyển TEXT sang kiểu khác có thể báo lỗi nếu giá trị không hợp lệ.

```sql
-- Text → Integer
SELECT '123'::INTEGER;
-- Kết quả: 123  ✅

SELECT '  456  '::INTEGER;
-- Kết quả: 456  ✅ (tự bỏ khoảng trắng đầu/cuối)

SELECT 'abc'::INTEGER;
-- LỖI: invalid input syntax for type integer: "abc"  ❌

SELECT '12.5'::INTEGER;
-- LỖI: invalid input syntax for type integer: "12.5"  ❌
-- (muốn chuyển '12.5' sang INTEGER, phải qua NUMERIC trước)
SELECT '12.5'::NUMERIC::INTEGER;
-- Kết quả: 12  ✅ (cắt phần thập phân, không làm tròn)

-- Text → NUMERIC
SELECT '99.50'::NUMERIC;
-- Kết quả: 99.5

SELECT '15,000,000'::NUMERIC;
-- LỖI: dấu phẩy không hợp lệ trong NUMERIC  ❌
-- Giải pháp: dùng TO_NUMBER() (xem phần dưới)

-- Text → DATE (phải đúng format YYYY-MM-DD)
SELECT '2024-01-15'::DATE;
-- Kết quả: 2024-01-15  ✅

SELECT '15/01/2024'::DATE;
-- Lỗi hoặc hiểu sai!  ❌ → Dùng TO_DATE() thay thế

-- Text → BOOLEAN
SELECT 'true'::BOOLEAN;
SELECT 'yes'::BOOLEAN;
SELECT '1'::BOOLEAN;
-- Cả ba kết quả: TRUE  ✅

SELECT 'false'::BOOLEAN;
SELECT 'no'::BOOLEAN;
SELECT '0'::BOOLEAN;
-- Cả ba kết quả: FALSE  ✅

SELECT 'maybe'::BOOLEAN;
-- LỗI: invalid input syntax for type boolean: "maybe"  ❌

-- Text → TIMESTAMP
SELECT '2024-01-15 14:30:00'::TIMESTAMP;
-- Kết quả: 2024-01-15 14:30:00  ✅
```

---

### Chuyển Giữa Các Kiểu Số

```sql
-- INTEGER → NUMERIC
SELECT 42::NUMERIC;
-- Kết quả: 42

SELECT 42::NUMERIC(10,2);
-- Kết quả: 42.00

-- NUMERIC → INTEGER (CẮT phần thập phân, KHÔNG làm tròn)
SELECT 9.9::INTEGER;
-- Kết quả: 9  ← CẮT, không phải làm tròn!

SELECT 9.1::INTEGER;
-- Kết quả: 9

SELECT (-9.9)::INTEGER;
-- Kết quả: -9  ← Cũng CẮT (về phía 0)

-- Muốn LÀM TRÒN trước khi chuyển sang INTEGER:
SELECT ROUND(9.9)::INTEGER;
-- Kết quả: 10  ✅

SELECT ROUND(9.4)::INTEGER;
-- Kết quả: 9  ✅

SELECT CEIL(9.1)::INTEGER;
-- Kết quả: 10  (làm tròn lên)

SELECT FLOOR(9.9)::INTEGER;
-- Kết quả: 9   (làm tròn xuống)

-- INTEGER → BIGINT (luôn an toàn)
SELECT 2147483647::BIGINT;
-- Kết quả: 2147483647

-- BIGINT → INTEGER (có thể tràn số!)
SELECT 9999999999::INTEGER;
-- LỖI: integer out of range  ❌ (vượt quá 2.1 tỷ)
```

---

### Chuyển Đổi Ngày Tháng

```sql
-- DATE → TIMESTAMP (thêm giờ 00:00:00)
SELECT '2024-01-15'::DATE::TIMESTAMP;
-- Kết quả: 2024-01-15 00:00:00

-- DATE → TIMESTAMPTZ
SELECT '2024-01-15'::DATE::TIMESTAMPTZ;
-- Kết quả: 2024-01-15 00:00:00+07 (thêm múi giờ hiện tại)

-- TIMESTAMP → DATE (bỏ phần giờ)
SELECT '2024-01-15 14:30:00'::TIMESTAMP::DATE;
-- Kết quả: 2024-01-15

-- TIMESTAMP → TIME (chỉ lấy phần giờ)
SELECT '2024-01-15 14:30:00'::TIMESTAMP::TIME;
-- Kết quả: 14:30:00

-- DATE + INTERVAL
SELECT '2024-01-15'::DATE + INTERVAL '1 month';
-- Kết quả: 2024-02-15

SELECT '2024-01-31'::DATE + INTERVAL '1 month';
-- Kết quả: 2024-02-29 (PostgreSQL tự xử lý tháng 2 ngắn)

SELECT '2024-01-15'::DATE + INTERVAL '1 year 6 months';
-- Kết quả: 2025-07-15
```

---

## Hàm Định Dạng — TO_CHAR, TO_DATE, TO_NUMBER

Khi `::` không đủ linh hoạt (cần format tùy chỉnh), dùng các hàm `TO_*`.

---

### TO_CHAR() — Chuyển Số / Ngày Sang Chuỗi Có Định Dạng

**Cú pháp:**
```sql
TO_CHAR(value, 'format_pattern')
```

**So sánh Excel:** Hàm `TEXT(value, format)` trong Excel — ví dụ `TEXT(A1,"DD/MM/YYYY")`.

#### TO_CHAR với Ngày Tháng

**Bảng ký hiệu format ngày:**

| Ký hiệu | Ý nghĩa | Ví dụ (với 2024-03-20) |
|---|---|---|
| `YYYY` | Năm 4 chữ số | `2024` |
| `YY` | Năm 2 chữ số | `24` |
| `MM` | Tháng 2 chữ số (01–12) | `03` |
| `MON` | Tên tháng viết tắt (tiếng Anh) | `MAR` |
| `Month` | Tên tháng đầy đủ (tiếng Anh) | `March` |
| `DD` | Ngày 2 chữ số (01–31) | `20` |
| `D` | Thứ trong tuần (1=Chủ nhật) | `4` (thứ 4) |
| `Day` | Tên thứ đầy đủ (tiếng Anh) | `Wednesday` |
| `HH24` | Giờ theo hệ 24h (00–23) | `14` |
| `HH12` | Giờ theo hệ 12h (01–12) | `02` |
| `MI` | Phút (00–59) | `30` |
| `SS` | Giây (00–59) | `00` |
| `AM/PM` | Sáng/Chiều | `PM` |
| `FM` | Fill Mode: bỏ khoảng trắng thừa | (xem ví dụ) |

**Ví dụ thực tế:**

```sql
-- Ngày dạng Việt Nam: DD/MM/YYYY
SELECT TO_CHAR('1995-03-20'::DATE, 'DD/MM/YYYY');
-- Kết quả: '20/03/1995'

-- Ngày dạng dài
SELECT TO_CHAR('1995-03-20'::DATE, 'DD Month YYYY');
-- Kết quả: '20 March     1995'  ← Có khoảng trắng thừa!

-- Dùng FM để bỏ khoảng trắng thừa
SELECT TO_CHAR('1995-03-20'::DATE, 'FMDay, DD Month YYYY');
-- Kết quả: 'Wednesday, 20 March 1995'

-- Ngày giờ đầy đủ
SELECT TO_CHAR(NOW(), 'HH24:MI:SS DD/MM/YYYY');
-- Kết quả: '14:30:25 13/04/2026' (ví dụ)

-- Chỉ tháng và năm
SELECT TO_CHAR(current_date, 'MM/YYYY');
-- Kết quả: '04/2026'

-- Dùng trong query thực tế
SELECT
    ho_ten,
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY') AS ngay_sinh_vn
FROM nhan_vien;
-- Thay vì hiện '1995-03-20', sẽ hiện '20/03/1995'
```

#### TO_CHAR với Số

**Bảng ký hiệu format số:**

| Ký hiệu | Ý nghĩa | Ví dụ |
|---|---|---|
| `9` | Chữ số (nếu không có thì hiện khoảng trắng) | `9999` |
| `0` | Chữ số (nếu không có thì hiện số 0) | `0099` |
| `.` | Dấu thập phân | `9999.99` |
| `,` | Dấu phân cách nhóm 3 chữ số | `999,999` |
| `L` | Ký hiệu tiền tệ địa phương | `L999` |
| `$` | Ký hiệu đô la | `$999` |
| `MI` | Dấu trừ ở cuối (cho số âm) | `999MI` |
| `FM` | Bỏ khoảng trắng thừa | `FM999` |

**Ví dụ thực tế:**

```sql
-- Format lương dạng có dấu phẩy ngăn cách
SELECT TO_CHAR(15000000, '999,999,999');
-- Kết quả: ' 15,000,000'  ← Có khoảng trắng đầu

-- Dùng FM để bỏ khoảng trắng đầu
SELECT TO_CHAR(15000000, 'FM999,999,999');
-- Kết quả: '15,000,000'

-- Thêm đơn vị tiền tệ
SELECT TO_CHAR(15000000, 'FM999,999,999') || ' VNĐ';
-- Kết quả: '15,000,000 VNĐ'

-- Format số thập phân
SELECT TO_CHAR(3.14159, 'FM9.99');
-- Kết quả: '3.14'

SELECT TO_CHAR(3.14159, 'FM9.999999');
-- Kết quả: '3.14159'

-- Dùng trong query thực tế
SELECT
    ho_ten,
    TO_CHAR(luong, 'FM999,999,999') || ' VNĐ' AS luong_format
FROM nhan_vien;
-- Kết quả đẹp: Trần Thị Mai | 15,000,000 VNĐ
```

---

### TO_DATE() — Chuyển Chuỗi Sang DATE Theo Format Tùy Chỉnh

**Cú pháp:**
```sql
TO_DATE('chuoi_ngay', 'format_pattern')
```

**Ký hiệu format:** Giống như TO_CHAR (DD, MM, YYYY, Mon...).

**Dùng khi nào:** Khi ngày tháng nhập từ ngoài không theo format YYYY-MM-DD.

```sql
-- Ngày dạng Việt Nam (DD/MM/YYYY)
SELECT TO_DATE('20/03/1995', 'DD/MM/YYYY');
-- Kết quả: 1995-03-20 (DATE đúng)

-- Ngày dạng Mỹ (MM/DD/YYYY)
SELECT TO_DATE('03/20/1995', 'MM/DD/YYYY');
-- Kết quả: 1995-03-20 ✅

-- Ngày có tên tháng
SELECT TO_DATE('20-Mar-1995', 'DD-Mon-YYYY');
-- Kết quả: 1995-03-20 ✅

SELECT TO_DATE('20 March 1995', 'DD Month YYYY');
-- Kết quả: 1995-03-20 ✅

-- Ngày dạng gộp không có dấu phân cách
SELECT TO_DATE('20031995', 'DDMMYYYY');
-- Kết quả: 1995-03-20 ✅

-- Ứng dụng thực tế: import dữ liệu từ Excel/CSV
-- Excel thường xuất ngày dạng '20/03/1995'
-- Trong PostgreSQL, insert với:
INSERT INTO nhan_vien (ho_ten, ngay_sinh)
VALUES ('Trần Thị Mai', TO_DATE('20/03/1995', 'DD/MM/YYYY'));
```

---

### TO_NUMBER() — Chuyển Chuỗi Sang Số

**Cú pháp:**
```sql
TO_NUMBER('chuoi_so', 'format_pattern')
```

**Dùng khi nào:** Khi số được lưu dưới dạng text có dấu phẩy, ký hiệu tiền tệ...

```sql
-- Số có dấu phẩy ngăn cách
SELECT TO_NUMBER('15,000,000', '999,999,999');
-- Kết quả: 15000000

-- Số thập phân
SELECT TO_NUMBER('99.50', '99.99');
-- Kết quả: 99.50

-- Xóa ký hiệu tiền tệ
SELECT TO_NUMBER('$1,234.56', 'L9,999.99');
-- Kết quả: 1234.56

-- Ứng dụng thực tế: import từ file CSV xuất từ Excel
-- File CSV có cột lương dạng '15,000,000'
-- Khi INSERT: TO_NUMBER(luong_text, '999,999,999')
```

---

## Xử Lý Lỗi Khi Cast

### Các Lỗi Thường Gặp

#### Lỗi 1: invalid input syntax for type integer

```sql
SELECT 'abc'::INTEGER;
-- ERROR: invalid input syntax for type integer: "abc"
```

**Nguyên nhân:** Chuỗi không phải số nguyên hợp lệ.

**Giải pháp:**
```sql
-- Kiểm tra trước khi cast bằng CASE WHEN
SELECT
    CASE
        WHEN ma_so ~ '^[0-9]+$'   -- Kiểm tra chỉ chứa chữ số
        THEN ma_so::INTEGER
        ELSE NULL
    END AS ma_so_int
FROM bang_nhap;

-- Hoặc dùng PostgreSQL 9.4+: hàm tự viết để cast an toàn
-- (nâng cao — sẽ học sau)
```

#### Lỗi 2: date/time field value out of range

```sql
SELECT '30/02/2024'::DATE;
-- ERROR: date/time field value out of range: "30/02/2024"
```

**Nguyên nhân:** Format DD/MM/YYYY không tự động nhận diện — PostgreSQL đọc là MM/DD/YYYY → tháng 30 không tồn tại.

**Giải pháp:**
```sql
-- Luôn dùng format YYYY-MM-DD
SELECT '2024-02-29'::DATE;  -- ✅ (2024 là năm nhuận)

-- Hoặc dùng TO_DATE với format rõ ràng
SELECT TO_DATE('29/02/2024', 'DD/MM/YYYY');  -- ✅
```

#### Lỗi 3: numeric field overflow

```sql
-- Cột khai báo NUMERIC(5,2) — tối đa 999.99
INSERT INTO bang_test (so_nho) VALUES (10000.00);
-- ERROR: numeric field overflow
-- A field with precision 5, scale 2 must round to an absolute value less than 10^3.
```

**Giải pháp:** Tăng p (precision) khi khai báo cột, ví dụ `NUMERIC(10,2)`.

#### Lỗi 4: value too long for type character varying(n)

```sql
-- Cột khai báo VARCHAR(10)
INSERT INTO bang_test (ten_ngan) VALUES ('Nguyễn Văn An Toàn');
-- ERROR: value too long for type character varying(10)
```

**Giải pháp:** Tăng n hoặc dùng TEXT.

### Mất Dữ Liệu Âm Thầm — Cẩn Thận!

```sql
-- NUMERIC → INTEGER: CẮT, không làm tròn
SELECT 9.9::INTEGER;  -- Kết quả: 9  (mất 0.9!)
SELECT 9.1::INTEGER;  -- Kết quả: 9  (mất 0.1!)

-- Nếu muốn làm tròn đúng:
SELECT ROUND(9.9, 0)::INTEGER;  -- 10  ✅
SELECT ROUND(9.4, 0)::INTEGER;  -- 9   ✅

-- TIMESTAMP → DATE: mất phần giờ
SELECT '2024-01-15 23:59:59'::TIMESTAMP::DATE;
-- Kết quả: 2024-01-15  (mất thông tin giờ!)
```

---

## Ví Dụ Tổng Hợp Thực Tế

### Tình Huống 1: Tạo Câu Chào Với Ngày

```sql
-- Ghép chuỗi với ngày tháng — cần cast ngày thành text
SELECT 'Hôm nay là ' || TO_CHAR(current_date, 'FMDay, DD/MM/YYYY');
-- Kết quả: 'Hôm nay là Monday, 13/04/2026'

-- Cách khác (cast đơn giản hơn, format mặc định)
SELECT 'Hôm nay là ' || current_date::TEXT;
-- Kết quả: 'Hôm nay là 2026-04-13'
```

### Tình Huống 2: Tính Tuổi Nhân Viên

```sql
SELECT
    ho_ten,
    ngay_sinh,
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY') AS ngay_sinh_format,
    EXTRACT(YEAR FROM AGE(ngay_sinh))::INTEGER AS tuoi
FROM nhan_vien
ORDER BY tuoi DESC;
```

**Kết quả:**

| ho_ten | ngay_sinh | ngay_sinh_format | tuoi |
|---|---|---|---|
| Phạm Minh Châu | 1988-01-25 | 25/01/1988 | 38 |
| Nguyễn Văn An | 1990-07-15 | 15/07/1990 | 35 |
| ...| ... | ... | ... |

### Tình Huống 3: Format Báo Cáo Lương

```sql
SELECT
    ho_ten,
    phong_ban,
    TO_CHAR(luong, 'FM999,999,999') || ' VNĐ' AS luong_format
FROM nhan_vien
ORDER BY luong DESC;
```

**Kết quả:**

| ho_ten | phong_ban | luong_format |
|---|---|---|
| Phạm Minh Châu | IT | 25,000,000 VNĐ |
| Võ Văn Em | Kinh doanh | 22,000,000 VNĐ |
| Nguyễn Văn An | Kinh doanh | 20,000,000 VNĐ |

### Tình Huống 4: Import Ngày Từ CSV Dạng DD/MM/YYYY

```sql
-- Khi import dữ liệu từ file Excel xuất ra CSV
-- Ngày trong file: '20/03/1995', '15/07/1990'...

INSERT INTO nhan_vien (ho_ten, ngay_sinh) VALUES
    ('Trần Thị Mai',  TO_DATE('20/03/1995', 'DD/MM/YYYY')),
    ('Nguyễn Văn An', TO_DATE('15/07/1990', 'DD/MM/YYYY'));
```

### Tình Huống 5: Tính Ngày Hết Hạn Hợp Đồng

```sql
SELECT
    ho_ten,
    ngay_vao,
    (ngay_vao + INTERVAL '1 year')::DATE AS het_thu_viec,
    CASE
        WHEN (ngay_vao + INTERVAL '1 year')::DATE <= current_date
        THEN 'Đã hết thử việc'
        ELSE 'Đang thử việc — còn ' ||
             ((ngay_vao + INTERVAL '1 year')::DATE - current_date)::TEXT ||
             ' ngày'
    END AS trang_thai
FROM nhan_vien;
```

### Tình Huống 6: Xử Lý Dữ Liệu Số Dạng Text (Từ Import)

```sql
-- Giả sử có cột luong_text TEXT chứa '15,000,000' (từ Excel)
-- Cần chuyển thành số để tính toán

SELECT
    ho_ten,
    TO_NUMBER(luong_text, 'FM999,999,999') AS luong_so,
    TO_NUMBER(luong_text, 'FM999,999,999') * 12 AS luong_nam
FROM bang_import;
```

---

## Bảng Tra Cứu Nhanh

### Cast Thông Dụng

```sql
-- Số → Chuỗi
42::TEXT                          -- '42'
3.14::TEXT                        -- '3.14'
TO_CHAR(15000000, 'FM999,999,999')-- '15,000,000'

-- Chuỗi → Số
'123'::INTEGER                    -- 123
'99.5'::NUMERIC                   -- 99.5
'15,000'::NUMERIC                 -- LỖI → dùng TO_NUMBER

-- Ngày → Chuỗi
current_date::TEXT                -- '2026-04-13'
TO_CHAR(current_date, 'DD/MM/YYYY') -- '13/04/2026'

-- Chuỗi → Ngày
'2024-01-15'::DATE                -- 2024-01-15
TO_DATE('15/01/2024', 'DD/MM/YYYY') -- 2024-01-15

-- Ngày → Timestamp
'2024-01-15'::DATE::TIMESTAMP    -- 2024-01-15 00:00:00

-- Cắt phần giờ
NOW()::DATE                       -- Ngày hôm nay

-- Làm tròn rồi chuyển số
ROUND(9.7, 0)::INTEGER            -- 10
FLOOR(9.7)::INTEGER               -- 9
CEIL(9.1)::INTEGER                -- 10
```

### Hàm Format Hay Dùng

```sql
TO_CHAR(ngay,     'DD/MM/YYYY')        -- Ngày dạng VN
TO_CHAR(ngay,     'DD Month YYYY')     -- '20 March 1995'
TO_CHAR(ngaygio,  'HH24:MI DD/MM/YYYY') -- Ngày giờ đầy đủ
TO_CHAR(so,       'FM999,999,999')     -- Số có dấu phẩy, bỏ khoảng trắng
TO_CHAR(so,       'FM9.99')            -- Số thập phân 2 chữ số
TO_DATE(chuoi,    'DD/MM/YYYY')        -- Chuỗi VN → ngày
TO_NUMBER(chuoi,  'FM999,999,999')     -- Chuỗi có dấu phẩy → số
```

---

*Tham khảo thêm: [PostgreSQL Documentation — Data Type Formatting Functions](https://www.postgresql.org/docs/current/functions-formatting.html)*
