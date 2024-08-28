page 60103 "Project Factbox"
{
    PageType = CardPart;
    SourceTable = "Xee Project Header";

    layout
    {
        area(Content)
        {

            group(Control2)
            {
                ShowCaption = false;
                field(Attachments; Attachments)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Recs: Record "Document Attachment";
                    begin
                        Clear(Page_DcoumentAttachment);
                        Clear(Recs);
                        Recs.Reset();
                        Recs.SetRange("Table ID",60100);
                        Recs.SetRange("No.", Rec."No.");
                        IF Recs.FindFirst() then;
                        Page_DcoumentAttachment.SetRecord(Recs);
                        Page_DcoumentAttachment.SetTableView(Recs);
                        Page_DcoumentAttachment.RunModal();
                        Clear(Rec_DocumentAttachment);
                        Clear(Attachments);
                        Rec_DocumentAttachment.Reset();
                        Rec_DocumentAttachment.SetRange("No.", Rec."No.");
                        IF Rec_DocumentAttachment.FindSet() then
                            Attachments := Rec_DocumentAttachment.Count;
                    end;
                }

            }

        }

    }
    var
        Attachments: Integer;
        Rec_DocumentAttachment: Record "Document Attachment";
        Page_DcoumentAttachment: Page "Xee Project Attachment";

    trigger OnAfterGetRecord()
    begin
        Clear(Attachments);
        Clear(Rec_DocumentAttachment);
        Rec_DocumentAttachment.Reset();
        Rec_DocumentAttachment.SetRange("No.", Rec."No.");
        IF Rec_DocumentAttachment.FindSet() then
            Attachments := Rec_DocumentAttachment.Count;
    end;
}