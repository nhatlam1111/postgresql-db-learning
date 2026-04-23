-- ============================================================
-- TUẦN 7: KẾT NỐI NHIỀU BẢNG — JOIN
-- File: 07.JOIN_examples.sql
-- Hướng dẫn: Copy từng khối SQL vào DBeaver và nhấn Ctrl+Enter để chạy
-- ============================================================

-- ============================================================
-- SETUP: Tạo toàn bộ dữ liệu mẫu cho tuần này
-- Chạy phần này TRƯỚC KHI chạy các ví dụ bên dưới
-- Tuần này giới thiệu 4 bảng liên kết: khach_hang, san_pham, don_hang, chi_tiet_don_hang
-- ============================================================

DROP TABLE IF EXISTS chi_tiet_don_hang;
DROP TABLE IF EXISTS don_hang;
DROP TABLE IF EXISTS san_pham;
DROP TABLE IF EXISTS khach_hang;
DROP TABLE IF EXISTS nhan_vien;

-- Bảng 1: Nhân viên (quen thuộc từ tuần trước)
CREATE TABLE nhan_vien (
    id            SERIAL PRIMARY KEY,
    ho_ten        VARCHAR(100) NOT NULL,
    phong_ban     VARCHAR(50),
    luong         NUMERIC(12,0),
    dang_lam      BOOLEAN DEFAULT TRUE
);

INSERT INTO nhan_vien (ho_ten, phong_ban, luong, dang_lam) VALUES
    ('Võ Văn Em',       'Kinh doanh', 22000000, TRUE),
    ('Nguyễn Thị Ngọc', 'Kinh doanh', 21000000, TRUE),
    ('Hồ Thị Hoa',      'Kinh doanh', 17500000, FALSE),
    ('Lê Văn Dũng',     'Kinh doanh', 19000000, TRUE);

-- Bảng 2: Khách hàng
CREATE TABLE khach_hang (
    id            SERIAL PRIMARY KEY,
    ho_ten        VARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(20),
    email         VARCHAR(100),
    thanh_pho     VARCHAR(50)
);

INSERT INTO khach_hang (ho_ten, so_dien_thoai, email, thanh_pho) VALUES
    ('Trần Thị Mai',     '0901123456', 'mai.tran@gmail.com',   'Hà Nội'),
    ('Nguyễn Văn An',    '0912234567', 'an.nguyen@gmail.com',  'TP.HCM'),
    ('Lê Thị Bình',      '0923345678', 'binh.le@outlook.com',  'Đà Nẵng'),
    ('Phạm Minh Châu',   '0934456789', 'chau.pham@yahoo.com',  'Hà Nội'),
    ('Hoàng Văn Đức',    '0945567890', NULL,                   'TP.HCM'),
    ('Ngô Thị Phương',   '0956678901', 'phuong.ngo@gmail.com', 'Cần Thơ');
-- Lưu ý: Khách Ngô Thị Phương (id=6) sẽ KHÔNG có đơn hàng — để minh hoạ LEFT JOIN

-- Bảng 3: Sản phẩm
CREATE TABLE san_pham (
    id            SERIAL PRIMARY KEY,
    ten_sp        VARCHAR(200) NOT NULL,
    danh_muc      VARCHAR(50),
    gia           NUMERIC(12,0) NOT NULL
);

INSERT INTO san_pham (ten_sp, danh_muc, gia) VALUES
    ('Laptop Dell XPS 13',     'Điện tử',  28000000),
    ('Chuột không dây Logitech','Điện tử',   350000),
    ('Bàn phím cơ Keychron',   'Điện tử',  1800000),
    ('Áo sơ mi trắng nam',     'Thời trang', 280000),
    ('Quần Jean Levi''s',      'Thời trang', 950000),
    ('Balo laptop 15"',        'Phụ kiện',  420000),
    ('Tai nghe Sony WH-1000XM5','Điện tử', 8500000),
    ('Sách PostgreSQL cơ bản', 'Sách',      180000);
-- Lưu ý: Sản phẩm id=8 (Sách) sẽ KHÔNG có trong đơn hàng — để minh hoạ JOIN

-- Bảng 4: Đơn hàng
CREATE TABLE don_hang (
    id              SERIAL PRIMARY KEY,
    ma_don_hang     VARCHAR(20) NOT NULL,
    khach_hang_id   INTEGER REFERENCES khach_hang(id),
    nhan_vien_id    INTEGER REFERENCES nhan_vien(id),
    ngay_dat        DATE NOT NULL,
    tong_tien       NUMERIC(15,2),
    trang_thai      VARCHAR(20) DEFAULT 'hoan_thanh'
);

INSERT INTO don_hang (ma_don_hang, khach_hang_id, nhan_vien_id, ngay_dat, tong_tien, trang_thai) VALUES
    ('DH001', 1, 1, '2024-01-05', 28350000, 'hoan_thanh'),
    ('DH002', 2, 2, '2024-01-12',  2740000, 'hoan_thanh'),
    ('DH003', 1, 1, '2024-01-20',  2220000, 'hoan_thanh'),
    ('DH004', 3, 4, '2024-02-03',  9200000, 'hoan_thanh'),
    ('DH005', 4, 2, '2024-02-14', 28000000, 'hoan_thanh'),
    ('DH006', 2, 1, '2024-02-28',   560000, 'huy'),
    ('DH007', 3, 4, '2024-03-07', 10300000, 'hoan_thanh'),
    ('DH008', 1, 1, '2024-03-15',  1050000, 'hoan_thanh'),
    ('DH009', 5, 2, '2024-03-22',  1790000, 'hoan_thanh'),
    ('DH010', 4, 4, '2024-04-01', 28000000, 'hoan_thanh'),
    ('DH011', 2, 2, '2024-04-10',  3300000, 'hoan_thanh'),
    ('DH012', 1, 1, '2024-04-18',  2220000, 'hoan_thanh');
-- Lưu ý: Khách id=6 (Ngô Thị Phương) không có đơn nào — để minh hoạ LEFT JOIN

-- Bảng 5: Chi tiết đơn hàng
CREATE TABLE chi_tiet_don_hang (
    id            SERIAL PRIMARY KEY,
    don_hang_id   INTEGER REFERENCES don_hang(id),
    san_pham_id   INTEGER REFERENCES san_pham(id),
    so_luong      INTEGER NOT NULL,
    don_gia       NUMERIC(12,0) NOT NULL
);

INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia) VALUES
    (1,  1, 1, 28000000),   -- DH001: Laptop Dell
    (1,  2, 1,   350000),   -- DH001: Chuột Logitech
    (2,  5, 2,   950000),   -- DH002: Jean Levi's x2
    (2,  4, 3,   280000),   -- DH002: Áo sơ mi x3
    (3,  3, 1,  1800000),   -- DH003: Bàn phím Keychron
    (3,  6, 1,   420000),   -- DH003: Balo
    (4,  7, 1,  8500000),   -- DH004: Tai nghe Sony
    (4,  2, 2,   350000),   -- DH004: Chuột x2
    (5,  1, 1, 28000000),   -- DH005: Laptop Dell
    (6,  4, 2,   280000),   -- DH006 (đã hủy): Áo x2
    (7,  7, 1,  8500000),   -- DH007: Tai nghe Sony
    (7,  3, 1,  1800000),   -- DH007: Bàn phím
    (8,  2, 3,   350000),   -- DH008: Chuột x3
    (9,  5, 1,   950000),   -- DH009: Jean
    (9,  6, 2,   420000),   -- DH009: Balo x2
    (10, 1, 1, 28000000),   -- DH010: Laptop Dell
    (11, 4, 5,   280000),   -- DH011: Áo x5
    (11, 5, 2,   950000),   -- DH011: Jean x2
    (12, 3, 1,  1800000),   -- DH012: Bàn phím
    (12, 6, 1,   420000);   -- DH012: Balo

-- Kiểm tra dữ liệu
SELECT * FROM khach_hang;
SELECT * FROM san_pham;
SELECT * FROM don_hang;
SELECT * FROM chi_tiet_don_hang;


-- ============================================================
-- PHẦN 7.1: INNER JOIN — KẾT NỐI CƠ BẢN
-- ============================================================

-- Xem đơn hàng kèm tên khách hàng
-- (Tương đương: VLOOKUP mã khách trong sheet Đơn hàng để lấy tên từ sheet Khách hàng)
SELECT
    dh.ma_don_hang,
    kh.ho_ten           AS ten_khach,
    kh.so_dien_thoai,
    dh.ngay_dat,
    dh.trang_thai
FROM don_hang dh
INNER JOIN khach_hang kh ON dh.khach_hang_id = kh.id
ORDER BY dh.ngay_dat DESC;

-- Xem đơn hàng kèm nhân viên phụ trách
SELECT
    dh.ma_don_hang,
    kh.ho_ten           AS ten_khach,
    nv.ho_ten           AS nhan_vien_phu_trach,
    dh.ngay_dat,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh  ON dh.khach_hang_id = kh.id
JOIN nhan_vien nv   ON dh.nhan_vien_id = nv.id
ORDER BY dh.ngay_dat;

-- Xem chi tiết đơn hàng kèm tên sản phẩm
SELECT
    dh.ma_don_hang,
    sp.ten_sp,
    sp.danh_muc,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia    AS thanh_tien
FROM chi_tiet_don_hang ct
JOIN don_hang dh    ON ct.don_hang_id = dh.id
JOIN san_pham sp    ON ct.san_pham_id = sp.id
WHERE dh.trang_thai = 'hoan_thanh'
ORDER BY dh.ma_don_hang, sp.ten_sp;


-- ============================================================
-- PHẦN 7.2: LEFT JOIN — LẤY TẤT CẢ TỪ BẢNG TRÁI
-- ============================================================

-- Tất cả khách hàng, kể cả người chưa có đơn nào
SELECT
    kh.ho_ten,
    kh.thanh_pho,
    dh.ma_don_hang,
    dh.ngay_dat
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
ORDER BY kh.ho_ten, dh.ngay_dat;
-- Khách Ngô Thị Phương sẽ xuất hiện với NULL ở các cột đơn hàng

-- Tìm khách hàng CHƯA CÓ đơn hàng nào (LEFT JOIN + IS NULL)
SELECT kh.ho_ten, kh.so_dien_thoai, kh.thanh_pho
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
WHERE dh.id IS NULL;
-- Kết quả: Ngô Thị Phương

-- Tất cả sản phẩm, kể cả sản phẩm chưa bao giờ được mua
SELECT
    sp.ten_sp,
    sp.danh_muc,
    sp.gia,
    COUNT(ct.id)    AS so_lan_ban
FROM san_pham sp
LEFT JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY sp.id, sp.ten_sp, sp.danh_muc, sp.gia
ORDER BY so_lan_ban DESC;
-- Sách PostgreSQL sẽ có so_lan_ban = 0

-- Sản phẩm chưa từng có trong đơn hàng nào
SELECT sp.ten_sp, sp.danh_muc, sp.gia
FROM san_pham sp
LEFT JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
WHERE ct.id IS NULL;


-- ============================================================
-- PHẦN 7.3: JOIN NHIỀU BẢNG
-- ============================================================

-- Báo cáo đầy đủ: Khách → Đơn → Sản phẩm (4 bảng)
SELECT
    kh.ho_ten               AS ten_khach,
    kh.thanh_pho,
    dh.ma_don_hang,
    dh.ngay_dat,
    sp.ten_sp,
    sp.danh_muc,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia AS thanh_tien
FROM chi_tiet_don_hang ct
JOIN don_hang dh     ON ct.don_hang_id = dh.id
JOIN khach_hang kh   ON dh.khach_hang_id = kh.id
JOIN san_pham sp     ON ct.san_pham_id = sp.id
WHERE dh.trang_thai = 'hoan_thanh'
ORDER BY dh.ngay_dat DESC, kh.ho_ten;

-- Xem đơn hàng đầy đủ: khách + nhân viên phụ trách + tổng tiền
SELECT
    dh.ma_don_hang,
    dh.ngay_dat,
    kh.ho_ten               AS ten_khach,
    kh.thanh_pho,
    nv.ho_ten               AS nhan_vien_phu_trach,
    SUM(ct.so_luong * ct.don_gia) AS tong_tien_don_hang
FROM don_hang dh
JOIN khach_hang kh          ON dh.khach_hang_id = kh.id
JOIN nhan_vien nv           ON dh.nhan_vien_id = nv.id
JOIN chi_tiet_don_hang ct   ON dh.id = ct.don_hang_id
WHERE dh.trang_thai = 'hoan_thanh'
GROUP BY dh.id, dh.ma_don_hang, dh.ngay_dat,
         kh.ho_ten, kh.thanh_pho, nv.ho_ten
ORDER BY dh.ngay_dat DESC;


-- ============================================================
-- PHẦN 7.4: JOIN + GROUP BY — BÁO CÁO TỔNG HỢP
-- ============================================================

-- Tổng chi tiêu của mỗi khách hàng (chỉ đơn hoàn thành)
SELECT
    kh.ho_ten,
    kh.thanh_pho,
    COUNT(DISTINCT dh.id)   AS so_don_hang,
    SUM(ct.so_luong * ct.don_gia) AS tong_chi_tieu
FROM khach_hang kh
LEFT JOIN don_hang dh        ON kh.id = dh.khach_hang_id
                             AND dh.trang_thai = 'hoan_thanh'
LEFT JOIN chi_tiet_don_hang ct ON dh.id = ct.don_hang_id
GROUP BY kh.id, kh.ho_ten, kh.thanh_pho
ORDER BY tong_chi_tieu DESC NULLS LAST;

-- Top 5 sản phẩm bán chạy nhất (chỉ đơn hoàn thành)
SELECT
    sp.ten_sp,
    sp.danh_muc,
    SUM(ct.so_luong)                    AS tong_so_luong_ban,
    SUM(ct.so_luong * ct.don_gia)       AS tong_doanh_thu
FROM san_pham sp
JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
JOIN don_hang dh          ON ct.don_hang_id = dh.id
WHERE dh.trang_thai = 'hoan_thanh'
GROUP BY sp.id, sp.ten_sp, sp.danh_muc
ORDER BY tong_so_luong_ban DESC
LIMIT 5;

-- Doanh thu theo nhân viên kinh doanh
SELECT
    nv.ho_ten               AS nhan_vien,
    COUNT(DISTINCT dh.id)   AS so_don_phu_trach,
    SUM(ct.so_luong * ct.don_gia) AS tong_doanh_thu
FROM nhan_vien nv
LEFT JOIN don_hang dh         ON nv.id = dh.nhan_vien_id
                              AND dh.trang_thai = 'hoan_thanh'
LEFT JOIN chi_tiet_don_hang ct ON dh.id = ct.don_hang_id
WHERE nv.dang_lam = TRUE
GROUP BY nv.id, nv.ho_ten
ORDER BY tong_doanh_thu DESC NULLS LAST;

-- Doanh thu theo danh mục sản phẩm
SELECT
    sp.danh_muc,
    COUNT(DISTINCT sp.id)           AS so_san_pham,
    SUM(ct.so_luong)                AS tong_so_luong_ban,
    SUM(ct.so_luong * ct.don_gia)   AS tong_doanh_thu
FROM san_pham sp
JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
JOIN don_hang dh          ON ct.don_hang_id = dh.id
WHERE dh.trang_thai = 'hoan_thanh'
GROUP BY sp.danh_muc
ORDER BY tong_doanh_thu DESC;

-- Doanh thu theo thành phố khách hàng
SELECT
    kh.thanh_pho,
    COUNT(DISTINCT kh.id)           AS so_khach,
    COUNT(DISTINCT dh.id)           AS so_don_hang,
    SUM(ct.so_luong * ct.don_gia)   AS tong_doanh_thu
FROM khach_hang kh
JOIN don_hang dh            ON kh.id = dh.khach_hang_id
JOIN chi_tiet_don_hang ct   ON dh.id = ct.don_hang_id
WHERE dh.trang_thai = 'hoan_thanh'
GROUP BY kh.thanh_pho
ORDER BY tong_doanh_thu DESC;


-- ============================================================
-- PHẦN 7.5: DEMO CÁC LỖI THƯỜNG GẶP (đã sửa đúng)
-- ============================================================

-- ⚠️ Demo tên cột mơ hồ — lỗi khi không chỉ rõ bảng
-- Bỏ comment để thấy lỗi:
-- SELECT id, ho_ten, ma_don_hang
-- FROM khach_hang
-- JOIN don_hang ON khach_hang.id = don_hang.khach_hang_id;
-- → ERROR: column reference "id" is ambiguous

-- ✅ Sửa: chỉ rõ bảng cho cột "id"
SELECT kh.id, kh.ho_ten, dh.ma_don_hang
FROM khach_hang kh
JOIN don_hang dh ON kh.id = dh.khach_hang_id;

-- ⚠️ Demo LEFT JOIN bị biến thành INNER JOIN do WHERE sai chỗ
-- So sánh hai query sau — kết quả khác nhau!

-- Query 1: WHERE lọc sau JOIN → mất hàng NULL (Ngô Thị Phương bị mất)
SELECT kh.ho_ten, dh.ma_don_hang
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
WHERE dh.trang_thai = 'hoan_thanh';   -- ← loại luôn hàng NULL!

-- Query 2: Điều kiện trong ON → giữ được hàng NULL (Ngô Thị Phương vẫn xuất hiện)
SELECT kh.ho_ten, dh.ma_don_hang
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
                      AND dh.trang_thai = 'hoan_thanh';  -- ← đúng chỗ


-- ============================================================
-- CÂU TRUY VẤN TỔNG HỢP — Thực tế công việc
-- ============================================================

-- Báo cáo tổng hợp khách hàng: hạng VIP/Thường/Mới (sẽ học CASE WHEN ở tuần 8)
-- Hiện tại: chỉ xem tổng chi tiêu
SELECT
    kh.ho_ten                       AS "Khách hàng",
    kh.thanh_pho                    AS "Thành phố",
    kh.so_dien_thoai                AS "SĐT",
    COUNT(DISTINCT dh.id)           AS "Số đơn",
    COALESCE(SUM(ct.so_luong * ct.don_gia), 0) AS "Tổng chi tiêu (VNĐ)"
FROM khach_hang kh
LEFT JOIN don_hang dh         ON kh.id = dh.khach_hang_id
                              AND dh.trang_thai = 'hoan_thanh'
LEFT JOIN chi_tiet_don_hang ct ON dh.id = ct.don_hang_id
GROUP BY kh.id, kh.ho_ten, kh.thanh_pho, kh.so_dien_thoai
ORDER BY "Tổng chi tiêu (VNĐ)" DESC;

-- Tìm khách hàng tiềm năng: đã mua nhưng tổng chưa đến 10 triệu
SELECT
    kh.ho_ten,
    kh.so_dien_thoai,
    COUNT(DISTINCT dh.id)                       AS so_don,
    SUM(ct.so_luong * ct.don_gia)               AS tong_chi_tieu
FROM khach_hang kh
JOIN don_hang dh            ON kh.id = dh.khach_hang_id
JOIN chi_tiet_don_hang ct   ON dh.id = ct.don_hang_id
WHERE dh.trang_thai = 'hoan_thanh'
GROUP BY kh.id, kh.ho_ten, kh.so_dien_thoai
HAVING SUM(ct.so_luong * ct.don_gia) < 10000000
ORDER BY tong_chi_tieu DESC;
