# Bài Tập Tuần 3: Tạo Bảng & Nhập Dữ Liệu

> **Yêu cầu:** Đã kết nối DBeaver vào database `hoc_sql` và đã chạy `examples.sql` Phần 2–3 (tạo bảng + nhập dữ liệu mẫu).

---

## Nhóm A: Chọn Kiểu Dữ Liệu (Cơ Bản)

> Không cần chạy SQL — bài tập tư duy về kiểu dữ liệu.

### Bài A1 — Ghép Đôi

Nối mỗi mô tả bên trái với kiểu dữ liệu phù hợp nhất bên phải:

| # | Mô tả cột | | Kiểu dữ liệu |
|---|---|---|---|
| 1 | Số điện thoại Việt Nam (VD: 0901234567) | → | A. `DATE` |
| 2 | Số tuổi của nhân viên (0–120) | → | B. `BOOLEAN` |
| 3 | Mô tả chi tiết sản phẩm, không giới hạn | → | C. `VARCHAR(15)` |
| 4 | Giá sản phẩm (VD: 15,990,000.00 VNĐ) | → | D. `SMALLINT` |
| 5 | Ngày sinh nhân viên | → | E. `NUMERIC(12,2)` |
| 6 | Trạng thái còn hàng hay hết hàng | → | F. `TEXT` |
| 7 | STT tự tăng cho mỗi đơn hàng | → | G. `TIMESTAMPTZ` |
| 8 | Thời điểm đặt hàng (có múi giờ, dùng toàn cầu) | → | H. `SERIAL` |

*Ghi đáp án của bạn:* 1→___ 2→___ 3→___ 4→___ 5→___ 6→___ 7→___ 8→___

---

### Bài A2 — Đúng hay Sai?

Đọc mỗi khai báo cột và đánh dấu Đúng (D) hoặc Sai (S). Nếu Sai, giải thích lý do.

```
1. luong    REAL          -- Lưu lương nhân viên theo VNĐ
   [ ] Đúng  [ ] Sai
   Lý do nếu Sai: _______________________________________________

2. ho_ten   CHAR(100)     -- Lưu họ tên nhân viên
   [ ] Đúng  [ ] Sai
   Lý do nếu Sai: _______________________________________________

3. diem_kpi INTEGER       -- Lưu điểm KPI từ 0.0 đến 5.0
   [ ] Đúng  [ ] Sai
   Lý do nếu Sai: _______________________________________________

4. ngay_sinh TIMESTAMP    -- Lưu ngày sinh nhân viên
   [ ] Đúng  [ ] Sai
   Lý do nếu Sai: _______________________________________________

5. ma_tinh  CHAR(2)       -- Lưu mã tỉnh thành (HN, SG, DN...)
   [ ] Đúng  [ ] Sai
   Lý do nếu Sai: _______________________________________________

6. so_luong SMALLINT      -- Lưu số lượng hàng trong kho (tối đa vài ngàn)
   [ ] Đúng  [ ] Sai
   Lý do nếu Sai: _______________________________________________
```

---

### Bài A3 — Chọn Kiểu Phù Hợp

Với mỗi cột bên dưới, chọn kiểu dữ liệu tốt nhất và giải thích ngắn gọn tại sao:

```
1. Cột lưu nội dung email (thân bài email, không giới hạn ký tự)
   Kiểu: _______________  Lý do: _______________________________________________

2. Cột lưu mã quốc gia theo ISO (VN, US, JP — luôn đúng 2 ký tự)
   Kiểu: _______________  Lý do: _______________________________________________

3. Cột lưu tọa độ kinh độ GPS (ví dụ: 106.6602671 — cần 7 chữ số thập phân)
   Kiểu: _______________  Lý do: _______________________________________________

4. Cột lưu số lượng lượt xem của bài viết (có thể lên đến hàng tỷ)
   Kiểu: _______________  Lý do: _______________________________________________

5. Cột lưu thời hạn bảo hành sản phẩm (ví dụ: "1 năm", "6 tháng")
   Kiểu: _______________  Lý do: _______________________________________________
```

---

## Nhóm B: Thiết Kế Bảng — CREATE TABLE (Trung Bình)

> Viết lệnh SQL và chạy trong DBeaver.

### Bài B1 — Tạo Bảng `phong_ban`

Công ty cần một bảng quản lý phòng ban với các thông tin sau:
- Mã phòng ban (tự tăng, duy nhất)
- Tên phòng ban (bắt buộc, không trùng, tối đa 100 ký tự)
- Tên trưởng phòng (tối đa 100 ký tự, có thể chưa có)
- Ngân sách hàng tháng (số tiền VNĐ, phải lớn hơn 0)
- Ngày thành lập phòng ban
- Đang hoạt động hay đã giải thể (mặc định: đang hoạt động)

```sql
-- Viết câu CREATE TABLE của bạn ở đây:
CREATE TABLE phong_ban (


);
```

Sau khi tạo, kiểm tra bằng cách xem tab **Columns** trong DBeaver.

---

### Bài B2 — Tạo Bảng `kho_hang`

Thiết kế bảng theo dõi nhập/xuất kho với yêu cầu:
- STT tự tăng
- Mã sản phẩm (số nguyên, bắt buộc)
- Loại giao dịch: chỉ được là `'Nhập'` hoặc `'Xuất'`
- Số lượng giao dịch (phải lớn hơn 0)
- Ghi chú (không giới hạn ký tự, có thể để trống)
- Thời điểm giao dịch (ngày + giờ, tự động điền thời điểm hiện tại)
- Người thực hiện (tối đa 100 ký tự, bắt buộc)

```sql
-- Viết câu CREATE TABLE của bạn ở đây:
CREATE TABLE kho_hang (


);
```

---

### Bài B3 — Phát Hiện Lỗi

Các câu CREATE TABLE dưới đây có lỗi. Tìm và sửa lỗi:

**Bảng 1:**
```sql
CREATE TABLE san_pham_loi (
    id       SERIAL,
    ten_sp   VARCHAR(200) NOT NULL UNIQUE,
    gia      REAL,                          -- Dùng để lưu giá tiền VNĐ
    so_luong SMALLINT DEFAULT 0,
    PRIMARY KAY (id)                        -- Có lỗi chính tả
);
```
Lỗi: _______________________________________________
Sửa thành: _______________________________________________

**Bảng 2:**
```sql
CREATE TABLE don_hang_loi (
    id          SERIAL PRIMARY KEY,
    ngay_dat    DATE NOT NULL DEFAULT '2024-01-01',
    tong_tien   NUMERIC(12,2) CHECK tong_tien > 0,  -- Thiếu dấu ngoặc
    trang_thai  VARCHAR(20) DEFAULT Cho xu ly        -- Thiếu dấu nháy đơn
);
```
Lỗi 1: _______________________________________________
Lỗi 2: _______________________________________________
Sửa thành:
```sql
-- Viết lại câu đúng:
```

---

## Nhóm C: Nhập Dữ Liệu — INSERT INTO (Trung Bình)

> Chạy trong DBeaver, quan sát kết quả và lỗi.

### Bài C1 — INSERT Cơ Bản

Thêm 5 sản phẩm vào bảng `san_pham` (dùng thực phẩm/đồ uống làm ví dụ):

```sql
-- Yêu cầu: tối thiểu có ten_sp, danh_muc, gia, so_luong_ton
-- Ít nhất 1 sản phẩm có mo_ta, ít nhất 1 sản phẩm để mo_ta = NULL
INSERT INTO san_pham (ten_sp, danh_muc, gia, so_luong_ton, mo_ta)
VALUES
    -- Viết dữ liệu của bạn:
    (...),
    (...),
    (...),
    (...),
    (...);
```

Sau khi INSERT, chạy `SELECT * FROM san_pham ORDER BY id DESC LIMIT 5;` để xem 5 sản phẩm vừa thêm.

---

### Bài C2 — Thử Nghiệm Vi Phạm Ràng Buộc

Chạy từng câu dưới đây và ghi lại thông báo lỗi PostgreSQL trả về. Giải thích tại sao lỗi xảy ra.

```sql
-- Câu 1: Vi phạm NOT NULL
INSERT INTO nhan_vien (phong_ban, luong)
VALUES ('IT', 20000000);
```
Lỗi: _______________________________________________
Nguyên nhân: _______________________________________________

---

```sql
-- Câu 2: Vi phạm UNIQUE (email đã tồn tại)
INSERT INTO nhan_vien (ho_ten, email)
VALUES ('Người Mới', 'mai.tran@cty.com');
```
Lỗi: _______________________________________________
Nguyên nhân: _______________________________________________

---

```sql
-- Câu 3: Vi phạm CHECK constraint
INSERT INTO san_pham (ten_sp, gia, so_luong_ton)
VALUES ('Sản phẩm lỗi', -5000, 10);
```
Lỗi: _______________________________________________
Nguyên nhân: _______________________________________________

---

```sql
-- Câu 4: Sai kiểu dữ liệu
INSERT INTO nhan_vien (ho_ten, ngay_sinh)
VALUES ('Nguyễn Thử', 'hai mươi tháng ba');
```
Lỗi: _______________________________________________
Nguyên nhân: _______________________________________________

---

### Bài C3 — INSERT với RETURNING

```sql
-- Thêm một nhân viên mới và lấy lại id được tạo:
INSERT INTO nhan_vien (ho_ten, phong_ban, luong)
VALUES ('Nguyễn Nhân Viên Mới', 'IT', 19000000)
RETURNING id, ho_ten, ngay_vao;
```

```
1. id được tạo là bao nhiêu? _______________
2. ngay_vao có giá trị gì (dù không nhập)? _______________
3. Tại sao ngay_vao tự có giá trị?
   Trả lời: _______________________________________________
```

---

### Bài C4 — Thực Hành INSERT Hoàn Chỉnh

Thêm 3 khách hàng vào bảng `khach_hang`:
1. Một khách hàng VIP có đầy đủ thông tin
2. Một khách hàng bình thường chỉ có tên và số điện thoại
3. Một khách hàng chỉ có tên (không có SĐT, không có email)

```sql
-- Viết 3 câu INSERT của bạn:
INSERT INTO khach_hang (...) VALUES (...);
INSERT INTO khach_hang (...) VALUES (...);
INSERT INTO khach_hang (...) VALUES (...);
```

Sau đó kiểm tra:
```sql
SELECT ho_ten, so_dien_thoai, email, la_vip
FROM khach_hang
ORDER BY id DESC
LIMIT 3;
```

```
Khách VIP có la_vip = _______________
Khách chỉ có tên: so_dien_thoai = _______________ email = _______________
```

---

## Nhóm D: NULL và COALESCE (Trung Bình → Nâng Cao)

> Chạy trong DBeaver với dữ liệu đã nhập từ examples.sql.

### Bài D1 — Tìm Hiểu NULL

Chạy từng câu và ghi lại kết quả:

```sql
-- Câu 1
SELECT 100 + NULL AS ket_qua;
```
Kết quả: _______________ Giải thích: _______________________________________________

---

```sql
-- Câu 2
SELECT NULL = NULL AS so_sanh;
```
Kết quả: _______________ Giải thích tại sao không phải TRUE:
_______________________________________________

---

```sql
-- Câu 3: Điều gì xảy ra khi lọc với = NULL?
SELECT COUNT(*) FROM nhan_vien WHERE email = NULL;
SELECT COUNT(*) FROM nhan_vien WHERE email IS NULL;
```
Câu 3a kết quả: _______________
Câu 3b kết quả: _______________
Bài học rút ra: _______________________________________________

---

```sql
-- Câu 4: NULL trong chuỗi
SELECT 'Nhân viên: ' || NULL AS thong_tin;
```
Kết quả: _______________ 
Giải pháp để tránh NULL: _______________________________________________

---

### Bài D2 — Thực Hành COALESCE

Viết câu SQL hoàn chỉnh cho từng yêu cầu:

```
1. Hiển thị danh sách khách hàng: cột "lien_lac" ưu tiên hiển thị
   số điện thoại, nếu không có thì hiển thị email, nếu vẫn không có
   thì hiển thị "Không có thông tin liên lạc".

SQL: _______________________________________________
     _______________________________________________
```

---

```
2. Hiển thị danh sách nhân viên với cột "luong_thang" — nếu lương NULL
   thì hiển thị 0, đồng thời tính thêm cột "luong_nam" = luong_thang * 13
   (13 tháng lương bao gồm thưởng tháng 13).

SQL: _______________________________________________
     _______________________________________________
```

---

```
3. Trong bảng san_pham, hiển thị cột "mo_ta_hien_thi": nếu mo_ta có giá
   trị thì dùng mo_ta, nếu NULL thì hiển thị "Chưa có mô tả".

SQL: _______________________________________________
     _______________________________________________
```

---

### Bài D3 — Câu Hỏi Tư Duy

```
1. Sự khác biệt giữa:
   (a) nhan_vien chưa có email → email = NULL
   (b) nhan_vien có email rỗng → email = ''
   Khi nào dùng NULL, khi nào dùng '' ?
   Trả lời: _______________________________________________
   _______________________________________________

2. Tại sao COUNT(*) và COUNT(ten_cot) cho kết quả khác nhau?
   Trả lời: _______________________________________________

3. Một nhân viên có luong = 0 khác gì với luong = NULL?
   Trả lời: _______________________________________________
```

---

## Nhóm E: ALTER TABLE (Nâng Cao)

> Thực hành thay đổi cấu trúc bảng trên dữ liệu thật.

### Bài E1 — Thêm và Xóa Cột

```
1. Thêm cột "website" (VARCHAR 200, có thể để trống) vào bảng khach_hang.
   Viết lệnh SQL: _______________________________________________

2. Thêm cột "diem_thuong" (INTEGER, mặc định 0, không được âm) vào khach_hang.
   Viết lệnh SQL: _______________________________________________

3. Kiểm tra: SELECT * FROM khach_hang LIMIT 3;
   Cột diem_thuong của các hàng cũ có giá trị gì? _______________
   Tại sao? _______________________________________________

4. Xóa cột "website" vừa thêm.
   Viết lệnh SQL: _______________________________________________
```

---

### Bài E2 — Thêm Constraint Sau Khi Tạo Bảng

Bảng `san_pham` hiện tại thiếu một số ràng buộc. Thêm chúng:

```sql
-- 1. Đảm bảo ten_sp không có khoảng trắng ở đầu và cuối
--    (Gợi ý: CHECK với hàm TRIM)
ALTER TABLE san_pham
    ADD CONSTRAINT _______________________________________________

-- 2. Thêm giá trị mặc định cho cột danh_muc
ALTER TABLE san_pham
    ALTER COLUMN _______________________________________________

-- 3. Thêm constraint: so_luong_ton không được vượt quá 99999
ALTER TABLE san_pham
    ADD CONSTRAINT _______________________________________________
```

---

### Bài E3 — Kịch Bản Thực Tế

Công ty vừa có yêu cầu mới: cần thêm trường "hệ số lương" vào bảng nhân viên để tính lương theo công thức `luong_co_ban * he_so`.

```
1. Thêm cột he_so_luong (NUMERIC, 2 chữ số thập phân, mặc định 1.0, 
   phải từ 0.5 đến 3.0) vào bảng nhan_vien.
   Viết lệnh: _______________________________________________
              _______________________________________________

2. Sau khi thêm, chạy câu SELECT để hiển thị:
   ho_ten | luong | he_so_luong | luong_thuc_nhan (= luong * he_so_luong)
   Viết lệnh: _______________________________________________
              _______________________________________________

3. Đổi tên cột he_so_luong thành he_so.
   Viết lệnh: _______________________________________________
```

---

## Đáp Án Gợi Ý

---

### Đáp Án Nhóm A

**Bài A1 — Ghép đôi:**
1→C (VARCHAR(15) — số điện thoại có thể có ký tự đặc biệt, không phải INTEGER)
2→D (SMALLINT — tuổi người tối đa ~120, nằm trong phạm vi SMALLINT)
3→F (TEXT — không giới hạn ký tự)
4→E (NUMERIC(12,2) — tiền tệ cần chính xác, không dùng REAL)
5→A (DATE — chỉ cần ngày, không cần giờ)
6→B (BOOLEAN — TRUE/FALSE)
7→H (SERIAL — STT tự tăng)
8→G (TIMESTAMPTZ — có múi giờ, dùng toàn cầu)

**Bài A2 — Đúng / Sai:**
1. ❌ Sai — Không dùng REAL cho tiền tệ vì lỗi làm tròn. Dùng NUMERIC(15,2).
2. ❌ Sai — CHAR(100) luôn chiếm đúng 100 ký tự, thêm dấu cách thừa. Dùng VARCHAR(100).
3. ❌ Sai — INTEGER không lưu được số thập phân (0.0–5.0). Dùng NUMERIC(3,1).
4. ❌ Sai — Ngày sinh chỉ cần DATE, không cần TIMESTAMP (thừa phần giờ/phút/giây).
5. ✅ Đúng — Mã tỉnh luôn đúng 2 ký tự → CHAR(2) phù hợp.
6. ✅ Đúng — Số lượng kho vài ngàn nằm trong phạm vi SMALLINT (≤32,767).

**Bài A3 — Chọn kiểu:**
1. TEXT — nội dung email không giới hạn ký tự
2. CHAR(2) — mã quốc gia luôn đúng 2 ký tự
3. NUMERIC(11,7) — tọa độ GPS cần chính xác tuyệt đối, không dùng REAL/DOUBLE PRECISION
4. BIGINT — hàng tỷ lượt view vượt quá phạm vi INTEGER (±2.1 tỷ)
5. INTERVAL — thời hạn bảo hành là khoảng thời gian; có thể dùng VARCHAR nếu muốn lưu text

---

### Đáp Án Nhóm B

**Bài B1 — Bảng phong_ban (gợi ý):**
```sql
CREATE TABLE phong_ban (
    id            SERIAL         PRIMARY KEY,
    ten_pb        VARCHAR(100)   NOT NULL UNIQUE,
    truong_phong  VARCHAR(100),
    ngan_sach     NUMERIC(15,2)  CHECK (ngan_sach > 0),
    ngay_thanh_lap DATE,
    dang_hoat_dong BOOLEAN       DEFAULT TRUE
);
```

**Bài B2 — Bảng kho_hang (gợi ý):**
```sql
CREATE TABLE kho_hang (
    id            SERIAL         PRIMARY KEY,
    san_pham_id   INTEGER        NOT NULL,
    loai_gd       VARCHAR(10)    NOT NULL CHECK (loai_gd IN ('Nhập', 'Xuất')),
    so_luong      INTEGER        NOT NULL CHECK (so_luong > 0),
    ghi_chu       TEXT,
    thoi_diem     TIMESTAMP      DEFAULT NOW(),
    nguoi_thuc_hien VARCHAR(100) NOT NULL
);
```

**Bài B3 — Phát hiện lỗi:**

Bảng 1:
- Lỗi: `PRIMARY KAY` → sửa thành `PRIMARY KEY`

Bảng 2:
- Lỗi 1: `CHECK tong_tien > 0` → thiếu dấu ngoặc, sửa thành `CHECK (tong_tien > 0)`
- Lỗi 2: `DEFAULT Cho xu ly` → thiếu dấu nháy đơn, sửa thành `DEFAULT 'Cho xu ly'`

---

### Đáp Án Nhóm C

**Bài C2 — Thông báo lỗi:**
1. `null value in column "ho_ten" of relation "nhan_vien" violates not-null constraint` — ho_ten là NOT NULL nhưng không được truyền vào
2. `duplicate key value violates unique constraint "nhan_vien_email_key"` — email 'mai.tran@cty.com' đã tồn tại
3. `new row for relation "san_pham" violates check constraint "san_pham_gia_check"` — gia = -5000 vi phạm CHECK (gia > 0)
4. `invalid input syntax for type date: "hai mươi tháng ba"` — chuỗi không thể chuyển thành DATE

**Bài C3 — RETURNING:**
- id: số tiếp theo sau 6 nhân viên đã có (thường là 7)
- ngay_vao: ngày hôm nay (CURRENT_DATE)
- Tại sao: vì cột ngay_vao có DEFAULT CURRENT_DATE

---

### Đáp Án Nhóm D

**Bài D1:**
1. Kết quả: `NULL` — bất kỳ phép tính nào với NULL đều ra NULL
2. Kết quả: `NULL` — NULL = NULL là UNKNOWN, không phải TRUE
3. Câu 3a: `0` — `= NULL` không bao giờ đúng; Câu 3b: `1` — IS NULL đúng
4. Kết quả: `NULL` — nối chuỗi với NULL ra NULL; Giải pháp: dùng COALESCE(email, '')

**Bài D2:**
1. `SELECT ho_ten, COALESCE(so_dien_thoai, email, 'Không có thông tin liên lạc') AS lien_lac FROM khach_hang;`
2. `SELECT ho_ten, COALESCE(luong,0) AS luong_thang, COALESCE(luong,0)*13 AS luong_nam FROM nhan_vien;`
3. `SELECT ten_sp, COALESCE(mo_ta, 'Chưa có mô tả') AS mo_ta_hien_thi FROM san_pham;`

**Bài D3:**
1. NULL = "không có / chưa biết"; `''` = "biết rõ là rỗng". Dùng NULL khi thông tin chưa có, dùng `''` khi biết chắc giá trị là chuỗi rỗng. Trong thực tế nên chọn một cách nhất quán, thường dùng NULL.
2. `COUNT(*)` đếm tất cả hàng kể cả NULL; `COUNT(cot)` chỉ đếm hàng có giá trị (bỏ qua NULL).
3. `luong = 0`: nhân viên biết rõ lương là 0 (ví dụ: thực tập sinh không lương). `luong = NULL`: chưa xác định lương (chưa ký hợp đồng, chưa thỏa thuận).

---

### Đáp Án Nhóm E

**Bài E1:**
```sql
-- 1. Thêm cột website
ALTER TABLE khach_hang ADD COLUMN website VARCHAR(200);

-- 2. Thêm cột diem_thuong
ALTER TABLE khach_hang ADD COLUMN diem_thuong INTEGER DEFAULT 0 CHECK (diem_thuong >= 0);

-- 3. Kết quả: diem_thuong = 0 — vì khi thêm cột mới, các hàng cũ lấy DEFAULT
-- 4. Xóa cột website
ALTER TABLE khach_hang DROP COLUMN website;
```

**Bài E2:**
```sql
-- 1. CHECK TRIM
ALTER TABLE san_pham
    ADD CONSTRAINT ten_sp_khong_chua_khoang_trang CHECK (TRIM(ten_sp) = ten_sp);

-- 2. DEFAULT cho danh_muc
ALTER TABLE san_pham ALTER COLUMN danh_muc SET DEFAULT 'Chưa phân loại';

-- 3. Giới hạn tồn kho
ALTER TABLE san_pham
    ADD CONSTRAINT ton_kho_toi_da CHECK (so_luong_ton <= 99999);
```

**Bài E3:**
```sql
-- 1. Thêm he_so_luong
ALTER TABLE nhan_vien
    ADD COLUMN he_so_luong NUMERIC(4,2) DEFAULT 1.0
        CHECK (he_so_luong BETWEEN 0.5 AND 3.0);

-- 2. Hiển thị lương thực nhận
SELECT
    ho_ten,
    luong,
    he_so_luong,
    ROUND(luong * he_so_luong, 0) AS luong_thuc_nhan
FROM nhan_vien;

-- 3. Đổi tên cột
ALTER TABLE nhan_vien RENAME COLUMN he_so_luong TO he_so;
```

---

## Tự Kiểm Tra Cuối Tuần 3

```
[ ] Tôi biết chọn đúng kiểu dữ liệu cho các tình huống thực tế
[ ] Tôi hiểu sự khác biệt NUMERIC vs REAL (và tại sao dùng NUMERIC cho tiền)
[ ] Tôi hiểu sự khác biệt VARCHAR(n) vs TEXT
[ ] Tôi viết được CREATE TABLE với ít nhất PRIMARY KEY và NOT NULL
[ ] Tôi nhập được dữ liệu bằng INSERT INTO (1 hàng và nhiều hàng)
[ ] Tôi hiểu NULL là gì và dùng IS NULL / IS NOT NULL đúng cách
[ ] Tôi biết dùng COALESCE để xử lý NULL
[ ] Tôi thêm/xóa/đổi tên cột được bằng ALTER TABLE
[ ] Tôi biết sự khác biệt giữa DROP TABLE và TRUNCATE
[ ] (Nâng cao) Tôi biết thêm constraint sau khi bảng đã tạo
```

**Tick được 8/10 → Sẵn sàng cho Tuần 4!** 🎉
