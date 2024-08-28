pageextension 60104 "Xee User Setup Ext" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(PhoneNo)
        {
            field("Project Team"; Rec."XEE Project Team")
            {
                ApplicationArea = all;
                Visible = PreventedFromAccessUserSetup;
            }
        }
    }

    actions
    {
        addafter("User Batches")
        {

            action("Product Groups")
            {
                ApplicationArea = All;
                Image = ItemGroup;
                RunObject = page "Product Group Approvers";
                RunPageLink = "User Id" = field("User ID");
                Visible = PreventedFromAccessUserSetup;
            }
        }
    }



    trigger OnOpenPage()
    var
        UserStup: Record "User Setup";
    begin
        if UserStup.get(UserId) then begin
            PreventedFromAccessUserSetup := UserStup."Prevented From User Setup";
        end;
    end;

    var
        PreventedFromAccessUserSetup: Boolean;

}