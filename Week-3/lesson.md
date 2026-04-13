# Tuần 3: Tạo Bảng & Nhập Dữ Liệu

> **Thời lượng dự kiến:** 4–5 giờ
>
> **Yêu cầu:** Đã hoàn thành Tuần 2 — DBeaver kết nối được với PostgreSQL, database `hoc_sql` đã tạo

---

## Mục Tiêu Tuần 3

Sau tuần này, bạn sẽ:
- ✅ Hiểu và biết chọn đúng kiểu dữ liệu cho từng cột
- ✅ Tạo bảng với đầy đủ ràng buộc (`CREATE TABLE`)
- ✅ Nhập dữ liệu vào bảng (`INSERT INTO`)
- ✅ Hiểu giá trị NULL và cách xử lý
- ✅ Chỉnh sửa cấu trúc bảng sau khi đã tạo (`ALTER TABLE`)
- ✅ Biết xem thông tin cấu trúc bảng trong DBeaver

---

## Mở Đầu

Tuần 2, bạn đã "nếm thử" lệnh `CREATE TABLE nhan_vien (...)` và thấy nó hoạt động — nhưng bạn chưa thực sự hiểu tại sao phải viết `SERIAL`, `VARCHAR(100)`, hay `NOT NULL`.

Tuần này, chúng ta học từ gốc: **thiết kế bảng đúng cách**.

Hãy nghĩ về việc tạo bảng trong database như thiết kế một form nhập liệu trong Excel:
- Bạn phải quyết định **có bao nhiêu cột** (trường)
- Mỗi cột chứa **loại thông tin gì** (kiểu dữ liệu)
- Cột nào **bắt buộc**, cột nào **có thể để trống**
- Giá trị nào **hợp lệ**, giá trị nào bị chặn

Sự khác biệt lớn với Excel: trong Excel, bạn có thể gõ bất cứ gì vào bất kỳ ô nào. Trong database, **mỗi cột được ràng buộc nghiêm ngặt** — đây chính là sức mạnh của database, không phải hạn chế.

---

## Section 3.1: Kiểu Dữ Liệu (Data Types)

### Tại Sao Phải Khai Báo Kiểu Dữ Liệu?

Trong Excel, bạn có thể gõ `"abc"` vào ô lương — Excel sẽ không phàn nàn gì. Nhưng kết quả là báo cáo sai, hàm SUM bị lỗi, dữ liệu ô nhiễm.

**Trong PostgreSQL, mỗi cột có một kiểu dữ liệu cố định:**
- Cột `luong` khai báo kiểu `NUMERIC` → chỉ nhận số, không nhận chữ
- Cột `ngay_sinh` khai báo kiểu `DATE` → chỉ nhận ngày hợp lệ, không nhận '30/02/2024'
- Cột `ho_ten` khai báo kiểu `VARCHAR(100)` → chỉ nhận chuỗi, tối đa 100 ký tự

PostgreSQL sẽ **từ chối** mọi dữ liệu sai kiểu và báo lỗi ngay lập tức. Đây là cách database bảo vệ tính toàn vẹn dữ liệu.

**So sánh Excel:**

| | Excel | PostgreSQL |
|---|---|---|
| Nhập chữ vào ô số | Cho phép (dữ liệu ô nhiễm) | Báo lỗi, từ chối |
| Nhập ngày sai | Lưu dưới dạng text | Báo lỗi, từ chối |
| Kiểm tra dữ liệu | Data Validation (tùy chọn) | Kiểu dữ liệu (bắt buộc) |

---

### Bảng Tổng Quan: Tất Cả Kiểu Dữ Liệu

> 💡 **Gợi ý:** Click vào tên kiểu dữ liệu để nhảy đến phần giải thích chi tiết bên dưới.

| Nhóm | Kiểu dữ liệu | Phạm vi / Kích thước | Dùng khi nào | Excel tương đương |
|---|---|---|---|---|
| **Số nguyên** | [SMALLINT](#smallint) | -32,768 đến 32,767 | Tuổi, điểm đánh giá | Số nguyên nhỏ |
| | [INTEGER](#integer) | ±2.1 tỷ | **Id, số lượng — mặc định** | Số nguyên |
| | [BIGINT](#bigint) | ±9.2 × 10¹⁸ | Hệ thống lớn | Số nguyên lớn |
| | [SERIAL](#serial) | 1 → 2.1 tỷ, tự tăng | Cột id tự tăng | Fill series tự động |
| | [BIGSERIAL](#serial) | 1 → 9.2 × 10¹⁸, tự tăng | Cột id bảng siêu lớn | Fill series tự động |
| **Số thập phân** | [NUMERIC(p,s)](#numeric) | Chính xác tuyệt đối | **Tiền tệ, kế toán** | Number (decimal) |
| | [REAL](#real) | ~6 chữ số thập phân | Tính toán khoa học | Float |
| | [DOUBLE PRECISION](#real) | ~15 chữ số thập phân | Tính toán khoa học | Double |
| **Chuỗi** | [CHAR(n)](#char) | Cố định n ký tự | Mã cố định (tỉnh, quốc gia) | Text cố định |
| | [VARCHAR(n)](#varchar) | Biến đổi, tối đa n ký tự | Tên, email, địa chỉ | Text giới hạn |
| | [TEXT](#text) | Không giới hạn | Mô tả dài, ghi chú | Text tự do |
| **Ngày / Giờ** | [DATE](#date) | Ngày (YYYY-MM-DD) | Ngày sinh, ngày hết hạn | Date format |
| | [TIME](#time) | Giờ (HH:MM:SS) | Giờ mở/đóng cửa | Time format |
| | [TIMESTAMP](#timestamp) | Ngày + giờ | Ghi log, thời gian tạo | Date+Time |
| | [TIMESTAMPTZ](#timestamptz) | Ngày + giờ + múi giờ | App quốc tế, giao dịch | Date+Time+TZ |
| | [INTERVAL](#interval) | Khoảng thời gian | Thời hạn hợp đồng, tuổi | Tính số ngày |
| **Đúng / Sai** | [BOOLEAN](#boolean) | TRUE / FALSE / NULL | Trạng thái, cờ bật/tắt | TRUE/FALSE |
| **Đặc biệt** | [UUID](#uuid) | Chuỗi 32 ký tự hex | Id hệ thống phân tán | — |
| | [JSON / JSONB](#json) | Dữ liệu JSON linh hoạt | Thuộc tính không cố định | — |
| | [ARRAY](#array) | Mảng nhiều giá trị | Danh sách trong 1 cột | — |

---

### Nhóm 1: Kiểu Số Nguyên

Số nguyên là các số không có phần thập phân: 1, 42, -10, 0.

PostgreSQL có **5 kiểu số nguyên** khác nhau — chọn kiểu phù hợp giúp tiết kiệm bộ nhớ và tránh tràn số.

<a id="smallint"></a>

#### SMALLINT

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

> **Lưu ý:** SMALLINT tiết kiệm bộ nhớ hơn INTEGER, nhưng ngày nay ổ cứng rẻ — ưu tiên chọn INTEGER cho an toàn trừ khi bảng có hàng trăm triệu dòng.

---

<a id="integer"></a>

#### INTEGER (INT)

```sql
id          INTEGER,
so_luong    INTEGER,
nam_sinh    INTEGER
```

| Thuộc tính | Giá trị |
|---|---|
| Bộ nhớ | 4 bytes |
| Phạm vi | -2,147,483,648 đến 2,147,483,647 (khoảng ±2.1 tỷ) |
| Dùng khi nào | **Mặc định cho hầu hết trường hợp** |

**Kiểu số nguyên thông dụng nhất trong PostgreSQL.** Khi không chắc nên dùng kiểu nào, chọn INTEGER.

**Ví dụ thực tế:** id bảng, số lượng hàng tồn, năm sinh, số điện thoại (dưới dạng số — nhưng thực tế nên dùng VARCHAR cho số điện thoại vì có thể bắt đầu bằng 0)

---

<a id="bigint"></a>

#### BIGINT

```sql
so_luong_toan_quoc   BIGINT,
tong_doanh_thu       BIGINT
```

| Thuộc tính | Giá trị |
|---|---|
| Bộ nhớ | 8 bytes |
| Phạm vi | -9,223,372,036,854,775,808 đến 9,223,372,036,854,775,807 (khoảng ±9.2 × 10¹⁸) |
| Dùng khi nào | Số cực lớn, hệ thống phân tán |

**Khi nào cần BIGINT:**
- ID của bảng có hàng tỷ dòng (mạng xã hội lớn, hệ thống log)
- Tổng tiền toàn hệ thống trong nhiều năm
- Số lượng view trên YouTube

**Thực tế:** Đại đa số ứng dụng không bao giờ cần BIGINT cho id — INTEGER (2.1 tỷ) là quá đủ.

---

<a id="serial"></a>

#### SERIAL và BIGSERIAL — Số Tự Tăng

```sql
id   SERIAL PRIMARY KEY
```

| Kiểu | Phạm vi | Tương đương |
|---|---|---|
| SERIAL | 1 đến 2,147,483,647 | Sequence + INTEGER |
| BIGSERIAL | 1 đến 9,223,372,036,854,775,807 | Sequence + BIGINT |

**SERIAL không phải kiểu dữ liệu thật** — nó là cú pháp rút gọn của PostgreSQL:

```sql
-- Khi bạn viết:
id SERIAL PRIMARY KEY

-- PostgreSQL thực ra tạo:
CREATE SEQUENCE nhan_vien_id_seq;
id INTEGER NOT NULL DEFAULT nextval('nhan_vien_id_seq') PRIMARY KEY
```

**So sánh Excel:** Khi bạn gõ 1, 2, 3 vào ô rồi dùng Fill Handle để kéo xuống tự động điền 4, 5, 6... — SERIAL làm điều đó tự động mỗi khi INSERT dữ liệu mới.

```
Excel (thủ công):          PostgreSQL SERIAL (tự động):
┌────┬──────────┐           INSERT → id tự động = 1
│ 1  │ Trần Mai │           INSERT → id tự động = 2
│ 2  │ Nguyễn An│           INSERT → id tự động = 3
│ 3  │ Lê Bình  │           ...
└────┴──────────┘
(phải tự điền STT)          (PostgreSQL tự điền)
```

> ⚠️ **CẢNH BÁO — SERIAL không lấp đầy số bị thiếu:**
>
> Nếu bạn INSERT hàng có `id = 3` rồi xóa nó, id 3 **không bao giờ được dùng lại**.
> Câu INSERT tiếp theo sẽ có `id = 4`, bỏ qua 3.
>
> Đây là hành vi bình thường — id chỉ cần **duy nhất**, không cần **liên tục**.
>
> ```
> id: 1, 2, 4, 5, 7 ...  ← Hoàn toàn ổn! (3 và 6 đã bị xóa)
> ```

> **Lưu ý PostgreSQL 10+:** Từ PostgreSQL 10, có thể dùng `GENERATED ALWAYS AS IDENTITY` thay SERIAL — cách hiện đại hơn. Nhưng SERIAL vẫn hoạt động tốt và phổ biến hơn trong thực tế.

---

### Nhóm 2: Kiểu Số Thập Phân

Số thập phân có phần sau dấu phẩy: 15.5, 99.99, -3.14.

> ⚠️ **QUAN TRỌNG: Không phải kiểu số thập phân nào cũng giống nhau.**
>
> PostgreSQL có 3 kiểu số thập phân với tính chất khác nhau — chọn sai có thể dẫn đến **lỗi tính toán tiền tệ**.

<a id="numeric"></a>

#### NUMERIC(p, s) — Hay còn gọi là DECIMAL(p, s)

```sql
luong       NUMERIC(12, 2),   -- tối đa 12 chữ số, 2 chữ số thập phân
ty_le_chiet NUMERIC(5, 4),    -- tối đa 5 chữ số, 4 chữ số thập phân: 0.1234
```

| Thuộc tính | Giá trị |
|---|---|
| Độ chính xác | **Tuyệt đối — không có lỗi làm tròn** |
| p (precision) | Tổng số chữ số (cả phần nguyên và thập phân) |
| s (scale) | Số chữ số phần thập phân |
| Dùng khi nào | **Tiền tệ, kế toán, bất kỳ số nào cần chính xác** |

**Giải thích p và s:**

```
NUMERIC(10, 2)
         ↑  ↑
         p  s

Ví dụ: 12345678.99
       ↑↑↑↑↑↑↑↑ ↑↑
       8 chữ số  2 chữ số
       nguyên    thập phân
       Tổng p = 10 ✅ (8 + 2 = 10, không vượt)

Ví dụ sẽ bị lỗi: 123456789.99 (11 chữ số > p=10) ❌
```

**Phạm vi cho các trường hợp thường gặp:**

| Trường hợp | Kiểu gợi ý | Ví dụ giá trị tối đa |
|---|---|---|
| Lương nhân viên (VNĐ) | NUMERIC(12, 2) | 9,999,999,999.99 |
| Giá sản phẩm | NUMERIC(10, 2) | 99,999,999.99 |
| Tỷ lệ phần trăm | NUMERIC(5, 2) | 999.99% |
| Tọa độ GPS | NUMERIC(10, 7) | 999.9999999 |

**So sánh Excel:** Ô được format "Number" với 2 chữ số thập phân, nhưng Excel không giới hạn số chữ số như NUMERIC(p,s).

---

<a id="real"></a>

#### REAL và DOUBLE PRECISION — Số Dấu Phẩy Động

```sql
nhiet_do    REAL,
toa_do_x    DOUBLE PRECISION
```

| Kiểu | Độ chính xác | Ví dụ |
|---|---|---|
| REAL | ~6 chữ số thập phân | 3.14159 (chỉ tin đến 6 chữ số) |
| DOUBLE PRECISION | ~15 chữ số thập phân | 3.14159265358979 |

> ⚠️ **CẢNH BÁO — Tuyệt Đối Không Dùng REAL/DOUBLE PRECISION Cho Tiền Tệ:**
>
> Đây là một trong những lỗi nghiêm trọng nhất khi thiết kế database.
>
> **Ví dụ minh họa lỗi làm tròn:**
> ```sql
> SELECT 0.1::REAL + 0.2::REAL;
> -- Kết quả thực tế: 0.30000001192...  (KHÔNG phải 0.3!)
> ```
>
> Nguyên nhân: REAL và DOUBLE PRECISION lưu số theo dạng nhị phân (binary) — không thể biểu diễn chính xác nhiều số thập phân.
>
> **Dùng REAL/DOUBLE PRECISION khi nào:**
> - Tính toán khoa học, kỹ thuật (vật lý, hóa học)
> - Kết quả gần đúng là chấp nhận được
> - Không liên quan đến tiền bạc

---

### Nhóm 3: Kiểu Chuỗi Ký Tự (Text)

<a id="char"></a>

#### CHAR(n) — Chuỗi Độ Dài Cố Định

```sql
ma_tinh   CHAR(2),    -- 'HN', 'SG', 'DN'
ma_quoc   CHAR(3),    -- 'VNM', 'USA', 'JPN'
```

| Thuộc tính | Giá trị |
|---|---|
| n | Số ký tự cố định |
| Đặc điểm | Luôn chiếm đúng n ký tự — tự thêm dấu cách nếu thiếu |
| Dùng khi nào | Mã có độ dài **cố định và đã biết trước** |

**Ví dụ quan trọng về CHAR:**

```sql
-- Cột mã tỉnh khai báo CHAR(2)
INSERT vào cột này với giá trị 'HN'  → lưu 'HN'  (đúng 2 ký tự)
INSERT vào cột này với giá trị 'H'   → lưu 'H '  (tự thêm 1 dấu cách)
INSERT vào cột này với giá trị 'HNO' → Lỗi! (vượt quá 2 ký tự)
```

**Khi nào KHÔNG dùng CHAR:**
- Tên người: 'Lê' vs 'Nguyễn Thị Bạch Tuyết' — độ dài khác nhau → dùng VARCHAR
- Email, địa chỉ — độ dài không cố định → dùng VARCHAR hoặc TEXT

**Thực tế:** CHAR ít được dùng vì hầu hết dữ liệu không có độ dài cố định. Khi nghi ngờ, hãy dùng VARCHAR.

---

<a id="varchar"></a>

#### VARCHAR(n) — Chuỗi Độ Dài Biến Đổi, Có Giới Hạn

```sql
ho_ten      VARCHAR(100),
email       VARCHAR(150),
phong_ban   VARCHAR(50),
dia_chi     VARCHAR(255)
```

| Thuộc tính | Giá trị |
|---|---|
| n | Số ký tự tối đa |
| Đặc điểm | Chiếm đúng số ký tự thực tế — không thêm dấu cách |
| Dùng khi nào | Chuỗi có độ dài **thay đổi nhưng có giới hạn trên** |

**Cách chọn n:**

```
ho_ten VARCHAR(100)   → Họ tên người Việt dài nhất khoảng 50 ký tự → 100 là dư dả
email VARCHAR(150)    → Email thường < 100 ký tự → 150 là an toàn
phong_ban VARCHAR(50) → Tên phòng ban ngắn → 50 là ổn
dia_chi VARCHAR(255)  → Địa chỉ có thể dài → 255 là truyền thống (lý do lịch sử)
```

**Nếu nhập vượt quá n:**
```sql
-- Cột ho_ten VARCHAR(10)
INSERT với 'Nguyễn Văn An Toàn Bình' (22 ký tự) → Lỗi!
-- ERROR: value too long for type character varying(10)
```

---

<a id="text"></a>

#### TEXT — Chuỗi Không Giới Hạn

```sql
mo_ta        TEXT,
noi_dung     TEXT,
ghi_chu      TEXT
```

| Thuộc tính | Giá trị |
|---|---|
| Giới hạn | Không có (lý thuyết tối đa ~1 GB) |
| Đặc điểm | Lưu bao nhiêu ký tự cũng được |
| Dùng khi nào | Mô tả dài, nội dung bài viết, ghi chú tự do |

**TEXT vs VARCHAR — Khi nào chọn cái nào?**

```
Dùng TEXT khi:
  ✅ Không biết trước độ dài tối đa
  ✅ Nội dung có thể rất dài (mô tả sản phẩm, bình luận)
  ✅ Muốn linh hoạt, không muốn bị giới hạn

Dùng VARCHAR(n) khi:
  ✅ Muốn database tự kiểm tra và từ chối dữ liệu quá dài
  ✅ n là ràng buộc nghiệp vụ ("email tối đa 150 ký tự")
```

> **Thực tế trong PostgreSQL:** TEXT và VARCHAR không có nhiều khác biệt về hiệu năng. VARCHAR(n) chỉ thêm một ràng buộc về độ dài — không nhanh hơn hay chậm hơn TEXT.

**So sánh Excel:**

| PostgreSQL | Excel tương đương |
|---|---|
| CHAR(n) | Ô với Data Validation "text length = exactly n" |
| VARCHAR(n) | Ô với Data Validation "text length ≤ n" |
| TEXT | Ô không có giới hạn (General) |

---

### Nhóm 4: Kiểu Ngày Tháng và Thời Gian

Dữ liệu thời gian phức tạp hơn người ta nghĩ — ngày/giờ/múi giờ là 3 thứ khác nhau.

<a id="date"></a>

#### DATE — Chỉ Ngày

```sql
ngay_sinh   DATE,
ngay_vao    DATE,
ngay_het_han DATE
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Chỉ ngày (không có giờ) |
| Format nhập | `'YYYY-MM-DD'` (ISO 8601) |
| Phạm vi | 4713 BC đến 5874897 AD |
| Bộ nhớ | 4 bytes |

**Ví dụ giá trị hợp lệ:**
```sql
'2024-01-15'   -- 15 tháng 1 năm 2024 ✅
'1995-03-20'   -- 20 tháng 3 năm 1995 ✅
'2024-02-29'   -- 29/2/2024 (năm nhuận) ✅
'2023-02-29'   -- 29/2/2023 → LỖI! (2023 không phải năm nhuận) ❌
'2024-13-01'   -- Tháng 13 → LỖI! ❌
```

> **Tại sao phải dùng format YYYY-MM-DD?**
>
> Nếu bạn nhập `'01/03/2024'`, PostgreSQL không biết đây là ngày 1 tháng 3 hay ngày 3 tháng 1 (vì Mỹ dùng MM/DD, Việt Nam dùng DD/MM).
>
> Format `YYYY-MM-DD` theo chuẩn quốc tế ISO 8601 — **không bao giờ nhầm lẫn**.
>
> Nếu cần nhập dạng khác: dùng `TO_DATE('20/03/1995', 'DD/MM/YYYY')`.

**Phép tính với DATE:**
```sql
-- Tính số ngày giữa 2 ngày
SELECT '2024-12-31'::DATE - '2024-01-01'::DATE;  -- Kết quả: 365

-- Cộng thêm số ngày
SELECT '2024-01-01'::DATE + 30;  -- Kết quả: 2024-01-31

-- Hàm ngày hôm nay
SELECT current_date;   -- Ngày hôm nay
SELECT CURRENT_DATE;   -- Như nhau (không phân biệt hoa/thường)
```

---

<a id="time"></a>

#### TIME — Chỉ Giờ

```sql
gio_lam_viec_bat_dau  TIME,
gio_mo_cua            TIME DEFAULT '08:00:00'
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Chỉ giờ phút giây (không có ngày) |
| Format | `'HH:MM:SS'` hoặc `'HH:MM'` |
| Bộ nhớ | 8 bytes |

```sql
'08:30:00'   -- 8 giờ 30 phút sáng ✅
'14:00'      -- 14 giờ (PostgreSQL tự thêm :00) ✅
'25:00:00'   -- LỖI! (không có 25 giờ) ❌
```

**Thực tế:** TIME ít dùng hơn TIMESTAMP. Thường dùng TIMESTAMP (bao gồm cả ngày lẫn giờ) để tránh nhầm lẫn.

---

<a id="timestamp"></a>

#### TIMESTAMP — Ngày và Giờ (Không Có Múi Giờ)

```sql
ngay_tao     TIMESTAMP DEFAULT NOW(),
ngay_cap_nhat TIMESTAMP
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Ngày + giờ phút giây + phần nghìn giây |
| Format | `'YYYY-MM-DD HH:MM:SS'` |
| Bộ nhớ | 8 bytes |
| Múi giờ | **Không lưu** múi giờ |

```sql
'2024-01-15 14:30:00'         -- Ngày 15/1/2024 lúc 14:30 ✅
'2024-01-15 14:30:59.123'     -- Kèm phần nghìn giây ✅
```

**So sánh Excel:** Ô format "Custom: DD/MM/YYYY HH:MM:SS"

---

<a id="timestamptz"></a>

#### TIMESTAMPTZ — Ngày, Giờ và Múi Giờ

```sql
thoi_gian_dat_hang  TIMESTAMPTZ,
thoi_gian_giao_hang TIMESTAMPTZ DEFAULT NOW()
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Ngày + giờ + múi giờ |
| Bộ nhớ | 8 bytes |
| Múi giờ | **Có lưu** — tự động chuyển đổi |

**TIMESTAMP vs TIMESTAMPTZ — Khi nào dùng cái nào?**

```
Dùng TIMESTAMP khi:
  ✅ Ứng dụng chỉ dùng tại Việt Nam (một múi giờ)
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
Nếu dùng TIMESTAMP: lưu '2024-01-15 14:00:00'
Nếu dùng TIMESTAMPTZ: lưu '2024-01-15 07:00:00+00' (UTC)

Khách hàng ở Mỹ (UTC-5) hỏi: "Đơn đặt lúc mấy giờ?"
TIMESTAMP: không biết đó là giờ nào (thiếu thông tin múi giờ)
TIMESTAMPTZ: tự tính ra 02:00 (giờ Mỹ) ✅
```

---

<a id="interval"></a>

#### INTERVAL — Khoảng Thời Gian

```sql
thoi_gian_bao_hanh  INTERVAL,
thoi_han_hop_dong   INTERVAL
```

| Thuộc tính | Giá trị |
|---|---|
| Lưu gì | Khoảng thời gian (bao lâu) |
| Ví dụ | '1 year', '3 months', '30 days', '2 hours 30 minutes' |

```sql
-- Ví dụ sử dụng INTERVAL
SELECT '2024-01-15'::DATE + INTERVAL '1 year';   -- 2025-01-15
SELECT '2024-01-15'::DATE + INTERVAL '3 months'; -- 2024-04-15
SELECT NOW() + INTERVAL '30 days';               -- Ngày hết hạn sau 30 ngày

-- Tính tuổi nhân viên
SELECT ho_ten, AGE(ngay_sinh) AS tuoi_chinh_xac
FROM nhan_vien;
-- Kết quả: "30 years 7 months 5 days"

-- Chỉ lấy số năm
SELECT ho_ten, EXTRACT(YEAR FROM AGE(ngay_sinh)) AS tuoi
FROM nhan_vien;
```

---

<a id="boolean"></a>

### Nhóm 5: Kiểu Boolean (Đúng / Sai)

```sql
dang_lam_viec   BOOLEAN DEFAULT TRUE,
da_thanh_toan   BOOLEAN DEFAULT FALSE,
la_vip          BOOLEAN
```

| Thuộc tính | Giá trị |
|---|---|
| Các giá trị TRUE | `TRUE`, `'true'`, `'t'`, `'yes'`, `'y'`, `'on'`, `'1'` |
| Các giá trị FALSE | `FALSE`, `'false'`, `'f'`, `'no'`, `'n'`, `'off'`, `'0'` |
| Giá trị thứ 3 | `NULL` (không biết / chưa xác định) |
| Bộ nhớ | 1 byte |

**Ví dụ INSERT:**
```sql
-- Tất cả các cách sau đều có nghĩa như nhau:
INSERT INTO nhan_vien (dang_lam_viec) VALUES (TRUE);
INSERT INTO nhan_vien (dang_lam_viec) VALUES ('true');
INSERT INTO nhan_vien (dang_lam_viec) VALUES ('yes');
INSERT INTO nhan_vien (dang_lam_viec) VALUES ('1');
```

**So sánh Excel:** Ô chứa giá trị TRUE/FALSE (dùng trong công thức IF).

> **NULL ≠ FALSE trong Boolean:**
>
> ```
> TRUE  = Đúng, có, bật
> FALSE = Sai, không, tắt
> NULL  = Không biết (chưa xác định)
> ```
>
> Ví dụ: cột `da_gui_email`:
> - `TRUE` → Đã gửi
> - `FALSE` → Chưa gửi (biết chắc chưa gửi)
> - `NULL` → Chưa xác định (không biết đã gửi chưa)

**Phép tính với Boolean:**
```sql
-- Lọc nhân viên đang làm việc
WHERE dang_lam_viec = TRUE
-- hoặc ngắn gọn hơn:
WHERE dang_lam_viec

-- Lọc nhân viên đã nghỉ
WHERE dang_lam_viec = FALSE
-- hoặc:
WHERE NOT dang_lam_viec
```

---

### Nhóm 6: Các Kiểu Đặc Biệt (Giới Thiệu)

Bạn không cần dùng ngay, nhưng nên biết chúng tồn tại:

<a id="uuid"></a>

#### UUID — Mã Định Danh Toàn Cầu

```sql
id   UUID DEFAULT gen_random_uuid()
```

UUID là chuỗi 32 ký tự hex ngẫu nhiên, ví dụ: `'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'`

**Khi nào dùng UUID thay SERIAL:**
- Hệ thống phân tán (nhiều server, mỗi server tự tạo id mà không cần hỏi nhau)
- Không muốn lộ số lượng bản ghi (SERIAL id=5 → biết chỉ có 5 records)
- Merge dữ liệu từ nhiều nguồn (không bao giờ trùng id)

<a id="json"></a>

#### JSON và JSONB — Dữ Liệu Bán Cấu Trúc

```sql
thong_tin_bo_sung   JSONB,
cai_dat             JSON
```

Cho phép lưu dữ liệu dạng JSON (key-value linh hoạt) trong cột:
```sql
'{"mau_sac": "đỏ", "kich_co": "L", "chat_lieu": "cotton"}'
```

**JSONB nhanh hơn JSON** vì lưu dưới dạng binary và có thể đánh index.

**Khi nào dùng:** Khi cấu trúc dữ liệu không cố định (mỗi sản phẩm có thuộc tính khác nhau).

<a id="array"></a>

#### ARRAY — Mảng Giá Trị

```sql
so_dien_thoai   TEXT[],      -- Một người có thể có nhiều số điện thoại
ky_nang         VARCHAR[]    -- Danh sách kỹ năng
```

```sql
INSERT INTO nhan_vien (so_dien_thoai) VALUES (ARRAY['0901234567', '0281234567']);
-- hoặc
INSERT INTO nhan_vien (so_dien_thoai) VALUES ('{"0901234567", "0281234567"}');
```

**Khi nào dùng:** Khi muốn lưu nhiều giá trị trong một cột — nhưng thường thiết kế tốt hơn là tách thành bảng riêng.

---

### Tổng Kết — Bảng Tra Cứu Nhanh

```
Câu hỏi cần trả lời                    → Kiểu dữ liệu nên dùng
─────────────────────────────────────────────────────────────────
Cột id tự tăng?                         → SERIAL
Số nguyên thông thường?                 → INTEGER
Số nguyên rất lớn (hàng tỷ)?           → BIGINT
Tiền tệ, giá cả (cần chính xác)?       → NUMERIC(p, s)
Số khoa học (gần đúng là ổn)?          → DOUBLE PRECISION
Tên người, email (giới hạn độ dài)?    → VARCHAR(n)
Mô tả, ghi chú dài?                    → TEXT
Mã cố định (tỉnh, quốc gia)?           → CHAR(n)
Chỉ lưu ngày?                          → DATE
Lưu ngày + giờ (nội địa)?             → TIMESTAMP
Lưu ngày + giờ (quốc tế / không chắc)?→ TIMESTAMPTZ
Khoảng thời gian (1 tháng, 30 ngày)?  → INTERVAL
Đúng/Sai?                              → BOOLEAN
```

---

### Ví Dụ Thiết Kế Bảng Thực Tế

Đây là bảng `nhan_vien` được thiết kế đầy đủ — giải thích lý do chọn từng kiểu dữ liệu:

```sql
CREATE TABLE nhan_vien (
    -- SERIAL: id tự tăng, không bao giờ trùng
    id           SERIAL,

    -- VARCHAR(100): tên người dài tối đa ~50 ký tự → 100 dư dả
    ho_ten       VARCHAR(100),

    -- VARCHAR(50): tên phòng ban ngắn
    phong_ban    VARCHAR(50),

    -- NUMERIC(12,2): lương tối đa 9,999,999,999.99 VNĐ
    --   Dùng NUMERIC thay REAL vì đây là tiền tệ, cần chính xác
    luong        NUMERIC(12, 2),

    -- DATE: chỉ cần ngày, không cần giờ phút giây
    ngay_sinh    DATE,

    -- VARCHAR(150): email tối đa ~100 ký tự theo RFC 5321, đặt 150 cho an toàn
    email        VARCHAR(150),

    -- TIMESTAMP: ngày vào làm, chỉ cần giờ nội địa
    ngay_vao     TIMESTAMP DEFAULT NOW(),

    -- BOOLEAN: đang làm hay đã nghỉ
    dang_lam     BOOLEAN DEFAULT TRUE
);
```

---

*Các section tiếp theo (3.2 CREATE TABLE với Constraints, 3.3 INSERT INTO, 3.4 NULL, 3.5 ALTER TABLE, 3.6 DROP TABLE, 3.7 Xem thông tin bảng) sẽ được bổ sung trong các buổi học tiếp theo.*
