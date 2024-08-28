page 60114 "XEE Project Lines"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Xee Project Lines";
    AutoSplitKey = true;
    SourceTableView = where(Archived = filter(False));
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    ShowFilter = true;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
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
                Image = ShowList;

            }
            action("Show Document")
            {
                ApplicationArea = All;
                RunObject = page Project;
                RunPageLink = "No." = field("Document No.");
                RunPageMode = View;
                Image = GoTo;
            }

        }
    }



}