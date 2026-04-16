-- ============================================================
-- TUẦN 6: HÀM TỔNG HỢP & GROUP BY
-- File: 06.Aggregate_Functions_examples.sql
-- Hướng dẫn: Copy từng khối SQL vào DBeaver và nhấn Ctrl+Enter để chạy
-- ============================================================

-- ============================================================
-- SETUP: Tạo dữ liệu mẫu cho tuần này
-- Chạy phần này TRƯỚC KHI chạy các ví dụ bên dưới
-- ============================================================

-- Xóa bảng cũ nếu tồn tại (để chạy lại được)
DROP TABLE IF EXISTS don_hang;
DROP TABLE IF EXISTS nhan_vien;

-- Tạo bảng nhân viên
CREATE TABLE nhan_vien (
    id            SERIAL PRIMARY KEY,
    ho_ten        VARCHAR(100) NOT NULL,
    phong_ban     VARCHAR(50),
    luong         NUMERIC(12,0),
    ngay_vao_lam  DATE,
    email         VARCHAR(100),
    tinh_trang    VARCHAR(20) DEFAULT 'dang_lam'
);

-- Nhập dữ liệu nhân viên (12 người, 4 phòng ban)
INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_vao_lam, email, tinh_trang) VALUES
    ('Trần Thị Mai',     'Kế toán',    15000000, '2019-03-15', 'mai.tran@cty.com',    'dang_lam'),
    ('Nguyễn Văn An',    'Kinh doanh', 20000000, '2020-07-01', 'an.nguyen@cty.com',   'dang_lam'),
    ('Lê Thị Bình',      'Nhân sự',    18000000, '2018-11-20', 'binh.le@cty.com',     'dang_lam'),
    ('Phạm Minh Châu',   'IT',         25000000, '2021-01-10', 'chau.pham@cty.com',   'dang_lam'),
    ('Hoàng Thị Dung',   'Kế toán',    13000000, '2022-05-03', NULL,                  'dang_lam'),
    ('Võ Văn Em',        'Kinh doanh', 22000000, '2017-09-25', 'em.vo@gmail.com',     'dang_lam'),
    ('Đỗ Thị Phương',    'IT',         30000000, '2016-04-14', 'phuong.do@cty.com',   'dang_lam'),
    ('Bùi Văn Giang',    'Nhân sự',    16000000, '2023-02-28', NULL,                  'dang_lam'),
    ('Hồ Thị Hoa',       'Kinh doanh', 17500000, '2021-08-19', 'hoa.ho@gmail.com',    'nghi_viec'),
    ('Ngô Minh Khánh',   'IT',         28000000, '2019-06-30', 'khanh.ngo@cty.com',   'dang_lam'),
    ('Dương Thị Lan',    'Kế toán',    19000000, '2020-12-01', 'lan.duong@cty.com',   'dang_lam'),
    ('Nguyễn Thị Ngọc',  'Kinh doanh', 21000000, '2018-03-22', 'ngoc.nguyen@cty.com', 'dang_lam');

-- Tạo bảng đơn hàng
CREATE TABLE don_hang (
    id             SERIAL PRIMARY KEY,
    ma_don_hang    VARCHAR(20) NOT NULL,
    ma_nhan_vien   INTEGER REFERENCES nhan_vien(id),
    ngay_dat       DATE NOT NULL,
    gia_tri        NUMERIC(12,0) NOT NULL,
    trang_thai     VARCHAR(20) DEFAULT 'hoan_thanh'
);

-- Nhập dữ liệu đơn hàng
INSERT INTO don_hang (ma_don_hang, ma_nhan_vien, ngay_dat, gia_tri, trang_thai) VALUES
    ('DH001', 2,  '2024-01-05', 15000000, 'hoan_thanh'),
    ('DH002', 6,  '2024-01-12', 22000000, 'hoan_thanh'),
    ('DH003', 2,  '2024-01-20', 8000000,  'hoan_thanh'),
    ('DH004', 12, '2024-02-03', 31000000, 'hoan_thanh'),
    ('DH005', 6,  '2024-02-14', 18000000, 'hoan_thanh'),
    ('DH006', 2,  '2024-02-28', 12000000, 'huy'),
    ('DH007', 12, '2024-03-07', 25000000, 'hoan_thanh'),
    ('DH008', 6,  '2024-03-15', 9500000,  'hoan_thanh'),
    ('DH009', 2,  '2024-03-22', 40000000, 'hoan_thanh'),
    ('DH010', 12, '2024-04-01', 17000000, 'hoan_thanh'),
    ('DH011', 6,  '2024-04-10', 28000000, 'hoan_thanh'),
    ('DH012', 2,  '2024-04-18', 11000000, 'hoan_thanh');

-- Kiểm tra dữ liệu đã nhập
SELECT * FROM nhan_vien;
SELECT * FROM don_hang;


-- ============================================================
-- PHẦN 6.1: CÁC HÀM TỔNG HỢP CƠ BẢN — KHÔNG CÓ GROUP BY
-- Chạy trên toàn bộ bảng, kết quả là một hàng
-- ============================================================

-- Tổng kết nhân sự toàn công ty
SELECT
    COUNT(*)                    AS tong_nhan_vien,
    COUNT(email)                AS co_email,
    COUNT(*) - COUNT(email)     AS chua_co_email,
    SUM(luong)                  AS tong_quy_luong,
    ROUND(AVG(luong), 0)        AS luong_trung_binh,
    MIN(luong)                  AS luong_thap_nhat,
    MAX(luong)                  AS luong_cao_nhat
FROM nhan_vien
WHERE tinh_trang = 'dang_lam';

-- Tổng kết đơn hàng đã hoàn thành
SELECT
    COUNT(*)                    AS tong_don_hang,
    SUM(gia_tri)                AS tong_doanh_thu,
    ROUND(AVG(gia_tri), 0)      AS gia_tri_trung_binh,
    MIN(gia_tri)                AS don_nho_nhat,
    MAX(gia_tri)                AS don_lon_nhat
FROM don_hang
WHERE trang_thai = 'hoan_thanh';


-- ============================================================
-- PHẦN 6.2: COUNT — 3 DẠNG KHÁC NHAU
-- ============================================================

-- COUNT(*): Đếm tất cả hàng
SELECT COUNT(*) AS tong_tat_ca FROM nhan_vien;

-- COUNT(cot): Đếm hàng có giá trị, bỏ NULL
-- Kết quả khác COUNT(*) vì có 2 nhân viên chưa có email
SELECT
    COUNT(*)     AS tong_hang,        -- đếm tất cả
    COUNT(email) AS co_email          -- chỉ đếm hàng email không NULL
FROM nhan_vien;

-- COUNT(DISTINCT cot): Đếm giá trị khác nhau
-- Có bao nhiêu phòng ban khác nhau?
SELECT COUNT(DISTINCT phong_ban) AS so_phong_ban FROM nhan_vien;

-- Kết hợp để so sánh
SELECT
    COUNT(*)                        AS tong_nhan_vien,
    COUNT(DISTINCT phong_ban)       AS so_phong_ban,
    COUNT(DISTINCT tinh_trang)      AS so_tinh_trang
FROM nhan_vien;


-- ============================================================
-- PHẦN 6.3: SUM VÀ AVG
-- ============================================================

-- Tổng lương toàn công ty
SELECT SUM(luong) AS tong_quy_luong
FROM nhan_vien
WHERE tinh_trang = 'dang_lam';

-- Lương trung bình (làm tròn)
SELECT ROUND(AVG(luong), 0) AS luong_trung_binh
FROM nhan_vien
WHERE tinh_trang = 'dang_lam';

-- So sánh lương trung bình của người đang làm vs nghỉ việc
SELECT
    tinh_trang,
    COUNT(*)                AS so_nguoi,
    ROUND(AVG(luong), 0)    AS luong_trung_binh
FROM nhan_vien
GROUP BY tinh_trang;


-- ============================================================
-- PHẦN 6.4: MIN VÀ MAX
-- ============================================================

-- Lương cao nhất và thấp nhất
SELECT
    MIN(luong) AS luong_thap_nhat,
    MAX(luong) AS luong_cao_nhat,
    MAX(luong) - MIN(luong) AS khoang_chenh_lech
FROM nhan_vien
WHERE tinh_trang = 'dang_lam';

-- Ngày vào làm sớm nhất và muộn nhất
SELECT
    MIN(ngay_vao_lam) AS vao_som_nhat,
    MAX(ngay_vao_lam) AS vao_muon_nhat
FROM nhan_vien
WHERE tinh_trang = 'dang_lam';

-- Đơn hàng nhỏ nhất và lớn nhất theo từng tháng năm 2024
SELECT
    MIN(gia_tri) AS don_nho_nhat,
    MAX(gia_tri) AS don_lon_nhat
FROM don_hang
WHERE trang_thai = 'hoan_thanh';


-- ============================================================
-- PHẦN 6.5: GROUP BY — NHÓM DỮ LIỆU
-- ============================================================

-- Đếm nhân viên theo từng phòng ban (Pivot Table đơn giản nhất)
SELECT phong_ban, COUNT(*) AS so_nhan_vien
FROM nhan_vien
GROUP BY phong_ban
ORDER BY so_nhan_vien DESC;

-- Bảng tổng hợp đầy đủ theo phòng ban (tương đương Pivot Table)
SELECT
    phong_ban,
    COUNT(*)                    AS so_nhan_vien,
    SUM(luong)                  AS tong_luong,
    ROUND(AVG(luong), 0)        AS luong_trung_binh,
    MIN(luong)                  AS luong_thap_nhat,
    MAX(luong)                  AS luong_cao_nhat
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'
GROUP BY phong_ban
ORDER BY luong_trung_binh DESC;

-- ❌ Demo lỗi phổ biến: quên bỏ ho_ten vào GROUP BY
-- Bỏ comment dưới đây để xem thông báo lỗi thực tế:
-- SELECT phong_ban, ho_ten, COUNT(*)
-- FROM nhan_vien
-- GROUP BY phong_ban;
-- → ERROR: column "nhan_vien.ho_ten" must appear in the GROUP BY clause

-- ✅ Sửa đúng: chỉ lấy cột nhóm và hàm tổng hợp
SELECT phong_ban, COUNT(*) AS so_nhan_vien
FROM nhan_vien
GROUP BY phong_ban;


-- ============================================================
-- PHẦN 6.6: GROUP BY NHIỀU CỘT
-- ============================================================

-- Nhóm theo phòng ban VÀ tình trạng làm việc
SELECT
    phong_ban,
    tinh_trang,
    COUNT(*) AS so_nhan_vien
FROM nhan_vien
GROUP BY phong_ban, tinh_trang
ORDER BY phong_ban, tinh_trang;

-- Thống kê email theo phòng ban (có email / chưa có email)
SELECT
    phong_ban,
    COUNT(*)            AS tong_nhan_vien,
    COUNT(email)        AS co_email,
    COUNT(*) - COUNT(email) AS chua_co_email
FROM nhan_vien
GROUP BY phong_ban
ORDER BY phong_ban;

-- Số đơn hàng theo từng nhân viên (dùng bảng don_hang)
SELECT
    ma_nhan_vien,
    COUNT(*)            AS so_don_hang,
    SUM(gia_tri)        AS tong_gia_tri
FROM don_hang
WHERE trang_thai = 'hoan_thanh'
GROUP BY ma_nhan_vien
ORDER BY tong_gia_tri DESC;


-- ============================================================
-- PHẦN 6.7: HAVING — LỌC SAU KHI NHÓM
-- ============================================================

-- Chỉ lấy phòng ban có từ 3 nhân viên trở lên
SELECT phong_ban, COUNT(*) AS so_nhan_vien
FROM nhan_vien
GROUP BY phong_ban
HAVING COUNT(*) >= 3
ORDER BY so_nhan_vien DESC;

-- Phòng ban có lương trung bình trên 18 triệu
SELECT
    phong_ban,
    ROUND(AVG(luong), 0) AS luong_trung_binh
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'
GROUP BY phong_ban
HAVING AVG(luong) > 18000000
ORDER BY luong_trung_binh DESC;

-- Phòng ban có tổng quỹ lương trên 60 triệu
SELECT
    phong_ban,
    SUM(luong)  AS tong_luong
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'
GROUP BY phong_ban
HAVING SUM(luong) > 60000000
ORDER BY tong_luong DESC;

-- Nhân viên có hơn 3 đơn hàng hoàn thành trong don_hang
SELECT
    ma_nhan_vien,
    COUNT(*) AS so_don
FROM don_hang
WHERE trang_thai = 'hoan_thanh'
GROUP BY ma_nhan_vien
HAVING COUNT(*) > 3
ORDER BY so_don DESC;


-- ============================================================
-- PHẦN 6.8: PHÂN BIỆT WHERE vs HAVING
-- ============================================================

-- WHERE lọc HÀNG (trước khi nhóm):
-- "Chỉ tính những nhân viên đang làm việc"
SELECT phong_ban, ROUND(AVG(luong), 0) AS luong_tb
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'    -- lọc hàng TRƯỚC
GROUP BY phong_ban
ORDER BY luong_tb DESC;

-- HAVING lọc NHÓM (sau khi nhóm và tổng hợp):
-- "Chỉ hiển thị phòng có lương trung bình > 18 triệu"
SELECT phong_ban, ROUND(AVG(luong), 0) AS luong_tb
FROM nhan_vien
GROUP BY phong_ban
HAVING AVG(luong) > 18000000     -- lọc nhóm SAU
ORDER BY luong_tb DESC;

-- Kết hợp cả WHERE lẫn HAVING:
SELECT phong_ban, ROUND(AVG(luong), 0) AS luong_tb
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'    -- WHERE: lọc hàng trước
GROUP BY phong_ban
HAVING AVG(luong) > 18000000     -- HAVING: lọc nhóm sau
ORDER BY luong_tb DESC;

-- ❌ Demo lỗi: Dùng hàm tổng hợp trong WHERE
-- Bỏ comment để xem lỗi thực tế:
-- SELECT phong_ban, COUNT(*) AS so_nhan_vien
-- FROM nhan_vien
-- WHERE COUNT(*) >= 3
-- GROUP BY phong_ban;
-- → ERROR: aggregate functions are not allowed in WHERE


-- ============================================================
-- PHẦN 6.9: ALIAS VÀ THỨ TỰ THỰC THI
-- ============================================================

-- ❌ Lỗi alias trong HAVING (HAVING chạy trước SELECT)
-- Bỏ comment để xem lỗi:
-- SELECT phong_ban, ROUND(AVG(luong), 0) AS luong_tb
-- FROM nhan_vien
-- GROUP BY phong_ban
-- HAVING luong_tb > 18000000;    -- ERROR: column "luong_tb" does not exist

-- ✅ Đúng: Lặp lại hàm tổng hợp trong HAVING
SELECT phong_ban, ROUND(AVG(luong), 0) AS luong_tb
FROM nhan_vien
GROUP BY phong_ban
HAVING AVG(luong) > 18000000;     -- ✅ Dùng AVG(luong), không dùng alias

-- ✅ Alias dùng được trong ORDER BY (ORDER BY chạy sau SELECT)
SELECT phong_ban, ROUND(AVG(luong), 0) AS luong_tb
FROM nhan_vien
GROUP BY phong_ban
HAVING AVG(luong) > 18000000
ORDER BY luong_tb DESC;           -- ✅ ORDER BY có thể dùng alias


-- ============================================================
-- CÂU TRUY VẤN TỔNG HỢP — Thực tế công việc
-- ============================================================

-- Báo cáo nhân sự đầy đủ theo phòng ban
SELECT
    phong_ban                           AS "Phòng ban",
    COUNT(*)                            AS "Số NV",
    COUNT(email)                        AS "Có email",
    SUM(luong)                          AS "Tổng lương (VNĐ)",
    ROUND(AVG(luong), 0)                AS "Lương TB",
    MIN(luong)                          AS "Thấp nhất",
    MAX(luong)                          AS "Cao nhất"
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'
GROUP BY phong_ban
ORDER BY ROUND(AVG(luong), 0) DESC;

-- Xác định phòng nào cần xem xét tăng lương:
-- Phòng đang làm việc, có từ 2 người, lương TB dưới 20 triệu
SELECT
    phong_ban,
    COUNT(*)                    AS so_nhan_vien,
    ROUND(AVG(luong), 0)        AS luong_trung_binh
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'
GROUP BY phong_ban
HAVING COUNT(*) >= 2
   AND AVG(luong) < 20000000
ORDER BY luong_trung_binh ASC;
