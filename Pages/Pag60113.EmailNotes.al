page 60113 "XEE Email Notes"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    // UsageCategory = Administration;
    // SourceTable = TableName;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Note; Note)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
    procedure GetNote(): text;
    var

    begin
        exit(Note);
    end;


    var
        Note: text;
}