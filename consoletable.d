#!/usr/bin/env rdmd
import std.stdio;
import std.string;
import std.typecons;
import std.range;

enum Alignment
{
    Left,
    Right,
    Center
}

class TableHeader
{
    ulong columnSize;
    string header;
    Alignment alignment;

    this(string header, Nullable!ulong columnSize, Alignment alignment)
    {
        ulong computedColumnsize = !columnSize.isNull ? columnSize.get : header.length;
        this.columnSize = computedColumnsize;
        this.header = header;
        this.alignment = alignment;
    }
}

class TableRow
{
    string[] data;

    this(string[] data)
    {
        this.data = data;
    }
}

void main()
{
    TableHeader[] headers = [
        new TableHeader("Name", cast(Nullable!ulong) 30, Alignment.Left),
        new TableHeader("Age", cast(Nullable!ulong) 3, Alignment.Right),
        new TableHeader("Address", cast(Nullable!ulong) 30, Alignment.Left),
        new TableHeader("City", cast(Nullable!ulong) 13, Alignment.Left),
        new TableHeader("State", cast(Nullable!ulong) 2, Alignment.Center),
        new TableHeader("Country", cast(Nullable!ulong) 2, Alignment.Center),
    ];

    TableRow[] rows = [
        new TableRow([
            "Sean Galland", "43", "123 Park Place", "Lytton", "CA", "US"
        ]),
        new TableRow([
            "Josh Tallarion", "18", "456 Peekaboo Lane", "Jersey City", "NJ", "US"
        ]),
        new TableRow([
            "Joshua Dominick Jones", "36", "3501 West Park Place", "Seattle", "WA",
            "US"
        ]),
        new TableRow([
            "Enrique Englesias Shapiro III", "26", "293 South Westville Ave",
            "San Franciso",
            "CA", "US"
        ]),
        new TableRow([
            "Jason Williams", "101", "69588 Westlane Road", "Chicago", "IL",
            "US"
        ]),
    ];

    for (int header_index = 0; header_index < headers.length; header_index++)
    {
        TableHeader header = headers[header_index];
        write(header_index == 0 ? "| " : " | ");
        write(leftJustify(header.header, header.columnSize, ' '));
    }
    writeln(" |");

    for (int header_index = 0; header_index < headers.length; header_index++)
    {
        TableHeader header = headers[header_index];
        ulong repeatTimes = header.columnSize > header.header.length ? header.columnSize
            : header.header.length;
        write("| ", '-'.repeat(repeatTimes), ' ');
    }
    writeln("|");

    for (int row_index = 0; row_index < rows.length; row_index++)
    {
        TableRow row = rows[row_index];
        for (int column_index = 0; column_index < headers.length; column_index++)
        {
            TableHeader header = headers[column_index];

            string column_data = row.data[column_index];
            ulong trimToSize = header.columnSize < column_data.length ? header.columnSize
                : column_data.length;
            ulong columnSize = header.columnSize > header.header.length ? header.columnSize
                : header.header.length;
            auto adjustedOutput = header.alignment == Alignment.Left ? leftJustify(column_data[0 .. trimToSize], columnSize, ' ') : header
                .alignment == Alignment.Center ? center(column_data[0 .. trimToSize], columnSize, ' ') : rightJustify(
                    column_data[0 .. trimToSize], columnSize, ' ');
            write("| ", adjustedOutput, ' ');
        }
        writeln("|");
    }

}
