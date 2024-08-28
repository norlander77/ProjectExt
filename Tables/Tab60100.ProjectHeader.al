table 60100 "Xee Project Header"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Project: Record "Xee Project Header";
            begin
                Project.SetRange("No.", '<>%1', rec."No.");
                Project.SetRange(Name, rec.Name);
                if Project.FindFirst() then begin
                    Message('Project with the same name already exists\Project No. %1', Project."No.")
                end;
            end;
        }
        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Address; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; City; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "XEE City";
        }
        field(6; "Country/Region"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(7; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Expected Date of Execution"; date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned Execution Date';
        }
        field(9; "Project Type"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Xee Project Type";
        }
        field(10; "Project Stage"; Enum "Project Stages")
        {
            DataClassification = ToBeClassified;
        }
        // field(11; Stage; Enum "Project Stages")
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(13; "No. Series"; code[25])
        {
            DataClassification = ToBeClassified;
        }


        field(29; "Shortcut Dimension 1 Code"; Code[20])

        {

            CaptionClass = '1,2,1';



            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),

                                                          Blocked = CONST(false));



            trigger OnValidate();

            begin

                //    TestStatus;

                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");

            end;

        }


        field(30; "Shortcut Dimension 2 Code"; Code[20])

        {

            CaptionClass = '1,2,2';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),

                                                          Blocked = CONST(false));



            trigger OnValidate();

            begin

                // TestStatus;

                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");

            end;

        }

        field(46; "Shortcut Dimension 3 Code"; code[20])

        {

            CaptionClass = '1,2,3';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),

                                                          Blocked = CONST(false));

            trigger OnValidate();

            begin

                //TestStatus;

                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");

            end;

        }

        field(47; "Shortcut Dimension 4 Code"; code[20])

        {

            CaptionClass = '1,2,4';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),

                                                          Blocked = CONST(false));

            trigger OnValidate();

            begin

                // TestStatus;

                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

            end;

        }

        field(48; "Shortcut Dimension 5 Code"; code[20])

        {

            CaptionClass = '1,2,5';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),

                                                          Blocked = CONST(false));

            trigger OnValidate();

            begin

                // TestStatus;

                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");

            end;

        }

        field(49; "Shortcut Dimension 6 Code"; code[20])

        {

            CaptionClass = '1,2,6';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),

                                                          Blocked = CONST(false));

            trigger OnValidate();

            begin

                //TestStatus;

                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");

            end;

        }

        field(50; "Shortcut Dimension 7 Code"; code[20])

        {

            CaptionClass = '1,2,7';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),

                                                          Blocked = CONST(false));

            trigger OnValidate();

            begin

                //TestStatus;

                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");

            end;

        }

        field(51; "Shortcut Dimension 8 Code"; code[20])

        {

            CaptionClass = '1,2,8';

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),

                                                          Blocked = CONST(false));

            trigger OnValidate();

            begin

                //TestStatus;

                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");

            end;

        }

        field(55; "Shortcut Dimension 2 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(2), Code = field("Shortcut Dimension 2 Code")));

        }

        field(56; "Shortcut Dimension 7 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(7), Code = field("Shortcut Dimension 7 Code")));

        }

        field(57; "Shortcut Dimension 3 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(3), Code = field("Shortcut Dimension 3 Code")));

        }

        field(58; "Shortcut Dimension 4 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(4), Code = field("Shortcut Dimension 4 Code")));

        }

        field(59; "Shortcut Dimension 5 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(5), Code = field("Shortcut Dimension 5 Code")));

        }

        field(60; "Shortcut Dimension 6 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(6), Code = field("Shortcut Dimension 6 Code")));

        }

        field(61; "Shortcut Dimension 8 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(8), Code = field("Shortcut Dimension 8 Code")));

        }

        field(62; "Shortcut Dimension 1 Name"; text[50])

        {

            FieldClass = FlowField;

            CalcFormula = lookup("Dimension Value".Name WHERE("Global Dimension No." = CONST(1), Code = field("Shortcut Dimension 1 Code")));

        }

        field(63; "Dimension Set ID"; Integer)

        {

            CaptionML = ENU = 'Dimension Set ID',

                        FRC = 'Code ensemble de dimensions';

            Editable = false;

            TableRelation = "Dimension Set Entry";



            trigger OnLookup();

            begin

                ShowDocDim;

            end;



            trigger OnValidate();

            begin



                UpdateDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code");



            end;

        }
        // field(65; "Status"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = "Open","Released";
        //     trigger OnValidate()
        //     var
        //         myInt: Integer;
        //     begin
        //         if rec.Status = rec.Status::Released then
        //             rec.Validate(Stage, Stage::"Ready To Submit");
        //     end;
        // }


        field(66; "Creator"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }

        field(68; Priority; enum "Project Priority")
        {
            DataClassification = ToBeClassified;
        }

    }




    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }



    var

        DimMgt: Codeunit 408;

        GLSetup: Record "General Ledger Setup";

        GLSetupShortcutDimCode: array[8] of Code[50];

        DimSetEntry: Record "Dimension Set Entry";

        UserSetup: Record "User Setup";

        NoSeriesMgt: Codeunit 396;

        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', FRC = 'Vous avez probablement modifié une dimension.\\Souhaitez-vous mettre à jour les lignes ?';
        SalesSetup: Record "Sales & Receivables Setup";
    // NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsert()
    begin
        if rec."No." = '' then begin
            SalesSetup.get();
            SalesSetup.TestField("Xee Project No. Series");
            NoSeriesMgt.InitSeries(SalesSetup."Xee Project No. Series", xrec."No. Series", 0D, rec."No.", rec."No. Series");
            rec."Creation Date" := Today();
            rec.Creator := UserId;
        end
    end;

    trigger OnDelete()
    var
        lines: record 60101;
    begin
        if Confirm('You are about to delete Project ' + "No." + '. Delete the project and project lines?') then begin
            lines.setrange("Document No.", "No.");
            if lines.findset then lines.deleteall;
        end
        else
            error('Cancelled by user')
    end;




    local procedure TestNoSeries()
    var
        IsHandled: Boolean;
    begin
        if "No." <> xRec."No." then begin
            SalesSetup.Get();
            NoSeriesMgt.TestManual(SalesSetup."Xee Project No. Series");
            "No. Series" := '';
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);

    var

        OldDimSetID: Integer;

    begin

        OldDimSetID := "Dimension Set ID";

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        if "No." <> '' then
            MODIFY;



        if OldDimSetID <> "Dimension Set ID" then begin

            MODIFY;

            // if MRLinesExist then

            // UpdateAllLineDim("Dimension Set ID", OldDimSetID);

        end;

    end;



    // local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);

    // var

    //     NewDimSetID: Integer;

    //     ReceivedShippedItemLineDimChangeConfirmed: Boolean;

    //     i: Integer;

    //     ShortcutDimCodeArray: array[8] of Code[100];

    //     GLSetup: Record "General Ledger Setup";

    //     GLSetupShortcutDimCode: array[8] of Code[50];

    //     DimSetEntry: Record "Dimension Set Entry";

    // begin

    //     // Update all lines with changed dimensions.

    //     GLSetup.GET;

    //     GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";

    //     GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";

    //     GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";

    //     GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";

    //     GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";

    //     GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";

    //     GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";

    //     GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";

    //     if NewParentDimSetID = OldParentDimSetID then

    //         exit;

    //     if not CONFIRM(Text051) then

    //         exit;



    //     MRLines.RESET;

    //     MRLines.SETRANGE("Document No.", "No.");

    //     MRLines.LOCKTABLE;

    //     if MRLines.FIND('-') then

    //         repeat

    //             NewDimSetID := DimMgt.GetDeltaDimSetID(MRLines."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);

    //             if MRLines."Dimension Set ID" <> NewDimSetID then begin

    //                 MRLines."Dimension Set ID" := NewDimSetID;

    //                 DimMgt.UpdateGlobalDimFromDimSetID(

    //                   MRLines."Dimension Set ID", MRLines."Global Dimension 1 Code", MRLines."Global Dimension 2 Code");

    //                 //IPT + Update Shortcut Dimension

    //                 for i := 3 to 8 do begin

    //                     ShortcutDimCodeArray[i] := '';

    //                     if GLSetupShortcutDimCode[i] <> '' then

    //                         if DimSetEntry.GET("Dimension Set ID", GLSetupShortcutDimCode[i]) then

    //                             ShortcutDimCodeArray[i] := DimSetEntry."Dimension Value Code";

    //                 end;

    //                 MRLines."Shortcut Dimension 3 Code" := ShortcutDimCodeArray[3];

    //                 MRLines."Shortcut Dimension 4 Code" := ShortcutDimCodeArray[4];

    //                 MRLines."Shortcut Dimension 5 Code" := ShortcutDimCodeArray[5];

    //                 MRLines."Shortcut Dimension 6 Code" := ShortcutDimCodeArray[6];

    //                 MRLines."Shortcut Dimension 7 Code" := ShortcutDimCodeArray[7];

    //                 MRLines."Shortcut Dimension 8 Code" := ShortcutDimCodeArray[8];

    //                 MRLines.MODIFY;

    //             end;

    //         until MRLines.NEXT = 0;

    // end;





    procedure ShowDocDim();

    var

        OldDimSetID: Integer;

    begin

        OldDimSetID := "Dimension Set ID";

        "Dimension Set ID" :=

     EditDimensionSet2(

            "Dimension Set ID", STRSUBSTNO('%1', "No."),

            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code", "Shortcut Dimension 7 Code", "Shortcut Dimension 8 Code");



        if OldDimSetID <> "Dimension Set ID" then begin

            rec.MODIFY;



        end;

        // if MRLinesExist then

        //     UpdateAllLineDim("Dimension Set ID", OldDimSetID);



    end;



    procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]; VAR DimVal3: Code[20]; VAR DimVal4: Code[20]; VAR DimVal5: Code[20]; VAR DimVal6: Code[20]; VAR DimVal7: Code[20]; VAR DimVal8: Code[20]): Integer

    var

        EditDimSetEntries: Page "Edit Dimension Set Entries";

        NewDimSetID: Integer;

    begin



        NewDimSetID := DimSetID;

        DimSetEntry.RESET;

        DimSetEntry.FILTERGROUP(2);

        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);

        DimSetEntry.FILTERGROUP(0);

        EditDimSetEntries.SETTABLEVIEW(DimSetEntry);

        EditDimSetEntries.SetFormCaption(NewCaption);

        EditDimSetEntries.RUNMODAL;

        NewDimSetID := EditDimSetEntries.GetDimensionID;

        UpdateDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2, DimVal3, DimVal4, DimVal5, DimVal6, DimVal7, DimVal8);

        DimSetEntry.RESET;

        EXIT(NewDimSetID);

    end;





    procedure GetDimensionSetValues(DimSetID: Integer; VAR DimVal1: Code[20]; VAR DimVal2: Code[20]; VAR DimVal3: Code[20]; VAR DimVal4: Code[20]; VAR DimVal5: Code[20]; VAR DimVal6: Code[20]; VAR DimVal7: Code[20]; VAR DimVal8: Code[20])

    begin

        GetGLSetup;

        DimVal1 := '';

        DimVal2 := '';

        DimVal3 := '';

        DimVal4 := '';

        DimVal5 := '';

        DimVal6 := '';

        DimVal7 := '';

        DimVal8 := '';

        IF GLSetupShortcutDimCode[1] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[1]) THEN
                DimVal1 := DimSetEntry."Dimension Value Code";

        IF GLSetupShortcutDimCode[2] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[2]) THEN
                DimVal2 := DimSetEntry."Dimension Value Code";

        IF GLSetupShortcutDimCode[3] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[3]) THEN
                DimVal3 := DimSetEntry."Dimension Value Code";

        IF GLSetupShortcutDimCode[4] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[4]) THEN
                DimVal4 := DimSetEntry."Dimension Value Code";

        IF GLSetupShortcutDimCode[5] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[5]) THEN
                DimVal5 := DimSetEntry."Dimension Value Code";

        IF GLSetupShortcutDimCode[6] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[6]) THEN
                DimVal6 := DimSetEntry."Dimension Value Code";

        IF GLSetupShortcutDimCode[7] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[7]) THEN
                DimVal7 := DimSetEntry."Dimension Value Code";

        IF GLSetupShortcutDimCode[8] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[8]) THEN
                DimVal8 := DimSetEntry."Dimension Value Code";

    end;



    procedure UpdateDimFromDimSetID(DimSetID: Integer; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20]; VAR DimVal3: Code[20]; VAR DimVal4: Code[20]; VAR DimVal5: Code[20]; VAR DimVal6: Code[20]; VAR DimVal7: Code[20]; VAR DimVal8: Code[20])

    var

        ShortcutDimCode: array[8] of Code[20];

    begin

        DimMgt.GetShortcutDimensions(DimSetID, ShortcutDimCode);

        GlobalDimVal1 := ShortcutDimCode[1];

        GlobalDimVal2 := ShortcutDimCode[2];

        DimVal3 := ShortcutDimCode[3];

        DimVal4 := ShortcutDimCode[4];

        DimVal5 := ShortcutDimCode[5];

        DimVal6 := ShortcutDimCode[6];

        DimVal7 := ShortcutDimCode[7];

        DimVal8 := ShortcutDimCode[8];



    end;



    procedure GetGLSetup()

    begin

        GLSetup.GET;

        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";

        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";

        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";

        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";

        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";

        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";

        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";

        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";

    end;







}

