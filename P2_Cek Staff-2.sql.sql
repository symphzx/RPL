/* Program   : Reporting Data Staff */
/* File name : Prak-00-ReportingStaff.sql */

SET SERVEROUTPUT ON
SET VERIFY OFF
SET FEEDBACK OFF
SET LINESIZE 100

REM ===============================
REM Laporan Data Staff
REM ===============================

DECLARE
    v_staffNo   staff.staffNo%TYPE := '&staffNo';
    v_nama      VARCHAR2(120);
    v_branch    VARCHAR2(100);
    v_position  staff.sPosition%TYPE;
    v_sex       VARCHAR2(10);
    v_dob       VARCHAR2(20);
    v_salary    VARCHAR2(50);
BEGIN
    SELECT 
        staffNo,
        fName || ' ' || lName,
        b.street || ' ' || b.city || ' (' || b.branchNo || ')',
        sPosition,
        CASE s.sex
            WHEN 'M' THEN 'Pria'
            WHEN 'F' THEN 'Wanita'
            ELSE '-'
        END,
        UPPER(TO_CHAR(s.DOB, 'DD-Mon-YYYY')) AS dob_formatted,
        'Rp ' ||
        REPLACE(
            TO_CHAR(s.salary * 16000, 'FM999,999,999,999'),
            ',', '.'
        ) AS gaji_rupiah
    INTO
        v_staffNo,
        v_nama,
        v_branch,
        v_position,
        v_sex,
        v_dob,
        v_salary
    FROM staff s
    JOIN branch b ON s.branchNo = b.branchNo
    WHERE s.staffNo = v_staffNo;

    DBMS_OUTPUT.PUT_LINE('====================================');
    DBMS_OUTPUT.PUT_LINE('           REPORT DATA STAFF        ');
    DBMS_OUTPUT.PUT_LINE('====================================');
    DBMS_OUTPUT.PUT_LINE('No Staff       : ' || v_staffNo);
    DBMS_OUTPUT.PUT_LINE('Nama Staff     : ' || v_nama);
    DBMS_OUTPUT.PUT_LINE('Cabang         : ' || v_branch);
    DBMS_OUTPUT.PUT_LINE('Jabatan        : ' || v_position);
    DBMS_OUTPUT.PUT_LINE('Jenis Kelamin  : ' || v_sex);
    DBMS_OUTPUT.PUT_LINE('Tanggal Lahir  : ' || v_dob);
    DBMS_OUTPUT.PUT_LINE('Gaji (Annual)  : ' || v_salary || ',-');
    DBMS_OUTPUT.PUT_LINE('====================================');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('====================================');
        DBMS_OUTPUT.PUT_LINE('Data staff dengan nomor tersebut');
        DBMS_OUTPUT.PUT_LINE('TIDAK DITEMUKAN.');
        DBMS_OUTPUT.PUT_LINE('====================================');
END;
/
