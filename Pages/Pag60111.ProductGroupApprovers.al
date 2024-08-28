page 60111 "Product Group Approvers"
{
    ApplicationArea = All;
    Caption = 'Product Group Approvers';
    PageType = List;
    SourceTable = "XEE Product Group Approvers";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field("Product Group"; Rec."Product Group")
                {
                    ToolTip = 'Specifies the value of the Product Group field.';
                }
            }
        }
    }
}
