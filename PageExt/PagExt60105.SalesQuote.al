pageextension 60105 "Xee Sales Quotes Ext" extends "Sales Quote"
{
    layout
    {


        // Add changes to page layout here
        addafter(Status)
        {
            field("Project No."; Rec."XEE Project No.")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Project No.';
                trigger OnAssistEdit()
                var
                    myInt: Integer;
                    projectHeader: Record "Xee Project Header";
                    Project: page Project;
                begin
                    if rec."XEE Project No." <> '' then begin

                        if Projectheader.Get(rec."XEE Project No.") then;
                        // Project.SetTableView(projectHeader);
                        Project.SetRecord(projectHeader);
                        Project.Editable(false);
                        Project.Run();
                    end;
                end;

            }
            field("Project Name"; Rec."XEE Project Name")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Project Name';
            }
            // field("Expected Date of Execution"; Rec."Expected Date of Execution")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            //     Caption = 'Planned Execution Date';
            // }
            field("XEE Product Group"; Rec."XEE Product Group")
            {
                ApplicationArea = all;
                Caption = 'Product Group';
                Editable = false;
            }
            field(Deadline; Rec."XEE Deadline")
            {
                ApplicationArea = all;
                Editable = false;
            }
            // field(Stage; Rec.Stage)
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            // field("Project Status"; Rec."Project Status")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            // field("Project Type"; Rec."Project Type")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
        }
    }
    actions
    {
        modify(MakeOrder)
        {
            trigger OnBeforeAction()
            var
                projectLine: Record "Xee Project Lines";
            begin
                projectLine.SetRange("Document No.", rec."XEE Project No.");
                projectLine.SetRange("Product Group", rec."XEE Product Group");
                projectLine.SetRange("Customer No.", rec."Sell-to Customer No.");
                if projectLine.FindFirst() then
                    if not (projectLine."Project Status" = projectLine."Project Status"::won) then
                        Error('The project %1 is not Won yet', rec."XEE Project No.");
            end;
        }
        modify(MakeInvoice)
        {
            trigger OnBeforeAction()
            var
                projectLine: Record "Xee Project Lines";
            begin
                projectLine.SetRange("Document No.", rec."XEE Project No.");
                projectLine.SetRange("Product Group", rec."XEE Product Group");
                projectLine.SetRange("Customer No.", rec."Sell-to Customer No.");
                if projectLine.FindFirst() then
                    if not (projectLine."Project Status" = projectLine."Project Status"::won) then
                        Error('The project %1 is not Won yet', rec."XEE Project No.");
            end;
        }
        // Add changes to page actions here
        // modify()
    }
    // local procedure getslesmancode()
    // var
    //     userset: record "User Setup";
    // begin
    //     userset.get(UserId);
    //     salesman := userset."Salespers./Purch. Code";
    // end;

    // var
    //     salesman: code[30];
}