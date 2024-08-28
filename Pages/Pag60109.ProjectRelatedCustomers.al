// page 60109 "Project Related Customers"
// {
//     Caption = 'Project Related Customers';
//     PageType = Listpart;
//     SourceTable = "Xee Project Related Customers";
//     UsageCategory = None;
//     AutoSplitKey = true;


//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Project No."; Rec."Project No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Project No. field.';
//                 }
//                 field("Customer Type"; Rec."Customer Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Customer Type field.';
//                     Caption = 'Type';
//                 }
//                 field("Customer No."; Rec."Customer No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Customer No. field.';
//                     Caption = 'No.';
//                 }
//                 field("Customer Name"; Rec."Customer Name")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Customer Name';
//                     Editable = false;
//                 }
//                 field("Product Group"; Rec."Product Group")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Product Group field.';
//                 }
//                 field("Deadline"; Rec."Dead line")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dead line field.';
//                     Caption = 'Deadline';
//                 }
//                 field("SQ Generated"; Rec."Generated SQ")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Generated SQ field.';
//                     Editable = false;
//                     Caption = 'SQ Generated';
//                 }
//                 field("Related SQ"; Rec."Related SQ")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     trigger OnDrillDown()
//                     var
//                         myInt: Integer;
//                         SalesHeader: Record "Sales Header";
//                         SalesQuotes: Page "Sales Quotes";
//                     begin
//                         SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
//                         SalesHeader.SetRange("Project No.", rec."Project No.");
//                         SalesHeader.SetRange("Sell-to Customer No.", rec."Customer No.");
//                         SalesQuotes.SetTableView(SalesHeader);
//                         SalesQuotes.Run();

//                     end;
//                 }
//                 field(Stage; Rec.Stage)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Stage field.';
//                     Editable = false;
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//             action(Assign)
//             {
//                 ApplicationArea = All;
//                 image = Delegate;
//                 Visible = not rec.Assigned;

//                 trigger OnAction()
//                 var
//                     ProjectHeader: Record "Xee Project Header";
//                     // projectLines: Record "Xee Project Lines";
//                     RelatedCustomers: Record "Xee Project Related Customers";
//                     UserSetup: Record "User Setup";
//                     Link: Text;
//                     EmailSubject: Text;
//                     EmailRcptns: list of [text];
//                     EmailMessage: Codeunit "Email Message";
//                     Email: Codeunit Email;
//                     EmailBody: TextBuilder;
//                     LoopControl: Integer;
//                     TemBlob_rec: Codeunit "Temp Blob";
//                     InS: InStream;
//                     Out: OutStream;
//                     RecRef: RecordRef;
//                     base64: Codeunit "Base64 Convert";
//                     FileName: Text;
//                     MyPath: Text;
//                     XMLParameter: TextBuilder;
//                     ProductList: List of [code[25]];
//                     ProdGrpAppr: Record "Product Group Approvers";
//                 // x:Record Customer

//                 begin

//                     RelatedCustomers.SetRange("Project No.", rec."Project No.");
//                     if RelatedCustomers.FindFirst() then
//                         repeat
//                             if not ProductList.Contains(RelatedCustomers."Product Group") then begin
//                                 ProductList.Add(RelatedCustomers."Product Group");
//                                 // filter user setup
//                                 ProdGrpAppr.SetRange("Product Group", RelatedCustomers."Product Group");
//                                 if ProdGrpAppr.FindFirst() then
//                                     repeat

//                                         UserSetup.Get(ProdGrpAppr."User Id");
//                                         EmailBody.Clear();
//                                         EmailSubject := '';
//                                         ProjectHeader.SetRange("No.", rec."Project No.");
//                                         Link := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::Project, ProjectHeader, true);
//                                         EmailSubject := 'You Are Assigned to Review a Project Lines';
//                                         EmailBody.Append('Click the following link for more information : <br/>');
//                                         EmailBody.Append('<a href=" ' + Link + '"> Go to Project Page</a> ');
//                                         EmailMessage.Create(UserSetup."E-Mail", EmailSubject, EmailBody.ToText(), true);
//                                         Email.Send(EmailMessage);
//                                     // until UserSetup.Next() = 0;

//                                     until ProdGrpAppr.Next() = 0;
//                             end;
//                             RelatedCustomers.Assigned := true;
//                             RelatedCustomers.Modify();
//                         until RelatedCustomers.Next() = 0;

//                 end;
//             }
//             action(History)
//             {
//                 ApplicationArea = All;
//                 RunObject = page "Project Stages History";
//                 RunPageLink = "Project No." = field("Project No."), "Customer No." = field("Customer No.");
//                 Image = LedgerBook;
//                 trigger OnAction()
//                 begin

//                 end;
//             }
//             action("Create Sales Quote") //By prod Group
//             {
//                 ApplicationArea = All;
//                 Image = Purchase;
//                 // Visible = rec.Status = Rec.status::Released;
//                 trigger OnAction()
//                 Var
//                     SalesHeader: Record "Sales Header";
//                     SalesLines: Record "Sales Line";
//                     ProjectLines: Record "Xee Project Lines";
//                     LineNo: Integer;
//                     CustomerList: page "Customer List";
//                     customerNoList: list of [code[20]];
//                     CustomerCode: code[25];
//                     CatalogItemMgt: Codeunit "Catalog Item Management";
//                     CatalogItem: Record "Nonstock Item";
//                     ProductList: List of [code[25]];
//                     ProductsText: Text[1024];
//                     I: Integer;
//                     FilterText: Text[250];
//                     SQlist: page "Sales Quotes";
//                     tempProductGroup: Record "Product Group Temp";
//                     productListTemp: Page "Product Group Lookup";
//                     NewProductList: text[1024];
//                     ProjectAttachment: Record "Document Attachment";
//                     Salesattachment: record "Document Attachment";
//                     RelatedCustomers: Record "Xee Project Related Customers";
//                     ProjectHeader: Record "Xee Project Header";
//                     Contact: record Contact;
//                     c: page "Contact Card";

//                 begin

//                     // ProjectLines.SetRange("Document No.", rec."Project No.");
//                     // if ProjectLines.FindFirst() then
//                     //     repeat
//                     //         if not ProductList.Contains(ProjectLines."Xee Created By") then begin
//                     //             ProductList.Add(ProjectLines."Xee Created By");
//                     //             ProductsText += ProductList.Get(ProductList.Count) + ',';
//                     //             tempProductGroup.Init();
//                     //             tempProductGroup."Product Group" := ProductList.Get(ProductList.Count);
//                     //             tempProductGroup.Insert();
//                     //         end;
//                     //     until ProjectLines.Next() = 0;
//                     // productListTemp.SetRecord(tempProductGroup);
//                     // productListTemp.SetTableView(tempProductGroup);
//                     // productListTemp.LookupMode(true);
//                     // if productListTemp.RunModal() = Action::LookupOK then
//                     // NewProductList := productListTemp.GetProductGroup();



//                     productListTemp.InsertData(rec."Project No.");
//                     FilterText := productListTemp.GetData(rec."Project No.");
//                     // ProductsText := 'All,' + ProductsText;
//                     // FilterText := '';
//                     // I := Dialog.StrMenu(ProductsText, 0, 'Select') - 1;
//                     // if I <> 0 then begin
//                     //     // ProductList.Get()
//                     //     FilterText := ProductList.Get(i);
//                     // end;
//                     if FilterText <> '' then begin

//                         CurrPage.SetSelectionFilter(RelatedCustomers);
//                         IF RelatedCustomers.FindFirst() then
//                             repeat
//                                 if ProjectHeader.Get(RelatedCustomers."Project No.") then;
//                                 RelatedCustomers."Generated SQ" := true;
//                                 // CustomerList.LookupMode(true);
//                                 // if CustomerList.RunModal() = Action::LookupOK then begin
//                                 //     customerNoList := CustomerList.GetCustomers();
//                                 // end;
//                                 if RelatedCustomers."Customer Type" = RelatedCustomers."Customer Type"::Contact then begin

//                                     Contact.Get(RelatedCustomers."Customer No.");
//                                     if Contact."Contact Business Relation" = Contact."Contact Business Relation"::" " then begin
//                                         CustomerCode := contact.CreateCustomer(); ///////////////////////////////////////////////////////
//                                         rec."Created Customer" := CustomerCode;
//                                         rec.Modify();
//                                     end
//                                     else
//                                         CustomerCode := rec."Created Customer";
//                                 end
//                                 else
//                                     CustomerCode := RelatedCustomers."Customer No.";
//                                 // foreach customercode in customerNoList do begin
//                                 SalesHeader.Reset();
//                                 SalesHeader.Init();
//                                 SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Quote);
//                                 SalesHeader.Validate("Sell-to Customer No.", CustomerCode);
//                                 SalesHeader.Validate("Posting Date", Today());
//                                 SalesHeader.Validate("Project No.", ProjectHeader."No.");
//                                 SalesHeader.Validate("Project Name", ProjectHeader.Name);
//                                 // SalesHeader.Validate(Deadline, ProjectHeader.Deadline);
//                                 SalesHeader.Validate("Expected Date of Execution", ProjectHeader."Expected Date of Execution");
//                                 SalesHeader.Validate(Stage, ProjectHeader.Stage);
//                                 SalesHeader.Validate("Project Status", ProjectHeader."Project Status");
//                                 SalesHeader.Validate("Project Type", ProjectHeader."Project Type");
//                                 SalesHeader.Insert(true);
//                                 SalesHeader.Validate("Dimension Set ID", ProjectHeader."Dimension Set ID");
//                                 SalesHeader.Modify();
//                                 ProjectAttachment.SetRange("No.", ProjectHeader."No.");
//                                 if ProjectAttachment.FindFirst() then
//                                     repeat
//                                         Salesattachment.Reset();
//                                         Salesattachment.Init();
//                                         Salesattachment.TransferFields(ProjectAttachment);
//                                         Salesattachment."No." := SalesHeader."No.";
//                                         Salesattachment."Table ID" := Database::"Sales Header";
//                                         Salesattachment."Document Type" := Salesattachment."Document Type"::Quote;
//                                         Salesattachment.Insert(true);
//                                     until ProjectAttachment.Next() = 0;
//                                 SalesLines.SetRange("Document No.", SalesHeader."No.");
//                                 SalesLines.SetRange("Document Type", SalesHeader."Document Type");
//                                 if SalesLines.FindLast() then
//                                     LineNo := SalesLines."Line No." + 10000
//                                 else
//                                     LineNo := 10000;
//                                 ProjectLines.SetRange("Document No.", ProjectHeader."No.");
//                                 ProjectLines.SetFilter("Product Group", FilterText);
//                                 ProjectLines.SetRange(Status, ProjectLines.Status::Released);
//                                 if ProjectLines.FindFirst() then
//                                     repeat
//                                         SalesLines.Reset();
//                                         SalesLines.Init();
//                                         SalesLines.Validate("Document Type", SalesHeader."Document Type");
//                                         SalesLines.Validate("Document No.", SalesHeader."No.");
//                                         SalesLines.Validate(Type, SalesLines.Type::Item);

//                                         SalesLines.Validate("Line No.", LineNo);
//                                         if ProjectLines.Type = ProjectLines.Type::"Item Catalog" then begin
//                                             CatalogItem.Get(ProjectLines."No.");
//                                             if CatalogItem."Item No." = '' then begin
//                                                 CatalogItemMgt.NonstockAutoItem(CatalogItem);
//                                                 SalesLines.Validate("No.", CatalogItem."Vendor Item No.");
//                                             end;
//                                         end else
//                                             SalesLines.Validate("No.", ProjectLines."No.");
//                                         SalesLines.Insert(true);
//                                         SalesLines.Validate("Unit of Measure Code", ProjectLines."Unit of Measure");
//                                         SalesLines.Validate("XEE BOQ Description", ProjectLines."BOQ Description");
//                                         SalesLines.Validate("XEE BOQ Title", ProjectLines."BOQ Title");
//                                         SalesLines.Validate(Quantity, ProjectLines.Quantity);
//                                         SalesLines.Validate("Unit Price", ProjectLines.Price);
//                                         SalesLines.Modify(true);
//                                         LineNo += 10000;
//                                     // SalesLines.Validate(Type,ProjectLines.);
//                                     until ProjectLines.Next() = 0;
//                             until RelatedCustomers.Next() = 0;

//                         if Confirm('Do you want to open the Sales Quotes', true) then begin
//                             SalesHeader.SetRange("Project No.", ProjectHeader."No.");
//                             SQlist.SetTableView(SalesHeader);
//                             SQlist.Run();
//                         end;
//                     end
//                 end;

//             }
//         }
//     }
//     trigger OnClosePage()
//     var
//         myInt: Integer;
//         relatedCust: record "Xee Project Related Customers";
//         StagesHistory: Record "Xee Project Stages History";
//     begin
//         relatedCust.SetRange("Project No.", Rec."Project No.");
//         if relatedCust.FindFirst() then
//             repeat
//                 StagesHistory.SetRange("Project No.", relatedCust."Project No.");
//                 StagesHistory.SetRange("Customer Type", relatedCust."Customer Type");
//                 StagesHistory.SetRange("Customer No.", relatedCust."Customer No.");
//                 StagesHistory.SetRange("Product Group", relatedCust."Product Group");
//                 StagesHistory.SetRange(Stage, relatedCust.Stage);
//                 if not StagesHistory.FindFirst() then begin
//                     // rec.Stage := stage::Tendering;
//                     StagesHistory.Reset();
//                     StagesHistory.Init();
//                     StagesHistory."Project No." := relatedCust."Project No.";
//                     StagesHistory."Customer Type" := relatedCust."Customer Type";
//                     StagesHistory."Customer No." := relatedCust."Customer No.";
//                     StagesHistory."Product Group" := relatedCust."Product Group";
//                     StagesHistory."Date & Time" := CurrentDateTime;
//                     StagesHistory."User Id" := UserId;
//                     StagesHistory.Stage := relatedCust.Stage;
//                     StagesHistory.Insert(true);

//                 end;
//             until relatedCust.Next() = 0;
//     end;
//     // end;

// }
