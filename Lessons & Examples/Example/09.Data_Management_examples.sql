-- ============================================================
-- TUẦN 9: QUẢN LÝ DỮ LIỆU — UPDATE, DELETE, TRANSACTION & VIEW
-- File: 09.Data_Management_examples.sql
-- Hướng dẫn: Copy từng khối SQL vào DBeaver và nhấn Ctrl+Enter để chạy
-- ⚠️  Tuần này có lệnh thay đổi dữ liệu thực — đọc kỹ trước khi chạy
-- ============================================================

-- ============================================================
-- SETUP: Tạo toàn bộ dữ liệu mẫu cho tuần này
-- Chạy phần này TRƯỚC KHI chạy các ví dụ bên dưới
-- Dùng lại cấu trúc 5 bảng từ Tuần 8 và bổ sung ma_sp/ten_sp cho san_pham
-- ============================================================

DROP TABLE IF EXISTS chi_tiet_don_hang;
DROP TABLE IF EXISTS don_hang;
DROP TABLE IF EXISTS san_pham;
DROP TABLE IF EXISTS khach_hang;
DROP TABLE IF EXISTS nhan_vien;

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
    ('Trần Thị Mai',      'Kế toán',    15000000, '1995-03-20', '2020-01-15', 'dang_lam',  NULL,   'mai.tran@email.com'),
    ('Nguyễn Văn An',     'Kinh doanh', 22000000, '1990-07-15', '2018-06-01', 'dang_lam',  'An',   'an.nguyen@email.com'),
    ('Lê Thị Bình',       'Nhân sự',    18000000, '1992-11-03', '2019-03-10', 'nghi_phep', NULL,   'binh.le@email.com'),
    ('Phạm Minh Châu',    'IT',          25000000, '1988-01-25', '2017-09-01', 'dang_lam',  'Châu', 'chau.pham@email.com'),
    ('Hoàng Thị Dung',    'Kế toán',    13000000, '1996-09-10', '2022-02-20', 'dang_lam',  NULL,   NULL),
    ('Võ Văn Em',         'Kinh doanh', 22000000, '1993-05-30', '2019-11-05', 'dang_lam',  'Em',   'em.vo@email.com'),
    ('Nguyễn Thị Ngọc',   'Kinh doanh', 21000000, '1991-08-22', '2020-07-15', 'dang_lam',  NULL,   'ngoc.nguyen@email.com'),
    ('Hồ Thị Hoa',        'Kinh doanh', 17500000, '1994-04-12', '2021-01-10', 'nghi_viec', 'Hoa',  NULL),
    ('Lê Văn Dũng',       'IT',          20000000, '1989-12-05', '2018-04-20', 'dang_lam',  NULL,   'dung.le@email.com'),
    ('Đặng Thị Lan',      'IT',          19000000, '1997-06-18', '2023-08-01', 'dang_lam',  'Lan',  'lan.dang@email.com'),
    ('Trịnh Văn Minh',    'Nhân sự',    16500000, '1990-02-28', '2019-05-15', 'dang_lam',  NULL,   NULL),
    ('Bùi Thị Thu',       'Nhân sự',    14000000, '1998-10-07', '2022-09-01', 'nghi_viec', NULL,   'thu.bui@email.com');

CREATE TABLE khach_hang (
    id          SERIAL PRIMARY KEY,
    ho_ten      VARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(15),
    email       VARCHAR(100),
    thanh_pho   VARCHAR(50)
);

INSERT INTO khach_hang (ho_ten, so_dien_thoai, email, thanh_pho) VALUES
    ('Trần Thị Mai',    '0901123456', 'mai.tran@gmail.com',   'Hà Nội'),
    ('Nguyễn Văn An',   '0912234567', 'an.nguyen@gmail.com',  'TP.HCM'),
    ('Lê Thị Bình',     '0923345678', 'binh.le@outlook.com',  'Đà Nẵng'),
    ('Phạm Minh Châu',  '0934456789', 'chau.pham@yahoo.com',  'Hà Nội'),
    ('Hoàng Văn Đức',   '0945567890', NULL,                   'TP.HCM'),
    ('Ngô Thị Phương',  '0956678901', 'phuong.ngo@gmail.com', 'Cần Thơ');

CREATE TABLE san_pham (
    id            SERIAL PRIMARY KEY,
    ma_sp         VARCHAR(20) UNIQUE,
    ten_sp        VARCHAR(200) NOT NULL,
    danh_muc      VARCHAR(50),
    gia           NUMERIC(12,0) NOT NULL,
    so_luong_ton  INTEGER DEFAULT 0
);

INSERT INTO san_pham (ma_sp, ten_sp, danh_muc, gia, so_luong_ton) VALUES
    ('SP001', 'Laptop Dell XPS 13',        'Điện tử',    28000000,  5),
    ('SP002', 'Chuột không dây Logitech',  'Điện tử',      450000, 50),
    ('SP003', 'Áo thun nam Cotton',        'Thời trang',   250000, 100),
    ('SP004', 'Quần Jean nữ Slim',         'Thời trang',   650000,  40),
    ('SP005', 'Bình nước giữ nhiệt 500ml', 'Gia dụng',     320000,  80),
    ('SP006', 'Máy pha cà phê mini',       'Gia dụng',    1200000,  15),
    ('SP007', 'Tai nghe Sony WH-1000XM5',  'Điện tử',    8500000,   8),
    ('SP008', 'Sách PostgreSQL Căn Bản',   'Sách',         180000,   0);

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
    ('DH001', 1, 2, '2024-01-05',  28450000, 'hoan_thanh'),
    ('DH002', 2, 6, '2024-01-12',    700000, 'hoan_thanh'),
    ('DH003', 1, 2, '2024-02-03',    900000, 'hoan_thanh'),
    ('DH004', 3, 7, '2024-02-18',   9150000, 'hoan_thanh'),
    ('DH005', 4, 6, '2024-03-02',    770000, 'hoan_thanh'),
    ('DH006', 2, 2, '2024-03-15',   1520000, 'huy'),
    ('DH007', 5, 7, '2024-04-01',   8820000, 'hoan_thanh'),
    ('DH008', 1, 6, '2024-04-22',    570000, 'hoan_thanh'),
    ('DH009', 3, 2, '2024-05-10',   1470000, 'hoan_thanh'),
    ('DH010', 4, 7, '2024-05-28',  28000000, 'hoan_thanh'),
    ('DH011', 2, 6, '2024-06-14',    320000, 'cho_xu_ly'),
    ('DH012', 1, 2, '2024-06-30',   1200000, 'hoan_thanh');

CREATE TABLE chi_tiet_don_hang (
    id          SERIAL PRIMARY KEY,
    don_hang_id INTEGER REFERENCES don_hang(id),
    san_pham_id INTEGER REFERENCES san_pham(id),
    so_luong    INTEGER NOT NULL,
    don_gia     NUMERIC(12,0) NOT NULL
);

INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia) VALUES
    (1,  1, 1, 28000000), (1,  2, 1, 450000),
    (2,  3, 2, 250000),
    (3,  3, 2, 250000),   (3,  5, 1, 320000), (3, 2, 1, 450000),
    (4,  7, 1, 8500000),  (4,  4, 1, 650000),
    (5,  4, 1, 650000),   (5,  2, 1, 450000),
    (6,  6, 1, 1200000),  (6,  5, 1, 320000),
    (7,  7, 1, 8500000),  (7,  5, 1, 320000),
    (8,  3, 1, 250000),   (8,  5, 1, 320000),
    (9,  6, 1, 1200000),
    (10, 1, 1, 28000000),
    (11, 5, 1, 320000),
    (12, 6, 1, 1200000);


-- ============================================================
-- 9.1 UPDATE — SỬA DỮ LIỆU
-- ============================================================

-- Xem dữ liệu trước khi sửa (thói quen tốt)
SELECT id, ho_ten, phong_ban, luong, tinh_trang FROM nhan_vien ORDER BY id;


-- Ví dụ 9.1.1: Sửa một hàng theo ID
-- Bước 1: Xem trước
SELECT ho_ten, luong FROM nhan_vien WHERE id = 5;
-- Bước 2: Sửa
UPDATE nhan_vien
SET luong = 14500000
WHERE id = 5;
-- Bước 3: Kiểm tra lại
SELECT ho_ten, luong FROM nhan_vien WHERE id = 5;


-- Ví dụ 9.1.2: Sửa nhiều cột cùng lúc
UPDATE nhan_vien
SET
    email    = 'dung.hoang@company.com',
    nickname = 'Dung'
WHERE id = 5;

SELECT id, ho_ten, email, nickname FROM nhan_vien WHERE id = 5;


-- Ví dụ 9.1.3: Tăng lương 10% cho phòng IT
-- Xem trước
SELECT ho_ten, phong_ban, luong,
       luong * 1.10 AS luong_sau_tang
FROM nhan_vien
WHERE phong_ban = 'IT' AND tinh_trang = 'dang_lam';

-- Thực hiện
UPDATE nhan_vien
SET luong = luong * 1.10
WHERE phong_ban = 'IT' AND tinh_trang = 'dang_lam';

-- Xem kết quả
SELECT ho_ten, phong_ban, luong FROM nhan_vien WHERE phong_ban = 'IT';


-- Ví dụ 9.1.4: UPDATE với CASE WHEN — mỗi phòng ban tăng lương khác nhau
-- (Chạy SETUP lại trước nếu muốn thử lại từ đầu)
UPDATE nhan_vien
SET luong = luong * CASE phong_ban
    WHEN 'IT'         THEN 1.15
    WHEN 'Kinh doanh' THEN 1.10
    WHEN 'Kế toán'    THEN 1.08
    ELSE                   1.05
END
WHERE tinh_trang = 'dang_lam';

-- Kiểm tra kết quả từng phòng ban
SELECT phong_ban,
       COUNT(*) AS so_nv,
       AVG(luong)::NUMERIC(12,0) AS luong_tb
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'
GROUP BY phong_ban
ORDER BY phong_ban;


-- Ví dụ 9.1.5: UPDATE trang thái đơn hàng quá hạn
-- Xem trước
SELECT ma_don_hang, ngay_dat, trang_thai
FROM don_hang
WHERE trang_thai = 'cho_xu_ly'
  AND ngay_dat < CURRENT_DATE - INTERVAL '30 days';

-- Cập nhật
UPDATE don_hang
SET trang_thai = 'qua_han'
WHERE trang_thai = 'cho_xu_ly'
  AND ngay_dat < CURRENT_DATE - INTERVAL '30 days';

-- Xem lại
SELECT ma_don_hang, ngay_dat, trang_thai FROM don_hang ORDER BY ngay_dat;


-- ============================================================
-- 9.2 DELETE — XÓA DỮ LIỆU
-- ============================================================

-- Ví dụ 9.2.1: Xóa một nhân viên đã nghỉ việc
-- Bước 1: Xem trước ai sẽ bị xóa
SELECT id, ho_ten, tinh_trang FROM nhan_vien WHERE tinh_trang = 'nghi_viec';

-- Bước 2: Xóa nhân viên nghỉ việc (chỉ xóa id=8 để minh họa)
DELETE FROM nhan_vien WHERE id = 8;

-- Bước 3: Kiểm tra
SELECT COUNT(*) AS so_nv_con_lai FROM nhan_vien;
SELECT id, ho_ten, tinh_trang FROM nhan_vien WHERE tinh_trang = 'nghi_viec';


-- Ví dụ 9.2.2: Xóa đơn hàng bị hủy (phải xóa chi tiết trước)
-- Bước 1: Xem đơn hàng bị hủy
SELECT * FROM don_hang WHERE trang_thai = 'huy';

-- Bước 2: Xóa chi tiết của đơn hủy trước (bảng con)
DELETE FROM chi_tiet_don_hang
WHERE don_hang_id IN (
    SELECT id FROM don_hang WHERE trang_thai = 'huy'
);

-- Bước 3: Xóa đơn hàng hủy (bảng cha)
DELETE FROM don_hang WHERE trang_thai = 'huy';

-- Bước 4: Kiểm tra
SELECT COUNT(*) AS so_don_hang FROM don_hang;
SELECT trang_thai, COUNT(*) FROM don_hang GROUP BY trang_thai;


-- ============================================================
-- 9.3 TRANSACTION — BEGIN / COMMIT / ROLLBACK
-- ============================================================

-- Ví dụ 9.3.1: Thực hành ROLLBACK — an toàn để học
BEGIN;

-- Thử xóa toàn bộ nhân viên phòng Kế toán
DELETE FROM nhan_vien WHERE phong_ban = 'Kế toán';

-- Kiểm tra (trong transaction — chỉ bạn nhìn thấy thay đổi này)
SELECT COUNT(*) AS so_nv FROM nhan_vien;
SELECT phong_ban, COUNT(*) FROM nhan_vien GROUP BY phong_ban;

-- Nhận ra sai → Hủy bỏ!
ROLLBACK;

-- Kiểm tra lại: Kế toán đã trở về
SELECT phong_ban, COUNT(*) FROM nhan_vien GROUP BY phong_ban;


-- Ví dụ 9.3.2: Transaction COMMIT — lưu thay đổi thật sự
BEGIN;

-- Thêm một nhân viên mới
INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_vao, tinh_trang)
VALUES ('Phan Văn Tuấn', 'IT', 18000000, '2024-03-01', 'dang_lam');

-- Kiểm tra
SELECT ho_ten, phong_ban, luong
FROM nhan_vien
WHERE ho_ten = 'Phan Văn Tuấn';

-- Thấy đúng → Lưu
COMMIT;

-- Nhân viên mới đã được lưu vĩnh viễn
SELECT id, ho_ten, phong_ban FROM nhan_vien ORDER BY id DESC LIMIT 3;


-- Ví dụ 9.3.3: Transaction bảo vệ nhiều thao tác liên quan
-- Tình huống: Đổi nhân viên phụ trách đơn hàng
-- (Chuyển đơn DH011 từ nhân viên id=6 sang nhân viên id=2)
BEGIN;

-- Kiểm tra trước
SELECT ma_don_hang, nhan_vien_id FROM don_hang WHERE ma_don_hang = 'DH011';

-- Cập nhật
UPDATE don_hang
SET nhan_vien_id = 2
WHERE ma_don_hang = 'DH011';

-- Kiểm tra sau
SELECT dh.ma_don_hang, nv.ho_ten AS nhan_vien_phu_trach
FROM don_hang dh
JOIN nhan_vien nv ON dh.nhan_vien_id = nv.id
WHERE dh.ma_don_hang = 'DH011';

-- Đúng rồi → Lưu
COMMIT;


-- Ví dụ 9.3.4: SAVEPOINT — điểm lưu giữa chừng
BEGIN;

-- Bước 1: Tăng lương IT
UPDATE nhan_vien SET luong = luong * 1.10 WHERE phong_ban = 'IT';

SAVEPOINT sau_khi_tang_IT;   -- Tạo điểm lưu

-- Bước 2: Tăng lương Kế toán (nhập nhầm 2.0 thay vì 1.08)
UPDATE nhan_vien SET luong = luong * 2.0 WHERE phong_ban = 'Kế toán';

-- Ôi sai rồi! Hoàn tác chỉ bước Kế toán
ROLLBACK TO SAVEPOINT sau_khi_tang_IT;

-- Làm lại đúng
UPDATE nhan_vien SET luong = luong * 1.08 WHERE phong_ban = 'Kế toán';

-- Kiểm tra
SELECT phong_ban, AVG(luong)::NUMERIC(12,0) AS luong_tb
FROM nhan_vien WHERE tinh_trang = 'dang_lam'
GROUP BY phong_ban;

COMMIT;  -- Lưu: IT +10%, Kế toán +8%


-- ============================================================
-- 9.4 TRUNCATE — XÓA NHANH TOÀN BỘ
-- ============================================================

-- Ví dụ 9.4.1: So sánh DELETE không WHERE vs TRUNCATE
-- (Dùng bảng tạm để demo an toàn)

CREATE TEMP TABLE bang_thu_nghiem (
    id    SERIAL PRIMARY KEY,
    ten   VARCHAR(50),
    diem  INTEGER
);

INSERT INTO bang_thu_nghiem (ten, diem) VALUES
    ('Học sinh A', 85), ('Học sinh B', 90), ('Học sinh C', 75);

-- Kiểm tra
SELECT * FROM bang_thu_nghiem;

-- TRUNCATE — xóa hết, reset SERIAL
TRUNCATE TABLE bang_thu_nghiem RESTART IDENTITY;

-- Nhập lại
INSERT INTO bang_thu_nghiem (ten, diem) VALUES ('Học sinh D', 88);

-- id bắt đầu lại từ 1
SELECT * FROM bang_thu_nghiem;

-- Dọn dẹp
DROP TABLE bang_thu_nghiem;


-- ============================================================
-- 9.5 VIEW — TẠO VÀ SỬ DỤNG
-- ============================================================

-- Ví dụ 9.5.1: Tạo view nhân viên đang làm việc
CREATE OR REPLACE VIEW v_nhan_vien_dang_lam AS
SELECT
    nv.id,
    nv.ho_ten,
    nv.phong_ban,
    nv.luong,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, nv.ngay_vao))::INTEGER  AS nam_tham_nien,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, nv.ngay_sinh))::INTEGER AS tuoi,
    CASE
        WHEN nv.luong >= 22000000 THEN 'Cao'
        WHEN nv.luong >= 17000000 THEN 'Trung bình'
        ELSE                           'Thấp'
    END AS phan_loai_luong,
    COALESCE(nv.email, '(chưa có email)') AS email_hien_thi
FROM nhan_vien nv
WHERE nv.tinh_trang = 'dang_lam';

-- Dùng view như bảng bình thường
SELECT * FROM v_nhan_vien_dang_lam ORDER BY luong DESC;

-- Lọc từ view
SELECT * FROM v_nhan_vien_dang_lam WHERE phong_ban = 'IT';

-- Thống kê từ view
SELECT
    phong_ban,
    COUNT(*)                   AS so_nv,
    AVG(luong)::NUMERIC(12,0)  AS luong_tb,
    MIN(tuoi)                  AS tuoi_nho_nhat,
    MAX(tuoi)                  AS tuoi_lon_nhat
FROM v_nhan_vien_dang_lam
GROUP BY phong_ban
ORDER BY luong_tb DESC;


-- Ví dụ 9.5.2: View báo cáo doanh thu theo tháng
CREATE OR REPLACE VIEW v_doanh_thu_theo_thang AS
SELECT
    DATE_TRUNC('month', dh.ngay_dat)::DATE         AS thang,
    TO_CHAR(dh.ngay_dat, 'MM/YYYY')                AS thang_hien_thi,
    COUNT(dh.id)                                    AS so_don_tong,
    SUM(CASE WHEN dh.trang_thai != 'huy' THEN 1 ELSE 0 END)   AS so_don_hoan_thanh,
    SUM(CASE WHEN dh.trang_thai = 'huy'  THEN 1 ELSE 0 END)   AS so_don_huy,
    COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                      THEN dh.tong_tien END), 0)    AS doanh_thu
FROM don_hang dh
GROUP BY DATE_TRUNC('month', dh.ngay_dat), TO_CHAR(dh.ngay_dat, 'MM/YYYY')
ORDER BY thang;

SELECT * FROM v_doanh_thu_theo_thang;

-- Tính tổng doanh thu từ view
SELECT SUM(doanh_thu) AS tong_doanh_thu FROM v_doanh_thu_theo_thang;


-- Ví dụ 9.5.3: View tổng hợp khách hàng VIP
CREATE OR REPLACE VIEW v_thong_ke_khach_hang AS
SELECT
    kh.id,
    kh.ho_ten,
    kh.thanh_pho,
    COUNT(dh.id)                                         AS tong_don,
    COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                      THEN dh.tong_tien END), 0)         AS tong_tien_mua,
    MAX(dh.ngay_dat)                                     AS don_gan_nhat,
    CASE
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien END), 0) >= 10000000 THEN 'VIP'
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien END), 0) >= 1000000  THEN 'Thường'
        WHEN COUNT(dh.id) = 0                                          THEN 'Chưa mua'
        ELSE                                                                'Mới'
    END AS phan_loai
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten, kh.thanh_pho;

-- Dùng view
SELECT * FROM v_thong_ke_khach_hang ORDER BY tong_tien_mua DESC;

-- Chỉ xem khách VIP
SELECT ho_ten, tong_don, tong_tien_mua
FROM v_thong_ke_khach_hang
WHERE phan_loai = 'VIP';

-- JOIN view với bảng khác
SELECT
    tkh.ho_ten   AS ten_khach,
    tkh.phan_loai,
    kh.so_dien_thoai
FROM v_thong_ke_khach_hang tkh
JOIN khach_hang kh ON tkh.id = kh.id
WHERE tkh.phan_loai != 'Chưa mua'
ORDER BY tkh.tong_tien_mua DESC;


-- Ví dụ 9.5.4: Cập nhật view (CREATE OR REPLACE)
-- Thêm cột số ngày kể từ đơn gần nhất vào view khách hàng
CREATE OR REPLACE VIEW v_thong_ke_khach_hang AS
SELECT
    kh.id,
    kh.ho_ten,
    kh.thanh_pho,
    COUNT(dh.id)                                         AS tong_don,
    COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                      THEN dh.tong_tien END), 0)         AS tong_tien_mua,
    MAX(dh.ngay_dat)                                     AS don_gan_nhat,
    CASE
        WHEN MAX(dh.ngay_dat) IS NULL THEN NULL
        ELSE (CURRENT_DATE - MAX(dh.ngay_dat))           -- Thêm mới: số ngày từ đơn cuối
    END AS ngay_khong_mua,
    CASE
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien END), 0) >= 10000000 THEN 'VIP'
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien END), 0) >= 1000000  THEN 'Thường'
        WHEN COUNT(dh.id) = 0                                          THEN 'Chưa mua'
        ELSE                                                                'Mới'
    END AS phan_loai
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten, kh.thanh_pho;

SELECT ho_ten, tong_tien_mua, don_gan_nhat, ngay_khong_mua, phan_loai
FROM v_thong_ke_khach_hang
ORDER BY tong_tien_mua DESC;


-- Ví dụ 9.5.5: Xóa view
DROP VIEW IF EXISTS v_thong_ke_khach_hang;
-- Thông báo: "DROP VIEW" — view đã bị xóa

-- Kiểm tra: giờ SELECT từ view sẽ báo lỗi
-- SELECT * FROM v_thong_ke_khach_hang;  -- ERROR: relation does not exist

-- Tạo lại
CREATE OR REPLACE VIEW v_thong_ke_khach_hang AS
SELECT
    kh.id,
    kh.ho_ten,
    kh.thanh_pho,
    COUNT(dh.id)                                         AS tong_don,
    COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                      THEN dh.tong_tien END), 0)         AS tong_tien_mua,
    MAX(dh.ngay_dat)                                     AS don_gan_nhat,
    CASE
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien END), 0) >= 10000000 THEN 'VIP'
        WHEN COALESCE(SUM(CASE WHEN dh.trang_thai != 'huy'
                               THEN dh.tong_tien END), 0) >= 1000000  THEN 'Thường'
        WHEN COUNT(dh.id) = 0                                          THEN 'Chưa mua'
        ELSE                                                                'Mới'
    END AS phan_loai
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten, kh.thanh_pho;


-- ============================================================
-- 9.6 ALTER TABLE — THAY ĐỔI CẤU TRÚC BẢNG
-- ============================================================

-- Ví dụ 9.6.1: Thêm cột mới vào bảng
ALTER TABLE nhan_vien
ADD COLUMN diem_danh_gia NUMERIC(3,1);

-- Kiểm tra cột đã được thêm (tất cả giá trị là NULL)
SELECT id, ho_ten, diem_danh_gia FROM nhan_vien LIMIT 5;

-- Cập nhật điểm cho nhân viên
UPDATE nhan_vien SET diem_danh_gia = 9.0 WHERE id = 4;  -- Châu
UPDATE nhan_vien SET diem_danh_gia = 8.5 WHERE id = 2;  -- An
UPDATE nhan_vien SET diem_danh_gia = 8.0 WHERE id = 6;  -- Em
UPDATE nhan_vien SET diem_danh_gia = 7.5 WHERE tinh_trang = 'dang_lam' AND diem_danh_gia IS NULL;

SELECT ho_ten, phong_ban, luong, diem_danh_gia
FROM nhan_vien
ORDER BY diem_danh_gia DESC NULLS LAST;
-- NULLS LAST: đặt NULL xuống cuối khi sắp xếp


-- Ví dụ 9.6.2: Thêm cột số điện thoại vào bảng khách hàng (đã có)
-- Thực ra bảng khach_hang đã có so_dien_thoai, thêm cột ghi_chu thay
ALTER TABLE khach_hang
ADD COLUMN ghi_chu TEXT;

-- Cập nhật ghi chú cho một số khách
UPDATE khach_hang SET ghi_chu = 'Khách thân thiết từ 2022' WHERE id = 1;
UPDATE khach_hang SET ghi_chu = 'Khách doanh nghiệp'        WHERE id = 4;

SELECT id, ho_ten, ghi_chu FROM khach_hang;


-- Ví dụ 9.6.3: Đổi tên cột
ALTER TABLE nhan_vien
RENAME COLUMN nickname TO ten_goi;

-- Kiểm tra
SELECT id, ho_ten, ten_goi FROM nhan_vien WHERE ten_goi IS NOT NULL;


-- Ví dụ 9.6.4: Xóa cột
-- (Thêm lại nickname để xóa minh họa)
ALTER TABLE nhan_vien
ADD COLUMN ghi_chu_nv TEXT;

UPDATE nhan_vien SET ghi_chu_nv = 'Nhân viên mới' WHERE ngay_vao >= '2022-01-01';

SELECT ho_ten, ghi_chu_nv FROM nhan_vien WHERE ghi_chu_nv IS NOT NULL;

-- Xóa cột ghi_chu_nv
ALTER TABLE nhan_vien
DROP COLUMN ghi_chu_nv;

-- Kiểm tra cột đã mất
SELECT id, ho_ten, ten_goi FROM nhan_vien LIMIT 3;


-- ============================================================
-- 9.7 IMPORT CSV (MINH HỌA — không cần file thật)
-- ============================================================

-- Ví dụ 9.7.1: Cấu trúc lệnh COPY để import
-- (Thay đường dẫn thực tế khi dùng)

-- Import dữ liệu từ CSV:
/*
COPY san_pham (ma_sp, ten_sp, danh_muc, gia, so_luong_ton)
FROM 'C:/data/san_pham_moi.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    ENCODING 'UTF8'
);
*/

-- Export dữ liệu ra CSV:
/*
COPY (
    SELECT
        nv.ho_ten,
        nv.phong_ban,
        nv.luong,
        TO_CHAR(nv.ngay_vao, 'DD/MM/YYYY') AS ngay_vao
    FROM nhan_vien nv
    WHERE nv.tinh_trang = 'dang_lam'
    ORDER BY nv.phong_ban, nv.ho_ten
)
TO 'C:/data/nhan_vien_export.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8');
*/

-- Ví dụ 9.7.2: Dùng bảng tạm để kiểm tra dữ liệu trước khi import chính thức
-- Bước 1: Tạo bảng tạm cùng cấu trúc
CREATE TEMP TABLE san_pham_import (
    ma_sp        VARCHAR(20),
    ten_sp       VARCHAR(200),
    danh_muc     VARCHAR(50),
    gia          NUMERIC(12,0),
    so_luong_ton INTEGER
);

-- Bước 2: Import vào bảng tạm
-- COPY san_pham_import FROM 'C:/data/san_pham_moi.csv' WITH (FORMAT CSV, HEADER TRUE);

-- Bước 3: Kiểm tra dữ liệu trong bảng tạm (giả lập bằng INSERT)
INSERT INTO san_pham_import VALUES
    ('SP009', 'Bàn phím cơ RGB', 'Điện tử', 1500000, 20),
    ('SP010', 'Màn hình 27 inch', 'Điện tử', 6500000, 10),
    ('SP011', 'Ghế văn phòng',    'Nội thất', 3200000, 8);

-- Bước 4: Kiểm tra — có dữ liệu nào bất thường không?
SELECT * FROM san_pham_import;
SELECT COUNT(*), MIN(gia), MAX(gia) FROM san_pham_import;

-- Bước 5: Chuyển sang bảng thật nếu OK
INSERT INTO san_pham (ma_sp, ten_sp, danh_muc, gia, so_luong_ton)
SELECT ma_sp, ten_sp, danh_muc, gia, so_luong_ton
FROM san_pham_import;

-- Kiểm tra kết quả
SELECT * FROM san_pham ORDER BY id;

-- Ví dụ 9.7.3: ON CONFLICT (UPSERT) — nếu trùng ma_sp thì cập nhật
INSERT INTO san_pham (ma_sp, ten_sp, danh_muc, gia, so_luong_ton)
VALUES ('SP002', 'Chuột không dây Logitech M331', 'Điện tử', 490000, 60)
ON CONFLICT (ma_sp)
DO UPDATE SET
    ten_sp       = EXCLUDED.ten_sp,
    danh_muc     = EXCLUDED.danh_muc,
    gia          = EXCLUDED.gia,
    so_luong_ton = EXCLUDED.so_luong_ton;

SELECT ma_sp, ten_sp, gia, so_luong_ton
FROM san_pham
WHERE ma_sp = 'SP002';

-- Nếu chỉ muốn bỏ qua hàng trùng, dùng DO NOTHING
INSERT INTO san_pham (ma_sp, ten_sp, danh_muc, gia, so_luong_ton)
VALUES ('SP002', 'Chuột không dây Logitech M331', 'Điện tử', 490000, 60)
ON CONFLICT (ma_sp) DO NOTHING;

-- Bảng tạm tự xóa khi đóng phiên làm việc
-- Hoặc xóa thủ công:
DROP TABLE san_pham_import;


-- ============================================================
-- 9.8 TỔNG KẾT — CÁC VIEW ĐÃ TẠO
-- ============================================================

-- Liệt kê các view hiện có trong schema public
SELECT viewname, definition
FROM pg_views
WHERE schemaname = 'public'
ORDER BY viewname;

-- Dùng tất cả các view đã tạo
SELECT 'Nhân viên đang làm' AS bao_cao, COUNT(*) AS so_luong
FROM v_nhan_vien_dang_lam
UNION ALL
SELECT 'Khách VIP', COUNT(*)
FROM v_thong_ke_khach_hang WHERE phan_loai = 'VIP'
UNION ALL
SELECT 'Tháng có doanh thu', COUNT(*)
FROM v_doanh_thu_theo_thang;
