-- ============================================================
-- TUẦN 5: LỌC & SẮP XẾP DỮ LIỆU
-- File: 05.Filter_Data_examples.sql
-- Hướng dẫn: Copy từng khối SQL vào DBeaver và nhấn Ctrl+Enter để chạy
-- ============================================================

-- ============================================================
-- SETUP: Tạo dữ liệu mẫu cho tuần này
-- Chạy phần này TRƯỚC KHI chạy các ví dụ bên dưới
-- ============================================================

-- Xóa bảng nếu đã tồn tại (để chạy lại được)
DROP TABLE IF EXISTS don_hang;
DROP TABLE IF EXISTS nhan_vien;

-- Tạo bảng nhân viên
CREATE TABLE nhan_vien (
    id          SERIAL PRIMARY KEY,
    ho_ten      VARCHAR(100) NOT NULL,
    phong_ban   VARCHAR(50),
    luong       NUMERIC(12,0),
    ngay_vao_lam DATE,
    email       VARCHAR(100),
    tinh_trang  VARCHAR(20) DEFAULT 'dang_lam'
);

-- Nhập dữ liệu mẫu
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

-- Kiểm tra dữ liệu đã nhập
SELECT * FROM nhan_vien;


-- ============================================================
-- PHẦN 5.1: WHERE CƠ BẢN
-- ============================================================

-- Ví dụ 1: Lọc theo phòng ban cụ thể
-- Giống Filter cột "Phòng ban" → chọn "IT" trong Excel
SELECT ho_ten, luong, phong_ban
FROM nhan_vien
WHERE phong_ban = 'IT';

-- Ví dụ 2: Lọc nhân viên lương trên 20 triệu
SELECT ho_ten, luong, phong_ban
FROM nhan_vien
WHERE luong > 20000000;

-- Ví dụ 3: Lọc nhân viên đang làm việc
SELECT ho_ten, phong_ban, tinh_trang
FROM nhan_vien
WHERE tinh_trang = 'dang_lam';


-- ============================================================
-- PHẦN 5.2: TOÁN TỬ SO SÁNH
-- ============================================================

-- = (bằng)
SELECT ho_ten, luong FROM nhan_vien
WHERE luong = 18000000;

-- != (không bằng) — lấy tất cả trừ phòng Kế toán
SELECT ho_ten, phong_ban FROM nhan_vien
WHERE phong_ban != 'Kế toán';

-- > (lớn hơn) — lương trên 20 triệu
SELECT ho_ten, luong FROM nhan_vien
WHERE luong > 20000000;

-- >= (lớn hơn hoặc bằng) — lương từ 20 triệu trở lên
SELECT ho_ten, luong FROM nhan_vien
WHERE luong >= 20000000;

-- < (nhỏ hơn) — lương dưới 18 triệu
SELECT ho_ten, luong FROM nhan_vien
WHERE luong < 18000000;

-- So sánh ngày tháng
SELECT ho_ten, ngay_vao_lam FROM nhan_vien
WHERE ngay_vao_lam >= '2021-01-01';   -- Nhân viên vào từ năm 2021 trở đi


-- ============================================================
-- PHẦN 5.3: AND / OR / NOT
-- ============================================================

-- AND: Phòng Kinh doanh VÀ lương trên 20 triệu
SELECT ho_ten, luong, phong_ban
FROM nhan_vien
WHERE phong_ban = 'Kinh doanh' AND luong > 20000000;

-- OR: Phòng IT HOẶC phòng Kinh doanh
SELECT ho_ten, phong_ban
FROM nhan_vien
WHERE phong_ban = 'IT' OR phong_ban = 'Kinh doanh';

-- NOT: Không phải phòng Kế toán
SELECT ho_ten, phong_ban
FROM nhan_vien
WHERE NOT phong_ban = 'Kế toán';

-- ⚠️ Bẫy AND + OR không có ngoặc — SAI
-- Câu hỏi: Nhân viên (Kinh doanh hoặc IT) có lương trên 20 triệu
-- Viết sai — máy hiểu: Kinh doanh bất kỳ lương, OR (IT và lương > 20tr)
SELECT ho_ten, luong, phong_ban FROM nhan_vien
WHERE phong_ban = 'Kinh doanh' OR phong_ban = 'IT' AND luong > 20000000;

-- ✅ Viết đúng — dùng ngoặc để nhóm OR
SELECT ho_ten, luong, phong_ban FROM nhan_vien
WHERE (phong_ban = 'Kinh doanh' OR phong_ban = 'IT')
  AND luong > 20000000;

-- Kết hợp 3 điều kiện
SELECT ho_ten, luong, phong_ban, tinh_trang
FROM nhan_vien
WHERE phong_ban = 'IT'
  AND luong >= 25000000
  AND tinh_trang = 'dang_lam';


-- ============================================================
-- PHẦN 5.4: BETWEEN VÀ IN
-- ============================================================

-- BETWEEN: Lọc lương từ 15 triệu đến 22 triệu
SELECT ho_ten, luong
FROM nhan_vien
WHERE luong BETWEEN 15000000 AND 22000000;
-- Tương đương: WHERE luong >= 15000000 AND luong <= 22000000

-- BETWEEN với ngày tháng: Nhân viên vào làm từ 2019 đến 2021
SELECT ho_ten, ngay_vao_lam
FROM nhan_vien
WHERE ngay_vao_lam BETWEEN '2019-01-01' AND '2021-12-31'
ORDER BY ngay_vao_lam;

-- IN: Lọc nhiều phòng ban cùng lúc
SELECT ho_ten, phong_ban
FROM nhan_vien
WHERE phong_ban IN ('IT', 'Kinh doanh');
-- Ngắn hơn: WHERE phong_ban = 'IT' OR phong_ban = 'Kinh doanh'

-- NOT IN: Loại trừ các phòng ban
SELECT ho_ten, phong_ban
FROM nhan_vien
WHERE phong_ban NOT IN ('Kế toán', 'Nhân sự');


-- ============================================================
-- PHẦN 5.5: LIKE VÀ ILIKE
-- ============================================================

-- % ở cuối: Tìm họ Nguyễn
SELECT ho_ten FROM nhan_vien
WHERE ho_ten LIKE 'Nguyễn%';

-- % ở đầu: Tìm email kết thúc bằng @gmail.com
SELECT ho_ten, email FROM nhan_vien
WHERE email LIKE '%@gmail.com';

-- % ở cả hai đầu: Tìm chứa "Văn" ở bất kỳ vị trí nào
SELECT ho_ten FROM nhan_vien
WHERE ho_ten LIKE '%Văn%';

-- % ở cuối và có domain cty.com
SELECT ho_ten, email FROM nhan_vien
WHERE email LIKE '%@cty.com';

-- ILIKE: Không phân biệt hoa thường (PostgreSQL)
SELECT ho_ten FROM nhan_vien
WHERE ho_ten ILIKE 'nguyễn%';   -- Tìm được dù viết thường

-- NOT LIKE: Tìm email KHÔNG phải gmail
SELECT ho_ten, email FROM nhan_vien
WHERE email NOT LIKE '%@gmail.com'
  AND email IS NOT NULL;   -- Loại NULL ra để kết quả sạch hơn


-- ============================================================
-- PHẦN 5.6: IS NULL VÀ IS NOT NULL
-- ============================================================

-- Nhân viên chưa có email
SELECT ho_ten, phong_ban, email
FROM nhan_vien
WHERE email IS NULL;

-- Nhân viên đã có email
SELECT ho_ten, email
FROM nhan_vien
WHERE email IS NOT NULL;

-- ⚠️ Sai — dùng = với NULL luôn trả về kết quả rỗng!
SELECT ho_ten FROM nhan_vien
WHERE email = NULL;    -- 0 hàng dù có nhân viên không có email

-- ✅ Đúng
SELECT ho_ten FROM nhan_vien
WHERE email IS NULL;


-- ============================================================
-- PHẦN 5.7: ORDER BY
-- ============================================================

-- Sắp xếp lương tăng dần (thấp → cao)
SELECT ho_ten, luong, phong_ban
FROM nhan_vien
ORDER BY luong ASC;

-- Sắp xếp lương giảm dần (cao → thấp)
SELECT ho_ten, luong, phong_ban
FROM nhan_vien
ORDER BY luong DESC;

-- Sắp xếp theo tên A→Z
SELECT ho_ten FROM nhan_vien
ORDER BY ho_ten ASC;

-- Sắp xếp theo phòng ban A→Z, rồi lương cao→thấp trong mỗi phòng
SELECT ho_ten, phong_ban, luong
FROM nhan_vien
ORDER BY phong_ban ASC, luong DESC;

-- Sắp xếp theo ngày vào làm (mới nhất lên trước)
SELECT ho_ten, ngay_vao_lam
FROM nhan_vien
ORDER BY ngay_vao_lam DESC;

-- NULLS LAST: Đưa người chưa có email xuống cuối
SELECT ho_ten, email
FROM nhan_vien
ORDER BY email ASC NULLS LAST;


-- ============================================================
-- PHẦN 5.8: KẾT HỢP WHERE + ORDER BY + LIMIT
-- ============================================================

-- Top 3 nhân viên lương cao nhất toàn công ty
SELECT ho_ten, luong, phong_ban
FROM nhan_vien
ORDER BY luong DESC
LIMIT 3;

-- Top 3 nhân viên lương cao nhất trong phòng IT
SELECT ho_ten, luong
FROM nhan_vien
WHERE phong_ban = 'IT'
ORDER BY luong DESC
LIMIT 3;

-- Nhân viên lâu năm nhất (vào làm sớm nhất)
SELECT ho_ten, ngay_vao_lam, phong_ban
FROM nhan_vien
ORDER BY ngay_vao_lam ASC
LIMIT 1;

-- Nhân viên mới nhất công ty đang làm việc
SELECT ho_ten, ngay_vao_lam, phong_ban
FROM nhan_vien
WHERE tinh_trang = 'dang_lam'
ORDER BY ngay_vao_lam DESC
LIMIT 1;

-- 5 nhân viên lương thấp nhất trong phòng Kinh doanh (xem xét điều chỉnh)
SELECT ho_ten, luong
FROM nhan_vien
WHERE phong_ban = 'Kinh doanh'
  AND tinh_trang = 'dang_lam'
ORDER BY luong ASC
LIMIT 5;


-- ============================================================
-- PHẦN 5.9: ALIAS VÀ THỨ TỰ THỰC THI
-- ============================================================

-- ❌ SAI: Không dùng alias trong WHERE
-- Bỏ comment để thấy lỗi:
-- SELECT ho_ten, luong * 0.9 AS luong_sau_thue
-- FROM nhan_vien
-- WHERE luong_sau_thue > 13500000;   -- ERROR: column "luong_sau_thue" does not exist

-- ✅ ĐÚNG: Lặp lại biểu thức trong WHERE
SELECT ho_ten, luong * 0.9 AS luong_sau_thue
FROM nhan_vien
WHERE luong * 0.9 > 13500000;

-- ✅ Alias dùng được trong ORDER BY (ORDER BY chạy sau SELECT)
SELECT ho_ten, luong * 0.9 AS luong_sau_thue
FROM nhan_vien
ORDER BY luong_sau_thue DESC;


-- ============================================================
-- CÂU TRUY VẤN TỔNG HỢP — Thực tế công việc
-- ============================================================

-- Báo cáo: Danh sách nhân viên IT đang làm, sắp theo thâm niên
SELECT
    ho_ten          AS "Họ và tên",
    luong           AS "Lương (VNĐ)",
    ngay_vao_lam    AS "Ngày vào làm",
    email           AS "Email"
FROM nhan_vien
WHERE phong_ban = 'IT'
  AND tinh_trang = 'dang_lam'
ORDER BY ngay_vao_lam ASC;

-- Báo cáo: Nhân viên lương trên 18 triệu, chưa có email (cần cập nhật)
SELECT
    ho_ten          AS "Họ và tên",
    phong_ban       AS "Phòng ban",
    luong           AS "Lương"
FROM nhan_vien
WHERE luong > 18000000
  AND email IS NULL
ORDER BY luong DESC;
