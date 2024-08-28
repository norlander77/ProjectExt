// table 60104 "Xee Project Related Customers"
// {
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Project No."; code[20])
//         {
//             DataClassification = ToBeClassified;

//         }
//         field(2; "Customer Type"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = "Customer","Contact";
//             trigger OnValidate()
//             var

//             begin
//                 rec."Customer No." := '';
//                 rec."Customer Name" := '';
//             end;
//         }
//         field(3; "Customer No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             trigger OnLookup()
//             var
//                 myInt: Integer;
//                 Customers: Record Customer;
//                 Customerlist: Page "Customer List";
//                 Contact: Record Contact;
//                 contactlist: page "Contact List";
//             begin
//                 if "Customer Type" = "Customer Type"::Customer then begin
//                     // if Rec."Vendor No." <> '' then begin
//                     //     item.SetFilter("Vendor No.", rec."Vendor No.");

//                     // end;
//                     Customerlist.SetTableView(Customers);
//                     Customerlist.SetRecord(Customers);
//                     Customerlist.LookupMode(true);
//                     if Customerlist.RunModal() = Action::LookupOK then
//                         rec."Customer No." := Customerlist.GetCustomerNo();
//                     rec.Validate("Customer No.");
//                 end
//                 else
//                     if "Customer Type" = "Customer Type"::Contact then begin
//                         Contact.SetRange("Contact Business Relation", Contact."Contact Business Relation"::None);
//                         contactlist.SetTableView(Contact);
//                         contactlist.LookupMode(true);
//                         if contactlist.RunModal() = Action::LookupOK then
//                             rec.Validate("Customer No.", contactlist.GetContacts());
//                     end;
//             end;

//             trigger OnValidate()
//             var
//                 myInt: Integer;
//                 Customer: Record Customer;
//                 Contact: Record contact;
//             begin
//                 if rec."Customer Type" = "Customer Type"::Customer then begin
//                     if Customer.get(rec."Customer No.") then;
//                     rec."Customer Name" := Customer.Name;

//                 end
//                 else
//                     if rec."Customer Type" = "Customer Type"::Contact then begin
//                         Contact.get(rec."Customer No.");
//                         rec."Customer Name" := contact.Name;
//                     end;
//             end;

//         }
//         field(4; "Product Group"; code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "XEE Product Group";

//         }
//         field(5; "Dead line"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6; "Generated SQ"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(7; Stage; Enum "Project Stages")
//         {
//             DataClassification = ToBeClassified;
//             trigger OnValidate()
//             var
//                 myInt: Integer;
//                 relatedCust: record "Xee Project Related Customers";
//                 StagesHistory: Record "Xee Project Stages History";
//             begin
//                 relatedCust.SetRange("Project No.", Rec."Project No.");
//                 if relatedCust.FindFirst() then
//                     repeat
//                         StagesHistory.SetRange("Project No.", relatedCust."Project No.");
//                         StagesHistory.SetRange("Customer Type", relatedCust."Customer Type");
//                         StagesHistory.SetRange("Customer No.", relatedCust."Customer No.");
//                         StagesHistory.SetRange("Product Group", relatedCust."Product Group");
//                         StagesHistory.SetRange(Stage, relatedCust.Stage);
//                         if not StagesHistory.FindFirst() then begin
//                             // rec.Stage := stage::Tendering;
//                             StagesHistory.Reset();
//                             StagesHistory.Init();
//                             StagesHistory."Project No." := relatedCust."Project No.";
//                             StagesHistory."Customer Type" := relatedCust."Customer Type";
//                             StagesHistory."Customer No." := relatedCust."Customer No.";
//                             StagesHistory."Product Group" := relatedCust."Product Group";
//                             StagesHistory."Date & Time" := CurrentDateTime;
//                             StagesHistory."User Id" := UserId;
//                             StagesHistory.Stage := relatedCust.Stage;
//                             StagesHistory.Insert(true);

//                         end;
//                     until relatedCust.Next() = 0;
//             end;

//         }
//         field(8; "Customer Name"; text[250])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(9; "Line No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(10; "Related SQ"; Integer)
//         {
//             // DataClassification = ToBeClassified;
//             FieldClass = FlowField;
//             Editable = false;
//             CalcFormula = count("Sales Header" where("XEE Project No." = field("Project No."), "Sell-to Customer No." = field("Customer No.")));
//         }
//         field(11; Assigned; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12; "Created Customer"; code[20])
//         {
//             DataClassification = ToBeClassified;

//         }
//         field(13; "Document No."; code[20]) { }
//     }

//     keys
//     {
//         key(Pk; "Project No.", "Customer No.", "Product Group", "Line No.")
//         {
//             Clustered = true;
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnInsert()
//     var
//         StagesHistory: Record "Xee Project Stages History";

//     begin
//         // rec.Validate(Stage, stage::Tendering);
//         // StagesHistory.Reset();
//         // StagesHistory.Init();
//         // StagesHistory."Project No." := REC."Project No.";
//         // StagesHistory."Customer Type" := REC."Customer Type";
//         // StagesHistory."Customer No." := REC."Customer No.";
//         // StagesHistory."Product Group" := rec."Product Group";
//         // StagesHistory."Date & Time" := CurrentDateTime;
//         // StagesHistory."User Id" := UserId;
//         // StagesHistory.Insert(true);

//     end;

//     trigger OnModify()
//     begin

//     end;

//     trigger OnDelete()
//     begin

//     end;

//     trigger OnRename()
//     begin

//     end;

// }