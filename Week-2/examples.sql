-- ============================================================
-- TUẦN 2: File SQL Thực Hành — Chạy Thật Trong DBeaver!
-- ============================================================
-- Khác với Tuần 1 (chỉ đọc), file này bạn CHẠY THẬT.
--
-- Cách chạy trong DBeaver:
--   Ctrl+Enter = Chạy câu SQL tại vị trí con trỏ (câu lẻ)
--   Alt+X      = Chạy toàn bộ script từ đầu đến cuối
--
-- LƯU Ý: Chạy từng PHẦN một, đọc kết quả rồi mới chạy phần tiếp theo.
-- ============================================================


-- ============================================================
-- PHẦN 1: Kiểm Tra Kết Nối & Thông Tin Hệ Thống
-- ============================================================
-- Mục đích: Xác nhận PostgreSQL hoạt động và bạn đã kết nối thành công.
-- Các câu này KHÔNG cần bảng — chúng truy vấn thẳng hệ thống.
-- ============================================================

-- 1.1 Xem phiên bản PostgreSQL đang dùng
-- Giống: xem "About" trong Excel để kiểm tra version
SELECT version();
-- Kết quả mong đợi: chuỗi dài như "PostgreSQL 16.2, compiled by..."


-- 1.2 Xem ngày hôm nay
-- Trong Excel: =TODAY()
SELECT current_date;
-- Kết quả mong đợi: ngày hôm nay theo dạng YYYY-MM-DD (ví dụ: 2026-04-13)


-- 1.3 Xem ngày và giờ hiện tại (đầy đủ)
-- Trong Excel: =NOW()
SELECT now();
-- Kết quả mong đợi: "2026-04-13 14:30:25.123456+07"


-- 1.4 Tính toán đơn giản — PostgreSQL như máy tính!
-- Trong Excel: gõ =1+1 vào ô
SELECT 1 + 1 AS ket_qua;
-- Kết quả mong đợi: 2
-- Lưu ý: "AS ket_qua" đặt tên cho cột kết quả — giống đặt tiêu đề cột


-- 1.5 Tính toán thực tế hơn
SELECT 52 * 5 AS tong_ngay_lam_trong_nam;
-- Kết quả mong đợi: 260 (52 tuần × 5 ngày/tuần)


-- 1.6 Ghép chuỗi văn bản
-- Trong Excel: =CONCATENATE("Xin chào, ", "PostgreSQL!") hoặc ="Xin chào, "&"PostgreSQL!"
-- Trong PostgreSQL: dùng || (hai thanh đứng) để nối chuỗi
SELECT 'Xin chào, ' || 'PostgreSQL!' AS loi_chao;
-- Kết quả mong đợi: "Xin chào, PostgreSQL!"


-- 1.7 Kết hợp tính toán và chuỗi
SELECT
    'Tuần ' || 2 AS tuan_hoc,
    current_date AS ngay_hoc;
-- Kết quả mong đợi: "Tuần 2" | ngày hôm nay


-- ============================================================
-- PHẦN 2: Tạo Database hoc_sql
-- ============================================================
-- Mục đích: Tạo database riêng để học — không dùng chung với postgres mặc định.
--
-- QUAN TRỌNG: Phần này chạy khi đang kết nối vào database "postgres" (mặc định).
-- Sau khi tạo xong, chuyển kết nối sang hoc_sql trong DBeaver.
-- ============================================================

-- 2.1 Tạo database mới tên hoc_sql
-- Đọc như tiếng Anh: "Create database hoc_sql"
-- Trong Excel: giống Ctrl+N để tạo workbook mới
CREATE DATABASE hoc_sql;
-- Kết quả thành công: DBeaver hiện thông báo "1 statement executed successfully"
-- Sau đó: click phải "Databases" → "Refresh" → thấy hoc_sql xuất hiện


-- 2.2 Tạo database thứ hai để thử nghiệm
CREATE DATABASE thu_nghiem;
-- Đây là database thử nghiệm — tuần sau có thể xóa nếu muốn


-- ============================================================
-- PHẦN 3: Chuyển Sang database hoc_sql
-- ============================================================
-- Không có lệnh SQL để "chuyển" database — bạn làm trong giao diện DBeaver:
--
-- Cách 1: Double-click vào "hoc_sql" trong Database Navigator
-- Cách 2: Click phải vào "hoc_sql" → "Set as Default"
-- Cách 3: Mở SQL Editor mới từ hoc_sql (click phải hoc_sql → SQL Editor)
--
-- SAU KHI CHUYỂN, kiểm tra bằng lệnh này:
SELECT current_database();
-- Kết quả mong đợi: "hoc_sql"
-- Nếu thấy "postgres" → bạn chưa chuyển — hãy chuyển trước!


-- ============================================================
-- PHẦN 4: Tạo Bảng nhan_vien (Preview Tuần 3)
-- ============================================================
-- Mục đích: Tạo bảng dữ liệu đầu tiên trong hoc_sql.
-- Tuần 3 sẽ giải thích từng từ khóa chi tiết — hôm nay cứ chạy và xem kết quả!
--
-- ĐẢM BẢO: Đang kết nối vào "hoc_sql" trước khi chạy phần này!
-- ============================================================

-- 4.1 Tạo bảng nhan_vien
-- Giống tạo sheet mới trong Excel và khai báo tên từng cột
CREATE TABLE nhan_vien (
    id        SERIAL PRIMARY KEY,    -- STT tự tăng (1, 2, 3...) — không bao giờ trùng
    ho_ten    VARCHAR(100) NOT NULL, -- Tên nhân viên, tối đa 100 ký tự, bắt buộc nhập
    phong_ban VARCHAR(50),           -- Phòng ban, tối đa 50 ký tự, có thể để trống
    luong     NUMERIC(12,2),         -- Lương: tối đa 12 chữ số, 2 chữ số thập phân
    ngay_sinh DATE,                  -- Ngày sinh theo dạng YYYY-MM-DD
    email     VARCHAR(150)           -- Email, có thể để trống (NULL)
);
-- Kết quả thành công: "Table nhan_vien created"
-- Trong Navigator: hoc_sql → Schemas → public → Tables → nhan_vien (sau khi Refresh)


-- ============================================================
-- PHẦN 5: Nhập Dữ Liệu — 6 Nhân Viên Từ Tuần 1
-- ============================================================
-- Mục đích: Đưa dữ liệu vào bảng vừa tạo.
-- Đây là những nhân viên bạn đã quen từ các ví dụ Tuần 1 — giờ họ "thật" rồi!
-- ============================================================

-- 5.1 Nhập 6 nhân viên cùng một lúc (multi-row INSERT)
-- Giống nhập từng hàng vào Excel, nhưng một lần nhập nhiều hàng
INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_sinh, email) VALUES
    ('Trần Thị Mai',   'Kế toán',    15000000, '1995-03-20', 'mai.tran@cty.com'),
    ('Nguyễn Văn An',  'Kinh doanh', 20000000, '1990-07-15', 'an.nguyen@cty.com'),
    ('Lê Thị Bình',    'Nhân sự',    18000000, '1992-11-03', 'binh.le@cty.com'),
    ('Phạm Minh Châu', 'IT',         25000000, '1988-01-25', 'chau.pham@cty.com'),
    ('Hoàng Thị Dung', 'Kế toán',    13000000, '1996-09-10', NULL),  -- Không có email → NULL
    ('Võ Văn Em',      'Kinh doanh', 22000000, '1993-05-30', 'em.vo@cty.com');
-- Kết quả thành công: "6 rows affected" — đã thêm 6 hàng


-- ============================================================
-- PHẦN 6: SELECT — Xem Dữ Liệu Thật Lần Đầu Tiên!
-- ============================================================
-- Đây là khoảnh khắc "Aha!" — lần đầu tiên bạn thấy dữ liệu thật
-- từ một database do chính bạn tạo ra.
-- ============================================================

-- 6.1 Xem toàn bộ bảng — câu SELECT cơ bản nhất
-- Trong Excel: giống nhìn vào sheet không lọc, không sắp xếp gì
-- Dấu * nghĩa là "tất cả các cột"
SELECT * FROM nhan_vien;
-- Kết quả mong đợi: 6 hàng, 6 cột (id, ho_ten, phong_ban, luong, ngay_sinh, email)


-- 6.2 Đếm có bao nhiêu nhân viên
-- Trong Excel: =COUNTA(A2:A100)
SELECT COUNT(*) AS so_nhan_vien FROM nhan_vien;
-- Kết quả mong đợi: 6


-- 6.3 Xem danh sách có sắp xếp theo lương (cao → thấp)
-- Trong Excel: chọn cột lương → Sort → Largest to Smallest
SELECT ho_ten, phong_ban, luong
FROM nhan_vien
ORDER BY luong DESC;
-- Kết quả mong đợi:
-- Phạm Minh Châu  | IT         | 25000000
-- Võ Văn Em       | Kinh doanh | 22000000
-- Nguyễn Văn An   | Kinh doanh | 20000000
-- Lê Thị Bình     | Nhân sự    | 18000000
-- Trần Thị Mai    | Kế toán    | 15000000
-- Hoàng Thị Dung  | Kế toán    | 13000000


-- 6.4 Chỉ xem nhân viên phòng Kế toán
-- Trong Excel: Filter → Phòng ban = "Kế toán"
SELECT *
FROM nhan_vien
WHERE phong_ban = 'Kế toán';
-- Kết quả mong đợi: 2 hàng (Trần Thị Mai và Hoàng Thị Dung)


-- 6.5 Tìm nhân viên lương trên 18 triệu
-- Trong Excel: Filter → Lương > 18000000
SELECT ho_ten, luong
FROM nhan_vien
WHERE luong > 18000000;
-- Kết quả mong đợi: 3 người (An, Châu, Em)


-- 6.6 Đếm nhân viên theo phòng ban
-- Trong Excel: PivotTable → Rows: Phòng ban, Values: Count
SELECT phong_ban, COUNT(*) AS so_nguoi
FROM nhan_vien
GROUP BY phong_ban
ORDER BY so_nguoi DESC;
-- Kết quả mong đợi:
-- Kinh doanh | 2
-- Kế toán    | 2
-- IT         | 1
-- Nhân sự    | 1


-- 6.7 Tính lương trung bình toàn công ty
-- Trong Excel: =AVERAGE(D2:D7)
SELECT
    COUNT(*)              AS tong_nhan_vien,
    AVG(luong)            AS luong_trung_binh,
    MAX(luong)            AS luong_cao_nhat,
    MIN(luong)            AS luong_thap_nhat,
    SUM(luong)            AS tong_quy_luong
FROM nhan_vien;
-- Kết quả mong đợi:
-- 6 | 18833333.33 | 25000000 | 13000000 | 113000000


-- ============================================================
-- PHẦN 7: Câu SQL Từ Week-1/examples.sql — Chạy Thật!
-- ============================================================
-- Tuần 1 bạn chỉ đọc các câu SQL này. Bây giờ chạy chúng thật!
-- ============================================================

-- 7.1 Chọn chỉ một vài cột (không lấy tất cả)
-- Trong Excel: ẩn các cột không cần
SELECT ho_ten, luong FROM nhan_vien;


-- 7.2 Danh sách phòng ban không trùng lặp
-- Trong Excel: Data → Remove Duplicates trên cột Phòng ban
SELECT DISTINCT phong_ban FROM nhan_vien;
-- Kết quả mong đợi: 4 phòng ban (không trùng lặp)


-- 7.3 Sắp xếp theo nhiều tiêu chí
-- Trong Excel: Sort → thêm nhiều cấp độ sort
SELECT ho_ten, phong_ban, luong
FROM nhan_vien
ORDER BY phong_ban ASC, luong DESC;
-- Giải thích: Sắp theo phòng ban A→Z, trong mỗi phòng sắp lương cao→thấp


-- 7.4 Kết hợp WHERE và ORDER BY
-- Trong Excel: Filter "Kế toán" rồi Sort lương từ cao xuống thấp
SELECT ho_ten, luong
FROM nhan_vien
WHERE phong_ban = 'Kế toán'
ORDER BY luong DESC;


-- 7.5 Đếm email (không tính NULL)
-- COUNT(*) đếm tất cả hàng
-- COUNT(email) chỉ đếm hàng có email (bỏ qua NULL)
SELECT
    COUNT(*)     AS tong_nhan_vien,
    COUNT(email) AS co_email
FROM nhan_vien;
-- Kết quả mong đợi: 6 | 5 (Hoàng Thị Dung không có email)


-- ============================================================
-- PHẦN 8: Dọn Dẹp (Tùy Chọn)
-- ============================================================
-- Nếu bạn muốn xóa database thu_nghiem đã tạo ở Phần 2:
-- CẢNH BÁO: Lệnh DROP xóa vĩnh viễn, không thể phục hồi!
-- Chạy lệnh này khi đang kết nối vào "postgres" (không phải hoc_sql)
-- ============================================================

-- Xóa database thử nghiệm (tùy chọn)
-- DROP DATABASE thu_nghiem;
-- (Bỏ comment dòng trên nếu muốn xóa)


-- ============================================================
-- TỔNG KẾT TUẦN 2
-- ============================================================
-- Những lệnh bạn đã dùng trong tuần này:
--
-- SELECT version()         → xem phiên bản PostgreSQL
-- SELECT current_date      → xem ngày hôm nay
-- SELECT now()             → xem ngày giờ đầy đủ
-- SELECT ... AS ten_cot    → đặt tên cho cột kết quả
-- CREATE DATABASE ten_db   → tạo database mới
-- CREATE TABLE ...         → tạo bảng (Tuần 3 học kỹ hơn)
-- INSERT INTO ...          → nhập dữ liệu (Tuần 3 học kỹ hơn)
-- SELECT * FROM bang       → xem toàn bộ bảng
-- SELECT ... WHERE ...     → lọc dữ liệu (Tuần 5 học kỹ hơn)
-- SELECT ... ORDER BY ...  → sắp xếp (Tuần 5 học kỹ hơn)
-- COUNT(), AVG(), SUM()    → đếm và tính tổng (Tuần 6 học kỹ hơn)
--
-- Tuần 3 tiếp theo: CREATE TABLE và INSERT chi tiết!
-- ============================================================
