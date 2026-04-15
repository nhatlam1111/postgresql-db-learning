# Tổng Hợp Kiểu Dữ Liệu PostgreSQL — Tài Liệu Tham Khảo

> **Mục đích file này:** Đây là tài liệu tra cứu toàn bộ kiểu dữ liệu PostgreSQL.
> Các kiểu thiết yếu (dùng hằng ngày) đã được dạy chi tiết trong [`lesson.md`](lesson.md).
> File này bổ sung các kiểu mở rộng và nâng cao khi bạn gặp tình huống đặc biệt.

---

## Nhóm 1: Kiểu Thiết Yếu (Đã Học Trong Tuần 3)

Bảng tóm tắt nhanh — xem giải thích đầy đủ trong `lesson.md`.

| Kiểu | Phạm vi / Kích thước | Dùng khi nào | Excel tương đương |
|---|---|---|---|
| `INTEGER` | ±2,147,483,647 | Id, số lượng, năm | Số nguyên |
| `SERIAL` | 1 → 2.1 tỷ, tự tăng | Cột id tự tăng | Fill series tự động |
| `NUMERIC(p,s)` | Chính xác tuyệt đối | **Tiền tệ, kế toán** | Number (decimal) |
| `VARCHAR(n)` | Biến đổi, tối đa n ký tự | Tên, email, địa chỉ | Text giới hạn |
| `TEXT` | Không giới hạn | Mô tả dài, ghi chú | Text tự do |
| `DATE` | Ngày (YYYY-MM-DD) | Ngày sinh, ngày hết hạn | Date format |
| `TIMESTAMP` | Ngày + giờ (không múi giờ) | Ghi log, thời gian tạo | Date+Time |
| `BOOLEAN` | TRUE / FALSE / NULL | Trạng thái, cờ bật/tắt | TRUE/FALSE |

---

## Nhóm 2: Kiểu Số Nguyên Mở Rộng

### SMALLINT — Số Nguyên Nhỏ

```sql
tuoi        SMALLINT,
so_sao      SMALLINT   -- đánh giá từ 1 đến 5
```

| Thuộc tính | Giá trị |
|---|---|
| Bộ nhớ | 2 bytes |
| Phạm vi | -32,768 đến 32,767 |
| Dùng khi nào | Số nhỏ, biết chắc không bao giờ vượt 32,767 |

**Ví dụ phù hợp:** tuổi người (0–150), điểm đánh giá (1–5), số tầng tòa nhà
**Ví dụ KHÔNG phù hợp:** số lượng bán hàng (có thể lên hàng triệu)

> **Thực tế:** Ngày nay ổ cứng rẻ — ưu tiên dùng `INTEGER` cho an toàn, trừ khi bảng có hàng trăm triệu dòng và bạn cần tiết kiệm bộ nhớ.

---

### BIGINT — Số Nguyên Rất Lớn

```sql
so_luong_toan_quoc   BIGINT,
tong_doanh_thu       BIGINT
```

| Thuộc tính | Giá trị |
|---|---|
| Bộ nhớ | 8 bytes |
| Phạm vi | -9,223,372,036,854,775,808 đến 9,223,372,036,854,775,807 (khoảng ±9.2 × 10¹⁸) |
| Dùng khi nào | Số cực lớn, hệ thống phân tán, id bảng hàng tỷ dòng |

**Khi nào cần BIGINT:**
- ID của bảng có hàng tỷ dòng (mạng xã hội lớn, hệ thống log quy mô lớn)
- Tổng tiền toàn hệ thống tích lũy nhiều năm

> **Thực tế:** Đại đa số ứng dụng không bao giờ cần BIGINT — `INTEGER` (2.1 tỷ) là quá đủ.

---

### BIGSERIAL — Số Tự Tăng Cho Bảng Cực Lớn

```sql
id   BIGSERIAL PRIMARY KEY
```

| Kiểu | Phạm vi | Tương đương |
|---|---|---|
| SERIAL | 1 đến 2,147,483,647 | Sequence + INTEGER |
| BIGSERIAL | 1 đến 9,223,372,036,854,775,807 | Sequence + BIGINT |

Tương tự `SERIAL` nhưng dùng `BIGINT` làm nền. Chỉ cần khi bảng có khả năng vượt 2.1 tỷ dòng.

---

## Nhóm 3: Số Thập Phân Dấu Phẩy Động

> ⚠️ **CẢNH BÁO:** Không bao giờ dùng `REAL` hay `DOUBLE PRECISION` cho tiền tệ, giá cả, hoặc bất kỳ con số nào cần chính xác. Dùng `NUMERIC(p,s)` đã học trong `lesson.md`.

### REAL — Số Dấu Phẩy Động Đơn

```sql
nhiet_do    REAL
```

| Thuộc tính | Giá trị |
|---|---|
| Bộ nhớ | 4 bytes |
| Độ chính xác | ~6 chữ số thập phân |
| Dùng khi nào | Tính toán khoa học, vật lý, kỹ thuật |

**Lỗi làm tròn quan trọng:**
```sql
SELECT 0.1::REAL + 0.2::REAL;
-- Kết quả thực tế: 0.30000001192...  (KHÔNG phải 0.3!)
```

Nguyên nhân: REAL lưu số theo dạng nhị phân (binary) — không thể biểu diễn chính xác nhiều số thập phân.

**Khi nào dùng REAL:** Tính toán khoa học, kỹ thuật — kết quả gần đúng là chấp nhận được, không liên quan đến tiền bạc.

---

### DOUBLE PRECISION — Số Dấu Phẩy Động Kép

```sql
toa_do_x    DOUBLE PRECISION
```

| Thuộc tính | Giá trị |
|---|---|
| Bộ nhớ | 8 bytes |
| Độ chính xác | ~15 chữ số thập phân |
| Dùng khi nào | Tính toán khoa học cần độ chính xác cao hơn REAL |

Tương tự `REAL` nhưng chính xác hơn. Vẫn có lỗi làm tròn — **không dùng cho tiền tệ**.

---

## Nhóm 4: Kiểu Chuỗi Mở Rộng

### CHAR(n) — Chuỗi Độ Dài Cố Định

```sql
ma_tinh   CHAR(2),    -- 'HN', 'SG', 'DN'
ma_quoc   CHAR(3)     -- 'VNM', 'USA', 'JPN'
```

| Thuộc tính | Giá trị |
|---|---|
| n | Số ký tự cố định |
| Đặc điểm | Luôn chiếm đúng n ký tự — tự thêm dấu cách nếu thiếu |
| Dùng khi nào | Mã có độ dài **cố định và đã biết trước** |

**Ví dụ quan trọng:**
```sql
-- Cột mã tỉnh khai báo CHAR(2)
'HN'  → lưu 'HN'  ✅ (đúng 2 ký tự)
'H'   → lưu 'H '  (tự thêm 1 dấu cách)
'HNO' → Lỗi! (vượt quá 2 ký tự) ❌
```

**Khi nào KHÔNG dùng CHAR:**
- Tên người: 'Lê' vs 'Nguyễn Thị Bạch Tuyết' — độ dài khác nhau → dùng VARCHAR
- Email, địa chỉ — độ dài không cố định → dùng VARCHAR hoặc TEXT

> **Thực tế:** `CHAR` ít được dùng vì hầu hết dữ liệu không có độ dài cố định. Khi nghi ngờ, hãy dùng `VARCHAR`.

---

## Nhóm 5: Kiểu Thời Gian Mở Rộng

### TIME — Chỉ Giờ

```sql
gio_mo_cua   TIME DEFAULT '08:00:00'
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Chỉ giờ phút giây (không có ngày) |
| Format | `'HH:MM:SS'` hoặc `'HH:MM'` |
| Bộ nhớ | 8 bytes |

```sql
'08:30:00'   -- 8 giờ 30 sáng ✅
'14:00'      -- PostgreSQL tự thêm :00 ✅
'25:00:00'   -- LỖI! (không có 25 giờ) ❌
```

> **Thực tế:** `TIME` ít dùng vì mất thông tin ngày. Trong hầu hết trường hợp, `TIMESTAMP` sẽ phù hợp hơn.

---

### TIMESTAMPTZ — Ngày, Giờ và Múi Giờ

```sql
thoi_gian_dat_hang   TIMESTAMPTZ,
thoi_gian_giao_hang  TIMESTAMPTZ DEFAULT NOW()
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Ngày + giờ + múi giờ (lưu nội bộ dưới dạng UTC) |
| Bộ nhớ | 8 bytes |
| Múi giờ | **Có lưu** — tự động chuyển đổi khi đọc |

**TIMESTAMP vs TIMESTAMPTZ — Khi nào dùng cái nào?**

```
Dùng TIMESTAMP khi:
  ✅ Ứng dụng chỉ dùng tại Việt Nam (một múi giờ duy nhất)
  ✅ Giờ luôn là giờ Việt Nam (UTC+7)

Dùng TIMESTAMPTZ khi:
  ✅ Ứng dụng có người dùng ở nhiều múi giờ khác nhau
  ✅ Cần lưu đúng thời điểm tuyệt đối (không phụ thuộc múi giờ)
  ✅ Giao dịch tài chính quốc tế
  ✅ Không chắc → CHỌN TIMESTAMPTZ cho an toàn
```

**Ví dụ vấn đề múi giờ:**
```
Một đơn hàng được đặt lúc 14:00 (giờ Hà Nội, UTC+7).

Nếu dùng TIMESTAMP:   lưu '2024-01-15 14:00:00'
Nếu dùng TIMESTAMPTZ: lưu '2024-01-15 07:00:00+00' (UTC)

Khách hàng ở Mỹ (UTC-5) hỏi: "Đặt lúc mấy giờ?"
→ TIMESTAMP: không biết đó là giờ nào (thiếu thông tin múi giờ)
→ TIMESTAMPTZ: tự tính ra 02:00 sáng giờ Mỹ ✅
```

---

### INTERVAL — Khoảng Thời Gian

```sql
thoi_gian_bao_hanh   INTERVAL,
thoi_han_hop_dong    INTERVAL
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Khoảng thời gian (bao lâu, không phải thời điểm cụ thể) |
| Ví dụ giá trị | `'1 year'`, `'3 months'`, `'30 days'`, `'2 hours 30 minutes'` |

**So sánh Excel:** Hàm `DATEDIF()` hoặc công thức `=A2-A1` tính số ngày giữa hai ngày.

**Ví dụ sử dụng INTERVAL:**
```sql
-- Tính ngày hết hạn bảo hành
SELECT '2024-01-15'::DATE + INTERVAL '1 year';    -- 2025-01-15
SELECT '2024-01-15'::DATE + INTERVAL '3 months';  -- 2024-04-15

-- Lọc đơn hàng trong 30 ngày qua
SELECT * FROM don_hang
WHERE ngay_dat >= NOW() - INTERVAL '30 days';

-- Tính tuổi chính xác
SELECT ho_ten, AGE(ngay_sinh) AS tuoi_chinh_xac
FROM nhan_vien;
-- Kết quả dạng: "30 years 7 months 5 days"

-- Chỉ lấy số năm tuổi
SELECT ho_ten, EXTRACT(YEAR FROM AGE(ngay_sinh)) AS tuoi
FROM nhan_vien;
```

---

## Nhóm 6: Kiểu Nâng Cao

> Các kiểu này dành cho trường hợp đặc biệt. Người mới bắt đầu **không cần dùng ngay** — hãy nắm vững các kiểu thiết yếu trước.

### UUID — Mã Định Danh Toàn Cầu

```sql
id   UUID DEFAULT gen_random_uuid()
```

UUID là chuỗi 32 ký tự hex ngẫu nhiên, ví dụ:
`'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'`

**Khi nào dùng UUID thay SERIAL:**
- Hệ thống phân tán (nhiều server, mỗi server tự tạo id mà không cần hỏi nhau)
- Không muốn lộ số lượng bản ghi (SERIAL id=5 → biết chỉ có 5 records)
- Merge dữ liệu từ nhiều nguồn (UUID đảm bảo không bao giờ trùng id)

**Để dùng UUID cần bật extension:**
```sql
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
-- hoặc (PostgreSQL 13+):
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

---

### JSON và JSONB — Dữ Liệu Bán Cấu Trúc

```sql
thong_tin_bo_sung   JSONB,
cai_dat             JSON
```

Cho phép lưu dữ liệu dạng JSON (key-value linh hoạt) trong một cột:
```sql
'{"mau_sac": "đỏ", "kich_co": "L", "chat_lieu": "cotton"}'
```

**JSONB vs JSON:**

| | JSON | JSONB |
|---|---|---|
| Lưu dạng | Text nguyên gốc | Binary |
| Tốc độ đọc | Chậm hơn | **Nhanh hơn** |
| Index | Không hỗ trợ tốt | **Có thể đánh index** |
| Giữ thứ tự key | Có | Không |
| Nên dùng | Hiếm | **Ưu tiên** |

**Khi nào dùng JSONB:** Khi cấu trúc dữ liệu không cố định (mỗi sản phẩm có thuộc tính khác nhau).

> **Thực hành tốt:** Nếu cấu trúc cố định → tách thành các cột riêng. JSONB chỉ dùng khi thật sự cần linh hoạt.

---

### ARRAY — Mảng Giá Trị

```sql
so_dien_thoai   TEXT[],      -- Một người có nhiều số điện thoại
ky_nang         VARCHAR[]    -- Danh sách kỹ năng
```

```sql
-- Nhập dữ liệu
INSERT INTO nhan_vien (so_dien_thoai)
VALUES (ARRAY['0901234567', '0281234567']);

-- Truy vấn phần tử trong mảng (chỉ số bắt đầu từ 1, không phải 0)
SELECT so_dien_thoai[1] FROM nhan_vien;  -- lấy số điện thoại đầu tiên

-- Lọc theo phần tử mảng
SELECT * FROM nhan_vien WHERE '0901234567' = ANY(so_dien_thoai);
```

**Khi nào dùng ARRAY:** Khi muốn lưu nhiều giá trị cùng loại trong một cột.

> **Thực hành tốt:** Thường thiết kế tốt hơn là tách thành bảng riêng (quan hệ 1-nhiều). Dùng `ARRAY` chỉ khi mối quan hệ đơn giản và không cần truy vấn phức tạp.

---

## Bảng Tra Cứu Toàn Bộ

```
Câu hỏi cần trả lời                         → Kiểu dữ liệu
─────────────────────────────────────────────────────────────────
Cột id tự tăng?                              → SERIAL
Số nguyên thông thường?                      → INTEGER
Số nguyên nhỏ, biết chắc < 32,767?         → SMALLINT
Số nguyên cực lớn (hàng tỷ)?               → BIGINT
Tiền tệ, giá cả (cần chính xác)?            → NUMERIC(p, s)
Số khoa học (gần đúng là ổn)?              → DOUBLE PRECISION
Tên người, email (giới hạn độ dài)?        → VARCHAR(n)
Mô tả, ghi chú dài?                         → TEXT
Mã cố định (mã tỉnh, mã quốc gia)?         → CHAR(n)
Chỉ lưu ngày?                               → DATE
Chỉ lưu giờ?                                → TIME
Lưu ngày + giờ (nội địa)?                  → TIMESTAMP
Lưu ngày + giờ (quốc tế / không chắc)?    → TIMESTAMPTZ
Khoảng thời gian (1 tháng, 30 ngày)?       → INTERVAL
Đúng/Sai?                                    → BOOLEAN
Id hệ thống phân tán (không trùng toàn cầu)?→ UUID
Dữ liệu linh hoạt, cấu trúc không cố định? → JSONB
Nhiều giá trị cùng loại trong một cột?     → ARRAY
```
