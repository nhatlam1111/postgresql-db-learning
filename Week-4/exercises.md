# Bài Tập Tuần 4 — Truy Vấn Dữ Liệu (SELECT Cơ Bản)

> **Yêu cầu:** Đảm bảo bạn đã hoàn thành Tuần 3 và có đủ dữ liệu trong các bảng `nhan_vien`, `san_pham`, `khach_hang` trước khi làm bài tập này.

---

## Nhóm A: SELECT Cơ Bản *(Cơ bản)*

### A1 — Xem Toàn Bộ Dữ Liệu

Viết câu SQL để:

1. Xem **tất cả** dữ liệu trong bảng `nhan_vien`
2. Xem **tất cả** dữ liệu trong bảng `san_pham`
3. Xem **tất cả** dữ liệu trong bảng `khach_hang`

---

### A2 — Chọn Cột Cụ Thể

Viết câu SQL để xem các cột sau (không dùng `*`):

1. Từ `nhan_vien`: chỉ lấy cột `ho_ten` và `email`
2. Từ `nhan_vien`: chỉ lấy cột `ho_ten`, `phong_ban`, `luong`
3. Từ `san_pham`: chỉ lấy cột `ten_sp`, `gia`, `so_luong_ton`
4. Từ `khach_hang`: chỉ lấy cột `ho_ten` và `dien_thoai`

---

### A3 — Đổi Thứ Tự Cột

Bảng `nhan_vien` có cột theo thứ tự: `id, ho_ten, email, ngay_sinh, luong, phong_ban, ngay_vao, dang_lam`.

Viết câu SQL hiển thị các cột **theo thứ tự khác** — `phong_ban` lên đầu, rồi `ho_ten`, rồi `luong`.

*(Mục đích: Chứng minh bạn có thể chọn thứ tự hiển thị tùy ý, không phụ thuộc thứ tự trong bảng)*

---

### A4 — Đếm Dữ Liệu

Viết câu SQL để:

1. Đếm tổng số nhân viên trong bảng `nhan_vien`
2. Đếm tổng số sản phẩm trong bảng `san_pham`
3. Đếm tổng số khách hàng trong bảng `khach_hang`

*Gợi ý: Dùng `COUNT(*)`*

---

### A5 — Đọc Hiểu SQL

Câu SQL dưới đây làm gì? Hãy mô tả bằng lời (không cần chạy):

```sql
SELECT ho_ten, email
FROM khach_hang;
```

```sql
SELECT ten_sp, gia, danh_muc
FROM san_pham;
```

---

## Nhóm B: Alias và Tính Toán *(Cơ bản → Trung bình)*

### B1 — Alias Cột

Viết lại câu query sau, thêm alias tiếng Việt cho mỗi cột:

```sql
SELECT ho_ten, luong, phong_ban, ngay_vao
FROM nhan_vien;
```

Yêu cầu alias:
- `ho_ten` → `"Họ và tên"`
- `luong` → `"Mức lương (VNĐ)"`
- `phong_ban` → `"Phòng ban"`
- `ngay_vao` → `"Ngày vào làm"`

---

### B2 — Tính Lương Quy Đổi

Viết câu SQL hiển thị từ bảng `nhan_vien`:
- Tên nhân viên
- Lương tháng (cột gốc `luong`)
- **Lương năm** (lương × 12) — alias: `"Lương năm"`
- **Lương ngày** (lương ÷ 26 ngày công) — alias: `"Lương ngày"`, làm tròn số nguyên
- **Lương giờ** (lương ngày ÷ 8 giờ) — alias: `"Lương giờ"`, làm tròn số nguyên

---

### B3 — Tính Giá Trị Tồn Kho

Từ bảng `san_pham`, viết câu SQL hiển thị:
- Tên sản phẩm — alias: `"Sản phẩm"`
- Giá bán — alias: `"Đơn giá"`
- Số lượng tồn — alias: `"SL tồn"`
- **Giá trị tồn kho** = `gia × so_luong_ton` — alias: `"Giá trị tồn (VNĐ)"`
- **Giá trị tồn kho (triệu đồng)** = giá trị tồn ÷ 1.000.000, làm tròn 2 chữ số thập phân — alias: `"Giá trị tồn (triệu đ)"`

---

### B4 — Tính Giảm Giá

Cửa hàng đang giảm giá **20%** cho toàn bộ sản phẩm. Viết câu SQL hiển thị:
- Tên sản phẩm
- Giá gốc — alias: `"Giá gốc"`
- Số tiền được giảm (20% của giá gốc) — alias: `"Tiền giảm"`, làm tròn số nguyên
- Giá sau giảm — alias: `"Giá khuyến mại"`, làm tròn số nguyên

---

### B5 — Phát Hiện Lỗi *(Trung bình)*

Câu SQL dưới đây có vấn đề gì? Hãy giải thích và sửa lại:

**Câu a:**
```sql
SELECT ho_ten, luong / 12 AS "Lương tháng quy ngày"
FROM nhan_vien;
```
*(Gợi ý: Kiểm tra kiểu dữ liệu của `luong` và hậu quả của phép chia)*

**Câu b:**
```sql
SELECT ten_sp AS 'Tên sản phẩm', gia AS 'Đơn giá'
FROM san_pham;
```
*(Gợi ý: Kiểm tra dấu nháy)*

**Câu c:**
```sql
SELECT ho_ten, luong * 0.90 AS luong_sau_thue
FROM nhan_vien
WHERE luong_sau_thue > 15000000;
```
*(Gợi ý: Thứ tự thực thi SQL)*

---

## Nhóm C: DISTINCT và Hàm Chuỗi *(Trung bình)*

### C1 — DISTINCT Cơ Bản

Viết câu SQL để:

1. Liệt kê tất cả **phòng ban** khác nhau trong bảng `nhan_vien` (không trùng)
2. Liệt kê tất cả **danh mục** sản phẩm khác nhau (không trùng)
3. Đếm có bao nhiêu phòng ban khác nhau trong `nhan_vien`
4. Đếm có bao nhiêu danh mục sản phẩm khác nhau trong `san_pham`

---

### C2 — Xử Lý Chuỗi Cơ Bản

Từ bảng `nhan_vien`, viết câu SQL hiển thị:
- `ho_ten` gốc
- `ho_ten` viết HOA toàn bộ
- `ho_ten` viết thường toàn bộ
- Số ký tự trong `ho_ten`
- Phần trước `@` của `email` (username)

---

### C3 — Tạo Mã Định Danh

Viết câu SQL tạo "mã nhân viên" theo format `NV-001`, `NV-002`, `NV-003`... từ cột `id` của bảng `nhan_vien`.

Gợi ý: Dùng `LPAD(id::TEXT, 3, '0')` để tạo số 3 chữ số có đệm 0.

Kết quả mong đợi:
```
 Mã NV  | Họ và tên
--------+------------------
 NV-001 | Trần Thị Mai
 NV-002 | Nguyễn Văn An
 ...
```

---

### C4 — Nối Chuỗi Thông Tin

Từ bảng `nhan_vien`, viết câu SQL tạo một cột kết hợp theo format:

```
[Phòng ban] | Họ tên | Email
```

Ví dụ: `Kế toán | Trần Thị Mai | mai.tran@email.com`

Lưu ý: Nếu `email` là NULL, hiển thị `"Chưa có email"` thay vì NULL.

*Gợi ý: Dùng `CONCAT()` hoặc `||` kết hợp với `COALESCE()`*

---

### C5 — Chuẩn Hóa Dữ Liệu *(Trung bình)*

Giả sử khi nhập liệu, có một số email bị nhập sai format (chữ hoa lẫn lộn, có khoảng trắng thừa). Viết câu SQL để hiển thị email đã được "chuẩn hóa":
- Xóa khoảng trắng 2 đầu
- Chuyển về chữ thường hoàn toàn

Áp dụng với bảng `nhan_vien` (dù dữ liệu hiện tại đã đúng, hãy cứ viết để tập thói quen).

---

## Nhóm D: Hàm Số và Ngày/Giờ *(Trung bình → Nâng cao)*

### D1 — Hàm Số Học

Viết câu SQL (không cần dùng bảng — chỉ SELECT thuần):

```sql
SELECT
    -- Điền vào chỗ trống để ra kết quả đúng
    ROUND(???, 2)   AS "Pi làm tròn 2 số",   -- Mục tiêu: 3.14
    CEIL(???)       AS "Ceiling của 4.01",    -- Mục tiêu: 5
    FLOOR(???)      AS "Floor của 4.99",      -- Mục tiêu: 4
    ABS(???)        AS "ABS của -100",         -- Mục tiêu: 100
    MOD(???, ???)   AS "17 chia dư 5",         -- Mục tiêu: 2
    SQRT(???)       AS "Căn bậc 2 của 81";    -- Mục tiêu: 9
```

Điền giá trị vào chỗ `???` để câu SQL chạy ra đúng kết quả.

---

### D2 — Ngày Hôm Nay và Tính Toán

Viết câu SQL (không cần dùng bảng) hiển thị:
- Ngày hôm nay (`CURRENT_DATE`)
- 30 ngày trước
- 30 ngày sau
- 1 năm trước (dùng `CURRENT_DATE - 365`)
- Đầu tháng hiện tại (`DATE_TRUNC('month', CURRENT_DATE)`)

---

### D3 — Tính Tuổi Nhân Viên

Từ bảng `nhan_vien`, viết câu SQL hiển thị:
- Tên nhân viên
- Ngày sinh (format DD/MM/YYYY)
- Tuổi (số năm tròn)
- Phân loại tuổi:
  - Dưới 30 tuổi → `"Nhân viên trẻ"`
  - Từ 30 đến 40 → `"Kinh nghiệm trung bình"`
  - Trên 40 tuổi → `"Nhân viên kỳ cựu"`

*Gợi ý: Dùng `EXTRACT(YEAR FROM AGE(ngay_sinh))` và `CASE WHEN`*

---

### D4 — Thâm Niên Làm Việc

Từ bảng `nhan_vien`, viết câu SQL hiển thị:
- Tên nhân viên
- Ngày vào làm (format DD/MM/YYYY)
- Số năm làm việc (thâm niên, lấy phần nguyên)
- Số ngày đã làm việc
- Phân loại theo thâm niên:
  - Dưới 2 năm → `"Nhân viên mới"`
  - 2-5 năm → `"Nhân viên có kinh nghiệm"`
  - Trên 5 năm → `"Nhân viên lâu năm"`

---

### D5 — Tổng Hợp Báo Cáo *(Nâng cao)*

Từ bảng `nhan_vien`, xây dựng báo cáo đầy đủ với mỗi nhân viên gồm:

| Cột | Nội dung | Ghi chú |
|---|---|---|
| Mã NV | `NV-001`, `NV-002`... | Dùng LPAD |
| Họ và tên | Tên gốc | |
| Phòng ban | Tên phòng ban | |
| Tuổi | Số nguyên | Dùng EXTRACT + AGE |
| Ngày sinh | Định dạng DD/MM/YYYY | Dùng TO_CHAR |
| Thâm niên | X năm | Số năm làm tròn |
| Lương gross | Số nguyên VNĐ | |
| Lương (triệu đ) | Làm tròn 1 chữ số | VD: 15.0 |
| Lương thực nhận | Sau khi trừ 10.5% BH và 10% thuế TNCN | Công thức: luong × (1-0.105) × (1-0.10) |
| Username | Phần trước @ của email | Dùng SPLIT_PART |

Sắp xếp kết quả theo phòng ban (A→Z), trong cùng phòng ban sắp theo lương giảm dần.

---

## Nhóm E: Tổng Hợp *(Nâng cao)*

### E1 — Phân Tích Sản Phẩm

Từ bảng `san_pham`, tạo báo cáo tồn kho bao gồm:
- Mã sản phẩm (`SP-0001`, `SP-0002`...)
- Tên sản phẩm
- Danh mục
- Giá bán (định dạng số nguyên)
- Số lượng tồn
- Giá trị tồn kho (triệu đồng, 2 chữ số thập phân)
- **Nhận xét tồn kho:**
  - Tồn < 10: `"Sắp hết hàng"`
  - Tồn 10-50: `"Tồn kho bình thường"`
  - Tồn > 50: `"Tồn kho nhiều"`
- Ngày nhập (DD/MM/YYYY)

Sắp xếp theo danh mục rồi theo giá trị tồn kho giảm dần.

---

### E2 — Thống Kê Lương

Viết câu SQL hiển thị một hàng duy nhất với các thống kê lương từ bảng `nhan_vien`:

| Cột | Ý nghĩa |
|---|---|
| Tổng quỹ lương | Tổng tất cả lương |
| Lương cao nhất | MAX(luong) |
| Lương thấp nhất | MIN(luong) |
| Lương trung bình | AVG(luong), làm tròn 0 |
| Chênh lệch | Lương cao nhất − lương thấp nhất |
| Tổng quỹ lương (triệu đ) | Tổng quỹ lương ÷ 1.000.000, 1 chữ số thập phân |

*Gợi ý: Dùng MIN(), MAX(), SUM(), AVG() — đây là preview của Tuần 6!*

---

### E3 — Báo Cáo Khách Hàng

Từ bảng `khach_hang`, tạo báo cáo bao gồm:
- Mã khách hàng (`KH-0001`, `KH-0002`...)
- Họ tên (chuẩn hóa: xóa khoảng trắng thừa, Initcap)
- Email (chữ thường, bỏ khoảng trắng)
- Số điện thoại
- Số ngày đã là khách hàng (kể từ `ngay_dang_ky`)
- Phân loại:
  - Khách hàng mới: < 30 ngày
  - Khách hàng thân thiết: 30-365 ngày
  - Khách hàng trung thành: > 365 ngày

---

## Đáp Án

<details>
<summary>📌 Nhấn để xem đáp án Nhóm A</summary>

### A1 — Đáp án
```sql
-- 1. Tất cả nhân viên
SELECT * FROM nhan_vien;

-- 2. Tất cả sản phẩm
SELECT * FROM san_pham;

-- 3. Tất cả khách hàng
SELECT * FROM khach_hang;
```

### A2 — Đáp án
```sql
-- 1.
SELECT ho_ten, email FROM nhan_vien;

-- 2.
SELECT ho_ten, phong_ban, luong FROM nhan_vien;

-- 3.
SELECT ten_sp, gia, so_luong_ton FROM san_pham;

-- 4.
SELECT ho_ten, dien_thoai FROM khach_hang;
```

### A3 — Đáp án
```sql
SELECT phong_ban, ho_ten, luong
FROM nhan_vien;
-- Đổi thứ tự cột trong SELECT không ảnh hưởng dữ liệu trong bảng
```

### A4 — Đáp án
```sql
-- 1.
SELECT COUNT(*) AS "Số nhân viên" FROM nhan_vien;

-- 2.
SELECT COUNT(*) AS "Số sản phẩm" FROM san_pham;

-- 3.
SELECT COUNT(*) AS "Số khách hàng" FROM khach_hang;
```

### A5 — Đáp án
```
Câu 1: "Lấy cột ho_ten và email của tất cả bản ghi trong bảng khach_hang"
Câu 2: "Lấy cột ten_sp, gia và danh_muc của tất cả sản phẩm trong bảng san_pham"
```

</details>

---

<details>
<summary>📌 Nhấn để xem đáp án Nhóm B</summary>

### B1 — Đáp án
```sql
SELECT
    ho_ten      AS "Họ và tên",
    luong       AS "Mức lương (VNĐ)",
    phong_ban   AS "Phòng ban",
    ngay_vao    AS "Ngày vào làm"
FROM nhan_vien;
```

### B2 — Đáp án
```sql
SELECT
    ho_ten                              AS "Họ và tên",
    luong                               AS "Lương tháng",
    luong * 12                          AS "Lương năm",
    ROUND(luong / 26.0, 0)             AS "Lương ngày",
    ROUND(luong / 26.0 / 8.0, 0)       AS "Lương giờ"
FROM nhan_vien;
```

### B3 — Đáp án
```sql
SELECT
    ten_sp                                          AS "Sản phẩm",
    gia                                             AS "Đơn giá",
    so_luong_ton                                    AS "SL tồn",
    ROUND(gia * so_luong_ton, 0)                    AS "Giá trị tồn (VNĐ)",
    ROUND(gia * so_luong_ton / 1000000.0, 2)        AS "Giá trị tồn (triệu đ)"
FROM san_pham;
```

### B4 — Đáp án
```sql
SELECT
    ten_sp                              AS "Tên sản phẩm",
    gia                                 AS "Giá gốc",
    ROUND(gia * 0.20, 0)               AS "Tiền giảm",
    ROUND(gia * 0.80, 0)               AS "Giá khuyến mại"
FROM san_pham;
```

### B5 — Đáp án
**Câu a:** Vấn đề: `luong / 12` — nếu `luong` là kiểu INTEGER, phép chia sẽ cắt phần thập phân. Sửa: `luong / 12.0` hoặc `luong::NUMERIC / 12`

**Câu b:** Vấn đề: Alias dùng dấu nháy đơn `'...'` là sai. Alias phải dùng nháy kép `"..."`.
```sql
-- Sửa:
SELECT ten_sp AS "Tên sản phẩm", gia AS "Đơn giá"
FROM san_pham;
```

**Câu c:** Vấn đề: `WHERE` chạy trước `SELECT`, nên alias `luong_sau_thue` chưa tồn tại khi WHERE được thực thi.
```sql
-- Sửa: Dùng lại biểu thức trong WHERE
SELECT ho_ten, luong * 0.90 AS luong_sau_thue
FROM nhan_vien
WHERE luong * 0.90 > 15000000;
```

</details>

---

<details>
<summary>📌 Nhấn để xem đáp án Nhóm C</summary>

### C1 — Đáp án
```sql
-- 1. Phòng ban không trùng
SELECT DISTINCT phong_ban FROM nhan_vien ORDER BY phong_ban;

-- 2. Danh mục sản phẩm không trùng
SELECT DISTINCT danh_muc FROM san_pham ORDER BY danh_muc;

-- 3. Số phòng ban
SELECT COUNT(DISTINCT phong_ban) AS "Số phòng ban" FROM nhan_vien;

-- 4. Số danh mục
SELECT COUNT(DISTINCT danh_muc) AS "Số danh mục" FROM san_pham;
```

### C2 — Đáp án
```sql
SELECT
    ho_ten                          AS "Tên gốc",
    UPPER(ho_ten)                   AS "CHỮ HOA",
    LOWER(ho_ten)                   AS "chữ thường",
    LENGTH(ho_ten)                  AS "Số ký tự",
    SPLIT_PART(email, '@', 1)       AS "Username"
FROM nhan_vien;
```

### C3 — Đáp án
```sql
SELECT
    'NV-' || LPAD(id::TEXT, 3, '0')    AS "Mã NV",
    ho_ten                              AS "Họ và tên"
FROM nhan_vien
ORDER BY id;
```

### C4 — Đáp án
```sql
-- Dùng CONCAT (an toàn hơn với NULL)
SELECT
    CONCAT(phong_ban, ' | ', ho_ten, ' | ', COALESCE(email, 'Chưa có email')) AS "Thông tin"
FROM nhan_vien;

-- Hoặc dùng ||
SELECT
    phong_ban || ' | ' || ho_ten || ' | ' || COALESCE(email, 'Chưa có email') AS "Thông tin"
FROM nhan_vien;
```

### C5 — Đáp án
```sql
SELECT
    ho_ten,
    email                           AS "Email gốc",
    LOWER(TRIM(email))             AS "Email chuẩn hóa"
FROM nhan_vien;
```

</details>

---

<details>
<summary>📌 Nhấn để xem đáp án Nhóm D</summary>

### D1 — Đáp án
```sql
SELECT
    ROUND(PI(), 2)      AS "Pi làm tròn 2 số",   -- 3.14
    CEIL(4.01)          AS "Ceiling của 4.01",    -- 5
    FLOOR(4.99)         AS "Floor của 4.99",      -- 4
    ABS(-100)           AS "ABS của -100",         -- 100
    MOD(17, 5)          AS "17 chia dư 5",         -- 2
    SQRT(81)            AS "Căn bậc 2 của 81";    -- 9
```

### D2 — Đáp án
```sql
SELECT
    CURRENT_DATE                            AS "Hôm nay",
    CURRENT_DATE - 30                       AS "30 ngày trước",
    CURRENT_DATE + 30                       AS "30 ngày sau",
    CURRENT_DATE - 365                      AS "1 năm trước",
    DATE_TRUNC('month', CURRENT_DATE)       AS "Đầu tháng này";
```

### D3 — Đáp án
```sql
SELECT
    ho_ten                                              AS "Họ và tên",
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY')                   AS "Ngày sinh",
    EXTRACT(YEAR FROM AGE(ngay_sinh))                   AS "Tuổi",
    CASE
        WHEN EXTRACT(YEAR FROM AGE(ngay_sinh)) < 30  THEN 'Nhân viên trẻ'
        WHEN EXTRACT(YEAR FROM AGE(ngay_sinh)) <= 40 THEN 'Kinh nghiệm trung bình'
        ELSE 'Nhân viên kỳ cựu'
    END                                                 AS "Phân loại tuổi"
FROM nhan_vien;
```

### D4 — Đáp án
```sql
SELECT
    ho_ten                                              AS "Họ và tên",
    TO_CHAR(ngay_vao, 'DD/MM/YYYY')                    AS "Ngày vào làm",
    EXTRACT(YEAR FROM AGE(ngay_vao))                    AS "Thâm niên (năm)",
    CURRENT_DATE - ngay_vao                             AS "Số ngày đã làm",
    CASE
        WHEN EXTRACT(YEAR FROM AGE(ngay_vao)) < 2   THEN 'Nhân viên mới'
        WHEN EXTRACT(YEAR FROM AGE(ngay_vao)) <= 5  THEN 'Nhân viên có kinh nghiệm'
        ELSE 'Nhân viên lâu năm'
    END                                                 AS "Phân loại thâm niên"
FROM nhan_vien;
```

### D5 — Đáp án
```sql
SELECT
    'NV-' || LPAD(id::TEXT, 3, '0')                    AS "Mã NV",
    ho_ten                                              AS "Họ và tên",
    phong_ban                                           AS "Phòng ban",
    EXTRACT(YEAR FROM AGE(ngay_sinh))                   AS "Tuổi",
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY')                   AS "Ngày sinh",
    EXTRACT(YEAR FROM AGE(ngay_vao))                    AS "Thâm niên",
    luong                                               AS "Lương gross",
    ROUND(luong / 1000000.0, 1)                         AS "Lương (triệu đ)",
    ROUND(luong * (1 - 0.105) * (1 - 0.10), 0)         AS "Lương thực nhận",
    SPLIT_PART(email, '@', 1)                           AS "Username"
FROM nhan_vien
ORDER BY phong_ban ASC, luong DESC;
```

</details>

---

<details>
<summary>📌 Nhấn để xem đáp án Nhóm E</summary>

### E1 — Đáp án
```sql
SELECT
    'SP-' || LPAD(id::TEXT, 4, '0')                    AS "Mã SP",
    ten_sp                                              AS "Tên sản phẩm",
    danh_muc                                            AS "Danh mục",
    ROUND(gia, 0)                                       AS "Giá bán (VNĐ)",
    so_luong_ton                                        AS "SL tồn",
    ROUND(gia * so_luong_ton / 1000000.0, 2)            AS "Giá trị tồn (triệu đ)",
    CASE
        WHEN so_luong_ton < 10  THEN 'Sắp hết hàng'
        WHEN so_luong_ton <= 50 THEN 'Tồn kho bình thường'
        ELSE 'Tồn kho nhiều'
    END                                                 AS "Nhận xét tồn kho",
    TO_CHAR(ngay_nhap, 'DD/MM/YYYY')                   AS "Ngày nhập"
FROM san_pham
ORDER BY danh_muc ASC, ROUND(gia * so_luong_ton, 0) DESC;
```

### E2 — Đáp án
```sql
SELECT
    SUM(luong)                          AS "Tổng quỹ lương",
    MAX(luong)                          AS "Lương cao nhất",
    MIN(luong)                          AS "Lương thấp nhất",
    ROUND(AVG(luong), 0)               AS "Lương trung bình",
    MAX(luong) - MIN(luong)            AS "Chênh lệch",
    ROUND(SUM(luong) / 1000000.0, 1)   AS "Tổng quỹ lương (triệu đ)"
FROM nhan_vien;
```

### E3 — Đáp án
```sql
SELECT
    'KH-' || LPAD(id::TEXT, 4, '0')                    AS "Mã KH",
    INITCAP(TRIM(ho_ten))                               AS "Họ và tên",
    LOWER(TRIM(email))                                  AS "Email",
    dien_thoai                                          AS "SĐT",
    CURRENT_DATE - ngay_dang_ky                         AS "Số ngày là KH",
    CASE
        WHEN CURRENT_DATE - ngay_dang_ky < 30   THEN 'Khách hàng mới'
        WHEN CURRENT_DATE - ngay_dang_ky <= 365 THEN 'Khách hàng thân thiết'
        ELSE 'Khách hàng trung thành'
    END                                                 AS "Phân loại"
FROM khach_hang
ORDER BY ngay_dang_ky DESC;
```

</details>

---

## Tự Kiểm Tra

Sau khi làm xong bài tập, hãy kiểm tra lại:

- [ ] Tôi viết `SELECT` và `FROM` viết HOA
- [ ] Tôi dùng dấu nháy kép `"..."` cho alias tiếng Việt
- [ ] Tôi không dùng `*` khi chỉ cần vài cột cụ thể
- [ ] Tôi dùng `/ 12.0` thay vì `/ 12` khi muốn kết quả thập phân
- [ ] Tôi dùng `COALESCE()` để xử lý NULL trong chuỗi
- [ ] Tôi có thể giải thích tại sao alias không dùng được trong `WHERE`
- [ ] Tôi có thể viết `AGE()` và `EXTRACT()` để tính tuổi

---

*Tuần tiếp theo: **WHERE, ORDER BY, LIMIT** — Lọc và sắp xếp dữ liệu!*
