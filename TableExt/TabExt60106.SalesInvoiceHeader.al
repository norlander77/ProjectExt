tableextension 60106 "XEE SalesInvoiceHeader" extends "Sales Invoice Header"
{
    fields
    {
        field(60101; "XEE Product Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "XEE Product Group";
        }


        field(60105; "XEE Project No."; Code[25])
        {
            DataClassification = ToBeClassified;


        }
        field(60106; "XEE Project Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }


}