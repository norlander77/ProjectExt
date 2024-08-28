pageextension 60100 "Xee Sales & Rec Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Customer Nos.")
        {
            field("Project No. Series"; Rec."Xee Project No. Series")
            {
                ApplicationArea = all;
            }
        }
        addafter("Xee Cash Customer")
        {
            field("Project Sales Team Manager"; Rec."Project Sales Team Manager")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}