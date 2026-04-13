# Tuần 2: Cài Đặt PostgreSQL & Làm Quen Công Cụ

> **Thời lượng dự kiến:** 3–4 giờ (bao gồm cài đặt và thực hành)
>
> **Yêu cầu:** Máy tính Windows có kết nối internet

---

## Mục Tiêu Tuần 2

Sau tuần này, bạn sẽ:
- ✅ Cài được PostgreSQL trên Windows
- ✅ Cài được DBeaver và kết nối với PostgreSQL
- ✅ Biết dùng giao diện DBeaver (điều hướng, viết SQL)
- ✅ Tạo được database đầu tiên tên `hoc_sql`
- ✅ Chạy được câu SQL đầu tiên trong đời và thấy kết quả thật

---

## Mở Đầu: Từ Lý Thuyết Sang Thực Tế

Tuần trước bạn đã hiểu tại sao cần database, database khác Excel ở chỗ nào, và thậm chí đọc được một vài câu SQL đơn giản.

Nhưng "đọc về bơi" khác xa "nhảy xuống hồ bơi thật." Tuần này, chúng ta nhảy xuống hồ.

Hãy nhớ lần đầu bạn học Excel. Trước khi gõ được `=SUM(A1:A10)`, bạn phải cài Excel, mở file, học cách click vào ô. Tuần này là bước đó với PostgreSQL — **80% là thực hành cài đặt, không có lý thuyết phức tạp.**

Cuối tuần này, bạn sẽ gõ câu SQL đầu tiên và thấy kết quả ngay trước mắt. Đó là khoảnh khắc "Aha!" mà mọi người học SQL đều nhớ mãi.

---

## Phần 1: Cài Đặt PostgreSQL

### PostgreSQL là gì (nhắc lại nhanh)?

PostgreSQL là **phần mềm quản lý database** — giống như Excel là phần mềm quản lý bảng tính. Bạn cần cài nó vào máy để máy tính "hiểu" và lưu trữ dữ liệu theo cách của database.

Bộ cài PostgreSQL bao gồm:
- **PostgreSQL Server** — "engine" thật sự xử lý và lưu dữ liệu
- **Command Line Tools** — công cụ dòng lệnh (chúng ta sẽ dùng ít)
- ~~pgAdmin~~ — giao diện đồ họa đi kèm (chúng ta dùng DBeaver thay thế)

### Bước 1: Tải PostgreSQL

1. Mở trình duyệt, vào địa chỉ: **https://www.postgresql.org/download/windows/**
2. Nhấn vào link **"Download the installer"** (do EnterpriseDB cung cấp)
3. Chọn phiên bản mới nhất (16.x hoặc 17.x), bản **Windows x86-64**
4. Tải về — file .exe khoảng 250–300 MB

### Bước 2: Chạy Bộ Cài

Sau khi tải xong, double-click file .exe để bắt đầu cài đặt. Làm theo từng màn hình:

| Màn hình installer | Cần làm gì |
|---|---|
| "Setup - PostgreSQL" | Nhấn **Next** |
| "Installation Directory" | Giữ nguyên mặc định → **Next** |
| "Select Components" | Bỏ chọn **pgAdmin 4** (không cần); giữ lại **PostgreSQL Server** và **Command Line Tools** → **Next** |
| "Data Directory" | Giữ nguyên mặc định → **Next** |
| **"Password"** | ⚠️ **ĐẶT MẬT KHẨU — XEM CẢNH BÁO BÊN DƯỚI** → **Next** |
| "Port" | Giữ nguyên **5432** → **Next** |
| "Locale" | Giữ nguyên → **Next** |
| "Pre Installation Summary" | Nhấn **Next** để bắt đầu cài |
| "Completing the Setup Wizard" | Bỏ chọn "Launch Stack Builder at exit" → **Finish** |

> ⚠️ **CẢNH BÁO — MẬT KHẨU POSTGRES RẤT QUAN TRỌNG:**
>
> Màn hình "Password" yêu cầu bạn đặt mật khẩu cho tài khoản `postgres` (tài khoản quản trị chính của PostgreSQL).
>
> - **Hãy đặt mật khẩu đơn giản, dễ nhớ** (ví dụ: `postgres123` hoặc `Admin@123`)
> - **Ghi mật khẩu này ra giấy NGAY BÂY GIỜ** — bạn sẽ cần nó khi kết nối DBeaver
> - **Nếu quên mật khẩu:** phải gỡ cài đặt PostgreSQL hoàn toàn và cài lại — rất mất thời gian
> - Mật khẩu này **không phải** mật khẩu Windows của bạn — đây là mật khẩu riêng cho PostgreSQL

### Bước 3: Kiểm Tra PostgreSQL Đã Chạy Chưa

Sau khi cài xong, PostgreSQL tự động khởi động như một dịch vụ (service) nền. Kiểm tra:

**Cách 1: Qua Task Manager**
- Nhấn `Ctrl + Shift + Esc` để mở Task Manager
- Chuyển sang tab **"Services"**
- Tìm tên bắt đầu bằng `postgresql-x64-...`
- Status phải là **"Running"**

```
Task Manager
┌────────────────────────────────────────────────┐
│  Processes  Performance  App history  Services  │
├────────────────────────────────────────────────┤
│  Name                      Status              │
│  ...                       ...                 │
│  postgresql-x64-16         Running   ✅         │
│  ...                                           │
└────────────────────────────────────────────────┘
Thấy "Running" → PostgreSQL đang chạy tốt!
```

**Cách 2: Qua Services**
- Nhấn `Windows + R`, gõ `services.msc`, nhấn Enter
- Tìm **"postgresql-x64-..."** → cột Status phải là **"Running"**

> **Nếu không thấy "Running":** Click phải vào dịch vụ → "Start". Nếu vẫn không được, thử khởi động lại máy tính.

---

## Phần 2: Cài Đặt DBeaver Community

### DBeaver là gì?

Hãy nghĩ về mối quan hệ này:
- **PostgreSQL** = Engine xử lý dữ liệu (hoạt động ngầm, bạn không thấy)
- **DBeaver** = Giao diện đồ họa để bạn giao tiếp với PostgreSQL

Tương tự:
- **Excel engine** (tính toán) + **Giao diện Excel** (các ô, công thức, menu) = Excel bạn dùng hàng ngày
- **PostgreSQL** (xử lý) + **DBeaver** (giao diện) = Công cụ bạn sẽ dùng để học SQL

Không có DBeaver, bạn phải gõ lệnh trong cửa sổ đen (terminal) — rất không thân thiện. Với DBeaver, bạn có giao diện click chuột giống Excel.

### Bước 1: Tải DBeaver

1. Vào địa chỉ: **https://dbeaver.io/download/**
2. Tìm mục **"DBeaver Community"** (hoàn toàn miễn phí)
3. Chọn bản **"Windows (Installer)"** — file `.exe` khoảng 100 MB
4. Tải về và chạy

### Bước 2: Cài DBeaver

Cài đặt đơn giản như mọi phần mềm Windows:
- Next → I Agree → Next → Next → **Install** → **Finish**
- Không có cài đặt đặc biệt nào cần thay đổi

### Bước 3: Mở DBeaver Lần Đầu

Khi mở lần đầu, DBeaver có thể hỏi một số câu:
- **"Create sample database?"** → Nhấn **No** (chúng ta sẽ kết nối PostgreSQL thật)
- **"Would you like to update DBeaver?"** → Nhấn **Later** (cập nhật sau)

Giao diện DBeaver lần đầu mở trông như thế này:

```
┌─────────────────────────────────────────────────────────────┐
│  DBeaver Community Edition                        _ □ ×     │
├─────────────────────────────────────────────────────────────┤
│  [File] [Navigate] [Window] [Help]                          │
│  [🔌+] [▶] [■] [💾]  ← Toolbar                             │
├──────────────────────┬──────────────────────────────────────┤
│  Database Navigator  │                                      │
│                      │   Chào mừng đến DBeaver!            │
│  (Chưa có kết nối)   │                                      │
│                      │   Để bắt đầu, hãy tạo kết nối       │
│                      │   đến database của bạn.              │
│                      │                                      │
└──────────────────────┴──────────────────────────────────────┘
```

Bên trái (Database Navigator) đang trống vì chưa có kết nối nào. Bước tiếp theo sẽ thay đổi điều đó.

---

## Phần 3: Kết Nối DBeaver Với PostgreSQL

Đây là bước quan trọng nhất của tuần 2. Bạn đang "giới thiệu" DBeaver với PostgreSQL để chúng có thể "nói chuyện" với nhau.

**Phép so sánh:** Giống như khi bạn mở Excel và mở file .xlsx — DBeaver là Excel, PostgreSQL là file .xlsx. Bước này là thao tác "File → Open".

### Bước 1: Tạo Kết Nối Mới

Trong DBeaver, thực hiện một trong hai cách:
- **Cách 1:** Nhấn biểu tượng **ổ cắm có dấu +** trên toolbar (góc trên bên trái)
- **Cách 2:** Menu **Database** → **"New Database Connection"**

Hộp thoại **"Connect to a database"** xuất hiện.

### Bước 2: Chọn PostgreSQL

- Trong ô tìm kiếm, gõ `PostgreSQL`
- Click vào biểu tượng **PostgreSQL** (con voi xanh)
- Nhấn **Next**

### Bước 3: Điền Thông Tin Kết Nối

Màn hình kết nối hiện ra. Điền thông tin như bảng dưới:

| Trường | Giá trị cần điền | Giải thích |
|---|---|---|
| **Host** | `localhost` | PostgreSQL đang chạy trên máy này — "localhost" nghĩa là "máy tính của tôi" |
| **Port** | `5432` | Cổng mặc định PostgreSQL (như số nhà — giúp DBeaver tìm đúng PostgreSQL) |
| **Database** | `postgres` | Database mặc định, có sẵn sau khi cài PostgreSQL |
| **Username** | `postgres` | Tài khoản quản trị được tạo tự động khi cài |
| **Password** | *(mật khẩu bạn đặt)* | Mật khẩu bạn đã đặt ở Bước 1.2 — bước "Password" |

**Mẹo:** Tích vào ô **"Save password locally"** để DBeaver nhớ mật khẩu — bạn không phải nhập lại mỗi lần mở.

### Bước 4: Kiểm Tra Kết Nối

- Nhấn nút **"Test Connection"** (ở góc dưới bên trái hộp thoại)
- Nếu hiện thông báo **"Connected"** trong vòng tròn xanh → **Thành công!** 🎉
- Nhấn **OK** để đóng thông báo, rồi nhấn **Finish**

### Bước 5: Hoàn Thành

Sau khi nhấn Finish, Database Navigator bên trái sẽ hiện kết nối mới:

```
Database Navigator (sau khi kết nối thành công)
┌──────────────────────────────────┐
│  ▼ PostgreSQL (localhost)        │  ← Kết nối bạn vừa tạo
│    ▼ Databases                   │
│      ▶ postgres                  │  ← Database mặc định (có sẵn)
│      ▶ template0                 │  ← Database hệ thống (không dùng)
│      ▶ template1                 │  ← Database hệ thống (không dùng)
│    ▶ System Information          │
└──────────────────────────────────┘
```

> **Chúc mừng!** DBeaver đã kết nối thành công với PostgreSQL trên máy bạn!

### Xử Lý Lỗi Thường Gặp

Nếu bước "Test Connection" báo lỗi, xem bảng dưới:

| Thông báo lỗi | Nguyên nhân | Cách xử lý |
|---|---|---|
| `Connection refused` | PostgreSQL chưa khởi động | Vào Services → tìm postgresql → Start |
| `password authentication failed` | Sai mật khẩu | Nhập lại mật khẩu đúng |
| `could not connect to server` | Sai host hoặc port | Kiểm tra: host = `localhost`, port = `5432` |
| DBeaver hỏi tải driver | Cần tải driver PostgreSQL | Nhấn **"Download"** — DBeaver tự tải (cần internet) |

---

## Phần 4: Làm Quen Giao Diện DBeaver

Sau khi kết nối thành công, hãy dành 10 phút làm quen giao diện trước khi viết SQL.

### 4 Khu Vực Chính Của DBeaver

```
┌──────────────────────────────────────────────────────────────────────┐
│  DBeaver Community                                        _ □ ×      │
├──────────────────────────────────────────────────────────────────────┤
│  [File][Edit][Navigate][SQL Editor][Window][Help]                    │
│  [🔌+][▶][■][💾][🔍]                                                │
├─────────────────────────┬────────────────────────────────────────────┤
│                         │                                            │
│   (1) DATABASE          │      (2) SQL EDITOR                       │
│       NAVIGATOR         │                                            │
│                         │  SELECT *                                  │
│  ▼ PostgreSQL           │  FROM nhan_vien;                          │
│    ▼ Databases          │                                            │
│      ▶ postgres         │  Ctrl+Enter = Chạy câu SQL hiện tại       │
│      ▶ hoc_sql          │  Alt+X      = Chạy toàn bộ script         │
│        ▼ Schemas        │                                            │
│          ▼ public       ├────────────────────────────────────────────┤
│            ▼ Tables     │                                            │
│              nhan_vien  │      (3) RESULTS PANEL                    │
│              san_pham   │                                            │
│                         │  id │ ho_ten       │ phong_ban │ luong    │
│                         │   1 │ Trần Thị Mai │ Kế toán   │ 15tr    │
│   (4) PROPERTIES        │   2 │ Nguyễn Văn A │ KD        │ 20tr    │
│   (bên dưới Navigator   │                                            │
│    khi click vào bảng)  │                                            │
└─────────────────────────┴────────────────────────────────────────────┘
```

#### Khu vực 1: Database Navigator (bên trái — cây kết nối)

Giống **File Explorer** của Windows — hiển thị mọi thứ dưới dạng cây phân cấp:
- Kết nối → Databases → Schemas → Tables
- **Click chuột phải** để thấy menu tùy chọn (tạo mới, xóa, refresh...)
- **Double-click** để mở rộng hoặc thu gọn nhánh

#### Khu vực 2: SQL Editor (bên phải, phần trên)

Đây là nơi bạn viết SQL — giống **thanh công thức** trong Excel nhưng có nhiều dòng.

Mỗi tab trong SQL Editor = một file SQL riêng (giống workbook có nhiều sheet).

**Phím tắt quan trọng:**
| Phím tắt | Tác dụng |
|---|---|
| `Ctrl + Enter` | Chạy câu SQL tại vị trí con trỏ |
| `Alt + X` | Chạy toàn bộ script (tất cả các câu) |
| `Ctrl + /` | Comment/bỏ comment dòng đang chọn |
| `Ctrl + Z` | Undo (giống Excel) |
| `Ctrl + S` | Lưu script (giống Excel) |

#### Khu vực 3: Results Panel (bên phải, phần dưới)

Hiển thị kết quả sau khi chạy SQL — giống **bảng kết quả** trong Excel khi bạn dùng công thức mảng hay PivotTable: bạn ra lệnh, kết quả hiện ngay phía dưới.

#### Khu vực 4: Properties Panel

Xuất hiện khi bạn **double-click** vào một bảng trong Navigator. Hiện thị thông tin chi tiết về bảng (danh sách cột, kiểu dữ liệu...).

### Thực Hành Điều Hướng

Hãy thử ngay:
1. Trong Database Navigator, **click vào mũi tên** cạnh "PostgreSQL" để mở rộng
2. Tiếp tục mở rộng: Databases → postgres → Schemas → public → Tables
3. Lúc này Tables đang trống (chưa có bảng nào — bình thường!)
4. Click phải vào "postgres" → xem các tùy chọn có gì

---

## Phần 5: Tạo Database Đầu Tiên — `hoc_sql`

Database `postgres` là database mặc định, dùng cho hệ thống. Chúng ta sẽ tạo một database riêng tên `hoc_sql` để học.

**Phép so sánh:** Tạo database mới giống tạo một file Excel mới (Ctrl+N trong Excel). Database `postgres` là file hệ thống — chúng ta không nên làm việc trực tiếp ở đó.

### Cách 1: Dùng Giao Diện DBeaver (Click Chuột)

1. Trong Database Navigator, **click phải** vào tên kết nối "PostgreSQL (localhost)"
2. Chọn **"Create New Database"**
3. Trong hộp thoại, điền tên: `hoc_sql`
4. Nhấn **OK**
5. Click phải vào **"Databases"** → chọn **"Refresh"**
6. Thấy `hoc_sql` xuất hiện trong danh sách ✅

### Cách 2: Dùng SQL (Bắt Đầu Làm Quen Với Lệnh Thật)

1. Click phải vào tên kết nối → **"SQL Editor"** → **"New SQL Script"**
2. SQL Editor mở ra — gõ vào:

```sql
-- Tạo database mới tên hoc_sql
CREATE DATABASE hoc_sql;
```

3. Nhấn **Ctrl+Enter** để chạy
4. Click phải vào "Databases" → **"Refresh"** → thấy `hoc_sql` xuất hiện

**Đọc lệnh như tiếng Anh:**
```
CREATE   DATABASE   hoc_sql;
  ↓          ↓         ↓
Tạo     cơ sở dữ liệu  tên là hoc_sql
```

Đơn giản phải không? SQL cố ý viết gần với tiếng Anh tự nhiên để dễ đọc.

> ⚠️ **Lưu ý quan trọng — Chuyển kết nối sang `hoc_sql`:**
>
> Sau khi tạo `hoc_sql`, bạn cần "bước vào" database đó trước khi tạo bảng.
>
> **Cách chuyển:** Trong Database Navigator, **double-click** vào `hoc_sql` (hoặc click phải → "Set Active"). Tên database đang active sẽ hiện đậm hơn.
>
> Nếu quên chuyển sang `hoc_sql` trước khi tạo bảng, bảng sẽ được tạo trong database sai!

---

## Phần 6: SQL Editor — Viết và Chạy SQL Đầu Tiên

Đây là khoảnh khắc quan trọng nhất của tuần 2!

Để mở SQL Editor cho database `hoc_sql`:
1. Click phải vào `hoc_sql` trong Navigator
2. Chọn **"SQL Editor"** → **"New SQL Script"**
3. SQL Editor mở ra với kết nối đến `hoc_sql`

### Phần 6.1: Các Câu SQL Kiểm Tra Hệ Thống

Các câu SQL này không cần bảng — chúng truy vấn thẳng PostgreSQL. Hãy gõ từng câu và nhấn `Ctrl+Enter`:

**Câu 1: Xem phiên bản PostgreSQL**
```sql
SELECT version();
```
→ Kết quả hiện ra chuỗi dài, ví dụ: `PostgreSQL 16.2, compiled by Visual C++ build 1937, 64-bit`

Giống như mở About trong Excel để xem "Microsoft Excel 365, Version 2401".

---

**Câu 2: Xem ngày hôm nay**
```sql
SELECT current_date;
```
→ Kết quả: `2026-04-13` (ngày hôm nay theo định dạng YYYY-MM-DD)

**So sánh Excel:** Giống hàm `=TODAY()` trong Excel — trả về ngày hiện tại.

---

**Câu 3: Xem ngày và giờ hiện tại**
```sql
SELECT now();
```
→ Kết quả: `2026-04-13 14:30:25.123456+07` (ngày giờ đầy đủ kèm múi giờ)

**So sánh Excel:** Giống hàm `=NOW()` trong Excel.

---

**Câu 4: Tính toán đơn giản**
```sql
SELECT 1 + 1 AS ket_qua;
```
→ Kết quả: `2` (trong cột tên `ket_qua`)

**So sánh Excel:** Giống gõ `=1+1` vào ô Excel. Từ khóa `AS ket_qua` đặt tên cho cột kết quả — giống đặt tiêu đề cột trong Excel.

---

**Câu 5: Thử tính toán thực tế hơn**
```sql
SELECT 52 * 5 AS tong_gio_lam_trong_nam;
```
→ Kết quả: `260` (52 tuần × 5 ngày/tuần)

---

**Câu 6: Ghép chuỗi văn bản**
```sql
SELECT 'Xin chào, ' || 'PostgreSQL!' AS loi_chao;
```
→ Kết quả: `Xin chào, PostgreSQL!`

**So sánh Excel:** Giống hàm `=CONCATENATE("Xin chào, ", "PostgreSQL!")` hoặc `="Xin chào, " & "PostgreSQL!"` trong Excel. Trong PostgreSQL, ký hiệu nối chuỗi là `||` (hai thanh đứng).

---

**Câu 7: Thử điều kiện đơn giản**
```sql
SELECT
    'Trần Thị Mai' AS ho_ten,
    15000000 AS luong,
    CASE WHEN 15000000 > 10000000 THEN 'Trên 10 triệu' ELSE 'Dưới 10 triệu' END AS phan_loai;
```
→ Kết quả: một hàng với 3 cột: `ho_ten`, `luong`, `phan_loai`

Câu này phức tạp hơn — chúng ta sẽ học chi tiết ở Tuần 8. Nhưng bạn có thể đọc và hiểu ý nghĩa rồi!

### Phần 6.2: "Nếm Thử" Tuần 3 — Tạo Bảng và Nhập Dữ Liệu

Tuần 3 sẽ học kỹ về CREATE TABLE và INSERT. Nhưng nếu bạn muốn thử ngay hôm nay, đây là toàn bộ lệnh để tạo bảng `nhan_vien` với dữ liệu 6 nhân viên quen thuộc từ tuần 1.

**Đảm bảo bạn đang kết nối vào `hoc_sql` trước khi chạy!**

```sql
-- Bước 1: Tạo bảng nhan_vien
-- (Tuần 3 sẽ giải thích từng từ khóa chi tiết)
CREATE TABLE nhan_vien (
    id        SERIAL PRIMARY KEY,   -- STT tự tăng, không trùng
    ho_ten    VARCHAR(100) NOT NULL, -- Họ tên (bắt buộc)
    phong_ban VARCHAR(50),           -- Phòng ban
    luong     NUMERIC(12,2),         -- Lương (số thập phân)
    ngay_sinh DATE,                  -- Ngày sinh
    email     VARCHAR(150)           -- Email (có thể để trống)
);

-- Bước 2: Nhập 6 nhân viên quen thuộc từ Tuần 1
INSERT INTO nhan_vien (ho_ten, phong_ban, luong, ngay_sinh, email) VALUES
    ('Trần Thị Mai',   'Kế toán',    15000000, '1995-03-20', 'mai.tran@cty.com'),
    ('Nguyễn Văn An',  'Kinh doanh', 20000000, '1990-07-15', 'an.nguyen@cty.com'),
    ('Lê Thị Bình',    'Nhân sự',    18000000, '1992-11-03', 'binh.le@cty.com'),
    ('Phạm Minh Châu', 'IT',         25000000, '1988-01-25', 'chau.pham@cty.com'),
    ('Hoàng Thị Dung', 'Kế toán',    13000000, '1996-09-10', NULL),
    ('Võ Văn Em',      'Kinh doanh', 22000000, '1993-05-30', 'em.vo@cty.com');

-- Bước 3: Xem kết quả — đây là câu SELECT đầu tiên có dữ liệu thật!
SELECT * FROM nhan_vien;
```

**Khi bạn chạy `SELECT * FROM nhan_vien;`, Results Panel hiện ra:**
```
┌────┬──────────────────┬───────────────┬──────────────┬────────────┬────────────────────┐
│ id │ ho_ten           │ phong_ban     │ luong        │ ngay_sinh  │ email              │
├────┼──────────────────┼───────────────┼──────────────┼────────────┼────────────────────┤
│  1 │ Trần Thị Mai     │ Kế toán       │ 15000000.00  │ 1995-03-20 │ mai.tran@cty.com   │
│  2 │ Nguyễn Văn An    │ Kinh doanh    │ 20000000.00  │ 1990-07-15 │ an.nguyen@cty.com  │
│  3 │ Lê Thị Bình      │ Nhân sự       │ 18000000.00  │ 1992-11-03 │ binh.le@cty.com    │
│  4 │ Phạm Minh Châu   │ IT            │ 25000000.00  │ 1988-01-25 │ chau.pham@cty.com  │
│  5 │ Hoàng Thị Dung   │ Kế toán       │ 13000000.00  │ 1996-09-10 │ (NULL)             │
│  6 │ Võ Văn Em        │ Kinh doanh    │ 22000000.00  │ 1993-05-30 │ em.vo@cty.com      │
└────┴──────────────────┴───────────────┴──────────────┴────────────┴────────────────────┘
```

Bạn nhận ra 6 nhân viên này từ tuần 1 không? Lần đầu tiên chúng không chỉ là ví dụ trên giấy — chúng thật sự tồn tại trong database của bạn!

---

## Tóm Tắt Tuần 2

### Những Gì Bạn Đã Làm Được

```
✅ Cài PostgreSQL thành công trên Windows
✅ Cài DBeaver Community và mở được giao diện
✅ Tạo kết nối DBeaver ↔ PostgreSQL thành công
✅ Biết 4 khu vực chính của DBeaver
✅ Tạo database hoc_sql
✅ Chạy câu SQL đầu tiên: SELECT version()
✅ Biết phím tắt Ctrl+Enter để chạy SQL
```

### Bảng Thuật Ngữ Mới

| Thuật ngữ | Ý nghĩa |
|---|---|
| **PostgreSQL Server** | "Engine" xử lý và lưu trữ dữ liệu — chạy ngầm trong máy |
| **DBeaver** | Giao diện đồ họa để giao tiếp với PostgreSQL |
| **localhost** | Địa chỉ máy tính của chính mình |
| **Port 5432** | Cổng PostgreSQL lắng nghe kết nối (như số nhà) |
| **Database Navigator** | Cây kết nối bên trái DBeaver |
| **SQL Editor** | Nơi viết và chạy SQL trong DBeaver |
| **Results Panel** | Nơi hiển thị kết quả sau khi chạy SQL |
| **Ctrl+Enter** | Phím tắt chạy câu SQL hiện tại |
| **Alt+X** | Phím tắt chạy toàn bộ script |
| **CREATE DATABASE** | Lệnh tạo database mới |

### So Sánh Excel ↔ DBeaver

| Trong Excel | Tương đương trong DBeaver |
|---|---|
| Mở file .xlsx | Tạo kết nối đến database |
| Chuyển giữa các file | Chuyển database trong Navigator |
| Thanh công thức | SQL Editor |
| Nhấn Enter sau gõ công thức | Ctrl+Enter để chạy SQL |
| Kết quả công thức hiện trong ô | Kết quả SQL hiện trong Results Panel |
| Workbook mới (Ctrl+N) | CREATE DATABASE hoc_sql |

### Cầu Nối Sang Tuần 3

Tuần này bạn đã tạo bảng `nhan_vien` và nhập dữ liệu mẫu (nếu bạn đã thử phần 6.2). Nhưng bạn chưa hiểu tại sao phải viết `SERIAL PRIMARY KEY`, `VARCHAR(100)`, hay `NOT NULL`.

**Tuần 3** sẽ giải thích đầy đủ:
- Các **kiểu dữ liệu** trong PostgreSQL (INTEGER, VARCHAR, DATE, BOOLEAN...)
- Cách thiết kế bảng đúng với `CREATE TABLE`
- Nhập dữ liệu bằng `INSERT INTO`
- Tại sao `PRIMARY KEY` lại quan trọng

Lúc đó bạn sẽ không chỉ chạy được SQL — bạn sẽ **hiểu** từng dòng bạn đang viết.
