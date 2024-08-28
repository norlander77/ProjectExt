page 60110 "Project Stages History"
{
    ApplicationArea = All;
    Caption = 'Project Stages History';
    PageType = List;
    SourceTable = "Xee Project Stages History";
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project No. field.';
                }
                field("Product Group"; Rec."Product Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Group field.';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stage field.';
                }
                field("Date & Time"; Rec."Date & Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date & Time  field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }
            }
        }
    }
}
