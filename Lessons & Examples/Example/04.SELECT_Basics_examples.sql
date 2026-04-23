-- ================================================================
-- TUẦN 4: TRUY VẤN DỮ LIỆU — SELECT CƠ BẢN
-- ================================================================
-- File này sử dụng các bảng đã tạo từ Tuần 3.
-- Đảm bảo bạn đang kết nối vào database "hoc_sql" trước khi chạy.
--
-- Cách dùng:
--   - Chạy từng câu lệnh một để xem kết quả
--   - Đọc comment giải thích trước mỗi câu lệnh
-- ================================================================


-- ================================================================
-- PHẦN 0: KIỂM TRA DỮ LIỆU TỪ TUẦN 3
-- ================================================================

-- Kiểm tra bảng nhan_vien có dữ liệu chưa
SELECT COUNT(*) AS "Số nhân viên" FROM nhan_vien;

-- Kiểm tra bảng san_pham
SELECT COUNT(*) AS "Số sản phẩm" FROM san_pham;

-- Kiểm tra bảng khach_hang
SELECT COUNT(*) AS "Số khách hàng" FROM khach_hang;

-- Xem cấu trúc bảng (cột nào, kiểu gì)
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'nhan_vien'
ORDER BY ordinal_position;


-- ================================================================
-- PHẦN 4.1: SELECT CƠ BẢN
-- ================================================================

-- 4.1.1 Xem toàn bộ dữ liệu bảng nhan_vien
-- Giống mở sheet Excel và nhìn toàn bộ
SELECT * FROM nhan_vien;

-- 4.1.2 Chỉ chọn cột cần thiết
-- Giống ẩn các cột không cần trong Excel
SELECT ho_ten, luong, phong_ban
FROM nhan_vien;

-- 4.1.3 Thứ tự cột trong SELECT không cần khớp thứ tự trong bảng
-- Đặt phong_ban lên đầu để dễ nhóm khi đọc
SELECT phong_ban, ho_ten, luong
FROM nhan_vien;

-- 4.1.4 Xem dữ liệu bảng san_pham
SELECT * FROM san_pham;

-- Chỉ xem tên và giá sản phẩm
SELECT ten_sp, gia, so_luong_ton
FROM san_pham;


-- ================================================================
-- PHẦN 4.2: AS — ĐẶT TÊN HIỂN THỊ (ALIAS)
-- ================================================================

-- 4.2.1 Đặt tên cột tiếng Việt có dấu
SELECT
    ho_ten      AS "Họ và tên",
    luong       AS "Mức lương (VNĐ)",
    phong_ban   AS "Phòng ban"
FROM nhan_vien;

-- 4.2.2 Alias không có ký tự đặc biệt — không cần dấu nháy kép
SELECT
    ho_ten    AS ten_nhan_vien,
    luong     AS muc_luong,
    phong_ban AS don_vi
FROM nhan_vien;

-- 4.2.3 Alias cho bảng (table alias)
-- Dùng "nv" thay cho "nhan_vien" — hữu ích khi query phức tạp
SELECT
    nv.ho_ten   AS "Họ và tên",
    nv.luong    AS "Lương",
    nv.phong_ban AS "Phòng ban"
FROM nhan_vien AS nv;

-- 4.2.4 Alias cho sản phẩm
SELECT
    ten_sp      AS "Tên sản phẩm",
    danh_muc    AS "Danh mục",
    gia         AS "Giá bán (VNĐ)",
    so_luong_ton AS "Tồn kho"
FROM san_pham;


-- ================================================================
-- PHẦN 4.3: BIỂU THỨC TÍNH TOÁN TRONG SELECT
-- ================================================================

-- 4.3.1 Toán tử số học cơ bản
SELECT
    ho_ten,
    luong                       AS "Lương tháng",
    luong * 12                  AS "Lương năm",         -- Nhân 12 tháng
    ROUND(luong / 26.0, 0)      AS "Lương ngày (26 ngày công)", -- Chia lấy lương ngày
    ROUND(luong / 4.33, 0)      AS "Lương tuần"         -- Chia lấy lương tuần
FROM nhan_vien;

-- 4.3.2 Cái bẫy: chia số nguyên!
-- Chạy từng dòng để thấy sự khác biệt:
SELECT 7 / 2 AS "Sai: 7/2 kiểu INTEGER";    -- Kết quả: 3 (bị cắt!)
SELECT 7.0 / 2 AS "Đúng: 7.0/2";           -- Kết quả: 3.5
SELECT 7::NUMERIC / 2 AS "Đúng: cast";     -- Kết quả: 3.5

-- Ví dụ thực tế: lương chia 12 tháng
SELECT
    ho_ten,
    luong / 12      AS "Lương tháng (sai nếu INTEGER)",     -- Nguy hiểm!
    luong / 12.0    AS "Lương tháng (đúng)"                 -- An toàn
FROM nhan_vien;

-- 4.3.3 Tính các khoản trừ lương
SELECT
    ho_ten                                          AS "Họ và tên",
    luong                                           AS "Lương gross",
    ROUND(luong * 0.08, 0)                          AS "BHXH (8%)",
    ROUND(luong * 0.015, 0)                         AS "BHYT (1.5%)",
    ROUND(luong * 0.01, 0)                          AS "BHTN (1%)",
    ROUND(luong * 0.105, 0)                         AS "Tổng BH (10.5%)",
    ROUND(luong * 0.895, 0)                         AS "Lương sau khi đóng BH",
    ROUND(luong * 0.895 * 0.10, 0)                  AS "Thuế TNCN tạm tính (10%)",
    ROUND(luong * 0.895 * 0.90, 0)                  AS "Lương thực nhận"
FROM nhan_vien;

-- 4.3.4 Tính giá trị tồn kho (giá × số lượng)
SELECT
    ten_sp                              AS "Tên sản phẩm",
    gia                                 AS "Giá bán",
    so_luong_ton                        AS "Số lượng tồn",
    ROUND(gia * so_luong_ton, 0)        AS "Giá trị tồn kho (VNĐ)",
    ROUND(gia * so_luong_ton / 1000000.0, 2) AS "Giá trị tồn (triệu đ)"
FROM san_pham;

-- 4.3.5 Hàm làm tròn
SELECT
    ROUND(15567890.567, 0)  AS "Làm tròn số nguyên",   -- 15567891
    ROUND(15567890.567, 2)  AS "Làm tròn 2 thập phân", -- 15567890.57
    ROUND(15567890.567, -3) AS "Làm tròn hàng nghìn",  -- 15568000
    CEIL(15.001)            AS "Trần ceiling",           -- 16
    FLOOR(15.999)           AS "Sàn floor",              -- 15
    TRUNC(15.999, 1)        AS "Cắt 1 thập phân";       -- 15.9

-- 4.3.6 Tính phần trăm giảm giá
SELECT
    ten_sp                                  AS "Sản phẩm",
    gia                                     AS "Giá gốc",
    ROUND(gia * 0.85, 0)                    AS "Giá sau giảm 15%",
    ROUND(gia - gia * 0.85, 0)             AS "Số tiền được giảm",
    '15%'                                   AS "Mức giảm"
FROM san_pham;


-- ================================================================
-- PHẦN 4.4: DISTINCT — LOẠI BỎ GIÁ TRỊ TRÙNG
-- ================================================================

-- 4.4.1 Vấn đề: SELECT bình thường → bị trùng
SELECT phong_ban FROM nhan_vien;
-- Kết quả: 6 hàng (2 Kế toán, 2 Kinh doanh, 1 Nhân sự, 1 IT)

-- 4.4.2 DISTINCT → chỉ lấy giá trị duy nhất
SELECT DISTINCT phong_ban FROM nhan_vien;
-- Kết quả: 4 hàng (mỗi phòng ban 1 lần)

-- 4.4.3 DISTINCT trên nhiều cột
-- Kết hợp (phong_ban, trang_thai) duy nhất — giả sử bảng có cột trang_thai
SELECT DISTINCT phong_ban
FROM nhan_vien
ORDER BY phong_ban;

-- 4.4.4 Danh mục sản phẩm không trùng
SELECT DISTINCT danh_muc AS "Danh mục"
FROM san_pham
ORDER BY danh_muc;

-- 4.4.5 COUNT(DISTINCT ...) — đếm số giá trị khác nhau
SELECT
    COUNT(*)                    AS "Tổng số nhân viên",
    COUNT(DISTINCT phong_ban)   AS "Số phòng ban",
    COUNT(DISTINCT email)       AS "Số email khác nhau"
FROM nhan_vien;

-- 4.4.6 Tổng hợp thống kê sản phẩm
SELECT
    COUNT(*)                     AS "Tổng sản phẩm",
    COUNT(DISTINCT danh_muc)     AS "Số danh mục khác nhau",
    COUNT(DISTINCT ngay_nhap)    AS "Số ngày đã nhập hàng"
FROM san_pham;


-- ================================================================
-- PHẦN 4.5: HÀM XỬ LÝ CHUỖI
-- ================================================================

-- 4.5.1 Nối chuỗi với ||
SELECT
    ho_ten || ' (' || phong_ban || ')' AS "Thông tin nhân viên"
FROM nhan_vien;
-- Ví dụ kết quả: "Trần Thị Mai (Kế toán)"

-- 4.5.2 Bẫy || với NULL — NULL làm hỏng cả chuỗi
SELECT
    ho_ten,
    'Email: ' || email          AS "Email (|| — nguy hiểm với NULL)",
    'Email: ' || COALESCE(email, 'Chưa có') AS "Email (an toàn với COALESCE)"
FROM nhan_vien;

-- 4.5.3 CONCAT() — an toàn hơn với NULL
SELECT
    CONCAT('NV: ', ho_ten, ' | PB: ', phong_ban, ' | Email: ', email) AS "Thông tin đầy đủ"
FROM nhan_vien;

-- 4.5.4 UPPER / LOWER / INITCAP
SELECT
    ho_ten,
    UPPER(ho_ten)       AS "Chữ hoa",
    LOWER(ho_ten)       AS "Chữ thường",
    INITCAP(LOWER(ho_ten)) AS "Viết hoa chữ đầu"  -- Chuẩn hóa tên
FROM nhan_vien;

-- 4.5.5 LENGTH — đếm ký tự
SELECT
    ho_ten,
    LENGTH(ho_ten)      AS "Độ dài tên",
    email,
    LENGTH(email)       AS "Độ dài email"
FROM nhan_vien;

-- 4.5.6 TRIM / LTRIM / RTRIM
-- Dùng khi dữ liệu nhập có khoảng trắng thừa
SELECT
    '  Nguyễn Văn An  '                    AS "Chuỗi gốc (có khoảng trắng)",
    TRIM('  Nguyễn Văn An  ')              AS "TRIM (cả 2 đầu)",
    LTRIM('  Nguyễn Văn An  ')             AS "LTRIM (chỉ bên trái)",
    RTRIM('  Nguyễn Văn An  ')             AS "RTRIM (chỉ bên phải)";

-- 4.5.7 LEFT / RIGHT — lấy n ký tự
SELECT
    ho_ten,
    LEFT(ho_ten, 5)         AS "5 ký tự đầu",
    RIGHT(ho_ten, 5)        AS "5 ký tự cuối",
    email,
    SPLIT_PART(email, '@', 1) AS "Phần trước @",  -- Username
    SPLIT_PART(email, '@', 2) AS "Domain email"    -- Domain
FROM nhan_vien;

-- 4.5.8 SUBSTRING — cắt chuỗi tại vị trí bất kỳ
SELECT
    email,
    SUBSTRING(email FROM 1 FOR 5)  AS "5 ký tự đầu",
    POSITION('@' IN email)          AS "Vị trí @"
FROM nhan_vien;

-- 4.5.9 REPLACE — thay thế chuỗi
SELECT
    ten_sp,
    REPLACE(ten_sp, 'Laptop', 'Máy tính xách tay') AS "Tên đã thay thế"
FROM san_pham
WHERE ten_sp LIKE '%Laptop%';  -- (LIKE sẽ học kỹ Tuần 5)

-- 4.5.10 LPAD — tạo mã nhân viên có định dạng
SELECT
    id,
    ho_ten,
    'NV-' || LPAD(id::TEXT, 3, '0')    AS "Mã NV",     -- NV-001, NV-002...
    'SP-' || LPAD(id::TEXT, 4, '0')    AS "Mã SP mẫu"  -- SP-0001, SP-0002...
FROM nhan_vien;


-- ================================================================
-- PHẦN 4.6: HÀM SỐ HỌC
-- ================================================================

-- 4.6.1 Các hàm làm tròn và số học thông dụng
SELECT
    ABS(-15000000)          AS "Giá trị tuyệt đối",  -- 15000000
    POWER(2, 10)            AS "2 mũ 10",             -- 1024
    SQRT(144)               AS "Căn bậc 2 của 144",  -- 12
    MOD(100, 7)             AS "100 chia dư 7",       -- 2
    SIGN(-5)                AS "Dấu của -5",          -- -1
    SIGN(0)                 AS "Dấu của 0",           -- 0
    SIGN(5)                 AS "Dấu của 5";           -- 1

-- 4.6.2 Ứng dụng với dữ liệu nhân viên
SELECT
    ho_ten,
    luong,
    -- Làm tròn lương về hàng triệu gần nhất
    ROUND(luong, -6)                        AS "Làm tròn triệu",
    -- Tính luong quy về triệu đồng
    ROUND(luong / 1000000.0, 1)             AS "Lương (triệu đ)",
    -- Tính lãi suất tháng nếu gửi tiết kiệm (5.5%/năm)
    ROUND(luong * 0.055 / 12, 0)            AS "Lãi tiết kiệm/tháng (5.5%/năm)"
FROM nhan_vien;

-- 4.6.3 Ứng dụng với dữ liệu sản phẩm
SELECT
    ten_sp,
    gia,
    so_luong_ton,
    ROUND(gia * so_luong_ton / 1000000.0, 2)  AS "Giá trị tồn (triệu đ)",
    -- Kiểm tra số lượng tồn là chẵn hay lẻ
    CASE
        WHEN MOD(so_luong_ton, 2) = 0 THEN 'Số chẵn'
        ELSE 'Số lẻ'
    END AS "Chẵn/Lẻ"
FROM san_pham;


-- ================================================================
-- PHẦN 4.7: LIMIT VÀ OFFSET
-- ================================================================

-- 4.7.1 LIMIT — chỉ lấy N hàng đầu
SELECT * FROM nhan_vien LIMIT 3;

-- 4.7.2 LIMIT với ORDER BY (kết hợp đúng cách)
-- Xem 3 nhân viên lương cao nhất
SELECT ho_ten, luong
FROM nhan_vien
ORDER BY luong DESC    -- Sắp xếp giảm dần (cao → thấp)
LIMIT 3;

-- Xem 5 sản phẩm rẻ nhất
SELECT ten_sp, gia
FROM san_pham
ORDER BY gia ASC       -- Sắp xếp tăng dần (thấp → cao)
LIMIT 5;

-- 4.7.3 OFFSET — bỏ qua N hàng đầu (phân trang)
-- Trang 1: sản phẩm 1-5
SELECT ten_sp, gia FROM san_pham ORDER BY id LIMIT 5 OFFSET 0;

-- Trang 2: sản phẩm 6-10
SELECT ten_sp, gia FROM san_pham ORDER BY id LIMIT 5 OFFSET 5;

-- Trang 3: sản phẩm 11-15
SELECT ten_sp, gia FROM san_pham ORDER BY id LIMIT 5 OFFSET 10;

-- 4.7.4 LIMIT không có ORDER BY — kết quả không đảm bảo thứ tự
-- Chạy nhiều lần, kết quả có thể khác nhau!
SELECT * FROM san_pham LIMIT 3;  -- Không nên dùng thế này trong thực tế


-- ================================================================
-- PHẦN 4.8: THỰC HÀNH VIẾT SQL ĐẸP
-- ================================================================

-- 4.8.1 Kiểm tra: alias không dùng được trong WHERE (lỗi thường gặp)
-- Câu này sẽ BÁO LỖI — alias không dùng được trong WHERE
-- SELECT luong * 0.90 AS luong_sau_thue
-- FROM nhan_vien
-- WHERE luong_sau_thue > 15000000;  -- ❌ Lỗi: column does not exist

-- Cách đúng: dùng lại biểu thức trong WHERE
SELECT luong * 0.90 AS "Lương sau thuế"
FROM nhan_vien
WHERE luong * 0.90 > 15000000;    -- ✅ Đúng

-- 4.8.2 Ví dụ SQL viết đẹp — Báo cáo nhân sự đầy đủ
-- =====================================================
-- Báo cáo tổng quan nhân sự
-- Dùng bảng: nhan_vien
-- Mục đích: Xem thông tin lương và mã nhân viên
-- =====================================================
SELECT
    -- Định danh nhân viên
    'NV-' || LPAD(id::TEXT, 3, '0')        AS "Mã NV",
    ho_ten                                  AS "Họ và tên",
    phong_ban                               AS "Phòng ban",

    -- Thông tin lương
    luong                                   AS "Lương gross (VNĐ)",
    ROUND(luong / 1000000.0, 1)             AS "Lương (triệu đ)",
    ROUND(luong * 0.105, 0)                 AS "Tổng BH (10.5%)",
    ROUND(luong * 0.895, 0)                 AS "Lương sau BH",

    -- Thông tin liên lạc
    LOWER(TRIM(COALESCE(email, 'Chưa có email'))) AS "Email"

FROM nhan_vien
ORDER BY phong_ban, ho_ten;


-- ================================================================
-- PHẦN 4.9: HÀM NGÀY/GIỜ CƠ BẢN
-- ================================================================

-- 4.9.1 Các hàm thời gian cơ bản
SELECT
    CURRENT_DATE        AS "Hôm nay",
    CURRENT_TIMESTAMP   AS "Thời điểm hiện tại",
    now()               AS "now() — tương đương CURRENT_TIMESTAMP";

-- 4.9.2 EXTRACT — lấy thành phần từ ngày
SELECT
    ngay_sinh,
    EXTRACT(YEAR   FROM ngay_sinh)   AS "Năm sinh",
    EXTRACT(MONTH  FROM ngay_sinh)   AS "Tháng sinh",
    EXTRACT(DAY    FROM ngay_sinh)   AS "Ngày sinh",
    EXTRACT(DOW    FROM ngay_sinh)   AS "Thứ (0=CN)",
    EXTRACT(QUARTER FROM ngay_sinh)  AS "Quý"
FROM nhan_vien;

-- 4.9.3 AGE — tính tuổi và khoảng thời gian
SELECT
    ho_ten,
    ngay_sinh,
    AGE(ngay_sinh)                              AS "Tuổi đầy đủ",
    EXTRACT(YEAR FROM AGE(ngay_sinh))           AS "Số tuổi (năm)"
FROM nhan_vien;

-- 4.9.4 Số năm làm việc (thâm niên)
SELECT
    ho_ten,
    ngay_vao,
    AGE(ngay_vao)                               AS "Thời gian làm việc",
    EXTRACT(YEAR FROM AGE(ngay_vao))            AS "Thâm niên (năm)",
    CURRENT_DATE - ngay_vao                     AS "Tổng số ngày đã làm"
FROM nhan_vien;

-- 4.9.5 TO_CHAR — format ngày theo ý muốn
SELECT
    ho_ten,
    ngay_sinh,
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY')                AS "Ngày sinh kiểu VN",
    TO_CHAR(ngay_sinh, 'DD "tháng" MM "năm" YYYY')  AS "Ngày sinh đầy đủ tiếng Việt",
    TO_CHAR(ngay_sinh, 'Month DD, YYYY')            AS "Ngày sinh kiểu Mỹ"
FROM nhan_vien;

-- 4.9.6 Tính toán với ngày (cộng/trừ)
SELECT
    CURRENT_DATE                    AS "Hôm nay",
    CURRENT_DATE + 7                AS "7 ngày nữa",
    CURRENT_DATE - 30               AS "30 ngày trước",
    CURRENT_DATE + 365              AS "1 năm nữa",
    DATE_TRUNC('month', CURRENT_DATE)  AS "Đầu tháng này";

-- 4.9.7 Ứng dụng: Tìm nhân viên sinh nhật trong tháng này
SELECT
    ho_ten,
    TO_CHAR(ngay_sinh, 'DD/MM/YYYY') AS "Ngày sinh",
    EXTRACT(YEAR FROM AGE(ngay_sinh)) AS "Tuổi sắp tới"
FROM nhan_vien
WHERE EXTRACT(MONTH FROM ngay_sinh) = EXTRACT(MONTH FROM CURRENT_DATE);


-- ================================================================
-- PHẦN 4.10: QUERY TỔNG HỢP — KẾT HỢP NHIỀU KỸ NĂNG
-- ================================================================

-- 4.10.1 Báo cáo nhân sự hoàn chỉnh
SELECT
    'NV-' || LPAD(id::TEXT, 3, '0')                AS "Mã NV",
    ho_ten                                          AS "Họ và tên",
    EXTRACT(YEAR FROM AGE(ngay_sinh))               AS "Tuổi",
    phong_ban                                       AS "Phòng ban",
    ROUND(luong / 1000000.0, 1)                     AS "Lương (triệu đ)",
    ROUND(luong * 0.895, 0)                         AS "Lương thực nhận",
    EXTRACT(YEAR FROM AGE(ngay_vao))                AS "Thâm niên (năm)",
    TO_CHAR(ngay_vao, 'DD/MM/YYYY')                AS "Ngày vào làm",
    SPLIT_PART(email, '@', 1)                       AS "Username"
FROM nhan_vien
ORDER BY phong_ban, luong DESC;

-- 4.10.2 Báo cáo tồn kho sản phẩm
SELECT
    'SP-' || LPAD(id::TEXT, 4, '0')                AS "Mã SP",
    ten_sp                                          AS "Tên sản phẩm",
    danh_muc                                        AS "Danh mục",
    ROUND(gia, 0)                                   AS "Giá bán (VNĐ)",
    so_luong_ton                                    AS "Số lượng tồn",
    ROUND(gia * so_luong_ton / 1000000.0, 2)        AS "Giá trị tồn (triệu đ)",
    TO_CHAR(ngay_nhap, 'DD/MM/YYYY')               AS "Ngày nhập"
FROM san_pham
ORDER BY danh_muc, gia DESC;

-- 4.10.3 Thống kê nhanh theo phòng ban (preview Tuần 6 — GROUP BY)
SELECT
    DISTINCT phong_ban          AS "Phòng ban"
FROM nhan_vien
ORDER BY phong_ban;

-- (Khi học Tuần 6 sẽ mở rộng thành:)
-- SELECT phong_ban, COUNT(*), AVG(luong) FROM nhan_vien GROUP BY phong_ban;


-- ================================================================
-- KẾT THÚC TUẦN 4
-- ================================================================
-- Bài tập: Xem file exercises.md và làm theo hướng dẫn.
-- Tuần tiếp theo: WHERE, ORDER BY, LIMIT — Lọc và sắp xếp dữ liệu
-- ================================================================
