table 60101 "Xee Project Lines"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(2; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Customer","Contact";
            trigger OnValidate()
            var

            begin
                rec."Customer No." := '';
                rec."Customer Name" := '';
            end;
        }
        field(3; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                myInt: Integer;
                Customers: Record Customer;
                Customerlist: Page "Customer List";
                Contact: Record Contact;
                contactlist: page "Contact List";
            begin
                if "Customer Type" = "Customer Type"::Customer then begin
                    // if Rec."Vendor No." <> '' then begin
                    //     item.SetFilter("Vendor No.", rec."Vendor No.");

                    // end;
                    Customerlist.SetTableView(Customers);
                    Customerlist.SetRecord(Customers);
                    Customerlist.LookupMode(true);
                    if Customerlist.RunModal() = Action::LookupOK then
                        rec."Customer No." := Customerlist.GetCustomerNo();
                    rec.Validate("Customer No.");
                end
                else
                    if "Customer Type" = "Customer Type"::Contact then begin
                        Contact.SetRange("Contact Business Relation", Contact."Contact Business Relation"::None);
                        contactlist.SetTableView(Contact);
                        contactlist.LookupMode(true);
                        if contactlist.RunModal() = Action::LookupOK then
                            rec.Validate("Customer No.", contactlist.GetContacts());
                    end;
            end;

            trigger OnValidate()
            var
                myInt: Integer;
                Customer: Record Customer;
                Contact: Record contact;
            begin
                if rec."Customer Type" = "Customer Type"::Customer then begin
                    if Customer.get(rec."Customer No.") then;
                    rec."Customer Name" := Customer.Name;

                end
                else
                    if rec."Customer Type" = "Customer Type"::Contact then begin
                        Contact.get(rec."Customer No.");
                        rec."Customer Name" := contact.Name;
                    end;
            end;

        }
        field(4; "Product Group"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "XEE Product Group";
            trigger OnValidate()
            var

                ProdGrpAppr: Record "XEE Product Group Approvers";

            begin
                ProdGrpAppr.SetRange("Product Group", rec."Product Group");
                if ProdGrpAppr.FindFirst() then
                    rec."Assign to User" := ProdGrpAppr."User Id";
            end;

        }
        field(5; "Dead line"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Generated SQ"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // field(7; Stage; Enum "Project Stages")
        // {

        // }
        field(8; "Customer Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Related SQ"; Integer)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Sales Header" where("XEE Project No." = field("Document No."), "Sell-to Customer No." = field("Customer No."), "XEE Product Group" = field("Product Group"), "Document Type" = const(Quote)));
        }
        field(11; Assigned; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Created Customer"; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Document No."; code[20]) { }
        field(14; "Xee Created By"; code[50])
        {

        }
        field(15; "Assign to User"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup" where("XEE Project Team" = const(true));
        }

        field(17; "Related SO"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;

            CalcFormula = count("Sales Header" where("XEE Project No." = field("Document No."), "Sell-to Customer No." = field("Customer No."), "XEE Product Group" = field("Product Group"), "Document Type" = const(Order)));

        }
        field(18; "Related PSI"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Sales Invoice Header" where("XEE Project No." = field("Document No."), "Sell-to Customer No." = field("Customer No."), "XEE Product Group" = field("Product Group")));
        }
        field(19; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Quoting,"Ready To Submit","Submitted";
            trigger OnValidate()
            var

            begin
                rec.CalcFields("Related SQ");
                if (rec.Status = Rec.Status::"Ready To Submit") or (rec.Status = rec.Status::Submitted) then
                    if rec."Related SQ" = 0 then
                        Error('There is no Quotation for this product group');
            end;
        }
        field(20; "Project Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Tendering","In Hand","Won","Lost";
        }
        field(21; "Archived"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
        }
        field(23; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));

            trigger OnValidate()
            var

            begin

            end;
        }

    }

    keys
    {
        key(PK; "Document No.", "Customer No.", "Product Group", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        rec."Xee Created By" := UserId;
    end;


}