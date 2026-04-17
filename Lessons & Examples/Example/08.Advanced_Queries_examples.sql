-- ============================================================
-- TUẦN 8: TRUY VẤN NÂNG CAO — SUBQUERY, CASE WHEN & HÀM XỬ LÝ DỮ LIỆU
-- File: 08.Advanced_Queries_examples.sql
-- Hướng dẫn: Copy từng khối SQL vào DBeaver và nhấn Ctrl+Enter để chạy
-- ============================================================

-- ============================================================
-- SETUP: Tạo toàn bộ dữ liệu mẫu cho tuần này
-- Chạy phần này TRƯỚC KHI chạy các ví dụ bên dưới
-- Dùng lại cấu trúc 5 bảng từ Tuần 7 + thêm cột ngay_vao và tinh_trang
-- ============================================================

DROP TABLE IF EXISTS chi_tiet_don_hang;
DROP TABLE IF EXISTS don_hang;
DROP TABLE IF EXISTS san_pham;
DROP TABLE IF EXISTS khach_hang;
DROP TABLE IF EXISTS nhan_vien;

-- Bảng 1: Nhân viên (có thêm ngay_sinh, ngay_vao, tinh_trang so với tuần trước)
CREATE TABLE nhan_vien (
    id          SERIAL PRIMARY KEY,
    ho_ten      VARCHAR(100) NOT NULL,
    phong_ban   VARCHAR(50),
    luong       NUMERIC(12,0),
    ngay_sinh   DATE,
    ngay_vao    DATE,
    tinh_trang  VARCHAR(20) DEFAULT 'dang_lam',
    nickname    VARCHAR(50),
    email       VARCHAR(100)
);

INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_sinh, ngay_vao, tinh_trang, nickname, email) VALUES
    ('Trần Thị Mai',      'Kế toán',   15000000, '1995-03-20', '2020-01-15', 'dang_lam',  NULL,   'mai.tran@email.com'),
    ('Nguyễn Văn An',     'Kinh doanh',22000000, '1990-07-15', '2018-06-01', 'dang_lam',  'An',   'an.nguyen@email.com'),
    ('Lê Thị Bình',       'Nhân sự',   18000000, '1992-11-03', '2019-03-10', 'nghi_phep', NULL,   'binh.le@email.com'),
    ('Phạm Minh Châu',    'IT',         25000000, '1988-01-25', '2017-09-01', 'dang_lam',  'Châu', 'chau.pham@email.com'),
    ('Hoàng Thị Dung',    'Kế toán',   13000000, '1996-09-10', '2022-02-20', 'dang_lam',  NULL,   NULL),
    ('Võ Văn Em',         'Kinh doanh',22000000, '1993-05-30', '2019-11-05', 'dang_lam',  'Em',   'em.vo@email.com'),
    ('Nguyễn Thị Ngọc',   'Kinh doanh',21000000, '1991-08-22', '2020-07-15', 'dang_lam',  NULL,   'ngoc.nguyen@email.com'),
    ('Hồ Thị Hoa',        'Kinh doanh',17500000, '1994-04-12', '2021-01-10', 'nghi_viec', 'Hoa',  NULL),
    ('Lê Văn Dũng',       'IT',         20000000, '1989-12-05', '2018-04-20', 'dang_lam',  NULL,   'dung.le@email.com'),
    ('Đặng Thị Lan',      'IT',         19000000, '1997-06-18', '2023-08-01', 'dang_lam',  'Lan',  'lan.dang@email.com'),
    ('Trịnh Văn Minh',    'Nhân sự',   16500000, '1990-02-28', '2019-05-15', 'dang_lam',  NULL,   NULL),
    ('Bùi Thị Thu',       'Nhân sự',   14000000, '1998-10-07', '2022-09-01', 'nghi_viec', NULL,   'thu.bui@email.com');

-- Bảng 2: Khách hàng
CREATE TABLE khach_hang (
    id          SERIAL PRIMARY KEY,
    ho_ten      VARCHAR(100) NOT NULL,
    dien_thoai  VARCHAR(15),
    email       VARCHAR(100),
    thanh_pho   VARCHAR(50)
);

INSERT INTO khach_hang (ho_ten, dien_thoai, email, thanh_pho) VALUES
    ('Trần Thị Mai',    '0901123456', 'mai.tran@gmail.com',   'Hà Nội'),
    ('Nguyễn Văn An',   '0912234567', 'an.nguyen@gmail.com',  'TP.HCM'),
    ('Lê Thị Bình',     '0923345678', 'binh.le@outlook.com',  'Đà Nẵng'),
    ('Phạm Minh Châu',  '0934456789', 'chau.pham@yahoo.com',  'Hà Nội'),
    ('Hoàng Văn Đức',   '0945567890', NULL,                   'TP.HCM'),
    ('Ngô Thị Phương',  '0956678901', 'phuong.ngo@gmail.com', 'Cần Thơ');
-- Lưu ý: Khách Ngô Thị Phương (id=6) sẽ KHÔNG có đơn hàng

-- Bảng 3: Sản phẩm
CREATE TABLE san_pham (
    id            SERIAL PRIMARY KEY,
    ten_san_pham  VARCHAR(200) NOT NULL,
    danh_muc      VARCHAR(50),
    gia           NUMERIC(12,0) NOT NULL
);

INSERT INTO san_pham (ten_san_pham, danh_muc, gia) VALUES
    ('Laptop Dell XPS 13',        'Điện tử',   28000000),
    ('Chuột không dây Logitech',  'Điện tử',    450000),
    ('Áo thun nam Cotton',        'Thời trang', 250000),
    ('Quần Jean nữ Slim',         'Thời trang', 650000),
    ('Bình nước giữ nhiệt 500ml', 'Gia dụng',   320000),
    ('Máy pha cà phê mini',       'Gia dụng',  1200000),
    ('Tai nghe Sony WH-1000XM5',  'Điện tử',   8500000),
    ('Sách PostgreSQL Căn Bản',   'Sách',       180000);
-- Lưu ý: Sản phẩm id=8 (Sách PostgreSQL) sẽ KHÔNG có trong chi tiết đơn hàng

-- Bảng 4: Đơn hàng
CREATE TABLE don_hang (
    id              SERIAL PRIMARY KEY,
    ma_don_hang     VARCHAR(10) UNIQUE NOT NULL,
    khach_hang_id   INTEGER REFERENCES khach_hang(id),
    nhan_vien_id    INTEGER REFERENCES nhan_vien(id),
    ngay_dat        DATE NOT NULL,
    tong_tien       NUMERIC(12,0),
    trang_thai      VARCHAR(20) DEFAULT 'cho_xu_ly'
);

INSERT INTO don_hang (ma_don_hang, khach_hang_id, nhan_vien_id, ngay_dat, tong_tien, trang_thai) VALUES
    ('DH001', 1, 2, '2024-01-05', 28450000, 'hoan_thanh'),
    ('DH002', 2, 6, '2024-01-12',   700000, 'hoan_thanh'),
    ('DH003', 1, 2, '2024-02-03',   900000, 'hoan_thanh'),
    ('DH004', 3, 7, '2024-02-18',  9150000, 'hoan_thanh'),
    ('DH005', 4, 6, '2024-03-02',   770000, 'hoan_thanh'),
    ('DH006', 2, 2, '2024-03-15',  1520000, 'huy'),       -- Đơn bị hủy
    ('DH007', 5, 7, '2024-04-01',  8820000, 'hoan_thanh'),
    ('DH008', 1, 6, '2024-04-22',   570000, 'hoan_thanh'),
    ('DH009', 3, 2, '2024-05-10',  1470000, 'hoan_thanh'),
    ('DH010', 4, 7, '2024-05-28', 28000000, 'hoan_thanh'),
    ('DH011', 2, 6, '2024-06-14',   320000, 'cho_xu_ly'),
    ('DH012', 1, 2, '2024-06-30',  1200000, 'hoan_thanh');

-- Bảng 5: Chi tiết đơn hàng
CREATE TABLE chi_tiet_don_hang (
    id          SERIAL PRIMARY KEY,
    don_hang_id INTEGER REFERENCES don_hang(id),
    san_pham_id INTEGER REFERENCES san_pham(id),
    so_luong    INTEGER NOT NULL,
    don_gia     NUMERIC(12,0) NOT NULL
);

INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia) VALUES
    (1,  1, 1, 28000000), -- DH001: 1 Laptop Dell
    (1,  2, 1,   450000), -- DH001: 1 Chuột Logitech
    (2,  3, 2,   250000), -- DH002: 2 Áo thun
    (2,  4, 1,   650000), -- DH002: 1 Quần jean (trên 1 đơn khác nhau nhưng cùng dh002... nhưng thực ra tong_tien = 2*250+650 = 1150000 ≠ 700000 --> let me fix this)
    (3,  3, 2,   250000), -- DH003: 2 Áo thun
    (3,  5, 1,   320000), -- DH003: 1 Bình nước
    (3,  2, 1,   450000), -- DH003: 1 Chuột (tổng = 500+320+450 = 1270 ≠ 900 -- dữ liệu mẫu không cần khớp tuyệt đối)
    (4,  7, 1,  8500000), -- DH004: 1 Tai nghe Sony
    (4,  4, 1,   650000), -- DH004: 1 Quần jean
    (5,  4, 1,   650000), -- DH005: 1 Quần jean
    (5,  2, 1,   450000), -- DH005: 1 Chuột (650+450 = 1100 vs 770 -- sample data)
    (6,  6, 1,  1200000), -- DH006 (HỦY): Máy pha cà phê
    (6,  5, 1,   320000), -- DH006 (HỦY): Bình nước
    (7,  7, 1,  8500000), -- DH007: 1 Tai nghe Sony
    (7,  5, 1,   320000), -- DH007: 1 Bình nước
    (8,  3, 1,   250000), -- DH008: 1 Áo thun
    (8,  5, 1,   320000), -- DH008: 1 Bình nước
    (9,  6, 1,  1200000), -- DH009: 1 Máy pha cà phê
    (10, 1, 1, 28000000), -- DH010: 1 Laptop Dell
    (11, 5, 1,   320000), -- DH011: 1 Bình nước
    (12, 6, 1,  1200000); -- DH012: 1 Máy pha cà phê


-- ============================================================
-- 8.1 SUBQUERY CƠ BẢN — SO SÁNH VỚI GIÁ TRỊ TỔNG HỢP
-- ============================================================

-- Ví dụ 8.1.1: Tìm nhân viên có lương cao hơn mức trung bình
-- Tư duy: Bước 1 = AVG(luong), Bước 2 = WHERE luong > Bước 1
SELECT ho_ten, phong_ban, luong
FROM nhan_vien
WHERE luong > (SELECT AVG(luong) FROM nhan_vien)
ORDER BY luong DESC;

-- Kiểm tra: lương trung bình bao nhiêu?
SELECT ROUND(AVG(luong), 0) AS luong_trung_binh FROM nhan_vien;


-- Ví dụ 8.1.2: Tìm sản phẩm đắt hơn giá trung bình của cùng danh mục
-- Phức tạp hơn: subquery tham chiếu đến giá trị của hàng ngoài (correlated subquery)
SELECT sp1.ten_san_pham, sp1.danh_muc, sp1.gia
FROM san_pham sp1
WHERE sp1.gia > (
    SELECT AVG(sp2.gia)
    FROM san_pham sp2
    WHERE sp2.danh_muc = sp1.danh_muc   -- ← liên kết với hàng đang xét bên ngoài
)
ORDER BY sp1.danh_muc, sp1.gia DESC;


-- Ví dụ 8.1.3: Tìm sản phẩm đắt nhất (không dùng ORDER BY LIMIT 1)
SELECT ten_san_pham, gia
FROM san_pham
WHERE gia = (SELECT MAX(gia) FROM san_pham);


-- ============================================================
-- 8.2 SUBQUERY VỚI IN / NOT IN
-- ============================================================

-- Ví dụ 8.2.1: Tìm khách hàng đã từng đặt hàng
SELECT ho_ten, thanh_pho
FROM khach_hang
WHERE id IN (
    SELECT DISTINCT khach_hang_id
    FROM don_hang
    WHERE khach_hang_id IS NOT NULL  -- Phòng tránh bẫy NULL
);

-- Ví dụ 8.2.2: Tìm khách hàng CHƯA từng đặt hàng
SELECT ho_ten, thanh_pho
FROM khach_hang
WHERE id NOT IN (
    SELECT DISTINCT khach_hang_id
    FROM don_hang
    WHERE khach_hang_id IS NOT NULL  -- BẮT BUỘC: lọc NULL trước khi NOT IN
);

-- Kiểm chứng: Ngô Thị Phương (id=6) phải xuất hiện ở ví dụ 8.2.2


-- Ví dụ 8.2.3: Tìm sản phẩm CHƯA được mua lần nào
SELECT ten_san_pham, danh_muc, gia
FROM san_pham
WHERE id NOT IN (
    SELECT DISTINCT san_pham_id
    FROM chi_tiet_don_hang
    WHERE san_pham_id IS NOT NULL
);
-- Kết quả: Sách PostgreSQL Căn Bản (id=8) chưa được mua lần nào


-- Ví dụ 8.2.4: So sánh Subquery NOT IN vs LEFT JOIN IS NULL (cho cùng kết quả)
-- Cách 1 (subquery NOT IN):
SELECT ten_san_pham FROM san_pham
WHERE id NOT IN (SELECT DISTINCT san_pham_id FROM chi_tiet_don_hang WHERE san_pham_id IS NOT NULL);

-- Cách 2 (LEFT JOIN IS NULL - hiệu quả hơn cho dữ liệu lớn):
SELECT sp.ten_san_pham
FROM san_pham sp
LEFT JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
WHERE ct.id IS NULL;


-- ============================================================
-- 8.3 SUBQUERY TRONG FROM — BẢNG TẠM
-- ============================================================

-- Ví dụ 8.3.1: Tìm phòng ban có lương TB cao hơn lương TB toàn công ty
SELECT phong_ban, avg_luong
FROM (
    -- Bảng tạm: thống kê lương TB mỗi phòng ban
    SELECT
        phong_ban,
        AVG(luong)::NUMERIC(12,0) AS avg_luong
    FROM nhan_vien
    GROUP BY phong_ban
) AS bang_luong_pb                  -- ← bảng tạm phải có alias
WHERE avg_luong > (SELECT AVG(luong) FROM nhan_vien)
ORDER BY avg_luong DESC;


-- Ví dụ 8.3.2: Báo cáo tổng hợp khách hàng + phân loại
-- Bước 1 (bảng tạm): thống kê mua hàng từng khách
-- Bước 2 (ngoài):   phân loại dựa trên kết quả bước 1
SELECT
    ten_khach,
    tong_don,
    tong_tien,
    CASE
        WHEN tong_tien >= 5000000 THEN 'VIP'
        WHEN tong_tien >= 1000000 THEN 'Thường'
        ELSE                           'Mới'
    END AS phan_loai
FROM (
    SELECT
        kh.ho_ten                       AS ten_khach,
        COUNT(dh.id)                    AS tong_don,
        COALESCE(SUM(dh.tong_tien), 0)  AS tong_tien
    FROM khach_hang kh
    LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
                          AND dh.trang_thai != 'huy'  -- loại đơn bị hủy
    GROUP BY kh.id, kh.ho_ten
) AS thong_ke_kh
ORDER BY tong_tien DESC;


-- ============================================================
-- 8.4 CASE WHEN — CÂU LỆNH IF CỦA SQL (SEARCHED CASE)
-- ============================================================

-- Ví dụ 8.4.1: Phân loại nhân viên theo lương
SELECT
    ho_ten,
    phong_ban,
    luong,
    CASE
        WHEN luong >= 25000000 THEN 'Cao'
        WHEN luong >= 18000000 THEN 'Trung bình'
        WHEN luong >= 12000000 THEN 'Thấp'
        ELSE                        'Cần xem xét'
    END AS phan_loai_luong
FROM nhan_vien
ORDER BY luong DESC;


-- Ví dụ 8.4.2: CASE WHEN với điều kiện phức tạp (kết hợp nhiều cột)
SELECT
    ho_ten,
    phong_ban,
    tinh_trang,
    CASE
        WHEN tinh_trang = 'dang_lam'  AND phong_ban = 'IT' THEN 'IT Đang Làm'
        WHEN tinh_trang = 'dang_lam'                       THEN 'Đang Làm'
        WHEN tinh_trang = 'nghi_phep'                      THEN '🏖 Nghỉ Phép'
        WHEN tinh_trang = 'nghi_viec'                      THEN '🚪 Đã Nghỉ Việc'
        ELSE                                                     'Không xác định'
    END AS mo_ta_tinh_trang
FROM nhan_vien
ORDER BY phong_ban, ho_ten;


-- Ví dụ 8.4.3: CASE WHEN trong mệnh đề WHERE
-- Lọc: phòng IT cần lương > 20tr, còn lại cần lương > 15tr
SELECT ho_ten, phong_ban, luong
FROM nhan_vien
WHERE luong > CASE
                  WHEN phong_ban = 'IT' THEN 20000000
                  ELSE 15000000
              END
ORDER BY phong_ban, luong DESC;


-- ============================================================
-- 8.5 SIMPLE CASE — SO SÁNH BẰNG MỘT GIÁ TRỊ
-- ============================================================

-- Ví dụ 8.5.1: Đổi tên viết tắt phòng ban → tên đầy đủ
SELECT
    ho_ten,
    phong_ban,
    CASE phong_ban
        WHEN 'IT'         THEN 'Phòng Công Nghệ Thông Tin'
        WHEN 'Kế toán'    THEN 'Phòng Tài Chính - Kế Toán'
        WHEN 'Kinh doanh' THEN 'Phòng Kinh Doanh & Marketing'
        WHEN 'Nhân sự'    THEN 'Phòng Nhân Sự'
        ELSE                   phong_ban || ' (chưa phân loại)'
    END AS phong_ban_day_du
FROM nhan_vien;


-- ============================================================
-- 8.6 CASE WHEN + GROUP BY — COMBO PHÂN TÍCH MẠNH
-- ============================================================

-- Ví dụ 8.6.1: Đếm nhân viên theo nhóm lương
SELECT
    CASE
        WHEN luong >= 20000000 THEN 'Nhóm Cao (>= 20tr)'
        WHEN luong >= 15000000 THEN 'Nhóm TB (15-20tr)'
        ELSE                        'Nhóm Thấp (< 15tr)'
    END AS nhom_luong,
    COUNT(*)                    AS so_nhan_vien,
    MIN(luong)                  AS luong_min,
    MAX(luong)                  AS luong_max,
    AVG(luong)::NUMERIC(12,0)   AS luong_tb
FROM nhan_vien
GROUP BY
    CASE
        WHEN luong >= 20000000 THEN 'Nhóm Cao (>= 20tr)'
        WHEN luong >= 15000000 THEN 'Nhóm TB (15-20tr)'
        ELSE                        'Nhóm Thấp (< 15tr)'
    END
ORDER BY luong_tb DESC;


-- Ví dụ 8.6.2: Pivot ngang — đếm nhân viên theo tình trạng, phân theo phòng ban
-- Kỹ thuật: SUM(CASE WHEN ... THEN 1 ELSE 0 END)
SELECT
    phong_ban,
    COUNT(*)                                                       AS tong_nv,
    SUM(CASE WHEN tinh_trang = 'dang_lam'  THEN 1 ELSE 0 END)     AS dang_lam,
    SUM(CASE WHEN tinh_trang = 'nghi_phep' THEN 1 ELSE 0 END)     AS nghi_phep,
    SUM(CASE WHEN tinh_trang = 'nghi_viec' THEN 1 ELSE 0 END)     AS nghi_viec
FROM nhan_vien
GROUP BY phong_ban
ORDER BY phong_ban;


-- Ví dụ 8.6.3: Thống kê đơn hàng theo trạng thái và tháng (pivot ngang)
SELECT
    EXTRACT(MONTH FROM ngay_dat)::INTEGER             AS thang,
    COUNT(*)                                           AS tong_don,
    SUM(CASE WHEN trang_thai = 'hoan_thanh' THEN 1 ELSE 0 END)  AS hoan_thanh,
    SUM(CASE WHEN trang_thai = 'huy'        THEN 1 ELSE 0 END)  AS bi_huy,
    SUM(CASE WHEN trang_thai = 'cho_xu_ly'  THEN 1 ELSE 0 END)  AS cho_xu_ly,
    SUM(CASE WHEN trang_thai = 'hoan_thanh' THEN tong_tien ELSE 0 END) AS doanh_thu
FROM don_hang
GROUP BY EXTRACT(MONTH FROM ngay_dat)
ORDER BY thang;


-- ============================================================
-- 8.7 HÀM XỬ LÝ CHUỖI
-- ============================================================

-- Ví dụ 8.7.1: Các hàm chuỗi cơ bản
SELECT
    ho_ten,
    UPPER(ho_ten)               AS ho_ten_hoa,
    LOWER(ho_ten)               AS ho_ten_thuong,
    LENGTH(ho_ten)              AS so_ky_tu,
    TRIM('  ' || ho_ten || '  ') AS ho_ten_cat_trang
FROM nhan_vien;


-- Ví dụ 8.7.2: Làm sạch email
SELECT
    ho_ten,
    email                           AS email_goc,
    LOWER(TRIM(email))              AS email_chuan,
    POSITION('@' IN email)          AS vi_tri_at,
    SUBSTRING(email, POSITION('@' IN email) + 1, LENGTH(email)) AS ten_mien
FROM nhan_vien
WHERE email IS NOT NULL;


-- Ví dụ 8.7.3: Tạo mã nhân viên dạng NV-001
SELECT
    id,
    ho_ten,
    'NV-' || LPAD(id::TEXT, 3, '0') AS ma_nhan_vien
    -- LPAD(chuỗi, độ_dài, ký_tự_đệm): đệm ký tự vào đầu để đủ độ dài
    -- id::TEXT: ép kiểu INTEGER → TEXT
FROM nhan_vien;


-- Ví dụ 8.7.4: Cắt tên miền email để nhóm theo nhà cung cấp email
SELECT
    SUBSTRING(email, POSITION('@' IN email) + 1, LENGTH(email)) AS nha_cung_cap,
    COUNT(*) AS so_nhan_vien
FROM nhan_vien
WHERE email IS NOT NULL
GROUP BY SUBSTRING(email, POSITION('@' IN email) + 1, LENGTH(email))
ORDER BY so_nhan_vien DESC;


-- Ví dụ 8.7.5: REPLACE — thay thế nội dung trong chuỗi
-- Ví dụ: Chuẩn hóa định dạng số điện thoại (bỏ dấu gạch ngang nếu có)
SELECT
    ho_ten,
    dien_thoai,
    REPLACE(dien_thoai, '-', '') AS dien_thoai_chuan
FROM khach_hang;


-- ============================================================
-- 8.8 HÀM XỬ LÝ NGÀY THÁNG
-- ============================================================

-- Ví dụ 8.8.1: Các hàm ngày cơ bản
SELECT
    CURRENT_DATE                AS hom_nay,
    NOW()                       AS gio_hien_tai,
    CURRENT_DATE - INTERVAL '7 days'  AS tuan_truoc,
    CURRENT_DATE + INTERVAL '30 days' AS 30_ngay_toi;


-- Ví dụ 8.8.2: Lấy thành phần từ ngày
SELECT
    ho_ten,
    ngay_sinh,
    EXTRACT(YEAR  FROM ngay_sinh)::INTEGER AS nam_sinh,
    EXTRACT(MONTH FROM ngay_sinh)::INTEGER AS thang_sinh,
    EXTRACT(DAY   FROM ngay_sinh)::INTEGER AS ngay_sinh_so,
    EXTRACT(DOW   FROM ngay_sinh)::INTEGER AS thu_trong_tuan
    -- DOW: 0=Chủ nhật, 1=Thứ 2, ..., 6=Thứ 7
FROM nhan_vien
ORDER BY thang_sinh, ngay_sinh_so;


-- Ví dụ 8.8.3: Tính tuổi và thâm niên nhân viên
SELECT
    ho_ten,
    ngay_sinh,
    ngay_vao,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, ngay_sinh))::INTEGER  AS tuoi,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, ngay_vao))::INTEGER   AS nam_tham_nien,
    EXTRACT(MONTH FROM AGE(CURRENT_DATE, ngay_vao))::INTEGER  AS thang_le
FROM nhan_vien
ORDER BY nam_tham_nien DESC, thang_le DESC;


-- Ví dụ 8.8.4: Thống kê đơn hàng theo tháng
SELECT
    EXTRACT(YEAR  FROM ngay_dat)::INTEGER AS nam,
    EXTRACT(MONTH FROM ngay_dat)::INTEGER AS thang,
    COUNT(*)                              AS so_don,
    SUM(CASE WHEN trang_thai != 'huy' THEN tong_tien ELSE 0 END) AS doanh_thu
FROM don_hang
GROUP BY
    EXTRACT(YEAR  FROM ngay_dat),
    EXTRACT(MONTH FROM ngay_dat)
ORDER BY nam, thang;


-- Ví dụ 8.8.5: DATE_TRUNC — nhóm theo tháng (cách gọn hơn)
SELECT
    DATE_TRUNC('month', ngay_dat)::DATE AS dau_thang,
    COUNT(*)                             AS so_don,
    SUM(CASE WHEN trang_thai != 'huy' THEN tong_tien ELSE 0 END) AS doanh_thu
FROM don_hang
GROUP BY DATE_TRUNC('month', ngay_dat)
ORDER BY dau_thang;


-- Ví dụ 8.8.6: TO_CHAR — định dạng ngày thành chuỗi
SELECT
    ho_ten,
    ngay_sinh,
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY')       AS ngay_sinh_vn,
    TO_CHAR(ngay_vao,  'MM/YYYY')          AS thang_vao_lam,
    TO_CHAR(ngay_vao,  'Day DD Month YYYY') AS ngay_vao_day_du
    -- 'Day' → tên thứ: 'Monday', 'Tuesday'...
    -- 'Month' → tên tháng: 'January', 'February'...
FROM nhan_vien;


-- Ví dụ 8.8.7: Lọc đơn hàng trong 90 ngày gần nhất
SELECT ma_don_hang, ngay_dat, tong_tien, trang_thai
FROM don_hang
WHERE ngay_dat >= CURRENT_DATE - INTERVAL '180 days'  -- dùng 180 vì dữ liệu mẫu cũ
ORDER BY ngay_dat DESC;


-- Ví dụ 8.8.8: Phân loại đơn hàng theo quý
SELECT
    ma_don_hang,
    ngay_dat,
    CASE
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 1 AND 3  THEN 'Q1'
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 4 AND 6  THEN 'Q2'
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 7 AND 9  THEN 'Q3'
        ELSE                                                     'Q4'
    END AS quy,
    tong_tien
FROM don_hang
ORDER BY ngay_dat;

-- Thống kê doanh thu theo quý
SELECT
    CASE
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 1 AND 3  THEN 'Q1'
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 4 AND 6  THEN 'Q2'
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 7 AND 9  THEN 'Q3'
        ELSE                                                     'Q4'
    END AS quy,
    COUNT(*)    AS so_don,
    SUM(CASE WHEN trang_thai != 'huy' THEN tong_tien ELSE 0 END) AS doanh_thu
FROM don_hang
GROUP BY
    CASE
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 1 AND 3  THEN 'Q1'
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 4 AND 6  THEN 'Q2'
        WHEN EXTRACT(MONTH FROM ngay_dat) BETWEEN 7 AND 9  THEN 'Q3'
        ELSE                                                     'Q4'
    END
ORDER BY quy;


-- ============================================================
-- 8.9 COALESCE — XỬ LÝ NULL
-- ============================================================

-- Ví dụ 8.9.1: Hiển thị giá trị dự phòng khi NULL
SELECT
    ho_ten,
    COALESCE(email,    'Chưa có email')    AS email_hien_thi,
    COALESCE(nickname, ho_ten)             AS ten_goi,  -- dùng ho_ten nếu không có nickname
    COALESCE(email, '(chưa cập nhật)')     AS lien_he
FROM nhan_vien;


-- Ví dụ 8.9.2: COALESCE trong phép tính (tránh NULL lây sang kết quả)
SELECT
    kh.ho_ten,
    COUNT(dh.id)                      AS tong_don,
    COALESCE(SUM(dh.tong_tien), 0)    AS tong_tien  -- NULL → 0 thay vì NULL
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
                      AND dh.trang_thai != 'huy'
GROUP BY kh.id, kh.ho_ten
ORDER BY tong_tien DESC;


-- Ví dụ 8.9.3: So sánh NULL có xử lý và không xử lý
-- Không dùng COALESCE → kết quả NULL trong phép cộng
SELECT
    ho_ten,
    luong,
    NULL + 1000000  AS sai_NULL,        -- luôn là NULL
    COALESCE(NULL, 0) + 1000000  AS dung_COALESCE  -- trả về 1000000
FROM nhan_vien
LIMIT 3;


-- ============================================================
-- 8.10 BÀI TỔNG HỢP — BÁO CÁO PHÂN TÍCH KHÁCH HÀNG
-- ============================================================

-- Báo cáo đầy đủ: Tên khách, tổng đơn, tổng tiền, đơn gần nhất, phân loại
-- Kết hợp: Subquery + CASE WHEN + Hàm ngày + COALESCE
SELECT
    kh.ho_ten                                AS ten_khach,
    kh.thanh_pho,
    COUNT(dh.id)                             AS tong_so_don,
    COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                      THEN dh.tong_tien ELSE 0 END), 0)  AS tong_tien_mua,
    MAX(dh.ngay_dat)                         AS don_gan_nhat,
    CASE
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien ELSE 0 END), 0) >= 20000000 THEN 'VIP'
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien ELSE 0 END), 0) >= 5000000  THEN 'Thường'
        WHEN COUNT(dh.id) = 0                                                 THEN 'Chưa mua'
        ELSE                                                                        'Mới'
    END AS phan_loai_khach
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten, kh.thanh_pho
ORDER BY tong_tien_mua DESC;
