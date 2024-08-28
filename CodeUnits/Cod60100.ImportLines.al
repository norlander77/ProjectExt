// codeunit 60100 "Import From Excel-Att.Summary"
// {


//     trigger OnRun()
//     begin

//         ImportExcel();

//     end;

//     procedure ImportExcel()

//     begin
//         Rec_ExcelBuffer.DeleteAll();  // reset Excel buffer
//         Rows := 0;
//         Columns := 0;
//         DialogCaption := 'Select File To Import';

//         UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);   // Upload to Stream 

//         if Name <> '' then
//             Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)    
//         else
//             exit;

//         Rec_ExcelBuffer.Reset();

//         Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);

//         Rec_ExcelBuffer.ReadSheet();

//         Commit();

//         //Message('sheet %1', Sheetname);

//         ///finding total number of Rows to Import

//         Rec_ExcelBuffer.Reset();

//         Rec_ExcelBuffer.SetRange("Column No.", 1);

//         If Rec_ExcelBuffer.FindFirst() then
//             repeat

//                 Rows := Rows + 1;

//             until Rec_ExcelBuffer.Next() = 0;

//         //Message('No. of rows %1', Rows);

//         //Finding total number of columns to import

//         Rec_ExcelBuffer.Reset();

//         Rec_ExcelBuffer.SetRange("Row No.", 1);

//         if Rec_ExcelBuffer.FindFirst() then
//             repeat

//                 Columns := Columns + 1;

//             until Rec_ExcelBuffer.Next() = 0;



//         //Function to Get the last line number in Job Journal

//         LineNo := FindLineNo();


//         //Rows := 2;
//         //for RowNo := 1 to Rows do begin
//         for RowNo := 2 to Rows do begin
//             // Evaluate(ProjectLinesActual, GetValueAtIndex(RowNo, 4));
//             ProjectLines.Init();
//             Evaluate(ProjectLines.Period, GetValueAtIndex(RowNo, 1));
//             Evaluate(ProjectLines."Employee Code", GetValueAtIndex(RowNo, 2));
//             ProjectLines.Validate("Employee Code");
//             Evaluate(ProjectLines.Actual, GetValueAtIndex(RowNo, 4));
//             Evaluate(ProjectLines.OT, GetValueAtIndex(RowNo, 5));
//             Evaluate(ProjectLines."Sick Leave", GetValueAtIndex(RowNo, 6));
//             Evaluate(ProjectLines."Annual Leave", GetValueAtIndex(RowNo, 7));
//             // Evaluate(ProjectLines.)
//             Evaluate(ProjectLines."Deduction Daily", GetValueAtIndex(RowNo, 8));
//             ProjectLines.Validate("Deduction Daily");
//             ProjectLines.Insert();
//         end;
//         Message('Import Completed');
//     end;

//     local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer): Text

//     var

//         Rec_ExcelBuffer: Record "Excel Buffer";

//     begin

//         Rec_ExcelBuffer.Reset();

//         If Rec_ExcelBuffer.Get(RowNo, ColNo) then
//             exit(Rec_ExcelBuffer."Cell Value as Text");
//     end;



//     local procedure FindLineNo(): Integer
//     var
//         JobJnl: Record "Job Journal Line";
//         LineNo: Integer;
//     begin
//         JobJnl.Reset();
//         JobJnl.SetFilter("Journal Template Name", 'JOB');
//         JobJnl.SetCurrentKey(JobJnl."Line No.");
//         If JobJnl.FindLast() then
//             LineNo := JobJnl."Line No." + 10000
//         else
//             LineNo := 10000;
//         exit(LineNo);
//     end;

//     var

//         Rec_ExcelBuffer: Record "Excel Buffer";
//         Rows: Integer;
//         Columns: Integer;
//         Fileuploaded: Boolean;
//         UploadIntoStream: InStream;
//         FileName: Text;
//         Sheetname: Text;
//         UploadResult: Boolean;
//         DialogCaption: Text;
//         Name: Text;
//         NVInStream: InStream;
//         ProjectLines: Record "Xee Project Lines";
//         RowNo: Integer;
//         TxtDate: Text;
//         DocumentDate: Date;
//         LineNo: Integer;

// }