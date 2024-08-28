tableextension 60100 "Xee Sales & Rec Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(60100; "Xee Project No. Series"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'Project No. Series';
        }
                field(60101; "Project Sales Team Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
            Caption = 'Project Sales Team Manager';
        }
    }

    var
        myInt: Integer;
}