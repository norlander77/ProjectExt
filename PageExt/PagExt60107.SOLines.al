pageextension 60107 "XEE SalesQuoteLines" extends "Sales Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field("BOQ Title"; Rec."XEE Kit Title")
            {
                ApplicationArea = all;
                Caption = 'Kit';
            }
            field("BOQ Description"; Rec."XEE Kit Description")
            {
                ApplicationArea = all;
                Caption = 'Kit Description';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}