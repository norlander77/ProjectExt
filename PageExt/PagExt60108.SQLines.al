pageextension 60108 "XEE SalesOrderLines" extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("BOQ Title"; Rec."XEE Kit Title")
            {
                ApplicationArea = all;
            }
            field("BOQ Description"; Rec."XEE Kit Description")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}