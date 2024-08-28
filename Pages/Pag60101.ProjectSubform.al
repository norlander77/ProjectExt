page 60101 "Project Subform"
{
    PageType = ListPart;
    // ApplicationArea = All;
    // UsageCategory = Lists;
    SourceTable = "Xee Project Lines";
    AutoSplitKey = true;
    SourceTableView = where(Archived = filter(False));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Type field.';
                    Caption = 'Type';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Caption = 'No.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                    Caption = 'Customer Name';
                    Editable = false;
                }
                field("Product Group"; Rec."Product Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Group field.';
                }
                field("Assign to User"; Rec."Assign to User")
                {
                    ApplicationArea = all;
                }
                field("Deadline"; Rec."Dead line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dead line field.';
                    Caption = 'Deadline';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        Email: Codeunit Email;
                        EmailMessage: Codeunit "Email Message";
                        EmailBody: TextBuilder;
                        EmailSubject: TextBuilder;
                        UserSetup: Record "User Setup";
                        Link: text;
                        ProjectHeader: Record "Xee Project Header";
                        EmailNotes: Page "XEE Email Notes";
                        Note: text;
                        ProjectLines: Record "Xee Project Lines";
                        SRSetup: record "Sales & Receivables Setup";
                    // procedure GetUrl(ClientType: ClientType, [Company: Text], [ObjectType: ObjectType], [ObjectId: Integer], [Record: Table], [UseFilters: Boolean]): Text (+ 1 overload(s))
                    begin
                        if EmailNotes.RunModal() = Action::OK then
                            Note := EmailNotes.GetNote();

                        EmailBody.Clear();
                        EmailSubject.Clear();
                        if UserSetup.get(rec."Xee Created By") then begin
                            if UserSetup."E-Mail" <> '' then begin
                                ProjectHeader.SetFilter("No.", rec."Document No.");
                                Link := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, page::Project, ProjectHeader, true);
                                EmailSubject.Append(StrSubstNo('You Are Assigned to Review a Project Lines'));
                                EmailBody.Append(StrSubstNo('<p>you have been assigned to create Sales Quote for customer <b>%1</b> to the following product group <b>%2</b></br>', rec."Customer Name", rec."Product Group"));
                                EmailBody.Append('<p> Click the following link for more information');
                                EmailBody.Append(StrSubstNo('<a href="%1"> Go to Business Central</a>', Link));
                                if Note <> '' then
                                    EmailBody.Append(StrSubstNo('<p> PS: %1', Note));
                                // EmailBody.Append(StrSubstNo(''))
                                EmailMessage.Create(UserSetup."E-Mail", EmailSubject.ToText(), EmailBody.ToText(), true);
                                Email.Send(EmailMessage);
                                // rec.Assigned := true;
                                // rec.Modify();
                            end
                            else
                                Message('Please specifiy a valid E-mail Address is User Setup for %1', rec."Xee Created By");
                        end;

                        // send message to Mike
                        If (rec.Status = rec.Status::"Ready To Submit") and (rec.Status <> xrec.Status)
                         then begin
                            SRSetup.get;
                            SRSetup.testfield("Project Sales Team Manager");

                            EmailBody.Clear();
                            EmailSubject.Clear();
                            if UserSetup.get(SRSetup."Project Sales Team Manager") then begin
                                if UserSetup."E-Mail" <> '' then begin
                                    ProjectHeader.SetFilter("No.", rec."Document No.");
                                    Link := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, page::Project, ProjectHeader, true);
                                    EmailSubject.Append(StrSubstNo('Project ' + rec."Document No." + ' for customer ' + rec."Customer Name" + ' is ready to submit'));
                                    EmailBody.Append(StrSubstNo('<p>Project ' + rec."Document No." + ' for customer  <b>%1</b> is ready submit to the following product group <b>%2</b></br>', rec."Customer Name", rec."Product Group"));
                                    EmailBody.Append('<p> Click the following link for more information');
                                    EmailBody.Append(StrSubstNo('<a href="%1"> Go to Business Central</a>', Link));
                                    if Note <> '' then
                                        EmailBody.Append(StrSubstNo('<p> PS: %1', Note));
                                    // EmailBody.Append(StrSubstNo(''))
                                    EmailMessage.Create(UserSetup."E-Mail", EmailSubject.ToText(), EmailBody.ToText(), true);
                                    Email.Send(EmailMessage);
                                    // rec.Assigned := true;
                                    // rec.Modify();
                                end
                                else
                                    Message('Please specifiy a valid E-mail Address is User Setup for %1', SRSetup."Project Sales Team Manager");
                            end;
                        end;
                    end;

                }
                field("Project Status"; Rec."Project Status")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        ProjectLines: Record "Xee Project Lines";
                    begin
                        if (rec."Project Status" = rec."Project Status"::"In Hand") or (rec."Project Status" = rec."Project Status"::Won) then begin
                            ProjectLines.SetRange("Document No.", rec."Document No.");
                            ProjectLines.SetRange("Product Group", rec."Product Group");
                            ProjectLines.SetFilter("Customer No.", '<>%1', rec."Customer No.");
                            ProjectLines.ModifyAll(Archived, true);
                        end;
                    end;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    Caption = 'Salesperson Code';
                }
                field("SQ Generated"; Rec."Generated SQ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Generated SQ field.';
                    Editable = false;
                    Caption = 'SQ Generated';
                }
                field("Related SQ"; Rec."Related SQ")
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        SalesQuotes: Page "Sales Quotes";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
                        SalesHeader.SetRange("XEE Project No.", rec."Document No.");
                        SalesHeader.SetRange("Sell-to Customer No.", rec."Customer No.");
                        SalesHeader.SetRange("XEE Product Group", rec."Product Group");
                        SalesQuotes.SetTableView(SalesHeader);
                        SalesQuotes.Run();

                    end;
                }
                field("Related SO"; Rec."Related SO")
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        SalesQuotes: Page "Sales Orders";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("XEE Project No.", rec."Document No.");
                        SalesHeader.SetRange("Sell-to Customer No.", rec."Customer No.");
                        SalesHeader.SetRange("XEE Product Group", rec."Product Group");
                        SalesQuotes.SetTableView(SalesHeader);
                        SalesQuotes.Run();
                    end;
                }
                field("Related PSI"; Rec."Related PSI")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        PSI: Record "Sales Invoice Header";
                        PSIPage: Page "Posted Sales Invoices";
                    begin
                        // SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        PSI.SetRange("XEE Project No.", rec."Document No.");
                        PSI.SetRange("Sell-to Customer No.", rec."Customer No.");
                        PSI.SetRange("XEE Product Group", rec."Product Group");
                        PSIPage.SetTableView(PSI);
                        PSIPage.Run();
                    end;
                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Show Archived Lines")
            {
                ApplicationArea = All;
                RunObject = page "XEE Archived Project Lines";
                RunPageLink = "Document No." = field("Document No.");

            }
            action("Reopen Archived Lines")
            {
                ApplicationArea = All;
                Enabled = rec."Project Status" = rec."Project Status"::Tendering;
                trigger OnAction()
                var
                    ProjectLines: Record "Xee Project Lines";
                begin
                    ProjectLines.SetRange("Product Group", rec."Product Group");
                    ProjectLines.SetRange("Document No.", rec."Document No.");
                    ProjectLines.SetRange(Archived, true);
                    ProjectLines.ModifyAll(Archived, false);

                    // if ProjectLines.FindFirst() then begin
                    //     ProjectLines.Validate("Project Status", ProjectLines."Project Status"::Tendering);
                    //     ProjectLines.Validate(Archived, true);
                    //     ProjectLines.Modify();
                    // end;
                    // rec.Archived := false;
                    // rec.Modify();
                    CurrPage.Update();
                end;
            }


            action(EditInExcel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Edit in Excel';
                Image = Excel;
                // Promoted = true;
                // PromotedCategory = Category8;
                // PromotedIsBig = true;
                // PromotedOnly = true;
                Visible = true;
                ToolTip = 'Send the data in the sub page to an Excel file for analysis or editing';
                AccessByPermission = System "Allow Action Export To Excel" = X;

                trigger OnAction()
                var
                    EditinExcel: Codeunit "Edit in Excel";
                    EditinExcelFilters: Codeunit "Edit in Excel Filters";
                    ExcelFileNameTxt: Label 'Sales Order %1 - Lines', Comment = '%1 = document number, ex. 10000';
                begin
                    EditinExcelFilters.AddField('Document_No', Enum::"Edit in Excel Filter Type"::Equal, Rec."Document No.", Enum::"Edit in Excel Edm Type"::"Edm.String");

                    EditinExcel.EditPageInExcel(
                        'Projrct_Line',
                        page::"Project Subform",
                        EditinExcelFilters,
                        StrSubstNo(ExcelFileNameTxt, Rec."Document No."));
                end;

            }
            action("Assign")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Email: Codeunit Email;
                    EmailMessage: Codeunit "Email Message";
                    EmailBody: TextBuilder;
                    EmailSubject: TextBuilder;
                    UserSetup: Record "User Setup";
                    Link: text;
                    ProjectHeader: Record "Xee Project Header";
                    EmailNotes: Page "XEE Email Notes";
                    Note: text;
                    ProjectLines: Record "Xee Project Lines";
                // procedure GetUrl(ClientType: ClientType, [Company: Text], [ObjectType: ObjectType], [ObjectId: Integer], [Record: Table], [UseFilters: Boolean]): Text (+ 1 overload(s))
                begin
                    if EmailNotes.RunModal() = Action::OK then
                        Note := EmailNotes.GetNote();
                    ProjectLines.Copy(rec);
                    CurrPage.SetSelectionFilter(rec);
                    if ProjectLines.FindFirst() then
                        repeat
                            EmailBody.Clear();
                            EmailSubject.Clear();
                            if UserSetup.get(ProjectLines."Assign to User") then begin
                                if UserSetup."E-Mail" <> '' then begin
                                    ProjectHeader.SetFilter("No.", ProjectLines."Document No.");
                                    Link := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, page::Project, ProjectHeader, true);
                                    EmailSubject.Append(StrSubstNo('You Are Assigned to Review a Project Lines'));
                                    EmailBody.Append(StrSubstNo('<p>you have been assigned to create Sales Quote for customer <b>%1</b> to the following product group <b>%2</b></br>', ProjectLines."Customer Name", ProjectLines."Product Group"));
                                    EmailBody.Append('<p> Click the following link for more information');
                                    EmailBody.Append(StrSubstNo('<a href="%1"> Go to Business Central</a>', Link));
                                    if Note <> '' then
                                        EmailBody.Append(StrSubstNo('PS: %1', Note));
                                    // EmailBody.Append(StrSubstNo(''))
                                    EmailMessage.Create(UserSetup."E-Mail", EmailSubject.ToText(), EmailBody.ToText(), true);
                                    Email.Send(EmailMessage);
                                    ProjectLines.Assigned := true;
                                    ProjectLines.Modify();
                                end
                                else
                                    Message('Please specifiy a valid E-mail Address is User Setup for %1', ProjectLines."Assign to User");
                            end;
                        until ProjectLines.next = 0;
                end;

            }

            // }
            action("Create Sales Quote") //By prod Group
            {
                ApplicationArea = All;
                Image = Purchase;
                // Visible = rec.Status = Rec.status::Released;
                trigger OnAction()
                Var
                    SalesHeader: Record "Sales Header";
                    SalesLines: Record "Sales Line";
                    relatedcustomers: Record "Xee Project Lines";
                    LineNo: Integer;
                    CustomerList: page "Customer List";
                    customerNoList: list of [code[20]];
                    CustomerCode: code[25];
                    CatalogItemMgt: Codeunit "Catalog Item Management";
                    CatalogItem: Record "Nonstock Item";
                    ProductList: List of [code[25]];
                    ProductsText: Text[1024];
                    I: Integer;
                    FilterText: Text[250];
                    SQlist: page "Sales Quotes";
                    tempProductGroup: Record "Product Group Temp";
                    // productListTemp: Page "Product Group Lookup";
                    NewProductList: text[1024];
                    ProjectAttachment: Record "Document Attachment";
                    Salesattachment: record "Document Attachment";
                    // RelatedCustomers: Record "Xee Project Related Customers";
                    ProjectHeader: Record "Xee Project Header";
                    Contact: record Contact;
                    c: page "Contact Card";

                begin



                    if ProjectHeader.Get(rec."Document No.") then;
                    rec."Generated SQ" := true;
                    // CustomerList.LookupMode(true);
                    // if CustomerList.RunModal() = Action::LookupOK then begin
                    //     customerNoList := CustomerList.GetCustomers();
                    // end;
                    if rec."Customer Type" = rec."Customer Type"::Contact then begin

                        Contact.Get(rec."Customer No.");
                        if Contact."Contact Business Relation" = Contact."Contact Business Relation"::" " then begin
                            CustomerCode := contact.CreateCustomer(); ///////////////////////////////////////////////////////
                            rec."Created Customer" := CustomerCode;
                            rec.Modify();
                        end
                        else
                            CustomerCode := rec."Created Customer";
                    end
                    else
                        CustomerCode := Rec."Customer No.";
                    // foreach customercode in customerNoList do begin
                    SalesHeader.Reset();
                    SalesHeader.Init();
                    SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Quote);
                    SalesHeader.Validate("Sell-to Customer No.", CustomerCode);
                    SalesHeader.Validate("Posting Date", Today());
                    SalesHeader.Validate("XEE Project No.", ProjectHeader."No.");
                    SalesHeader.Validate("XEE Project Name", ProjectHeader.Name);
                    SalesHeader.Validate("XEE Product Group", rec."Product Group");
                    // SalesHeader.Validate(Deadline, ProjectHeader.Deadline);
                    // SalesHeader.Validate("Expected Date of Execution", ProjectHeader."Expected Date of Execution");
                    // SalesHeader.Validate(Stage, ProjectHeader.Stage);
                    // SalesHeader.Validate("Project Status", ProjectHeader."Project Status");
                    // SalesHeader.Validate("Project Type", ProjectHeader."Project Type");
                    SalesHeader.Insert(true);
                    SalesHeader.Validate("Dimension Set ID", ProjectHeader."Dimension Set ID");
                    SalesHeader.Validate("Salesperson Code", rec."Salesperson Code");
                    SalesHeader.Modify();
                    ProjectAttachment.SetRange("No.", ProjectHeader."No.");
                    if ProjectAttachment.FindFirst() then
                        repeat
                            Salesattachment.Reset();
                            Salesattachment.Init();
                            Salesattachment.TransferFields(ProjectAttachment);
                            Salesattachment."No." := SalesHeader."No.";
                            Salesattachment."Table ID" := Database::"Sales Header";
                            Salesattachment."Document Type" := Salesattachment."Document Type"::Quote;
                            Salesattachment.Insert(true);
                        until ProjectAttachment.Next() = 0;


                    if Confirm('Do you want to open the Sales Quotes', true) then begin
                        SalesHeader.SetRange("XEE Project No.", ProjectHeader."No.");
                        SQlist.SetTableView(SalesHeader);
                        SQlist.Run();
                    end;
                end;



            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var

    begin
        // CurrPage.Editable := rec.Status = rec.Status::Open;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
        userSetup: Record "User Setup";
        ProjectLines: Record "Xee Project Lines";
    begin
        if userSetup.Get(UserId) then;
        // if not userSetup."Project Team" then begin

        //     rec.FilterGroup(0);
        //     rec.SetFilter("Xee Created By", UserId);
        //     rec.FilterGroup(2)
        // end;


    end;
}