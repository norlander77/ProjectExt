page 60112 "XEE Archived Project Lines"
{
    PageType = list;
    Caption = 'Archived Project Lines';
    // ApplicationArea = All;
    // UsageCategory = Lists;
    SourceTable = "Xee Project Lines";
    AutoSplitKey = true;
    SourceTableView = where(Archived = filter(True));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

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
                    // trigger OnValidate()
                    // var
                    //     ProjectLines: Record "Xee Project Lines";
                    // begin
                    //     if rec."Project Status" = rec."Project Status"::"In Hand" then begin
                    //         ProjectLines.SetRange("Document No.", rec."Document No.");
                    //         ProjectLines.SetRange("Product Group", rec."Product Group");
                    //         ProjectLines.SetFilter("Customer No.", '<>%1', rec."Customer No.");
                    //         ProjectLines.ModifyAll(Archived, true);
                    //     end;
                    // end;
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
                        myInt: Integer;
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
                        myInt: Integer;
                        SalesHeader: Record "Sales Header";
                        SalesQuotes: Page "Sales Order";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("XEE Project No.", rec."Document No.");
                        SalesHeader.SetRange("Sell-to Customer No.", rec."Customer No.");
                        SalesHeader.SetRange("XEE Product Group", rec."Product Group");
                        SalesQuotes.SetTableView(SalesHeader);
                        SalesQuotes.Run();
                    end;
                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Reopen Line")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ProjectLines: Record "Xee Project Lines";
                begin
                    ProjectLines.SetRange("Product Group", rec."Product Group");
                    ProjectLines.SetRange("Document No.", rec."Document No.");
                    ProjectLines.SetRange(Archived, false);
                    if ProjectLines.FindFirst() then begin
                        ProjectLines.Validate("Project Status", ProjectLines."Project Status"::Tendering);
                        ProjectLines.Validate(Archived, true);
                        ProjectLines.Modify();
                    end;
                    rec.Archived := false;
                    rec.Modify();
                    CurrPage.Update();
                end;
            }
            // action("Reopen Product Group")
            // {
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         ProjectLines: Record "Xee Project Lines";
            //     begin
            //         ProjectLines.SetRange("Product Group", rec."Product Group");
            //         ProjectLines.SetRange("Document No.", rec."Document No.");
            //         ProjectLines.SetRange(Archived, false);
            //         if ProjectLines.FindFirst() then begin
            //             ProjectLines.Validate("Project Status", ProjectLines."Project Status"::Tendering);
            //             ProjectLines.Validate(Archived, true);
            //             ProjectLines.Modify();
            //         end;
            //         rec.Archived := false;
            //         rec.Modify();
            //         CurrPage.Update();
            //     end;


            // }
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