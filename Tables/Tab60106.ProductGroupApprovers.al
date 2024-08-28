table 60106 "XEE Product Group Approvers"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User Id"; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Product Group"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "XEE Product Group";
        }
    }

    keys
    {
        key(PK; "User Id", "Product Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}