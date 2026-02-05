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
    v_branchNo  staff.branchNo%TYPE;
    v_position  staff.sPosition%TYPE;
    v_sex       staff.sex%TYPE;
    v_dob       staff.DOB%TYPE; 
    v_salary    staff.salary%TYPE;
BEGIN
    SELECT 
        staffNo,
        fName || ' ' || lName,
        branchNo,
        sPosition,
        sex,
        DOB,
        salary
    INTO
        v_staffNo,
        v_nama,
        v_branchNo,
        v_position,
        v_sex,
        v_dob,
        v_salary
    FROM staff 
    WHERE staffNo = v_staffNo;

    DBMS_OUTPUT.PUT_LINE('====================================');
    DBMS_OUTPUT.PUT_LINE('           REPORT DATA STAFF        ');
    DBMS_OUTPUT.PUT_LINE('====================================');
    DBMS_OUTPUT.PUT_LINE('No Staff       : ' || v_staffNo);
    DBMS_OUTPUT.PUT_LINE('Nama Staff     : ' || v_nama);
    DBMS_OUTPUT.PUT_LINE('Cabang         : ' || v_branchNo);
    DBMS_OUTPUT.PUT_LINE('Jabatan        : ' || v_position);
    DBMS_OUTPUT.PUT_LINE('Jenis Kelamin  : ' || v_sex);
    DBMS_OUTPUT.PUT_LINE('Tanggal Lahir  : ' || TO_CHAR(v_dob, 'DD-MM-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Gaji           : ' || TO_CHAR(v_salary, 'FM999,999,999'));
    DBMS_OUTPUT.PUT_LINE('====================================');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('====================================');
        DBMS_OUTPUT.PUT_LINE('Data staff dengan nomor tersebut');
        DBMS_OUTPUT.PUT_LINE('TIDAK DITEMUKAN.');
        DBMS_OUTPUT.PUT_LINE('====================================');
END;
/
