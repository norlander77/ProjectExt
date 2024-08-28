page 60100 "Project"
{
    PageType = Document;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Xee Project Header";
    DataCaptionFields = "No.", Name;
    DelayedInsert = false;

    layout
    {
        area(Content)
        {
            group(Project)
            {
                field("No."; Rec."No.") { ApplicationArea = all; }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Country/Region"; Rec."Country/Region")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Expected Date of Execution"; Rec."Expected Date of Execution")
                {
                    ApplicationArea = All;
                    Caption = 'Planned Execution Date';
                }
                field("Project Status"; Rec."Project Stage")
                {
                    ApplicationArea = All;
                }
                field("Project Type"; Rec."Project Type")
                {
                    ApplicationArea = All;
                }
                // field(Satge; Rec.Stage)
                // {
                //     ApplicationArea = All;

                // }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Creator"; Rec."Creator")
                {
                    ApplicationArea = All;
                    editable = false;
                }
                // field(Deadline; Rec.Deadline)
                // {
                //     ApplicationArea = All;
                // }
                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = all;
                //     Editable = false;

                // }

            }
            part(ProjectLines; "Project Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
            }


        }
        area(FactBoxes)
        {
            part(Attachment; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(Database::"Xee Project Header"), "No." = field("No.");

            }


            systempart(Control1905767507; Notes)
            {
                ApplicationArea = all;
                Visible = true;
                Caption = 'Note';


            }
        }

    }

    actions
    {

        area(Processing)
        {
            // action("Related Customers")
            // {
            //     Image = CustomerList;
            //     ApplicationArea = All;
            //     RunPageLink = "Project No." = field("No.");
            //     RunObject = page "Project Related Customers";
            //     // RunPageOnRec=true;

            // }



            action(Dimensions)

            {

                AccessByPermission = TableData Dimension = R;

                ApplicationArea = Suite;

                Enabled = rec."No." <> '';

                Image = Dimensions;

                Promoted = false;

                ShortCutKey = 'Shift+Ctrl+D';

                ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',

                FRC = 'Affichez ou modifiez les dimensions, telles que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';



                trigger OnAction();
                var

                begin

                    rec.ShowDocDim;

                    CurrPage.SAVERECORD;

                end;

            }
            // action(Assign)
            // {
            //     ApplicationArea = All;
            //     image = Delegate;
            //     Visible = false;
            //     trigger OnAction()
            //     var
            //         ProjectHeader: Record "Xee Project Header";
            //         projectLines: Record "Xee Project Lines";
            //         UserSetup: Record "User Setup";
            //         Link: Text;
            //         EmailSubject: Text;
            //         EmailRcptns: list of [text];
            //         EmailMessage: Codeunit "Email Message";
            //         Email: Codeunit Email;
            //         EmailBody: TextBuilder;
            //         LoopControl: Integer;
            //         TemBlob_rec: Codeunit "Temp Blob";
            //         InS: InStream;
            //         Out: OutStream;
            //         RecRef: RecordRef;
            //         base64: Codeunit "Base64 Convert";
            //         FileName: Text;
            //         MyPath: Text;
            //         XMLParameter: TextBuilder;
            //         ProductList: List of [code[25]];
            //         ProdGrpAppr: Record "Product Group Approvers";

            //     begin
            //         projectLines.SetRange("Document No.", rec."No.");
            //         if projectLines.FindFirst() then
            //             repeat
            //                 if not ProductList.Contains(projectLines."Product Group") then begin
            //                     ProductList.Add(projectLines."Product Group");
            //                     // filter user setup
            //                     // UserSetup.SetRange("Product Group", projectLines."Product Group");
            //                     ProdGrpAppr.SetRange("Product Group", projectLines."Product Group");
            //                     if ProdGrpAppr.FindFirst()
            //                     then
            //                         repeat
            //                             //send Email here
            //                             UserSetup.Get(ProdGrpAppr."User Id");
            //                             EmailBody.Clear();
            //                             EmailSubject := '';
            //                             ProjectHeader.SetRange("No.", rec."No.");
            //                             Link := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::Project, ProjectHeader, true);
            //                             EmailSubject := 'You Are Assigned To Review A Project' + rec."No." + 'Lines';
            //                             EmailBody.Append('Click the following link for more information : <br/>');
            //                             EmailBody.Append('<a href=" ' + Link + '"> Go to Project Page</a> ');
            //                             EmailMessage.Create(UserSetup."E-Mail", EmailSubject, EmailBody.ToText(), true);
            //                             Email.Send(EmailMessage);
            //                         until ProdGrpAppr.Next() = 0;

            //                 end;

            //             until projectLines.Next() = 0;

            //     end;
            // }
            // action("Create Sales Quote")
            // {
            //     ApplicationArea = All;
            //     Image = Purchase;
            //     Visible = false; //rec.Status = Rec.status::Released;
            //     trigger OnAction()
            //     Var
            //         SalesHeader: Record "Sales Header";
            //         SalesLines: Record "Sales Line";
            //         ProjectLines: Record "Xee Project Lines";
            //         LineNo: Integer;
            //         CustomerList: page "Customer List";
            //         customerNoList: list of [code[20]];
            //         CustomerCode: code[25];
            //         CatalogItemMgt: Codeunit "Catalog Item Management";
            //         CatalogItem: Record "Nonstock Item";
            //         ProductList: List of [code[25]];
            //         ProductsText: Text[1024];
            //         I: Integer;
            //         FilterText: Text[250];
            //         SQlist: page "Sales Quotes";
            //         tempProductGroup: Record "Product Group Temp";
            //         productListTemp: Page "Product Group Lookup";
            //         NewProductList: text[1024];
            //         ProjectAttachment: Record "Document Attachment";
            //         Salesattachment: record "Document Attachment";

            //     begin

            //         ProjectLines.SetRange("Document No.", rec."No.");
            //         if ProjectLines.FindFirst() then
            //             repeat
            //                 if not ProductList.Contains(ProjectLines."Product Group") then begin
            //                     ProductList.Add(ProjectLines."Product Group");
            //                     ProductsText += ProductList.Get(ProductList.Count) + ',';
            //                     tempProductGroup.Init();
            //                     tempProductGroup."Product Group" := ProductList.Get(ProductList.Count);
            //                     tempProductGroup.Insert();
            //                 end;
            //             until ProjectLines.Next() = 0;
            //         productListTemp.SetRecord(tempProductGroup);
            //         productListTemp.SetTableView(tempProductGroup);
            //         productListTemp.LookupMode(true);
            //         if productListTemp.RunModal() = Action::LookupOK then
            //             // NewProductList := productListTemp.GetProductGroup();



            //             productListTemp.InsertData(rec."No.");
            //         FilterText := productListTemp.GetData(rec."No.");
            //         // ProductsText := 'All,' + ProductsText;
            //         // FilterText := '';
            //         // I := Dialog.StrMenu(ProductsText, 0, 'Select') - 1;
            //         // if I <> 0 then begin
            //         //     // ProductList.Get()
            //         //     FilterText := ProductList.Get(i);
            //         // end;
            //         if FilterText <> '' then begin

            //             CustomerList.LookupMode(true);
            //             if CustomerList.RunModal() = Action::LookupOK then begin
            //                 customerNoList := CustomerList.GetCustomers();
            //             end;
            //             foreach customercode in customerNoList do begin
            //                 SalesHeader.Reset();
            //                 SalesHeader.Init();
            //                 SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Quote);
            //                 SalesHeader.Validate("Sell-to Customer No.", CustomerCode);
            //                 SalesHeader.Validate("Posting Date", Today());
            //                 SalesHeader.Validate("Project No.", rec."No.");
            //                 SalesHeader.Validate("Project Name", rec.Name);
            //                 // SalesHeader.Validate(Deadline, rec.Deadline);
            //                 SalesHeader.Validate("Expected Date of Execution", Rec."Expected Date of Execution");
            //                 SalesHeader.Validate(Stage, rec.Stage);
            //                 SalesHeader.Validate("Project Status", rec."Project Status");
            //                 SalesHeader.Validate("Project Type", Rec."Project Type");
            //                 SalesHeader.Insert(true);
            //                 SalesHeader.Validate("Dimension Set ID", rec."Dimension Set ID");
            //                 SalesHeader.Modify();
            //                 ProjectAttachment.SetRange("No.", rec."No.");
            //                 if ProjectAttachment.FindFirst() then
            //                     repeat
            //                         Salesattachment.Reset();
            //                         Salesattachment.Init();
            //                         Salesattachment.TransferFields(ProjectAttachment);
            //                         Salesattachment."No." := SalesHeader."No.";
            //                         Salesattachment."Table ID" := Database::"Sales Header";
            //                         Salesattachment."Document Type" := Salesattachment."Document Type"::Quote;
            //                         Salesattachment.Insert(true);
            //                     until ProjectAttachment.Next() = 0;
            //                 SalesLines.SetRange("Document No.", SalesHeader."No.");
            //                 SalesLines.SetRange("Document Type", SalesHeader."Document Type");
            //                 if SalesLines.FindLast() then
            //                     LineNo := SalesLines."Line No." + 10000
            //                 else
            //                     LineNo := 10000;
            //                 ProjectLines.SetRange("Document No.", rec."No.");
            //                 ProjectLines.SetFilter("Product Group", FilterText);
            //                 if ProjectLines.FindFirst() then
            //                     repeat
            //                         SalesLines.Reset();
            //                         SalesLines.Init();
            //                         SalesLines.Validate("Document Type", SalesHeader."Document Type");
            //                         SalesLines.Validate("Document No.", SalesHeader."No.");
            //                         SalesLines.Validate(Type, SalesLines.Type::Item);
            //                         SalesLines.Validate("XEE BOQ Description", ProjectLines."BOQ Description");
            //                         SalesLines.Validate("XEE BOQ Title", ProjectLines."BOQ Title");

            //                         SalesLines.Validate("Line No.", LineNo);
            //                         if ProjectLines.Type = ProjectLines.Type::"Item Catalog" then begin
            //                             CatalogItem.Get(ProjectLines."No.");
            //                             if CatalogItem."Item No." = '' then begin
            //                                 CatalogItemMgt.NonstockAutoItem(CatalogItem);
            //                                 SalesLines.Validate("No.", CatalogItem."Vendor Item No.");
            //                             end;
            //                         end else
            //                             SalesLines.Validate("No.", ProjectLines."No.");
            //                         SalesLines.Insert(true);
            //                         SalesLines.Validate("Unit of Measure Code", ProjectLines."Unit of Measure");
            //                         SalesLines.Validate(Quantity, ProjectLines.Quantity);
            //                         SalesLines.Validate("Unit Price", ProjectLines.Price);
            //                         SalesLines.Modify(true);
            //                         LineNo += 10000;
            //                     // SalesLines.Validate(Type,ProjectLines.);
            //                     until ProjectLines.Next() = 0;

            //             end;
            //             if Confirm('Do you want to open the Sales Quotes', true) then begin
            //                 SalesHeader.SetRange("Project No.", rec."No.");
            //                 SQlist.SetRecord(SalesHeader);
            //                 SQlist.Run();
            //             end
            //         end;
            //     end;
            // }

        }
    }

    // trigger OnAfterGetCurrRecord()
    // var
    //     ProjLines: Record "Xee Project Lines";
    //     ProjHead: Record "Xee Project Header";
    //     sal: page "Sales Order Subform";
    // begin
    //     if CheckStatus(Rec) then begin
    //         rec.Validate(Rec.Status, ProjHead.Status::Released);
    //         CurrPage.Update();
    //     end
    //     else
    //         rec.Validate(rec.Status, ProjHead.Status::Open);
    // end;

    // local procedure CheckStatus(ProjHead: Record "Xee Project Header"): Boolean
    // var
    //     ProjLines: Record "Xee Project Lines";
    // begin
    //     if ProjHead."No." = '' then
    //         exit(false);
    //     ProjLines.SetFilter("Document No.", ProjHead."No.");
    //     if ProjLines.FindFirst() then
    //         repeat
    //             if ProjLines.Status <> ProjLines.Status::Released then
    //                 exit(false);

    //         until ProjLines.Next() = 0;
    //     exit(true);

    // end;
}