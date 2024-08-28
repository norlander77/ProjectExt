pageextension 60106 "Xee Contact List Ext" extends "Contact List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    procedure GetContacts() Contactlist: code[20];
    var
    // Vendor: Record Vendor;
    begin
        // CurrPage.SetSelectionFilter(rec);
        // if Rec.FindFirst() then
            Contactlist := rec."No.";

    end;

    var
}