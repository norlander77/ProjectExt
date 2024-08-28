table 60105 "Xee Project Stages History"
{
    Caption = 'Xee Project Stages History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Project No."; Code[25])
        {
            Caption = 'Project No.';
        }
        field(3; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers = "Customer","Contact";

        }
        field(6; "Product Group"; Code[25])
        {
            Caption = 'Product Group';
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(5; "User Id"; Code[50])
        {
            Caption = 'User Id';
        }
        field(7; "Date & Time"; DateTime)
        {
            Caption = 'Date & Time ';
        }
        field(8; Stage; Enum "Project Stages")
        {
            Caption = 'Stage';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
        StagesHistory: Record "Xee Project Stages History";

    begin
        if StagesHistory.FindLast() then
            rec."Entry No." := StagesHistory."Entry No." + 1
        else
            rec."Entry No." := 1;

    end;
}