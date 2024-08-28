pageextension 60103 "Xee Customer List Ext" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    procedure GetCustomers() CustomerList: list of [code[20]];
    var
    // Vendor: Record Vendor;
    begin
        CurrPage.SetSelectionFilter(rec);
        if Rec.FindFirst() then
            repeat
                CustomerList.Add(rec."No.");
            until rec.next = 0;
    end;

    procedure GetCustomerNo() Customer: code[20];
    var
    // Vendor: Record Vendor;
    begin
        // CurrPage.SetSelectionFilter(rec);
        // if Rec.FindFirst() then
        //     repeat
        Customer := rec."No.";
        // until rec.next = 0;
    end;

    var
}