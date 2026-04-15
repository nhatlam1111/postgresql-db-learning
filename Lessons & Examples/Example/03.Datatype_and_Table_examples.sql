-- ============================================================
-- TUẦN 3: Tạo Bảng & Nhập Dữ Liệu
-- ============================================================
-- File này chạy tuần tự từ trên xuống dưới.
-- Mỗi phần độc lập — đọc comment trước khi chạy.
--
-- Đảm bảo đang kết nối vào database: hoc_sql
-- Kiểm tra: SELECT current_database();  → phải ra 'hoc_sql'
-- ============================================================


-- ============================================================
-- PHẦN 1: Dọn Dẹp (nếu chạy lại từ đầu)
-- ============================================================
-- Chạy phần này nếu muốn xóa hết và bắt đầu lại từ đầu.
-- Bỏ comment từng dòng DROP khi cần.
-- ============================================================

-- DROP TABLE IF EXISTS chi_tiet_don_hang;
-- DROP TABLE IF EXISTS don_hang;
-- DROP TABLE IF EXISTS san_pham;
-- DROP TABLE IF EXISTS khach_hang;
-- DROP TABLE IF EXISTS nhan_vien;


-- ============================================================
-- PHẦN 2: Tạo Bảng — CREATE TABLE
-- ============================================================

-- ------------------------------------------------------------
-- 2.1 Bảng nhan_vien
-- Giống tạo sheet "Nhân viên" trong Excel, khai báo từng cột
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS nhan_vien (
    -- SERIAL: tự tăng 1, 2, 3... — không cần nhập tay
    id           SERIAL          PRIMARY KEY,

    -- VARCHAR(100) NOT NULL: tên bắt buộc, tối đa 100 ký tự
    ho_ten       VARCHAR(100)    NOT NULL,

    -- VARCHAR(50): phòng ban có thể để trống
    phong_ban    VARCHAR(50),

    -- NUMERIC(12,2): lương tối đa 9,999,999,999.99 — dùng NUMERIC vì tiền tệ
    -- CHECK đảm bảo lương không âm
    luong        NUMERIC(12, 2)  CHECK (luong >= 0),

    -- DATE: chỉ lưu ngày, không lưu giờ
    ngay_sinh    DATE,

    -- VARCHAR(150) UNIQUE: email không trùng, có thể NULL (chưa có email)
    email        VARCHAR(150)    UNIQUE,

    -- DEFAULT CURRENT_DATE: tự điền ngày hôm nay nếu không nhập
    ngay_vao     DATE            DEFAULT CURRENT_DATE,

    -- DEFAULT TRUE: mặc định đang làm việc
    dang_lam     BOOLEAN         DEFAULT TRUE
);

-- Xem lại cấu trúc vừa tạo
-- (Trong DBeaver: double-click vào bảng → tab Columns)
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'nhan_vien'
ORDER BY ordinal_position;


-- ------------------------------------------------------------
-- 2.2 Bảng san_pham
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS san_pham (
    id            SERIAL          PRIMARY KEY,
    ten_sp        VARCHAR(200)    NOT NULL,
    danh_muc      VARCHAR(100),
    gia           NUMERIC(12, 2)  NOT NULL CHECK (gia > 0),
    so_luong_ton  INTEGER         NOT NULL DEFAULT 0 CHECK (so_luong_ton >= 0),
    mo_ta         TEXT,                          -- Không giới hạn độ dài
    ngay_nhap     DATE            DEFAULT CURRENT_DATE,
    con_ban       BOOLEAN         DEFAULT TRUE
);


-- ------------------------------------------------------------
-- 2.3 Bảng khach_hang
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS khach_hang (
    id             SERIAL          PRIMARY KEY,
    ho_ten         VARCHAR(100)    NOT NULL,
    so_dien_thoai  VARCHAR(20)     UNIQUE,       -- Unique nhưng có thể NULL
    email          VARCHAR(150)    UNIQUE,
    dia_chi        TEXT,
    ngay_dang_ky   DATE            DEFAULT CURRENT_DATE,
    la_vip         BOOLEAN         DEFAULT FALSE
);


-- ------------------------------------------------------------
-- 2.4 Bảng don_hang (preview — FOREIGN KEY học ở Tuần 7)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS don_hang (
    id             SERIAL          PRIMARY KEY,
    khach_hang_id  INTEGER         NOT NULL,     -- Liên kết đến khach_hang.id
    ngay_dat       TIMESTAMP       DEFAULT NOW(),
    tong_tien      NUMERIC(15, 2)  CHECK (tong_tien >= 0),
    trang_thai     VARCHAR(20)     DEFAULT 'Chờ xác nhận'
                                   CHECK (trang_thai IN (
                                       'Chờ xác nhận', 'Đã xác nhận',
                                       'Đang giao', 'Đã giao', 'Đã hủy'
                                   ))
);


-- ------------------------------------------------------------
-- 2.5 Bảng chi_tiet_don_hang (preview — học ở Tuần 7)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chi_tiet_don_hang (
    id           SERIAL          PRIMARY KEY,
    don_hang_id  INTEGER         NOT NULL,
    san_pham_id  INTEGER         NOT NULL,
    so_luong     INTEGER         NOT NULL CHECK (so_luong > 0),
    don_gia      NUMERIC(12, 2)  NOT NULL CHECK (don_gia > 0)
);


-- ============================================================
-- PHẦN 3: Nhập Dữ Liệu — INSERT INTO
-- ============================================================

-- ------------------------------------------------------------
-- 3.1 Nhập nhân viên (6 người quen thuộc từ Tuần 1)
-- ------------------------------------------------------------
INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_sinh, email)
VALUES
    ('Trần Thị Mai',   'Kế toán',    15000000, '1995-03-20', 'mai.tran@cty.com'),
    ('Nguyễn Văn An',  'Kinh doanh', 20000000, '1990-07-15', 'an.nguyen@cty.com'),
    ('Lê Thị Bình',    'Nhân sự',    18000000, '1992-11-03', 'binh.le@cty.com'),
    ('Phạm Minh Châu', 'IT',         25000000, '1988-01-25', 'chau.pham@cty.com'),
    ('Hoàng Thị Dung', 'Kế toán',    13000000, '1996-09-10', NULL),   -- Chưa có email
    ('Võ Văn Em',      'Kinh doanh', 22000000, '1993-05-30', 'em.vo@cty.com');

-- Kiểm tra
SELECT * FROM nhan_vien;


-- ------------------------------------------------------------
-- 3.2 Nhập sản phẩm (12 sản phẩm)
-- ------------------------------------------------------------
INSERT INTO san_pham (ten_sp, danh_muc, gia, so_luong_ton, mo_ta)
VALUES
    ('Laptop Dell Inspiron 15',   'Điện tử',       15990000, 25,
        'Laptop văn phòng, Intel Core i5, RAM 8GB, SSD 256GB'),
    ('Chuột Logitech M170',       'Điện tử',          195000, 150,
        'Chuột không dây, pin AA, kết nối USB receiver'),
    ('Bàn phím cơ Keychron K2',   'Điện tử',         1890000,  40,
        'Bàn phím cơ Bluetooth/USB, switch Brown'),
    ('Màn hình LG 24"',           'Điện tử',         4290000,  15,
        'Full HD 1920x1080, IPS, 75Hz, cổng HDMI+VGA'),
    ('Tai nghe Sony WH-1000XM5',  'Điện tử',         8490000,  20,
        'Chống ồn chủ động ANC, Bluetooth 5.2, 30 giờ pin'),
    ('Áo thun nam cổ tròn',       'Thời trang',         189000, 200,
        'Chất liệu cotton 100%, nhiều màu sắc'),
    ('Quần jean nữ slim fit',     'Thời trang',         459000,  80, NULL),
    ('Giày thể thao Adidas',      'Thời trang',        1290000,  60, NULL),
    ('Bút bi Thiên Long TL-027',  'Văn phòng phẩm',      15000, 500,
        'Mực xanh, ngòi 0.5mm, hộp 20 cái'),
    ('Sổ tay A5 kẻ ngang',        'Văn phòng phẩm',      35000, 300, NULL),
    ('Ghế văn phòng lưới',        'Nội thất',         2490000,  10,
        'Ghế lưới thoáng mát, có tựa đầu, điều chỉnh độ cao'),
    ('Đèn bàn LED chống cận',     'Nội thất',           390000,  45,
        'Công suất 12W, điều chỉnh 3 màu ánh sáng, cổng USB sạc');

-- Kiểm tra
SELECT id, ten_sp, danh_muc, gia, so_luong_ton FROM san_pham;


-- ------------------------------------------------------------
-- 3.3 Nhập khách hàng (8 khách hàng)
-- ------------------------------------------------------------
INSERT INTO khach_hang (ho_ten, so_dien_thoai, email, dia_chi, la_vip)
VALUES
    ('Nguyễn Thị Lan',    '0901234567', 'lan.nguyen@gmail.com',
        '12 Lê Lợi, Q1, TP.HCM',           TRUE),
    ('Trần Văn Bình',     '0912345678', 'binh.tran@yahoo.com',
        '45 Hoàng Diệu, Q4, TP.HCM',        FALSE),
    ('Lê Thị Cúc',        '0923456789', NULL,
        '78 Nguyễn Huệ, Q1, TP.HCM',        TRUE),
    ('Phạm Đức Dũng',     NULL,         'dung.pham@gmail.com',
        '23 Trần Phú, Hà Đông, Hà Nội',     FALSE),
    ('Hoàng Minh Em',     '0934567890', 'em.hoang@outlook.com',
        '56 Lý Thường Kiệt, Huế',           FALSE),
    ('Vũ Thị Phương',     '0945678901', 'phuong.vu@gmail.com',
        '9 Bạch Đằng, Đà Nẵng',             TRUE),
    ('Đặng Văn Quang',    '0956789012', NULL,
        '34 Ngô Quyền, Hải Phòng',          FALSE),
    ('Bùi Thị Hoa',       NULL,         NULL,
        '67 Lê Duẩn, Cần Thơ',              FALSE);

-- Kiểm tra
SELECT * FROM khach_hang;


-- ------------------------------------------------------------
-- 3.4 Nhập đơn hàng mẫu
-- ------------------------------------------------------------
INSERT INTO don_hang (khach_hang_id, ngay_dat, tong_tien, trang_thai)
VALUES
    (1, '2026-01-15 10:30:00', 16185000, 'Đã giao'),
    (2, '2026-02-20 14:00:00',   459000, 'Đã giao'),
    (1, '2026-03-05 09:15:00',  8685000, 'Đang giao'),
    (3, '2026-03-10 16:45:00',  2505000, 'Đã xác nhận'),
    (5, '2026-04-01 11:00:00',   390000, 'Chờ xác nhận');

INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia)
VALUES
    (1, 1, 1, 15990000),   -- Đơn 1: 1 Laptop Dell
    (1, 2, 1,   195000),   -- Đơn 1: 1 Chuột Logitech
    (2, 7, 1,   459000),   -- Đơn 2: 1 Quần jean
    (3, 5, 1,  8490000),   -- Đơn 3: 1 Tai nghe Sony
    (3, 9, 1,   195000),   -- Đơn 3: 1 Chuột (nhầm, thực ra bút bi)
    (4, 11, 1, 2490000),   -- Đơn 4: 1 Ghế văn phòng
    (4, 9,  1,   15000),   -- Đơn 4: 1 Bút bi
    (5, 13, 1,  390000);   -- Đơn 5: 1 Đèn bàn


-- ============================================================
-- PHẦN 4: Ví Dụ Về NULL
-- ============================================================

-- ------------------------------------------------------------
-- 4.1 Tìm hàng có NULL và không có NULL
-- ------------------------------------------------------------

-- Nhân viên chưa có email (IS NULL)
-- Trong Excel: Filter → ô trống
SELECT ho_ten, phong_ban
FROM nhan_vien
WHERE email IS NULL;
-- Kết quả: Hoàng Thị Dung

-- Nhân viên đã có email (IS NOT NULL)
SELECT ho_ten, email
FROM nhan_vien
WHERE email IS NOT NULL;
-- Kết quả: 5 nhân viên còn lại

-- Khách hàng thiếu cả SĐT lẫn email (không có cách nào liên lạc)
SELECT ho_ten, dia_chi
FROM khach_hang
WHERE so_dien_thoai IS NULL
  AND email IS NULL;


-- ------------------------------------------------------------
-- 4.2 COALESCE — thay NULL bằng giá trị mặc định
-- Trong Excel: =IFERROR(A1, "Chưa có") hoặc =IF(ISBLANK(A1), "Chưa có", A1)
-- ------------------------------------------------------------

-- Hiển thị email, thay NULL bằng "Chưa có email"
SELECT
    ho_ten,
    COALESCE(email, 'Chưa có email') AS email_hien_thi
FROM nhan_vien;

-- Hiển thị thông tin liên lạc khách hàng (ưu tiên SĐT, không có thì dùng email)
SELECT
    ho_ten,
    COALESCE(so_dien_thoai, email, 'Không có thông tin') AS lien_lac
FROM khach_hang;

-- Tính lương với giá trị mặc định 0 nếu NULL
-- (đảm bảo phép tính không ra NULL)
SELECT
    ho_ten,
    COALESCE(luong, 0) AS luong_thuc_te,
    COALESCE(luong, 0) * 12 AS thu_nhap_nam
FROM nhan_vien;


-- ------------------------------------------------------------
-- 4.3 NULLIF — chuyển giá trị thành NULL theo điều kiện
-- ------------------------------------------------------------

-- Tránh lỗi chia cho 0
-- Nếu so_luong_ton = 0, NULLIF trả NULL → phép chia không bị lỗi
SELECT
    ten_sp,
    gia,
    so_luong_ton,
    gia / NULLIF(so_luong_ton, 0) AS gia_tren_mot_don_vi
FROM san_pham;

-- Chuẩn hóa: coi chuỗi rỗng '' như NULL
-- (hữu ích khi import dữ liệu từ CSV)
SELECT
    NULLIF('', '')      AS chuoi_rong_thanh_null,  -- NULL
    NULLIF('abc', '')   AS chuoi_that,              -- 'abc'
    NULLIF(5, 5)        AS so_bang_nhau,            -- NULL
    NULLIF(5, 0)        AS so_khac_nhau;            -- 5


-- ------------------------------------------------------------
-- 4.4 Ảnh hưởng của NULL đến hàm tổng hợp
-- ------------------------------------------------------------
SELECT
    COUNT(*)            AS tong_nhan_vien,      -- Đếm tất cả hàng: 6
    COUNT(email)        AS co_email,            -- Bỏ NULL: 5
    COUNT(luong)        AS co_luong,            -- 6 (tất cả có lương)
    AVG(luong)          AS luong_tb,            -- Tính trên 6 người
    AVG(COALESCE(luong, 0)) AS luong_tb_ke_null -- Như trên (vì ko có NULL)
FROM nhan_vien;


-- ============================================================
-- PHẦN 5: Ví Dụ CAST và TO_CHAR
-- ============================================================

-- ------------------------------------------------------------
-- 5.1 Hiển thị ngày sinh dạng Việt Nam DD/MM/YYYY
-- Trong Excel: =TEXT(A1, "DD/MM/YYYY")
-- ------------------------------------------------------------
SELECT
    ho_ten,
    ngay_sinh,
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY')       AS ngay_sinh_vn,
    EXTRACT(YEAR FROM AGE(ngay_sinh))::INTEGER AS tuoi
FROM nhan_vien
ORDER BY ngay_sinh;


-- ------------------------------------------------------------
-- 5.2 Format lương có dấu phẩy và đơn vị
-- Trong Excel: =TEXT(A1, "#,###") & " VNĐ"
-- ------------------------------------------------------------
SELECT
    ho_ten,
    phong_ban,
    luong                                           AS luong_goc,
    TO_CHAR(luong, 'FM999,999,999') || ' VNĐ'      AS luong_format
FROM nhan_vien
ORDER BY luong DESC;


-- ------------------------------------------------------------
-- 5.3 Cast giữa các kiểu
-- ------------------------------------------------------------

-- Số → Text
SELECT
    42::TEXT                    AS so_thanh_text,
    3.14::TEXT                  AS thap_phan_thanh_text,
    TRUE::TEXT                  AS bool_thanh_text;

-- Text → Số (chỉ khi text là số hợp lệ)
SELECT
    '123'::INTEGER              AS text_thanh_int,
    '99.50'::NUMERIC            AS text_thanh_numeric;

-- Ngày → Text và ngược lại
SELECT
    current_date::TEXT                          AS ngay_thanh_text,
    TO_DATE('20/03/1995', 'DD/MM/YYYY')         AS text_thanh_date,
    TO_CHAR(current_date, 'FMDay DD/MM/YYYY')   AS ngay_day_du;

-- Cắt phần thập phân (KHÔNG làm tròn)
SELECT
    9.9::INTEGER    AS cat_thap_phan,   -- 9
    9.1::INTEGER    AS cat_thap_phan2,  -- 9
    ROUND(9.9)::INTEGER AS lam_tron;    -- 10


-- ============================================================
-- PHẦN 6: Ví Dụ ALTER TABLE
-- ============================================================

-- ------------------------------------------------------------
-- 6.1 Thêm cột mới vào nhan_vien
-- ------------------------------------------------------------

-- Thêm số điện thoại
ALTER TABLE nhan_vien ADD COLUMN so_dien_thoai VARCHAR(20);

-- Thêm cấp bậc với giá trị mặc định
ALTER TABLE nhan_vien ADD COLUMN cap_bac VARCHAR(30) DEFAULT 'Nhân viên';

-- Kiểm tra cấu trúc sau khi thêm
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'nhan_vien'
ORDER BY ordinal_position;


-- ------------------------------------------------------------
-- 6.2 Cập nhật dữ liệu cho cột vừa thêm
-- (Tuần 9 sẽ học UPDATE chi tiết — đây chỉ là ví dụ)
-- ------------------------------------------------------------
UPDATE nhan_vien SET so_dien_thoai = '0901111111' WHERE id = 1;
UPDATE nhan_vien SET so_dien_thoai = '0912222222' WHERE id = 2;
UPDATE nhan_vien SET cap_bac = 'Trưởng phòng'   WHERE id = 4;

SELECT id, ho_ten, so_dien_thoai, cap_bac FROM nhan_vien;


-- ------------------------------------------------------------
-- 6.3 Đổi tên cột và thay đổi constraint
-- ------------------------------------------------------------

-- Thêm CHECK constraint cho cột mới
ALTER TABLE nhan_vien
    ADD CONSTRAINT kiem_tra_cap_bac
    CHECK (cap_bac IN ('Nhân viên', 'Tổ trưởng', 'Trưởng phòng', 'Giám đốc'));

-- Thử vi phạm constraint (sẽ báo lỗi):
-- UPDATE nhan_vien SET cap_bac = 'Boss' WHERE id = 1;
-- ERROR: new row violates check constraint "kiem_tra_cap_bac"

-- Xóa constraint nếu không cần nữa
ALTER TABLE nhan_vien DROP CONSTRAINT kiem_tra_cap_bac;


-- ------------------------------------------------------------
-- 6.4 Mở rộng độ dài VARCHAR
-- ------------------------------------------------------------
-- Cột ten_sp hiện là VARCHAR(200), mở rộng lên VARCHAR(300)
ALTER TABLE san_pham ALTER COLUMN ten_sp TYPE VARCHAR(300);


-- ============================================================
-- PHẦN 7: Xem Thông Tin Cấu Trúc Database
-- ============================================================

-- ------------------------------------------------------------
-- 7.1 Danh sách tất cả bảng trong hoc_sql
-- ------------------------------------------------------------
SELECT table_name AS ten_bang
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;


-- ------------------------------------------------------------
-- 7.2 Cấu trúc chi tiết của bảng san_pham
-- ------------------------------------------------------------
SELECT
    column_name                                 AS ten_cot,
    data_type                                   AS kieu_du_lieu,
    COALESCE(character_maximum_length::TEXT, '—') AS do_dai_toi_da,
    is_nullable                                 AS cho_phep_null,
    COALESCE(column_default, '—')               AS gia_tri_mac_dinh
FROM information_schema.columns
WHERE table_name   = 'san_pham'
  AND table_schema = 'public'
ORDER BY ordinal_position;


-- ------------------------------------------------------------
-- 7.3 Tóm tắt số cột và số dòng của mỗi bảng
-- ------------------------------------------------------------
SELECT
    t.table_name AS ten_bang,
    COUNT(c.column_name) AS so_cot
FROM information_schema.tables t
JOIN information_schema.columns c
    ON t.table_name = c.table_name
WHERE t.table_schema = 'public'
  AND t.table_type   = 'BASE TABLE'
GROUP BY t.table_name
ORDER BY t.table_name;


-- ============================================================
-- PHẦN 8: TRUNCATE và DROP (Demo Cẩn Thận)
-- ============================================================

-- ------------------------------------------------------------
-- 8.1 Tạo bảng thử nghiệm rồi xóa
-- ------------------------------------------------------------

CREATE TABLE thu_nghiem (
    id    SERIAL PRIMARY KEY,
    ten   VARCHAR(50),
    so    INTEGER DEFAULT 0
);

INSERT INTO thu_nghiem (ten, so) VALUES ('A', 1), ('B', 2), ('C', 3);
SELECT * FROM thu_nghiem;

-- TRUNCATE: xóa dữ liệu, giữ cấu trúc
-- SERIAL counter reset về 1
TRUNCATE TABLE thu_nghiem;
SELECT * FROM thu_nghiem;  -- Rỗng, nhưng bảng vẫn còn

INSERT INTO thu_nghiem (ten) VALUES ('X');
SELECT * FROM thu_nghiem;  -- id bắt đầu lại từ 1

-- DROP TABLE: xóa cả bảng lẫn dữ liệu
DROP TABLE thu_nghiem;
-- SELECT * FROM thu_nghiem;  -- Lỗi: bảng không tồn tại


-- ============================================================
-- TỔNG KẾT TUẦN 3
-- ============================================================
-- Những lệnh đã học:
--
-- CREATE TABLE ... (cot kieu [constraint])  → Tạo bảng
-- INSERT INTO ... VALUES (...)              → Thêm dữ liệu
-- IS NULL / IS NOT NULL                    → Kiểm tra NULL
-- COALESCE(a, b)                           → Giá trị thay thế khi NULL
-- NULLIF(a, b)                             → Trả NULL nếu a = b
-- ALTER TABLE ... ADD COLUMN ...           → Thêm cột
-- ALTER TABLE ... DROP COLUMN ...          → Xóa cột
-- ALTER TABLE ... RENAME COLUMN ...        → Đổi tên cột
-- ALTER TABLE ... ALTER COLUMN ... TYPE    → Đổi kiểu dữ liệu
-- DROP TABLE IF EXISTS ...                 → Xóa bảng an toàn
-- TRUNCATE TABLE ...                       → Xóa dữ liệu, giữ cấu trúc
-- TO_CHAR(value, format)                   → Format số/ngày ra chuỗi
-- TO_DATE(text, format)                    → Chuyển chuỗi thành ngày
-- value::type / CAST(value AS type)        → Chuyển kiểu dữ liệu
--
-- Tuần 4 tiếp theo: SELECT nâng cao (AS alias, DISTINCT, tính toán)
-- ============================================================
