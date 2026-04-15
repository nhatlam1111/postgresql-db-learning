-- ================================================================
-- TUẦN 1: Ví Dụ SQL Đầu Tiên
-- Chương trình học PostgreSQL căn bản
-- ================================================================
--
-- MỤC ĐÍCH CỦA FILE NÀY:
--   Tuần 1 chưa cần chạy những câu lệnh này.
--   Hãy ĐỌC từng câu, đọc comment giải thích, và thử đoán
--   kết quả trước khi xem đáp án trong exercises.md.
--
--   Tuần 2 sau khi cài PostgreSQL xong, bạn sẽ quay lại đây
--   và CHẠY THẬT từng câu lệnh để kiểm chứng.
--
-- CÁCH ĐỌC FILE NÀY:
--   - Dòng bắt đầu bằng "--" là COMMENT (ghi chú) — SQL bỏ qua
--   - Dòng không có "--" ở đầu là câu lệnh SQL thật
--   - Mỗi câu SQL kết thúc bằng dấu chấm phẩy ";"
--
-- ================================================================


-- ================================================================
-- DỮ LIỆU MẪU — BẢNG NHÂN VIÊN
-- ================================================================
--
-- Tất cả ví dụ dưới đây dùng bảng "nhan_vien" với nội dung:
--
--  id │    ho_ten      │ phong_ban  │   luong    │  ngay_sinh  │ email
-- ────┼────────────────┼────────────┼────────────┼─────────────┼──────────────────
--   1 │ Trần Thị Mai   │ Kế toán    │ 15,000,000 │ 1995-03-20  │ mai.tran@cty.com
--   2 │ Nguyễn Văn An  │ Kinh doanh │ 20,000,000 │ 1990-07-15  │ an.nguyen@cty.com
--   3 │ Lê Thị Bình    │ Nhân sự    │ 18,000,000 │ 1992-11-03  │ binh.le@cty.com
--   4 │ Phạm Minh Châu │ IT         │ 25,000,000 │ 1988-01-25  │ chau.pham@cty.com
--   5 │ Hoàng Thị Dung │ Kế toán    │ 13,000,000 │ 1996-09-10  │ (NULL - trống)
--   6 │ Võ Văn Em      │ Kinh doanh │ 22,000,000 │ 1993-05-30  │ em.vo@cty.com
--
-- ================================================================


-- ================================================================
-- PHẦN 1: NHÌN DỮ LIỆU — SELECT
-- (Giống việc mở file Excel và nhìn vào sheet)
-- ================================================================

-- ------------------------------------------------------------
-- 1.1  Xem TẤT CẢ dữ liệu trong bảng
-- ------------------------------------------------------------
-- Ý nghĩa: "Cho tôi xem tất cả từ bảng nhân viên"
-- * = "tất cả cột"
--
-- Trong Excel: giống việc mở sheet và nhìn toàn bộ dữ liệu
-- (tương đương nhấn Ctrl+End để thấy toàn bộ vùng dữ liệu)

SELECT * FROM nhan_vien;

-- Kết quả: 6 hàng, 6 cột — toàn bộ bảng


-- ------------------------------------------------------------
-- 1.2  Chỉ xem MỘT SỐ CỘT nhất định
-- ------------------------------------------------------------
-- Ý nghĩa: "Chỉ cho tôi xem họ tên và lương"
--
-- Trong Excel: giống ẩn tất cả cột trừ cột "họ tên" và "lương"
-- (hoặc dùng Ctrl+Click để chọn đúng 2 cột đó)

SELECT ho_ten, luong FROM nhan_vien;

-- Kết quả: 6 hàng, CHỈ 2 cột (ho_ten và luong)


-- ------------------------------------------------------------
-- 1.3  Đặt tên hiển thị cho cột (Alias)
-- ------------------------------------------------------------
-- Ý nghĩa: Hiển thị dữ liệu nhưng đổi tên tiêu đề cột
-- AS = "hiển thị với tên là..."
--
-- Trong Excel: giống gõ tiêu đề cột theo ý muốn ở hàng 1

SELECT
    ho_ten      AS "Họ và tên",
    phong_ban   AS "Phòng ban",
    luong       AS "Mức lương (VNĐ)"
FROM nhan_vien;

-- Kết quả: tiêu đề cột hiển thị tiếng Việt có dấu thay vì tên kỹ thuật


-- ------------------------------------------------------------
-- 1.4  Tính toán ngay trong câu SELECT
-- ------------------------------------------------------------
-- Ý nghĩa: Tính lương sau khi trừ thuế 10%
--
-- Trong Excel: giống thêm cột công thức =C2*(1-0.1)
-- Điểm khác: trong SQL không cần tạo cột mới trong bảng,
-- kết quả chỉ hiển thị tạm thời trong truy vấn này

SELECT
    ho_ten,
    luong                   AS "Lương gross",
    luong * 0.10            AS "Thuế (10%)",
    luong - luong * 0.10    AS "Lương thực nhận"
FROM nhan_vien;

-- Kết quả: 4 cột — tên, lương gốc, tiền thuế, lương sau thuế


-- ------------------------------------------------------------
-- 1.5  DISTINCT — Lấy giá trị không trùng
-- ------------------------------------------------------------
-- Ý nghĩa: Liệt kê các phòng ban (không lặp lại)
-- DISTINCT = "khác nhau, không trùng"
--
-- Trong Excel: giống Data > Remove Duplicates
-- hoặc dùng Advanced Filter "Unique records only"

SELECT DISTINCT phong_ban FROM nhan_vien;

-- Kết quả: 4 hàng (Kế toán, Kinh doanh, Nhân sự, IT)
-- Mặc dù "Kế toán" và "Kinh doanh" xuất hiện 2 lần trong bảng gốc,
-- DISTINCT chỉ giữ lại 1 lần mỗi giá trị


-- ================================================================
-- PHẦN 2: LỌC DỮ LIỆU — WHERE
-- (Giống tính năng Filter trong Excel)
-- ================================================================

-- ------------------------------------------------------------
-- 2.1  Lọc theo chuỗi ký tự (TEXT)
-- ------------------------------------------------------------
-- Ý nghĩa: Chỉ lấy nhân viên phòng IT
-- LƯU Ý: Giá trị chuỗi phải đặt trong dấu nháy đơn 'như thế này'
--         (Excel dùng "dấu nháy kép", SQL dùng 'dấu nháy đơn')
--
-- Trong Excel: giống Filter cột "Phòng ban" → chọn "IT"

SELECT * FROM nhan_vien
WHERE phong_ban = 'IT';

-- Kết quả: 1 hàng — chỉ Phạm Minh Châu


-- ------------------------------------------------------------
-- 2.2  Lọc theo số (NUMBER)
-- ------------------------------------------------------------
-- Ý nghĩa: Chỉ lấy nhân viên có lương trên 18 triệu
-- Các toán tử: >  >=  <  <=  =  <> (khác)
--
-- Trong Excel: giống Filter → Number Filters → Greater Than → 18000000

SELECT * FROM nhan_vien
WHERE luong > 18000000;

-- Kết quả: 3 hàng (Nguyễn Văn An, Phạm Minh Châu, Võ Văn Em)
-- LƯU Ý: Lê Thị Bình có lương ĐÚNG BẰNG 18tr → không lọc ra
--         Muốn bao gồm cả bằng 18tr, phải dùng: WHERE luong >= 18000000


-- ------------------------------------------------------------
-- 2.3  Lọc theo ngày (DATE)
-- ------------------------------------------------------------
-- Ý nghĩa: Nhân viên sinh sau ngày 01/01/1993
-- Format ngày: 'YYYY-MM-DD' (năm-tháng-ngày)
--
-- Trong Excel: giống Filter → Date Filters → After → 1/1/1993

SELECT ho_ten, ngay_sinh FROM nhan_vien
WHERE ngay_sinh > '1993-01-01';

-- Kết quả: 3 hàng (Trần Thị Mai 1995, Võ Văn Em 1993-05-30, Hoàng Thị Dung 1996)
-- LƯU Ý: Võ Văn Em sinh ngày 1993-05-30, sau 1993-01-01 nên được lọc ra


-- ------------------------------------------------------------
-- 2.4  Kết hợp nhiều điều kiện với AND
-- ------------------------------------------------------------
-- Ý nghĩa: Nhân viên phòng Kế toán VÀ có lương > 14 triệu
-- AND = cả hai điều kiện đều phải đúng
--
-- Trong Excel: giống Filter → lọc "Kế toán" → rồi lọc thêm lương > 14tr
--              (hoặc dùng Advanced Filter với nhiều điều kiện AND)

SELECT * FROM nhan_vien
WHERE phong_ban = 'Kế toán'
  AND luong > 14000000;

-- Kết quả: 1 hàng (chỉ Trần Thị Mai — 15tr, thỏa cả 2 điều kiện)
-- Hoàng Thị Dung (13tr) không thỏa điều kiện lương > 14tr


-- ------------------------------------------------------------
-- 2.5  Kết hợp điều kiện với OR
-- ------------------------------------------------------------
-- Ý nghĩa: Nhân viên phòng IT HOẶC phòng Nhân sự
-- OR = ít nhất một trong các điều kiện đúng
--
-- Trong Excel: giống Filter → chọn nhiều giá trị cùng lúc (check nhiều ô)

SELECT * FROM nhan_vien
WHERE phong_ban = 'IT'
   OR phong_ban = 'Nhân sự';

-- Kết quả: 2 hàng (Phạm Minh Châu + Lê Thị Bình)


-- ------------------------------------------------------------
-- 2.6  Lọc trong một danh sách — IN
-- ------------------------------------------------------------
-- Ý nghĩa: Nhân viên thuộc một trong các phòng ban này
-- IN (...) = viết gọn hơn nhiều lần OR
--
-- Trong Excel: giống Filter → chọn nhiều checkbox cùng lúc

SELECT * FROM nhan_vien
WHERE phong_ban IN ('IT', 'Nhân sự', 'Kinh doanh');

-- Kết quả: 4 hàng (tất cả trừ Kế toán)
-- So sánh: câu trên tương đương viết dài:
-- WHERE phong_ban = 'IT' OR phong_ban = 'Nhân sự' OR phong_ban = 'Kinh doanh'


-- ------------------------------------------------------------
-- 2.7  Lọc giá trị NULL (ô trống)
-- ------------------------------------------------------------
-- Ý nghĩa: Tìm nhân viên chưa có email
-- QUAN TRỌNG: Không dùng "= NULL" — phải dùng "IS NULL"
--
-- Trong Excel: giống Filter → chọn "(Blanks)"

SELECT ho_ten, email FROM nhan_vien
WHERE email IS NULL;

-- Kết quả: 1 hàng (Hoàng Thị Dung — cột email trống/NULL)

-- Ngược lại — tìm người ĐÃ CÓ email:
SELECT ho_ten, email FROM nhan_vien
WHERE email IS NOT NULL;

-- Kết quả: 5 hàng (tất cả trừ Hoàng Thị Dung)


-- ================================================================
-- PHẦN 3: SẮP XẾP — ORDER BY
-- (Giống tính năng Sort trong Excel)
-- ================================================================

-- ------------------------------------------------------------
-- 3.1  Sắp xếp tăng dần (mặc định)
-- ------------------------------------------------------------
-- ASC = Ascending = Tăng dần (A→Z, nhỏ→lớn)
-- ASC là mặc định — có thể bỏ qua, kết quả giống nhau
--
-- Trong Excel: Sort → A to Z / Smallest to Largest

SELECT ho_ten, luong FROM nhan_vien
ORDER BY luong ASC;

-- Kết quả (từ lương thấp nhất):
-- Hoàng Thị Dung | 13,000,000
-- Trần Thị Mai   | 15,000,000
-- Lê Thị Bình    | 18,000,000
-- Nguyễn Văn An  | 20,000,000
-- Võ Văn Em      | 22,000,000
-- Phạm Minh Châu | 25,000,000


-- ------------------------------------------------------------
-- 3.2  Sắp xếp giảm dần
-- ------------------------------------------------------------
-- DESC = Descending = Giảm dần (Z→A, lớn→nhỏ)
--
-- Trong Excel: Sort → Z to A / Largest to Smallest

SELECT ho_ten, luong FROM nhan_vien
ORDER BY luong DESC;

-- Kết quả (từ lương cao nhất):
-- Phạm Minh Châu | 25,000,000
-- Võ Văn Em      | 22,000,000
-- Nguyễn Văn An  | 20,000,000
-- ...


-- ------------------------------------------------------------
-- 3.3  Sắp xếp theo nhiều cột
-- ------------------------------------------------------------
-- Ý nghĩa: Sắp theo phòng ban (A→Z), trong cùng phòng thì sắp theo lương (cao→thấp)
--
-- Trong Excel: Sort → Add Level → sắp theo nhiều tiêu chí

SELECT ho_ten, phong_ban, luong FROM nhan_vien
ORDER BY phong_ban ASC, luong DESC;

-- Kết quả:
-- Hoàng Thị Dung | Kế toán    | 13,000,000  ← Kế toán đứng đầu (A→Z)
-- Trần Thị Mai   | Kế toán    | 15,000,000  ← ... nhưng trong KT, lương cao trước?
-- LƯU Ý: Ở đây Trần Thị Mai (15tr) cao hơn Hoàng Thị Dung (13tr)
--         nên Trần Thị Mai đứng trước trong nhóm Kế toán

-- Nguyễn Văn An  | Kinh doanh | 22,000,000  ← Nếu Võ Văn Em (22tr) thì trước
-- Võ Văn Em      | Kinh doanh | 20,000,000
-- ...


-- ================================================================
-- PHẦN 4: ĐẾM VÀ TÍNH TOÁN — COUNT, SUM, AVG
-- (Giống hàm COUNTA, SUM, AVERAGE trong Excel)
-- ================================================================

-- ------------------------------------------------------------
-- 4.1  Đếm tổng số hàng — COUNT(*)
-- ------------------------------------------------------------
-- Ý nghĩa: Có bao nhiêu nhân viên trong bảng?
-- COUNT(*) = đếm tất cả hàng (kể cả hàng có NULL)
--
-- Trong Excel: giống =COUNTA(A2:A100)

SELECT COUNT(*) FROM nhan_vien;

-- Kết quả: 6
-- (6 nhân viên trong bảng)


-- ------------------------------------------------------------
-- 4.2  Đếm số giá trị không rỗng trong một cột — COUNT(cột)
-- ------------------------------------------------------------
-- Ý nghĩa: Có bao nhiêu nhân viên ĐÃ CÓ email?
-- COUNT(email) = chỉ đếm hàng mà cột email KHÔNG NULL
--
-- Trong Excel: =COUNTA(F2:F7) — COUNTA bỏ qua ô trống

SELECT COUNT(email) FROM nhan_vien;

-- Kết quả: 5
-- (Hoàng Thị Dung không có email → không được đếm)
-- So sánh: COUNT(*) = 6, COUNT(email) = 5


-- ------------------------------------------------------------
-- 4.3  Tính tổng — SUM
-- ------------------------------------------------------------
-- Ý nghĩa: Tổng lương của tất cả nhân viên là bao nhiêu?
--
-- Trong Excel: giống =SUM(C2:C7)

SELECT SUM(luong) AS "Tổng lương" FROM nhan_vien;

-- Kết quả: 113,000,000
-- (15tr + 20tr + 18tr + 25tr + 13tr + 22tr = 113tr)


-- ------------------------------------------------------------
-- 4.4  Tính trung bình — AVG
-- ------------------------------------------------------------
-- Ý nghĩa: Lương trung bình là bao nhiêu?
--
-- Trong Excel: giống =AVERAGE(C2:C7)

SELECT AVG(luong) AS "Lương trung bình" FROM nhan_vien;

-- Kết quả: 18,833,333.33...
-- (113,000,000 / 6 ≈ 18.83 triệu)


-- ------------------------------------------------------------
-- 4.5  Giá trị lớn nhất và nhỏ nhất — MAX, MIN
-- ------------------------------------------------------------
-- Trong Excel: giống =MAX(C2:C7) và =MIN(C2:C7)

SELECT
    MAX(luong) AS "Lương cao nhất",
    MIN(luong) AS "Lương thấp nhất"
FROM nhan_vien;

-- Kết quả:
-- Lương cao nhất: 25,000,000 (Phạm Minh Châu)
-- Lương thấp nhất: 13,000,000 (Hoàng Thị Dung)


-- ------------------------------------------------------------
-- 4.6  Kết hợp nhiều hàm trong một câu SELECT
-- ------------------------------------------------------------
-- Ý nghĩa: Báo cáo tổng hợp lương trong 1 câu
--
-- Trong Excel: giống gõ =COUNT, =SUM, =AVERAGE, =MAX, =MIN
--              vào các ô khác nhau

SELECT
    COUNT(*)    AS "Tổng số NV",
    SUM(luong)  AS "Tổng lương",
    AVG(luong)  AS "Lương TB",
    MAX(luong)  AS "Cao nhất",
    MIN(luong)  AS "Thấp nhất"
FROM nhan_vien;

-- Kết quả: 1 hàng với 5 cột thống kê


-- ================================================================
-- PHẦN 5: KẾT HỢP — WHERE + ORDER BY + LIMIT
-- ================================================================

-- ------------------------------------------------------------
-- 5.1  Lọc + Sắp xếp kết hợp
-- ------------------------------------------------------------
-- Ý nghĩa: Xem nhân viên Kinh doanh, sắp theo lương cao nhất

SELECT ho_ten, luong
FROM nhan_vien
WHERE phong_ban = 'Kinh doanh'
ORDER BY luong DESC;

-- Kết quả:
-- Võ Văn Em      | 22,000,000
-- Nguyễn Văn An  | 20,000,000


-- ------------------------------------------------------------
-- 5.2  LIMIT — Giới hạn số kết quả
-- ------------------------------------------------------------
-- Ý nghĩa: Chỉ lấy 3 nhân viên có lương cao nhất
-- LIMIT n = "chỉ trả về n hàng đầu tiên"
--
-- Trong Excel: không có hàm tương đương trực tiếp,
--              nhường thường phải Sort xong copy 3 hàng đầu

SELECT ho_ten, luong
FROM nhan_vien
ORDER BY luong DESC
LIMIT 3;

-- Kết quả: CHỈ 3 hàng:
-- Phạm Minh Châu | 25,000,000
-- Võ Văn Em      | 22,000,000
-- Nguyễn Văn An  | 20,000,000


-- ------------------------------------------------------------
-- 5.3  Thứ tự thực thi trong SQL (quan trọng!)
-- ------------------------------------------------------------
-- SQL không chạy từ trên xuống dưới như bạn đọc.
-- Thứ tự thực thi thật:
--
--   1. FROM       → Chọn bảng nào
--   2. WHERE      → Lọc hàng nào
--   3. SELECT     → Chọn cột nào / tính toán gì
--   4. ORDER BY   → Sắp xếp
--   5. LIMIT      → Giới hạn số hàng
--
-- Ví dụ hiểu đúng:
SELECT ho_ten, luong * 0.9 AS luong_sau_thue
FROM nhan_vien
WHERE luong > 15000000
ORDER BY luong_sau_thue DESC
LIMIT 3;

-- Quá trình:
-- 1. Lấy bảng nhan_vien
-- 2. Lọc: chỉ giữ hàng có luong > 15tr (loại Mai và Dung)
-- 3. Tính: luong * 0.9 cho từng hàng còn lại
-- 4. Sắp xếp theo luong_sau_thue giảm dần
-- 5. Chỉ trả về 3 hàng đầu


-- ================================================================
-- PHẦN 6: XEM TRƯỚC — Tuần Sau Chúng Ta Sẽ Làm Thật
-- ================================================================

-- Sau khi cài PostgreSQL xong (Tuần 2), câu lệnh đầu tiên bạn sẽ chạy:

-- Kiểm tra phiên bản PostgreSQL đang dùng:
SELECT version();

-- Xem ngày hôm nay:
SELECT CURRENT_DATE;

-- Thử phép tính đơn giản (giống gõ =1+1 trong Excel):
SELECT 1 + 1 AS ket_qua;
SELECT 100 * 0.1 AS muoi_phan_tram;

-- Tạo database đầu tiên:
-- CREATE DATABASE hoc_sql;

-- Tạo bảng nhân viên (giống tạo sheet với các cột đã định sẵn):
-- CREATE TABLE nhan_vien (
--     id          SERIAL PRIMARY KEY,
--     ho_ten      VARCHAR(100) NOT NULL,
--     phong_ban   VARCHAR(50),
--     luong       NUMERIC(12,2),
--     ngay_sinh   DATE,
--     email       VARCHAR(150)
-- );

-- Thêm dữ liệu vào bảng (giống gõ từng hàng trong Excel):
-- INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_sinh, email)
-- VALUES ('Trần Thị Mai', 'Kế toán', 15000000, '1995-03-20', 'mai.tran@cty.com');

-- ================================================================
-- HẾT FILE EXAMPLES.SQL — TUẦN 1
-- ================================================================
--
-- Ghi nhớ 3 điều từ file này:
--
-- 1. SELECT ... FROM ... → Chọn dữ liệu từ bảng nào
-- 2. WHERE ...           → Lọc theo điều kiện (như Filter)
-- 3. ORDER BY ...        → Sắp xếp (như Sort)
--
-- Đây là 3 từ khóa bạn sẽ dùng nhiều nhất trong 80% công việc hàng ngày!
--
-- ================================================================
