# Gợi Ý Lesson Nâng Cao Theo Plan Học PostgreSQL

> Tài liệu này tổng hợp những phần trong PostgreSQL có thể phát triển thành lesson nâng cao sau khi hoàn thành lộ trình hiện tại. Mỗi mục đều nối trực tiếp với các tuần đã học và có nguồn tham khảo chính thống trên Internet để đối chiếu.

## Bảng Tóm Tắt Nhanh

| Chủ đề nâng cao | Nối từ tuần | Excel bridge | Vì sao đáng dạy | Nguồn web |
|---|---|---|---|---|
| Window Functions | Sau tuần 6 | RANK, SUMIFS, running total, cột phụ | Cho phép xếp hạng, cộng dồn, so sánh trong từng nhóm nhưng vẫn giữ từng dòng | [Tutorial Window Functions](https://www.postgresql.org/docs/current/tutorial-window.html) |
| GROUPING SETS / ROLLUP / CUBE | Sau tuần 6 | Nhiều Pivot Table trong một lần chạy | Mở rộng tự nhiên từ GROUP BY, rất hợp cho báo cáo đa chiều | [Table Expressions](https://www.postgresql.org/docs/current/queries-table-expressions.html#QUERIES-GROUPING-SETS) |
| CTE & Recursive CTE | Sau tuần 8 | Helper sheet, công thức trung gian | Giúp chia query dài thành từng bước rõ ràng, dễ đọc hơn subquery lồng nhau | [WITH Queries](https://www.postgresql.org/docs/current/queries-with.html) |
| LATERAL JOIN & truy vấn tương quan | Sau tuần 7 | Công thức phụ thuộc vào từng dòng hiện tại | Dùng khi một phần của FROM cần tham chiếu giá trị từ phần đứng trước | [Table Expressions](https://www.postgresql.org/docs/current/queries-table-expressions.html) |
| Indexes & EXPLAIN ANALYZE | Sau tuần 10 | Mục lục / tra cứu nhanh, xem kế hoạch tính toán | Rất thực chiến cho capstone và giúp giải thích vì sao query nhanh hoặc chậm | [Indexes](https://www.postgresql.org/docs/current/indexes.html), [Using EXPLAIN](https://www.postgresql.org/docs/current/using-explain.html) |
| UPSERT & MERGE | Sau tuần 9 | Dán đè có điều kiện theo khóa tra cứu | Phù hợp với nhập CSV, đồng bộ dữ liệu, cập nhật bản ghi trùng khóa | [INSERT](https://www.postgresql.org/docs/current/sql-insert.html), [MERGE](https://www.postgresql.org/docs/current/sql-merge.html) |
| Functions & Triggers | Sau tuần 9 | Macro hoặc rule tự chạy khi dữ liệu đổi | Hợp cho auto-check, audit log, chuẩn hóa dữ liệu và tự động hóa nghiệp vụ | [CREATE FUNCTION](https://www.postgresql.org/docs/current/sql-createfunction.html), [CREATE TRIGGER](https://www.postgresql.org/docs/current/sql-createtrigger.html), [Trigger Functions](https://www.postgresql.org/docs/current/plpgsql-trigger.html) |
| Materialized View | Sau tuần 9 | Pivot cache hoặc snapshot báo cáo | Hữu ích khi báo cáo nặng cần lưu sẵn kết quả và refresh theo lịch | [CREATE MATERIALIZED VIEW](https://www.postgresql.org/docs/current/sql-creatematerializedview.html) |
| JSON/JSONB & JSON_TABLE | Sau tuần 8-9 | Một ô chứa dữ liệu lồng nhau, sau đó tách cột | Rất phù hợp khi làm việc với API, dữ liệu bán cấu trúc hoặc log | [JSON Functions](https://www.postgresql.org/docs/current/functions-json.html) |
| Transaction Isolation & locking | Sau tuần 9 | Nhiều người cùng sửa một file Excel | Giải thích vì sao cùng một câu lệnh có thể cho kết quả khác khi có truy cập đồng thời | [Transaction Isolation](https://www.postgresql.org/docs/current/transaction-iso.html) |

## Nên Ưu Tiên Viết Trước

Nếu chỉ chọn ít lesson nâng cao để làm trước, thứ tự hợp lý nhất là:

1. Window Functions
1. CTE & Recursive CTE
1. Indexes & EXPLAIN ANALYZE
1. UPSERT & MERGE
1. Functions & Triggers
1. GROUPING SETS / ROLLUP / CUBE
1. Materialized View
1. JSON/JSONB & JSON_TABLE
1. Transaction Isolation & locking
1. LATERAL JOIN & truy vấn tương quan

Lý do: ba nhóm đầu giúp người học nâng cấp ngay tư duy báo cáo, đọc query và tối ưu hiệu năng. Các nhóm sau phù hợp để mở rộng sang quản trị dữ liệu, tự động hóa và dữ liệu bán cấu trúc.

## Nhận Xét Theo Lộ Trình Hiện Tại

### 1. Sau tuần 6: Mở rộng báo cáo

Đây là thời điểm đẹp nhất để thêm Window Functions và GROUPING SETS / ROLLUP / CUBE. Người học lúc này đã quen với SELECT, WHERE, GROUP BY và Pivot Table, nên rất dễ hiểu vì sao SQL vẫn giữ từng dòng nhưng vẫn tính được xếp hạng, tổng lũy kế hoặc nhiều tầng tổng hợp trong một truy vấn.

### 2. Sau tuần 7: Mở rộng JOIN

LATERAL JOIN là bước nâng cao tự nhiên sau JOIN. Chủ đề này nên dạy khi người học đã quen với INNER JOIN, LEFT JOIN và mô hình nhiều bảng, vì lúc đó họ mới thấy rõ giá trị của truy vấn phụ thuộc vào từng dòng.

### 3. Sau tuần 8: Mở rộng truy vấn nhiều bước

CTE và Recursive CTE là phần rất đáng đầu tư. Nó giúp câu lệnh dài bớt rối, đồng thời mở đường cho các bài toán phân cấp như danh mục cha-con, cây thư mục, hoặc chuỗi xử lý nhiều bước. JSON/JSONB cũng hợp ở giai đoạn này nếu muốn kéo dữ liệu API vào SQL.

### 4. Sau tuần 9: Mở rộng quản lý dữ liệu

UPSERT, MERGE, Functions, Triggers, Materialized View và Transaction Isolation đều là các chủ đề có tính vận hành rất cao. Chúng phù hợp sau khi người học đã nắm chắc UPDATE, DELETE, Transaction và VIEW, vì lúc đó mới phân biệt rõ đâu là thao tác thủ công, đâu là tự động hóa, đâu là cơ chế an toàn khi nhiều người cùng sửa dữ liệu.

### 5. Sau tuần 10: Mở rộng hiệu năng

Indexes và EXPLAIN ANALYZE nên để sau capstone hoặc song song với capstone. Lúc này người học đã có đủ bối cảnh thực tế để hiểu vì sao một query chậm, khi nào cần thêm index, và tại sao không phải cứ có index là nhanh hơn.

## Gợi Ý Chuyển Thành Lesson

Các lesson nâng cao nên được đặt tên theo kiểu "vấn đề trước, kỹ thuật sau" để đúng với tinh thần Excel làm cầu nối. Ví dụ:

- Từ Pivot Table sang Window Functions
- Viết query nhiều bước bằng CTE
- Tối ưu báo cáo bằng Index và EXPLAIN
- Tự động hóa dữ liệu bằng Function và Trigger
- Đồng bộ dữ liệu bằng UPSERT và MERGE
- Cache báo cáo với Materialized View
- Xử lý dữ liệu API bằng JSON và JSON_TABLE

## Ghi Chú Triển Khai

Các chủ đề như partitioning, replication, row-level security, event trigger hoặc tuning ở mức hệ thống có thể để cho giai đoạn sau nữa. Chúng rất hữu ích, nhưng hiện chưa cần nếu mục tiêu vẫn là giúp người mới học SQL nắm vững tư duy truy vấn, báo cáo và quản lý dữ liệu.
